//
//  AuthorsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/3/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "AuthorsViewController.h"
#import "AuthorCollectionViewCell.h"
#import "AuthorsList.h"
#import "Author.h"
#import "AuthorListingCell.h"
#import "AuthorProfileViewController.h"
@import Firebase;
@interface AuthorsViewController ()
{
    NSArray * featuredAuthors;
    NSMutableArray * filteredAuthorArticles;
    NSMutableArray * filteredAuthorArticlesWithAds;
    NSInteger selectedTimeFilterIndex;
    NSInteger selectedRecentFilterIndex;
    NSDictionary * timeDic;
    NSDictionary * recentDic;
    int page;
}
@end

@implementation AuthorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    featuredAuthors = [[NSArray alloc]init];
    filteredAuthorArticles = [[NSMutableArray alloc]init];
    filteredAuthorArticlesWithAds = [[NSMutableArray alloc]init];
    self.screenName = @"iOS - Authors Screen";
    timeDic = [[NSDictionary alloc]initWithObjects:@[@"All",@"1",@"7",@"30"] forKeys:@[@"الكل",@"خلال اليوم",@"خلال اسبوع",@"خلال شهر"]];
    recentDic = [[NSDictionary alloc]initWithObjects:@[@"new",@"read"] forKeys:@[@"الأحدث",@"الأكثر قراءة"]];
    selectedTimeFilterIndex = 0;
    selectedRecentFilterIndex = 0;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AuthorCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"AuthorCollectionViewCell"];
    [self.collectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    [self addBottomPullToRefresh];
    [self getAuthersListAPI];
    /////
    self.recentFilterBtn.layer.cornerRadius = 20;
    self.recentFilterBtn.clipsToBounds = YES;
    self.timeFilterBtn.layer.cornerRadius = 20;
    self.timeFilterBtn.clipsToBounds = YES;
    self.tableView.scrollsToTop = YES;
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS - Authors Screen"
                                     }];
}
-(void)viewDidAppear:(BOOL)animated
{
   // self.title = @"أراء حرة مباشرة";
    [self setMainSponsor];
    [super setUpBannerUnderNav:self.view anotherTopView:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    if([AppSponsors isFreeOpinionsSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"FreeOpinions"]];
    }
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];
    [super setNavigationBarBackgroundFromChildViewControllerImageStr:mainSponsorUrl champs_id:nil section_id:nil activeCategory: @"FreeOpinions"];
}
-(void)addBottomPullToRefresh
{
    page = 1;
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor blackColor];
    refreshControl.triggerVerticalOffset = 80.;
    [refreshControl addTarget:self action:@selector(refreshBottom) forControlEvents:UIControlEventValueChanged];
    self.scrollView.bottomRefreshControl=refreshControl;
}
-(void)refreshBottom
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        ++page;
        [self getAuthersListAPI];
        [self.scrollView.bottomRefreshControl endRefreshing];
    });
}
-(void)getAuthersListAPI
{
    NSDictionary * parameters = [[NSDictionary alloc]initWithObjects:@[[recentDic.allValues objectAtIndex:selectedRecentFilterIndex],[timeDic.allValues objectAtIndex:selectedTimeFilterIndex],[NSString stringWithFormat:@"%i",page],@"10"] forKeys:@[@"filterby",@"duration",@"page",@"pageSize"]];
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:AuthorsListAPI,[WServicesManager getApiBaseURL]] andParameters:parameters WithObjectName:@"AuthorsList" andAuthenticationType:CMSAPIs success:^(AuthorsList * authorsList)
     {
         [self.activityIndicator stopAnimating];
         featuredAuthors = authorsList.featured;
         
         [filteredAuthorArticles addObjectsFromArray:authorsList.filteredOpinions];
         filteredAuthorArticlesWithAds= [[CustiomizeAdTypes alloc]initalizeBannerAdsWithUnitID:MeduimRectangle_AD_UNIT_ID andItemsList:filteredAuthorArticles andAdSize:kGADAdSizeMediumRectangle andRepeatCount:[Global getInstance].appInfo.adsNewsListingFrequencey andViewController:self andKeywords:@[@"Inner"]];

         if(featuredAuthors.count>0&&self.collectionViewHeightConstraint.constant>0)
         {
          self.collectionView.hidden = NO;
          self.loadingLbl.hidden=YES;
         [self.collectionView reloadData];
         [self.collectionView layoutIfNeeded];
         self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height;
         }
         if(filteredAuthorArticlesWithAds.count>0)
         {
         self.tableView.hidden = NO;
         self.loadingLbl.hidden=YES;
         [self.tableView reloadData];
         [self.tableView layoutIfNeeded];
         self.tableViewHeightConstraint.constant = self.tableView.contentSize.height+100;
         [self.view updateConstraints];
         }
         else
         {
             self.loadingLbl.hidden=NO;
             self.loadingLbl.text = @"لايوجد أراء حرة";
             self.tableView.hidden = YES;
         }
         
     }failure:^(NSError *error) {
         [self.activityIndicator startAnimating];
         self.loadingLbl.hidden=NO;
         self.tableView.hidden = YES;
         self.loadingLbl.text = @"لايوجد أراء حرة";
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getAuthersListAPI];
                                          }];
         
     }];
}
#pragma mark - UICollectionview Datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return featuredAuthors.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(self.collectionView.frame.size.width/2-1, 190);
    return size;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Author * item = [featuredAuthors objectAtIndex:indexPath.item];
    AuthorCollectionViewCell *cell =(AuthorCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"AuthorCollectionViewCell" forIndexPath:indexPath];
    cell.authorNameLbl.text = item.name;
    cell.articleTitleLbl.text = item.latestOpinionTitle;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(authorImgTaped:)];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(authorImgTaped:)];
    
    [cell.imgView setTag:item.idField];
    [cell.authorNameLbl setTag:item.idField];
    
    tapGesture1.numberOfTouchesRequired = 1;
    tapGesture1.view.userInteractionEnabled = YES;
    tapGesture2.numberOfTouchesRequired = 1;
    tapGesture2.view.userInteractionEnabled = YES;
    
    cell.imgView.userInteractionEnabled = YES;
    cell.authorNameLbl.userInteractionEnabled = YES;
    
    [cell.imgView addGestureRecognizer: tapGesture1];
    [cell.authorNameLbl addGestureRecognizer: tapGesture2];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:[UIImage imageNamed:@"Coach-Image-Placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [cell.activityIndicator stopAnimating];
    }];
    return cell;
}

#pragma mark - UITableView Datasource
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return filteredAuthorArticlesWithAds.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[filteredAuthorArticlesWithAds objectAtIndex:indexPath.row]isKindOfClass:[GADBannerView class]])
    {
        return [(GADBannerView*)[filteredAuthorArticlesWithAds objectAtIndex:indexPath.row]adSize].size.height+20;
        
    }
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    
    if([[filteredAuthorArticlesWithAds objectAtIndex:indexPath.row]isKindOfClass:[GADBannerView class]]) {
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:(GADBannerView*)[filteredAuthorArticlesWithAds objectAtIndex:indexPath.row]];
        
    } else {
        NewsItem * item = [filteredAuthorArticlesWithAds objectAtIndex:indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AuthorListingCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AuthorListingCell" owner:self options:nil]objectAtIndex:0];
        ((AuthorListingCell*)cell).authorNameLbl.text = item.editorName;
        ((AuthorListingCell*)cell).authorArticalLbl.text = item.newsTitle;
        
        UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(authorImgTaped:)];
        UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(authorImgTaped:)];
        
        tapGesture1.numberOfTouchesRequired = 1;
        tapGesture1.view.userInteractionEnabled = YES;
        tapGesture2.numberOfTouchesRequired = 1;
        tapGesture2.view.userInteractionEnabled = YES;
        
        ((AuthorListingCell*)cell).imgView.userInteractionEnabled = YES;
        ((AuthorListingCell*)cell).authorNameLbl.userInteractionEnabled = YES;
        
        [((AuthorListingCell*)cell).imgView addGestureRecognizer:tapGesture1];
        [((AuthorListingCell*)cell).authorNameLbl addGestureRecognizer: tapGesture2];

        
        if(item.authors.count>0) {
            Author * author = [[Author alloc]init];
                author=item.authors[0];
            ((AuthorListingCell*)cell).authorNameLbl.text = author.name;
            [((AuthorListingCell*)cell).imgView setTag:author.idField];
            [((AuthorListingCell*)cell).authorNameLbl setTag:author.idField];

            [((AuthorListingCell*)cell).imgView sd_setImageWithURL:[NSURL URLWithString:author.image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [((AuthorListingCell*)cell).activityIndicator stopAnimating];
                [((AuthorListingCell*)cell).activityIndicator setHidden:YES];

            }];
        } else {
            [((AuthorListingCell*)cell).imgView setTag:item.editorId];
            [((AuthorListingCell*)cell).authorNameLbl setTag:item.editorId];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)recentFilterAction:(id)sender {
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@""
                                                                                           rows:recentDic.allKeys
                                                                               initialSelection:selectedRecentFilterIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          [self.activityIndicator startAnimating];
                                                                                          self.collectionViewHeightConstraint.constant=0;
                                                                  page =1;                         featuredAuthors = [[NSArray alloc]init];
                                                                                          filteredAuthorArticles = [[NSMutableArray alloc]init];
                                                                                          filteredAuthorArticlesWithAds = [[NSMutableArray alloc]init];                            selectedRecentFilterIndex =selectedIndex;                       [self.recentFilterBtn setTitle:[recentDic.allKeys objectAtIndex:selectedIndex] forState:UIControlStateNormal];                [self getAuthersListAPI];

                                                                                          
                                                                                      }
                                                                                    cancelBlock:^(ActionSheetStringPicker *picker) {
                                                                                        NSLog(@"Block Picker Canceled");
                                                                                    }
                                                                                         origin:sender];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"تم" style:UIBarButtonItemStyleDone target:self action:nil];
    [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    UIBarButtonItem * cancelButton=[[UIBarButtonItem alloc]initWithTitle:@"الغاء" style:UIBarButtonItemStyleDone target:self action:nil];
    [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [doneButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [actionsheetPicker setCancelButton:cancelButton];
    [actionsheetPicker setDoneButton:doneButton];
    [[UIToolbar appearance]setTintColor:[UIColor whiteColor]];
    actionsheetPicker.pickerBackgroundColor = [UIColor whiteColor];
    actionsheetPicker.toolbarBackgroundColor = [UIColor darkGrayColor];
    actionsheetPicker.toolbarButtonsColor = [UIColor whiteColor];
    [actionsheetPicker showActionSheetPicker];
}

- (IBAction)timeFilterAction:(id)sender {
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@""
                                                                                           rows:timeDic.allKeys
                                                                               initialSelection:selectedTimeFilterIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          page =1;
                                                                                          featuredAuthors = [[NSArray alloc]init];
                                                                                          self.collectionViewHeightConstraint.constant=0;
                                                                                          filteredAuthorArticles = [[NSMutableArray alloc]init];
                                                                                          filteredAuthorArticlesWithAds = [[NSMutableArray alloc]init];                       [self.activityIndicator startAnimating];
                                                                                                                                                                     selectedTimeFilterIndex =selectedIndex;                       [self.timeFilterBtn setTitle:[timeDic.allKeys objectAtIndex:selectedIndex] forState:UIControlStateNormal];                [self getAuthersListAPI];
                                                                                      }
                                                                                    cancelBlock:^(ActionSheetStringPicker *picker) {
                                                                                        NSLog(@"Block Picker Canceled");
                                                                                    }
                                                                                         origin:sender];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"تم" style:UIBarButtonItemStyleDone target:self action:nil];
    [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    UIBarButtonItem * cancelButton=[[UIBarButtonItem alloc]initWithTitle:@"الغاء" style:UIBarButtonItemStyleDone target:self action:nil];
    [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [doneButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [actionsheetPicker setCancelButton:cancelButton];
    [actionsheetPicker setDoneButton:doneButton];
    [[UIToolbar appearance]setTintColor:[UIColor whiteColor]];
    actionsheetPicker.pickerBackgroundColor = [UIColor whiteColor];
    actionsheetPicker.toolbarBackgroundColor = [UIColor darkGrayColor];
    actionsheetPicker.toolbarButtonsColor = [UIColor whiteColor];
    [actionsheetPicker showActionSheetPicker];
}
#pragma mark - Handle Gesture
-(void)authorImgTaped:(UITapGestureRecognizer*)tap
{
    Author * item = [[Author alloc]init];
    NSInteger idField = tap.view.tag;
    item.idField = idField ;
    AuthorProfileViewController * profileView = [[AuthorProfileViewController alloc]init];
    profileView.author = item;
    [self.navigationController pushViewController:profileView animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[filteredAuthorArticlesWithAds objectAtIndex:indexPath.row]isKindOfClass:[GADBannerView class]])
    {
        
    }
    else{
    NewsItem * item = [filteredAuthorArticlesWithAds objectAtIndex:indexPath.row];
    NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:item ];
    NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:item ];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
        else
    [self.navigationController pushViewController:newsDetailsScreen animated:YES];

    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Author * author = [featuredAuthors objectAtIndex:indexPath.item];
    NewsItem *item =[[NewsItem alloc]init];
    item.newsId = (int)author.latestOpinionID;
    item.newsTitle = author.latestOpinionTitle;
    if(item.newsId != 0)
    {
        NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:item ];
        NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:item ];
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
            [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
        else
            [self.navigationController pushViewController:newsDetailsScreen animated:YES];
    }
}
@end
