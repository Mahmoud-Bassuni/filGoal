//
//  GalleryDetailsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 4/19/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "GalleryDetailsViewController.h"
#import "ImageCollectionViewCell.h"
#import "Albums.h"
#import "PagerAdsViewController.h"
#import "Rec.h"
#import "BannersSliderViewController.h"
#import "UIImageView+WebCache.h"
#import "AlbumCustomCellTableViewCell.h"
#import "NewsDetailsViewController.h"
#import "VideoDetailsViewController.h"
#import "NewsDetailsViewControllerWithWKWebView.h"
@import Firebase;
@interface GalleryDetailsViewController ()
{
    NSArray * postSquarePosts;
    NSMutableDictionary * sections;
    AppDelegate * appDelegate;
    NSInteger selectedIndex;
    NSMutableArray * pictures;
    CustomIOSAlertView *alertView;
    
    
}
@end

@implementation GalleryDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    selectedIndex = 0;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    [self.collectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.screenName=  [NSString stringWithFormat:@"iOS- Gallery details with Gallery ID =%li",(long)self.albumItem.albumId];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Gallery details with Gallery ID =%li",(long)self.albumItem.albumId]
                                     }];
    sections = [[NSMutableDictionary alloc]init];
    
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.commentsBtn.hidden=NO;
    self.adsview=[[UIView alloc] init];
    self.bgcolor=[Global getInstance].bgcolor;
    self.textColor=[Global getInstance].textColor;
    self.fontSize=[Global getInstance].fontSize;
    [self.contentView setBackgroundColor:self.bgcolor];
    self.currentRelatedList=1;
    self.relatedGalleriesList=[[NSMutableArray alloc] init];
    self.canLoadMore=YES;
    [self.tableView setHidden:YES];
    [self.loadingLabel setHidden:NO];
    
    if (self.albumItem.albumId!=0) {
        
        [self updateUIElementsWithAlbumObject];
        
    }
    else
    {
        PagerAdsViewController *adsViewController =[[PagerAdsViewController alloc]init];
        [self addChildViewController:adsViewController];
        adsViewController.view.frame=CGRectMake(self.view.frame.origin.x,-40, self.view.frame.size.width,  self.view.frame.size.height+40);;
        [self.view addSubview:adsViewController.view];
        [adsViewController didMoveToParentViewController:self];
    }
    self.tableView.tableHeaderView=[self setBannerAdView];

    
    // lock orientation to portrait only
    appDelegate.isFullScreen=NO;
    [appDelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:appDelegate.window];
    
    [self loadPostQuareRequest];
    [self setCommentsBtnRoundCorners];
    [self getGalleriesDetailsAPI];
    [self addBannersSliderView];
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(albumBtnPressed:)];
    gesture.numberOfTapsRequired = 1 ;
    gesture.view.userInteractionEnabled = YES;
    [self.TopimageView addGestureRecognizer:gesture];
    [self setCoSponsorScreenSponsor];
    //[self setNavigationBtns];
//    if([self.parentViewController isKindOfClass:[UIPageViewController class]])
//        self.parentViewController.title = @"ألبومات";
//    else
//        self.title = @"ألبومات";
    
    self.scrollContent.bounces = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView*) setBannerAdView
{
    UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0,0, Screenwidth, 270)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(300, 250));
    DFPBannerView * bannerView=[[DFPBannerView alloc]initWithAdSize:customAdSize origin:CGPointMake((Screenwidth-300)/2-10, 0)];
    [footerView setBackgroundColor:[UIColor lightGrayAppColor]];
    bannerView.adUnitID = MeduimRectangle_AD_UNIT_ID;
    bannerView.delegate = self;
    bannerView.adSize=customAdSize;
    bannerView.rootViewController = self;
    DFPRequest *request = [DFPRequest request];
    request.keywords = @[@"Inner"];
    NSMutableArray * list=[[NSMutableArray alloc]init];
    [list addObjectsFromArray:[self getSectionNamesList]];
    [list addObjectsFromArray:[self getRelatedDate]];
    [list addObjectsFromArray:@[@"Inner",@"Album"]];
    request.customTargeting = [[NSDictionary alloc]initWithObjects:@[list,@[@"Pos1"]] forKeys:@[@"Keyword",@"Position"]];
    [super setscreenAnalyticsMetricsWithScreenName:[NSString stringWithFormat:@"iOS- Gallery details with Gallery ID =%li",(long)self.albumItem.albumId] andKeywords:[list componentsJoinedByString:@","]];

    [bannerView loadRequest:request];
    [footerView addSubview:bannerView];
    return footerView;
}
//To get sportes date and concatnate it into string to send the string to google analytics and ads
-(NSArray*)getRelatedDate{
    NSMutableArray * list=[[NSMutableArray alloc]init];
    for (ChampionShipData * champ in self.albumItem.relatedData.championships) {
        [list addObject:[NSString stringWithFormat:@"بطولة %@",champ.name]];
    }
    for (Player * item in self.albumItem.relatedData.people) {
        [list addObject:[NSString stringWithFormat:@"لاعب %@",item.name]];
    }
    for (MatchCenterDetails * item in self.albumItem.relatedData.matches) {
        [list addObject:[NSString stringWithFormat:@"مباراة %@ و %@",item.homeTeamName,item.awayTeamName]];
    }
    // NSString * outputListStr = [list componentsJoinedByString:@","];
    return [[NSArray alloc]initWithArray:list];
}

-(NSArray*)getSectionNamesList
{
    NSMutableArray * sectionNames=[[NSMutableArray alloc]init];
    for (NewsSectionId * item in self.albumItem.sectionIds) {
        Section * section =[[Global getInstance]getSectionItemWithSectionID:item.sectionId];
        if(section.sectionName!=nil)
            [sectionNames addObject:[NSString stringWithFormat:@"قسم %@",section.sectionName]];
    }
    return sectionNames;
}
-(void) getGalleriesDetailsAPI
{
    if(alertView != nil)
    {
        [alertView close];
        alertView = nil;
    }
    
    if([Global getInstance].appInfo.isPostquareActive)
        [self getPostSquarePosts];
    //Show Loading view
    [self.indLoader startAnimating];
    [self.loadingIndicator startAnimating];
    NSString * albumAPIUrl =[NSString stringWithFormat:Albums_Details_API_Url,[WServicesManager getApiBaseURL],self.albumItem.albumId];
    [WServicesManager getDataWithURLString:albumAPIUrl andParameters:nil WithObjectName:@"Albums" andAuthenticationType:CMSAPIs success:^(id success)
     {
         Albums * response = success;
         self.albumItem = response.info;
         [self updateUIElementsWithAlbumObject];
         [self.loadingIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Gallery Details with ID = %li ",(long)self.albumItem.albumId] ApiError:@"Success"];
         dispatch_async(dispatch_get_main_queue(), ^{
             self.tableView.tableHeaderView=[self setBannerAdView];
         });
     }failure:^(NSError *error) {
         [self.loadingIndicator stopAnimating];
         IBGLog(@"Galllery Details Error %@",error);
         [self showReloadAlert];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Gallery Details with ID = %li ",(long)self.albumItem.albumId] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getGalleriesDetailsAPI];
                                          }];
     }];
}
-(void)viewWillAppear:(BOOL)animated{
    if(self.albumItem.albumId != 0)
        [self setNavigationBtns];
    else
        self.parentViewController.navigationItem.rightBarButtonItems=nil;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.bgcolor=[Global getInstance].bgcolor;
    if(self.fontSize!=[Global getInstance].fontSize||self.textColor!=[Global getInstance].textColor){
        self.textColor=[Global getInstance].textColor;
        self.fontSize=[Global getInstance].fontSize;
    }
    [self.contentView setBackgroundColor:self.bgcolor];
    [super viewDidAppear:animated];

    [super setUpBannerUnderNav:self.view anotherTopView:nil];
}

-(void)loadPostQuareRequest
{
    if(self.postQuareUrlStr != nil && ![self.postQuareUrlStr isEqualToString:@""])
    {
        self.postquareWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self.postquareWebView setTag:4444];
        self.postquareWebView.navigationDelegate=self;
        [self.postquareWebView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",self.postQuareUrlStr]]]];
    }
    
}
-(void)getPostSquarePosts
{
    postSquarePosts = [[NSArray alloc]init];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    // pubid=152986&webid=116602&wid=105912&url=http://www.filgoal.com/articles/293709
    [dic setObject:[NSString stringWithFormat:@"%i",152986] forKey:@"pubid"];
    [dic setObject:[NSString stringWithFormat:@"%i",116602] forKey:@"webid"];
    [dic setObject:[NSString stringWithFormat:@"%i",105912] forKey:@"wid"];
    [dic setObject:[NSString stringWithFormat:@"http://www.filgoal.com/albums/%li",(long)self.albumItem.albumId] forKey:@"url"];
    
    [WServicesManager getDataWithURLString:POSTSQUARE_BASE_URL andParameters:dic WithObjectName:nil andAuthenticationType:NoAuth success:^(NSDictionary *newsData){
        PostSquareClass * posts=[[PostSquareClass alloc]initWithDictionary:newsData];
        if(posts.recs.count>0)
        {
            [sections setObject:posts.recs forKey:@"محتوي قد يعجبك"];
            postSquarePosts = posts.recs;
            
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            self.tableViewHeightConstraint.constant=self.tableView.contentSize.height+50;
            [self.view updateConstraintsIfNeeded];
            
        }
        
        
    } failure:^(NSError *error) {
        IBGLog(@"Gallery Details Error  : %@",error);
        
        
    }];
}




-(void) addBannersSliderView
{
    if([Global getInstance].appInfo.specialSection.isActive&&[Global getInstance].appInfo.specialSection.isNewsDetailsBannersActive)
    {
        self.bannersSliderView.hidden=NO;
        BannersSliderViewController * sliderView=[[BannersSliderViewController alloc]init];
        sliderView.isFromHome=NO;
        sliderView.view.frame=CGRectMake(0, 10, Screenwidth,100);
        [self addChildViewController:sliderView];
        [self.bannersSliderView addSubview:sliderView.view];
        self.bannerSliderHeightConstraint.constant=120;
        [self didMoveToParentViewController:sliderView];
        
    }
    else
    {
        self.bannerSliderHeightConstraint.constant=0;
        self.bannersSliderView.hidden=YES;
    }
    
}
#pragma mark - Screen Sponsors
-(void)setCoSponsorScreenSponsor
{
    self.sponser.hidden=YES;
    NSString * sponsorUrl;
    for (NewsSectionId * item in self.albumItem.sectionIds) {
        if([AppSponsors isSectionCoSponsorActiveUsingId:item.sectionId])
        {
            self.sponser.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:item.sectionId category: @"Albums"];
            sponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSectionBannerStripeImagePathUsingSectionId:item.sectionId andContentType:@"Albums"]];
            [self.sponser sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(error)
                {
                    self.sponser.hidden=YES;
                    //        self.sponsorImgHeightConstraint.constant = 0;

                }
                else
                {
                    self.sponser.hidden=NO;
                        self.sponsorImgHeightConstraint.constant =30;

                }
            }];
            break;
        }
    }
    
}
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    /// Main Sponsorship
    for (NewsSectionId * item in self.albumItem.sectionIds) {
        if([AppSponsors isSectionActiveUsingId:item.sectionId])
        {
            mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSpecialSectionBannerImagePathUsingId:item.sectionId]];
            [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:item.sectionId activeCategory: nil];
            break;
        }
    }
    if((mainSponsorUrl==nil||[mainSponsorUrl isEqualToString:@""])&&[AppSponsors isAlbumsSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"Albums"]];
        [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: @"Albums"];
    }
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];
}
- (IBAction)commentsBtnAction:(id)sender {
    GlobalViewController * webView=[[GlobalViewController alloc]init];
    webView.url=[NSURL URLWithString:[NSString stringWithFormat:DISQUS_URL,@"album",self.albumItem.albumId]];
    [self.navigationController pushViewController:webView animated:YES];
    
}

- (void)adViewDidReceiveAd:(DFPBannerView *)adView {
}

/// Tells the delegate an ad request failed.
- (void)adView:(DFPBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
}
#pragma mark tableView deleg
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections.allValues.count;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];
    
    [headerView setBackgroundColor:[UIColor lightGrayAppColor]];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(8, 5, self.tableView.frame.size.width-30, 25)];
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:title.font.pointSize]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentRight];
    [title setBackgroundColor:[UIColor clearColor]];
    if(sections.count>section)
        title.text = [[sections allKeys]objectAtIndex:section];
    [headerView addSubview:title];
    return headerView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [(NSArray*)[[sections allValues]objectAtIndex:section]count];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    if ([[[[sections allValues]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] isKindOfClass:[Album class]]) {
        NewsCustomCell *cell;
        Album * item=[self.relatedGalleriesList objectAtIndex:indexPath.row];
        if (cell == nil)
        {
            cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
            cell.hideDeleteBtn = YES;
            
        }
        Picture * firstPictureItem;
        if(item.pictures.count>0)
            firstPictureItem=[item.pictures objectAtIndex:0];
        [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:firstPictureItem.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                      [((NewsCustomCell*)cell).activityIndicator stopAnimating];
                                                  }];
        cell.playImg.image = [UIImage imageNamed:@"ic_album"];
        [( (NewsCustomCell*)cell).itemLbl setText:item.albumTitle];
        
        cell.playImg.hidden=NO;
        ( (NewsCustomCell*)cell).dateLabel.hidden = YES;
        return cell;
    }
    else
    {
        static NSString * cellIdentifier = @"Cell";
        NewsCustomCell *cell;
        Rec * postSqureItem=[postSquarePosts objectAtIndex:indexPath.row ];
        if(postSqureItem.postId==0)
        {
            UITableViewCell * logoCell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
            if(logoCell == nil)
            {
                logoCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                UIImage * image =[UIImage imageNamed:@"Postquare"];
                UIImageView * logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, image.size.width, image.size.height)];
                logoImgView.image = [UIImage imageNamed:@"Postquare"];
                
                [logoCell addSubview:logoImgView];
            }
            return logoCell;
            
        }
        
        else
        {
            if (cell == nil)
            {
                cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
                cell.hideDeleteBtn = YES;
                
                
            }
            [( (NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",postSqureItem.thumbnailPath]]placeholderImage:[UIImage imageNamed:@"place_holder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [( (NewsCustomCell*)cell).activityIndicator stopAnimating];
            }];
            NSString * title =[postSqureItem.title stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
            
            [( (NewsCustomCell*)cell).itemLbl setText:title];
            [( (NewsCustomCell*)cell).dateLabel setText:postSqureItem.displayName];
            NSString *urlToOpen = [NSString stringWithFormat:@"%@",postSqureItem.url];
            
            if([urlToOpen rangeOfString:@"/videos"].location  != NSNotFound)
            {
                cell.playImg.image = [UIImage imageNamed:@"play_button"];
                cell.playImg.hidden=NO;
            }
            else if([urlToOpen rangeOfString:@"/albums"].location  != NSNotFound)
            {
                cell.playImg.hidden=NO;
                cell.playImg.image = [UIImage imageNamed:@"ic_album"];
            }
            else
                cell.playImg.hidden=YES;
            
            
            return cell;
        }
        
        
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[[[sections allValues]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] isKindOfClass:[Rec class]])
    {
        Rec * item =[postSquarePosts objectAtIndex:indexPath.row];
        NewsItem * newsItem ;
        VideoItem * videoItem ;
        if(item.postId==0)
        {
        }
        else
        {
            NSString *urlToOpen = [NSString stringWithFormat:@"%@",item.url];
            
            if([urlToOpen rangeOfString:@"/articles"].location  != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"articles/"];
                newsItem=[[NewsItem alloc] init];
                if(elts.count>1)
                    newsItem.newsId=[[elts objectAtIndex:1] intValue];
                newsItem.newsTitle=item.title;
                UIViewController * newsDetailsScreenWebView;
                
                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
                {
                    newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:newsItem ];
                    ((NewsDetailsViewControllerWithWKWebView*)newsDetailsScreenWebView).postQuareUrlStr = item.clickUrl;
                    
                    
                    
                }
                else
                {
                    newsDetailsScreenWebView=[[NewsDetailsViewController alloc] initWithNewsItem:newsItem ];
                    ((NewsDetailsViewController*)newsDetailsScreenWebView).postQuareUrlStr = item.clickUrl;
                }
                [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
            }
            else   if([urlToOpen rangeOfString:@"/videos"].location  != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"videos/"];
                videoItem=[[VideoItem alloc] init];
                if(elts.count>1)
                    videoItem.videoId=[[elts objectAtIndex:1] intValue];
                videoItem.videoTitle=item.title;
                VideoDetailsViewController * newsDetailsScreenWebView=[[VideoDetailsViewController alloc]initWithVideo:videoItem];
                newsDetailsScreenWebView.postQuareUrlStr = item.clickUrl;
                [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
            }
            else   if([urlToOpen rangeOfString:@"/albums"].location  != NSNotFound){
                Album * albumItem = [[Album alloc]init] ;
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"albums/"];
                if(elts.count>1)
                    albumItem.albumId=[[elts objectAtIndex:1] intValue];
                albumItem.albumTitle=item.title;
                GalleryDetailsViewController * viewController=[[GalleryDetailsViewController alloc]init];
                viewController.albumItem = albumItem;
                viewController.postQuareUrlStr = item.clickUrl;
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else
                
            {
                GlobalViewController * webView=[[GlobalViewController alloc]init];
                webView.url= [NSURL URLWithString:[NSString stringWithFormat:@"http:%@",item.clickUrl]];
                [self.navigationController pushViewController:webView animated:YES];
            }
        }
    }
    
    
}

#pragma Btn Action
-(IBAction)changeFontTape:(id)sender{
    
    
    if (self.fontSize==25) {
        self.fontSize=15;
    }
    else{
        self.fontSize = ( self.fontSize >= 25) ?  self.fontSize -5 :  self.fontSize+5;
    }
    [Global getInstance].fontSize=self.fontSize;
    
}

-(IBAction)backBtnTaped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)share:(id)sender{
    
    NSString *text =self.albumItem.albumTitle;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.filgoal.com/albums/%li",(long)self.albumItem.albumId]];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url]
     applicationActivities:nil];
    
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    [self presentViewController:controller animated:YES completion:nil];
}


-(void)updateUIElementsWithAlbumObject
{
    Picture * firstPictureItem;
    if(self.albumItem.pictures.count>0)
        firstPictureItem=[self.albumItem.pictures objectAtIndex:0];
    if(self.relatedGalleriesList.count>0)
    {
        [sections setObject:self.relatedGalleriesList forKey:@"صور متعلقة"];
        [self.tableView reloadData];
        [self.tableView layoutIfNeeded];
    }
    pictures = [[NSMutableArray alloc]initWithArray:self.albumItem.pictures];
    if(pictures.count>0)
    [pictures removeObjectAtIndex:0];
    [self.collectionView reloadData];
    // self.newsWriterLabel.text = self.albumItem.byline;
    if(self.albumItem.byline != nil || ![self.albumItem.byline isEqualToString:@""])
        self.newsDateLabel.text = [NSString stringWithFormat:@"%@  |  %@", self.albumItem.albumDate,self.albumItem.byline];
    else
        self.newsDateLabel.text = self.albumItem.albumDate;
    
    self.canLoadMore=YES;
    [self.tableView setHidden:NO];
    [self.loadingLabel setHidden:YES];
    [self setMainSponsor];
    [self.tableView layoutIfNeeded];
    self.tableViewHeightConstraint.constant=self.tableView.contentSize.height;
    [self.view updateConstraintsIfNeeded];
    [self.titleLbl setText:self.albumItem.albumTitle];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:17],
                                 NSForegroundColorAttributeName: [UIColor greyColor]};
    
    if(self.albumItem.albumDescription != nil)
    {
        NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:self.albumItem.albumDescription attributes:attributes];
        
        _detailsTxtView.attributedText = attributedString;
    }
    self.detailsTxtView.dataDetectorTypes = UIDataDetectorTypeLink;
    [self.detailsTxtView setTextAlignment:NSTextAlignmentRight];
    
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:firstPictureItem.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.indLoader stopAnimating];
        
    }];
    

    
}

#pragma mark - UICollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.albumItem.pictures.count>3)
        return 3;
    else
        return self.albumItem.pictures.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // Add inset to the collection view if there are not enough cells to fill the width.
    CGFloat cellSpacing = ((UICollectionViewFlowLayout *) collectionViewLayout).minimumLineSpacing;
    CGFloat cellWidth = ((UICollectionViewFlowLayout *) collectionViewLayout).itemSize.width;
    NSInteger cellCount = [collectionView numberOfItemsInSection:section];
    CGFloat inset = (collectionView.bounds.size.width - (cellCount * cellWidth) - ((cellCount - 1)*cellSpacing)) * 0.5;
    inset = MAX(inset, 0.0);
    return UIEdgeInsetsMake(0.0, inset, 0.0, 0.0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ImageCollectionViewCell";
    Picture * item = [pictures objectAtIndex:indexPath.item];
    ImageCollectionViewCell *cell =(ImageCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:item.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [cell.activityIndicator stopAnimating];
        
    }];
    cell.imgView.layer.borderWidth = 0.0f;
    
    if(indexPath.item == 1)
    {
        cell.imgView.layer.borderWidth = 2.0f;
        cell.imgView.layer.borderColor = [[UIColor mainAppYellowColor]CGColor];
    }
    else if(indexPath.item == 2)
    {
        cell.nOfImagesLbl.hidden=NO;
        if(self.albumItem.pictures.count>5)
        {
            [cell.nOfImagesLbl setText:[NSString stringWithFormat:@"%lu +",(unsigned long)self.albumItem.pictures.count-4]];
        }
    }
    else
    {
        cell.nOfImagesLbl.hidden=YES;
        
    }
    
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.photos = [[NSMutableArray alloc]init];
//    if(indexPath.item==0)
//        selectedIndex=1;
//    else
    selectedIndex = indexPath.item+1;
  //  int repeatCount=[Global getInstance].appInfo.adsNewsListingFrequencey;
    for(Picture * item in self.albumItem.pictures)
    {
        MWPhoto * photo =[[MWPhoto alloc]initWithURL:[NSURL URLWithString:item.urls.large]];
        photo.caption = item.urls.caption;
        [self.photos addObject:photo];
        
    }

    [self showImageController];
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(90, 90);
    return size;
}
#pragma mark Photo Gallery

//#pragma mark - Photo Gallery
-(void)showImageController
{
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    // Set options
    //browser.displayActionButton = YES;
    //browser.alwaysShowControls = NO;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;//YES;
    browser.startOnGrid = NO;
    [browser setCurrentPhotoIndex:selectedIndex];
    browser.autoPlayOnAppear = NO; // Auto-play first video
    int repeatCount=(int)[Global getInstance].appInfo.adsNewsListingFrequencey;
    if(repeatCount>0) {
        //SMGL browser.isAdsEnabled=YES;
    }
    browser.hidesBottomBarWhenPushed = YES;
    [browser hideNavbar];
    // Present
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
     nc.modalPresentationStyle = UIModalPresentationFullScreen ;
    nc.title = @"close";
    [self presentViewController:nc animated:YES completion:nil];
    
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}
#pragma mark - MWPhotoBrowser Delegates
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        
        return [self.photos objectAtIndex:index];
    }
    return nil;
}


- (IBAction)albumBtnPressed:(id)sender {
    selectedIndex = 0;
    self.photos = [[NSMutableArray alloc]init];
    int repeatCount=0;

    for(Picture * item in self.albumItem.pictures)
    {
        MWPhoto * photo =[[MWPhoto alloc]initWithURL:[NSURL URLWithString:item.urls.large]];
        photo.caption = item.urls.caption;
        [self.photos addObject:photo];
        
    }
    int numOfAdsOnPager = (repeatCount>0) ? (int)self.photos.count/repeatCount : 0;
    
    for (int i=0; i<numOfAdsOnPager; i++) {
        [self.photos insertObject:[[UIView alloc]init] atIndex:i+repeatCount+repeatCount*i];
    }
    
    [self showImageController];
}

-(void) setCommentsBtnRoundCorners
{
    self.commentsBtn.layer.cornerRadius = 6.0;
    self.commentsBtn.clipsToBounds = YES;
}

#pragma mark - Create Custom Dialogue
- (void)showReloadAlert
{
    alertView = [[CustomIOSAlertView alloc] init];
    ReloadViewController * reloadViewController = [[ReloadViewController alloc]init];
    [alertView setContainerView:reloadViewController.view];
    _canLoadMore = YES;
    [reloadViewController.retryBtn addTarget:self action:@selector(getGalleriesDetailsAPI) forControlEvents:UIControlEventTouchUpInside];
    [alertView setButtonTitles:nil];
    [alertView setUseMotionEffects:true];
    [alertView show];
}


-(void)setNavigationBtns
{
    // Add rightbar button to refresh match details view
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    shareButton.bounds = CGRectMake(Screenwidth-20,0,16,18);
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    self.parentViewController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    
}

@end

