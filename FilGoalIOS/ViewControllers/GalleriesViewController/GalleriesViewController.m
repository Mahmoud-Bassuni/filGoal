//
//  GalleriesViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 4/19/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "GalleriesViewController.h"
#import "Albums.h"
#import "AlbumCustomCellTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GalleryDetailsViewController.h"
#import "PagerViewController.h"
@import Firebase;
@interface GalleriesViewController ()
{
    int page ;
    NSMutableArray * albums;
    NSMutableArray * albumsWithBannerAds;
    NSMutableArray * albumsWithPagerAds;
    UIRefreshControl *topRefreshControl;
    CustomIOSAlertView *alertView;

    
}
@end
#define ExtraPadding 20

@implementation GalleriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    albums = [[NSMutableArray alloc]init];
    albumsWithPagerAds = [[NSMutableArray alloc]init];
    albumsWithBannerAds = [[NSMutableArray alloc]init];
    self.screenName = @"iOS - Galleries";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS - Galleries"
                                     }];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    page = 0;
    [self getGalleriesListAPI];
    [self addBottomPullToRefresh];

    if(self.teamId == 0&& self.playerId == 0&& self.champId==0)
       [self addTopPullToRefresh];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self setScreenCoSponsor];
    if(self.sectionId==0&&self.champId==0)
    [self setMainSponsor];
   // self.title = @"الصور";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addTopPullToRefresh
{
    topRefreshControl = [UIRefreshControl new];
    topRefreshControl.tintColor = [UIColor blackColor];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14],
                                 NSForegroundColorAttributeName: [UIColor blackColor]};
    topRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"جاري تحميل الصور" attributes:attributes];
    [topRefreshControl addTarget:self action:@selector(refreshTop) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:topRefreshControl];
}
-(void)addBottomPullToRefresh
{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor blackColor];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14],
                                 NSForegroundColorAttributeName: [UIColor blackColor]};
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"جاري تحميل الصور" attributes:attributes];
    refreshControl.triggerVerticalOffset = 80.;
    [refreshControl addTarget:self action:@selector(refreshBottom) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl=refreshControl;
}
- (void)refreshTop {

    page=0;
    if(alertView != nil)
    {
        [alertView close];
        alertView = nil;
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
        [self.loadingLbl setHidden:NO];
    }
    [self getGalleriesListAPI];
}
-(void)refreshBottom
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self getGalleriesListAPI];
        [self.tableView.bottomRefreshControl endRefreshing];
    });
}
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    if([AppSponsors isAlbumsSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"Albums"]];
        [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: @"Albums"];
    }
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];

}
-(void) getGalleriesListAPI
{

    [self.activityIndicator startAnimating];
    NSDictionary * paramDic;
    NSString * urlString;
    if(self.playerId ==0 && self.teamId == 0 && self.champId == 0&&self.sectionId==0)
    {
    paramDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%i",++page]] forKeys:@[@"page"]];
        urlString = [NSString stringWithFormat:Albums_API_Url,[WServicesManager getApiBaseURL]];
    }
    else if (self.playerId != 0)
    {
        paramDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%i",++page],[NSString stringWithFormat:@"%i",self.playerId]] forKeys:@[@"page",@"id"]];
        urlString = [NSString stringWithFormat:PlayerAlbumsAPI,[WServicesManager getApiBaseURL]];


    }
    else if (self.teamId != 0)
    {
        paramDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%i",++page],[NSString stringWithFormat:@"%i",self.teamId]] forKeys:@[@"page",@"id"]];
        urlString = [NSString stringWithFormat:TeamAlbumsAPI,[WServicesManager getApiBaseURL]];
        
        
    }
    else if (self.champId != 0)
    {
        paramDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%i",++page],[NSString stringWithFormat:@"%i",self.champId]] forKeys:@[@"page",@"id"]];
        urlString = [NSString stringWithFormat:ChampionshipAlbumsAPI,[WServicesManager getApiBaseURL]];
        
        
    }
    else if (self.sectionId != 0)
    {
        paramDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%i",++page],[NSString stringWithFormat:@"%i",self.sectionId]] forKeys:@[@"page",@"Secid"]];
        urlString = [NSString stringWithFormat:Albums_API_Url,[WServicesManager getApiBaseURL]];
        
        
    }
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:[NSString stringWithFormat:@"iOS- Galleries ID-%d page %d",self.sectionId,page]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    [WServicesManager getDataWithURLString:urlString andParameters:paramDic WithObjectName:@"Albums" andAuthenticationType:CMSAPIs success:^(id success)
     {
         if(alertView != nil)
             [alertView close];
         if(topRefreshControl.isRefreshing)
         {
             [topRefreshControl endRefreshing];
             albums = [[NSMutableArray alloc]init];
         }
         Albums * response = success;
         [albums addObjectsFromArray:response.albums];
         BOOL isPagerAdsEnabled = NO;
         for (AdsEnabledPerVersion *temp in [Global getInstance].appInfo.adsEnabledPerVersion){
             
             if([temp.versionCode isEqualToString: [super appVersion]]){
                 isPagerAdsEnabled = temp.isPagerAdsEnabled;
             }
         }
       //  albumsWithPagerAds=[[CustiomizeAdTypes alloc]initializeIntersitialCustomAdsWithUnitID:MeduimRectangle_AD_UNIT_ID andItemsList:albums andRepeatCount:[Global getInstance].appInfo.adsRepeatCount andViewController:self];

         if(isPagerAdsEnabled)
         albumsWithPagerAds=[[CustiomizeAdTypes alloc]initializeIntersitialCustomAdsWithUnitID:MeduimRectangle_AD_UNIT_ID andItemsList:albums andRepeatCount:[Global getInstance].appInfo.adsRepeatCount andViewController:self];
         else
             albumsWithPagerAds=[[NSMutableArray alloc]initWithArray:albums];;

         if(self.teamId!=0)
         {
         albumsWithBannerAds= [[CustiomizeAdTypes alloc]initalizeBannerAdsWithUnitID:MeduimRectangle_AD_UNIT_ID andItemsList:albums andAdSize:kGADAdSizeMediumRectangle andRepeatCount:[Global getInstance].appInfo.adsNewsListingFrequencey andViewController:self andKeywords:@[@"Inner",@"Team",[NSString stringWithFormat:@"فريق %@",self.teamName]]];
         }
         else if(self.champId!=0)
         {
             albumsWithBannerAds= [[CustiomizeAdTypes alloc]initalizeBannerAdsWithUnitID:MeduimRectangle_AD_UNIT_ID andItemsList:albums andAdSize:kGADAdSizeMediumRectangle andRepeatCount:[Global getInstance].appInfo.adsNewsListingFrequencey andViewController:self andKeywords:@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",_champName]]];

         }
         else if(self.sectionId!=0)
         {
             albumsWithBannerAds= [[CustiomizeAdTypes alloc]initalizeBannerAdsWithUnitID:MeduimRectangle_AD_UNIT_ID andItemsList:albums andAdSize:kGADAdSizeMediumRectangle andRepeatCount:[Global getInstance].appInfo.adsNewsListingFrequencey andViewController:self andKeywords:@[@"Inner",@"Section",[NSString stringWithFormat:@"قسم %@",_sectionName]]];

         }
         else
         {
             albumsWithBannerAds= [[CustiomizeAdTypes alloc]initalizeBannerAdsWithUnitID:MeduimRectangle_AD_UNIT_ID andItemsList:albums andAdSize:kGADAdSizeMediumRectangle andRepeatCount:[Global getInstance].appInfo.adsNewsListingFrequencey andViewController:self andKeywords:@[@"Inner",@"قسم الصور"]];

         }
         
         [self.activityIndicator setHidden:YES];
         [self.activityIndicator stopAnimating];
         [self.loadingLbl setHidden:YES];
         
         if(albums.count>0)
         {
             [self.tableView setHidden:NO];
             [self.tableView reloadData];

         }
         else
         {
             [self.loadingLbl setText:@"لم يتم العثور علي صور"];
             [self.loadingLbl setHidden:NO];
             [self.tableView setHidden:YES];
             
         }
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Galleries Screen" ApiError:@"Success"];

         
     }failure:^(NSError *error) {
         [self.loadingLbl setText:@"لم يتم العثور علي صور"];
         IBGLog(@"Galleries Error  : %@",error);
         [self.loadingLbl setHidden:NO];
         [self.activityIndicator setHidden:YES];
         [self.activityIndicator stopAnimating];
         [self.tableView setHidden:YES];
//         if(alertView == nil)
//             [self showReloadAlert];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Galleries" ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getGalleriesListAPI];
                                          }];

         
     }];
}
-(void)setScreenCoSponsor
{
    if(self.sectionId !=0&&[AppSponsors isSectionCoSponsorActiveUsingId:self.sectionId])
    {
        NSString * sponsorUrl=[AppSponsors getSectionBannerStripeImagePathUsingSectionId:self.sectionId andContentType:@"Albums"];
        self.sponsorImgView.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:self.sectionId category:@"Albums"];
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgHeightConstraint.constant=image.size.height;
        }];
    }
    else if(self.champId !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.champId])
    {
        NSString * sponsorUrl=[AppSponsors getListingSponsorImagePathUsingChampionId:self.champId andContentType:@"Albums"];
        self.sponsorImgView.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.champId category:@"Albums"];
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgHeightConstraint.constant=image.size.height;
        }];
    }
    else
    {
        self.sponsorImgHeightConstraint.constant=0;
        
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return albumsWithBannerAds.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Album * item=[albumsWithBannerAds objectAtIndex:indexPath.row];
    UITableViewCell *cell ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if([[albumsWithBannerAds objectAtIndex:indexPath.row]isKindOfClass:[GADBannerView class]])
    {
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:(GADBannerView*)[albumsWithBannerAds objectAtIndex:indexPath.row]];
        
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
        [((StoryCell*)cell)initWithAlbumItem:item];
        return    cell;

    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[albumsWithBannerAds objectAtIndex:indexPath.row]isKindOfClass:[GADBannerView class]])
    {
        return [(GADBannerView*)[albumsWithBannerAds objectAtIndex:indexPath.row]adSize].size.height+20;
        
    }
    else
       {
           if (IS_IPHONE_6_PLUS) {
               return IPHONE_6Plus_Cell_Hieght+ExtraPadding;
           }
           else if (IS_IPHONE_6)
           {
               return IPHONE_6_Cell_Hieght+ExtraPadding;
           }
           else
           {
               return IPHONE_4_5_Cell_Hieght+ExtraPadding;
           }
       }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[albumsWithBannerAds objectAtIndex:indexPath.row]isKindOfClass:[GADBannerView class]])
    {

        
    }
    else
    {
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        Album * item = [albumsWithBannerAds objectAtIndex:indexPath.row];
        GalleryDetailsViewController * viewController =[[GalleryDetailsViewController alloc]init];
        viewController.albumItem = item;
        viewController.pageIndex = indexPath.row;
//        [self.navigationController pushViewController:viewController animated:YES];
        PagerViewController * pagerViewController = [[PagerViewController alloc]init];
        pagerViewController = [[PagerViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
       int currentIndex = (int) [albums indexOfObject:[albumsWithBannerAds objectAtIndex:indexPath.row]];
        pagerViewController.storiesListWithAds = albumsWithPagerAds;
        pagerViewController.stories = albums;
        pagerViewController.selectedAlbum = item;
        pagerViewController.currentIndex = indexPath.row;
        pagerViewController.pageNum = page;
        [pagerViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        [appDelegate.getSelectedNavigationController pushViewController:pagerViewController animated:YES];
    }
    
}

#pragma mark - Create Custom Dialogue
- (void)showReloadAlert
{
    alertView = [[CustomIOSAlertView alloc] init];
    ReloadViewController * reloadViewController = [[ReloadViewController alloc]init];
    [alertView setContainerView:reloadViewController.view];
    [reloadViewController.retryBtn addTarget:self action:@selector(refreshTop) forControlEvents:UIControlEventTouchUpInside];
    [alertView setButtonTitles:nil];
    [alertView setUseMotionEffects:true];
    [alertView show];
}
#pragma - mark XLPagerTabStripChildItem
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    if( self.champId != 0||self.sectionId!= 0)
    {
        if (targetContentOffset->y > 0){
            //NSLog(@"up");
          //  self.tableView.scrollEnabled=YES;
        }
        else if (targetContentOffset->y == 0){
           // self.tableView.scrollEnabled=NO;
        }
    }
    else     if(self.teamId !=0)
    {
        if (velocity.y > 0){
            //NSLog(@"up");
            BOOL scroll= true;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"TeamScrollUpNotification"
             object:userInfo];
            
        }
        if (velocity.y < 0){
            //NSLog(@"down");
            BOOL scroll= false;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
            if(scrollView.contentOffset.y<=0)
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"TeamScrollDownNotification"
                 object:userInfo];
            
        }
    }
}


@end
