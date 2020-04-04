//
//  VideosViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "VideosViewController.h"
#import "Images.h"
#import "UIImageView+WebCache.h"
#import "VideoSearchViewController.h"
#import "NewsDetailsViewController.h"
#import "VideoDetailsViewController.h"
#import "VideosCellLoader.h"
#import  "AppInfo.h"
#import "Sponsor.h"
#import "Global.h"
#import "AppDelegate.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@import Firebase;
#define ExtraPadding 20

@interface VideosViewController ()
{
    NSMutableArray *itemsWithAdsArray;
    int pageNum;
    int adsVideoListingFrequencey;
    NSMutableArray *newsListWithMRBanners;
    NSString * sponsorUrl;
    NSInteger pageSize;
    CustomIOSAlertView *alertView;
    
    
}
@end

@implementation VideosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithSectionId:(int)sectionId
{
    self = [super init];
    if (self) {
        self.sectionId=sectionId;
        pageNum=0;
        // Custom initialization
    }
    return self;
}
-(void)setScreenSponsor
{
    if(self.sectionId !=0&&[AppSponsors isSectionCoSponsorActiveUsingId:self.sectionId])
    {
        NSString * sponsorUrl=[AppSponsors getSectionBannerStripeImagePathUsingSectionId:self.sectionId andContentType:@"Videos"];
        self.sponser.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:self.sectionId category:@"Videos"];
        [self.sponser sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgHeightConstraint.constant=image.size.height;
            self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        }];
    }
    else if(self.champId !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.champId])
    {
        NSString * sponsorUrl=[AppSponsors getListingSponsorImagePathUsingChampionId:self.champId andContentType:@"Videos"];
        self.sponser.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.champId category:@"Videos"];
        [self.sponser sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgHeightConstraint.constant=image.size.height;
            self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        }];
    }
    else
    {
        self.sponsorImgHeightConstraint.constant=0;
        
    }
}
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    if([AppSponsors isVideoSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"Videos"]];
        //[super setNavigationBarBackgroundImage:mainSponsorUrl];
        [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: @"Videos"];
    }
    else
    {
        [super setNavigationBarBackgroundImage];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.tableView.scrollEnabled=YES;
   
}
- (void)viewDidLoad
{
    [self check3DTouch];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shareVideo3DTouchActionPressed:) name:@"ShareVideoDetails" object:nil];
    
    self.screenName = [NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]
                                     }];
    [super viewDidLoad];
    newsListWithMRBanners=[[NSMutableArray alloc]init];
    self.videosList=[[NSMutableArray alloc] init];
    self.canLoadMore=YES;
    //Show Loading view
    [self.indLoader startAnimating];
    [self.indLoader setHidden:NO];
    [self.tableView setHidden:YES];
    [self.loadingLabel setHidden:NO];
    pageNum=0;
    [self LoadMoreVideoItems];
   // [self.tableView setContentOffset:CGPointMake(0, 45) animated:YES];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:nil action:@selector(updateArray:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    if([[Global getInstance]appInfo].adsVideoListingFrequencey!=0)
        adsVideoListingFrequencey=[[Global getInstance]appInfo].adsVideoListingFrequencey+1;
    [self setScreenSponsor];

    
    if(self.teamId!=0 || self.playerId !=0)
        self.searchBar.hidden = YES;
    else
    self.searchBar.hidden = NO;

    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    {
        self.searchBar.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addBottomPullToRefresh];
}
-(void)addBottomPullToRefresh
{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor blackColor];
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14],
//                                 NSForegroundColorAttributeName: [UIColor blackColor]};
   // refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"جاري تحميل الالبومات" attributes:attributes];
    refreshControl.triggerVerticalOffset = 80.;
    [refreshControl addTarget:self action:@selector(refreshBottom) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl=refreshControl;
}
-(void)refreshBottom
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
         [self LoadMoreVideoItems];
        [self.tableView.bottomRefreshControl endRefreshing];
    });
}

#pragma mark - 3D touch

- (void)check3DTouch {
    
    if (IOS_VERSION_GREATER_THAN_8) {
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self
                                         sourceView:self.tableView];
        } else {
            
            
        }
    }
}

# pragma mark - 3D Touch Delegate

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    // check if we're not already displaying a preview controller
    VideoItem * newsObject=[[VideoItem alloc]init];;
    NSIndexPath *indexPath =
    [self.tableView indexPathForRowAtPoint:location];
    //  int newindex;
    // int repateCount=[Global getInstance].appInfo.adsVideoListingFrequencey;
    if (indexPath&&indexPath.row>=0) {
        [self.tableView cellForRowAtIndexPath:indexPath];
        newsObject = newsListWithMRBanners[indexPath.row];
    }
    if ([self.presentedViewController isKindOfClass:[VideoDetailsViewController class]]) {
        return nil;
    }
    
    VideoDetailsViewController * videoScreen =  [[VideoDetailsViewController alloc] initWithVideoIndex:(int)indexPath.row withVideosList:newsListWithMRBanners];
    videoScreen.isFrom3DTouch=YES;
    
    return videoScreen;
}
-(void)shareVideo3DTouchActionPressed:(NSNotification*)note
{
    [[NSNotificationCenter defaultCenter]removeObserver:@"ShareVideoDetails"];
    VideoItem * videoItem=[note object];
    NSString *text =videoItem.videoTitle;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://filgoal.com/videos/%i",videoItem.videoId]];
    //UIImage *image = [UIImage imageNamed:@"roadfire-icon-square-200"];
    
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
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    VideoDetailsViewController *vc = (VideoDetailsViewController *)viewControllerToCommit;
    vc.isFrom3DTouch=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *shareAction =
    [UIPreviewAction actionWithTitle:@"Share"
                               style:UIPreviewActionStyleDefault
                             handler:^(UIPreviewAction *action,
                                       UIViewController *previewViewController){
                                 // call a delegate or present the mail composer
                             }];
    return @[shareAction];
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.navigationController.viewControllers.count>1&&self.champId==0)
    {
        [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
      //  self.title = @"فيديوهات";
    }
 
    if(self.sectionId==0&&self.champId==0)
        [self setMainSponsor];
    
    //if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
    //    [super setUpBannerUnderNav:self.view anotherTopView: nil];
    //}
}
-(void) updateArray :(UIRefreshControl *)sender {
    pageNum=0;
    pageSize=0;
    [self LoadMoreVideoItems];
    if(alertView != nil)
    {
        [self.loadingLabel setText:@"برجاء الانتظار قليلا ....."];
        [self.indLoader startAnimating];
        [self.indLoader setHidden:NO];
        [self.loadingLabel setHidden:NO];
        [alertView close];
        alertView = nil;
    }
}
-(void)LoadMoreVideoItems{
    if(self.canLoadMore==YES){
        NSString *lastDate=@"";
        NSDictionary *dictionary;
        NSString * urlString;
        if ([self.videosList count]>0&&!self.refreshControl.isRefreshing) {
            lastDate=((VideoItem*)[self.videosList objectAtIndex:self.videosList.count-1]).sourceDate;
        }
        if(self.teamId == 0 && self.playerId == 0 && self.champId == 0)
        {
        dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"15",[NSString stringWithFormat:@"%i",++pageNum],[NSString stringWithFormat:@"%i",self.sectionId], nil] forKeys:[NSArray arrayWithObjects:@"PageSize",@"page",@"SecId", nil] ];
            urlString = [NSString stringWithFormat:VideosAPI,[WServicesManager getApiBaseURL]];

        }
        else if(self.playerId != 0)
        {
            dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%li",(long)self.playerId],@"15",[NSString stringWithFormat:@"%i",++pageNum], nil] forKeys:[NSArray arrayWithObjects:@"id",@"PageSize",@"page", nil] ];
            urlString = [NSString stringWithFormat:PlayerVideosAPI,[WServicesManager getApiBaseURL]];
        }
        else if(self.teamId != 0)
        {
            dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%li",(long)self.teamId],@"15",[NSString stringWithFormat:@"%i",++pageNum], nil] forKeys:[NSArray arrayWithObjects:@"id",@"PageSize",@"page", nil] ];
            urlString = [NSString stringWithFormat:TeamVideosAPI,[WServicesManager getApiBaseURL]];
        }
        else if(self.champId != 0)
        {
            dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%li",(long)self.champId],@"15",[NSString stringWithFormat:@"%i",++pageNum], nil] forKeys:[NSArray arrayWithObjects:@"id",@"PageSize",@"page", nil] ];
            urlString = [NSString stringWithFormat:ChampionshipVideosAPI,[WServicesManager getApiBaseURL]];
        }
        self.canLoadMore=NO;
        // pageNum++;
        id tracker = [[GAI sharedInstance] defaultTracker];
        [tracker set:kGAIScreenName
               value:[NSString stringWithFormat:@"iOS-Videos List with Section ID-%d page %d",self.sectionId,pageNum]];
        [tracker send:[[GAIDictionaryBuilder createAppView] build]];
        
        [WServicesManager getDataWithURLString:urlString andParameters:dictionary WithObjectName:@"VideosList" andAuthenticationType:CMSAPIs success:^(VideosList * success)
         {
            if(alertView != nil)
                [alertView close];
            
            
            if (self.refreshControl.isRefreshing) {
                pageNum=0;
                [newsListWithMRBanners removeAllObjects];
                [self.videosList removeAllObjects];
                [self.refreshControl endRefreshing];
            }
            
            [self.videosList addObjectsFromArray: success.videos];
             if(self.videosList.count==0||self.teamId!=0 || self.playerId !=0 ||self.champId != 0||self.sectionId!=0)
             {
                 self.searchBar.hidden = YES;
                 self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
                 [_refreshControl removeFromSuperview];

             }
             else
             {
                 self.searchBar.hidden = NO;
             }
            NSArray *itemsArray=self.videosList;
            
            int repateCount=[Global getInstance].appInfo.adsVideoListingFrequencey;
            int numOfAdsOnPager = (repateCount>0) ? (int)itemsArray.count/repateCount : 0;
            
            newsListWithMRBanners=[[NSMutableArray alloc]initWithArray:itemsArray];
            for (int i=0; i<numOfAdsOnPager; i++) {
                [newsListWithMRBanners insertObject:[[VideoItem alloc]init] atIndex:i+repateCount+repateCount*i];
            }
            pageSize=newsListWithMRBanners.count;
            // send event to google analytics
            id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@" iOS - App Interaction"     // Event category (required)
                                                                  action:@"iOS - load more videos"  // Event action (required)
                                                                   label: [NSString stringWithFormat:@"iOS - load more videos with page num %i",pageNum]
                                                                   value:nil] build]];
            //  [self.videosList addObjectsFromArray: newsData];
            [self.tableView reloadData];
            self.canLoadMore=YES;
            
            //hide Loading View
            [self.indLoader stopAnimating];
            [self.indLoader setHidden:YES];
            [self.tableView setHidden:NO];
            [self.loadingLabel setHidden:YES];
            if (self.videosList.count==0) {
                self.canLoadMore=YES;
                [self.indLoader stopAnimating];
                [self.indLoader setHidden:YES];
                [self.loadingLabel setHidden:NO];
                self.loadingLabel.text=@"لم يتم العثور علي فيديوهات";
            }
             [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Videos Screen" ApiError:@"Success"];

            
        } failure:^(NSError *error) {
            self.canLoadMore=YES;
            [self.indLoader stopAnimating];
            [self.indLoader setHidden:YES];
            IBGLog(@"Videos List Error : %@",error);
            [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Videos Screen" ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];

            self.loadingLabel.text=@"لم يتم العثور علي فيديوهات";
//            if(alertView == nil)
//                [self showReloadAlert];
            [self showDefaultNetworkingErrorMessageForError:error
                                             refreshHandler:^{
                                                 [self LoadMoreVideoItems];
                                             }];
        }];
        
    }
}
#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return newsListWithMRBanners.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    VideoItem *item;
    if(newsListWithMRBanners.count>indexPath.row)
        item=[newsListWithMRBanners objectAtIndex:indexPath.row ];
    
    if(item.videoId==0)
        return 270;
    
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
    return 0.0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    VideoItem * item;
    if(newsListWithMRBanners.count>indexPath.row)
        item=[newsListWithMRBanners objectAtIndex:indexPath.row ];
    
    if(item==nil||item.videoId==0)
    {
        // adsFreqSum+=adsVideoListingFrequencey;
        //  adsVideoListingFrequencey+=adsFreqSum;
        UITableViewCell *   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 270)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        if(indexPath.row == [Global getInstance].appInfo.adsVideoListingFrequencey)
        {
            if(self.teamId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Team",[NSString stringWithFormat:@"فريق %@",self.teamName]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else if (self.champId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",_champName]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else if (self.sectionId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Section",[NSString stringWithFormat:@"قسم %@",_sectionName]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"قسم الفيديوهات"] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            
            
        }
        else if(indexPath.row == ([Global getInstance].appInfo.adsVideoListingFrequencey*2)+1)
        {
            if(self.teamId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Team",[NSString stringWithFormat:@"فريق %@",self.teamName]] andPosition:@[@"Pos2"]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else if (self.champId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",_champName]] andPosition:@[@"Pos2"]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else if (self.sectionId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Section",[NSString stringWithFormat:@"قسم %@",_sectionName]] andPosition:@[@"Pos2"]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"قسم الفيديوهات"] andPosition:@[@"Pos2"]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            
        }
        else
        {
            if(self.teamId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Team",[NSString stringWithFormat:@"فريق %@",self.teamName]] andPosition:@[]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else if (self.champId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",_champName]] andPosition:@[]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else if (self.sectionId !=0)
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"Section",[NSString stringWithFormat:@"قسم %@",_sectionName]] andPosition:@[]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
            else
                [cell addSubview:[super setBannerViewFooter:@[@"Inner",@"قسم الفيديوهات"] andPosition:@[]andScreenName:[NSString stringWithFormat:@"iOS-videos List with Section ID =%i",self.sectionId ]]];
        }
        
        
        return cell;
    }
    else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
        
        [((StoryCell*)cell)initWithVideoItem:item];
        
        return    cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *itemsArray=self.videosList;
    //  int index= self.NewsList.count/[Global getInstance].appInfo.adsNewsListingFrequencey;
    
    int repateCount=0;
    int numOfAdsOnPager =0 ;
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = appDelegate.getSelectedNavigationController;

    itemsWithAdsArray=[[NSMutableArray alloc]initWithArray:itemsArray];
    
    BOOL isPagerAdsEnabled = NO;
    for (AdsEnabledPerVersion *temp in [Global getInstance].appInfo.adsEnabledPerVersion){
        
        if([temp.versionCode isEqualToString: [super appVersion]]){
            
            isPagerAdsEnabled = temp.isPagerAdsEnabled;
            
        }
        
    }
    
    if(isPagerAdsEnabled){
        repateCount=(int)[Global getInstance].appInfo.adsRepeatCount;
        numOfAdsOnPager=(repateCount>0) ? (int)itemsArray.count/repateCount : 0;;
        for (int i=0; i<numOfAdsOnPager; i++) {
            [itemsWithAdsArray insertObject:[[VideoItem alloc]init] atIndex:i+repateCount+repateCount*i];
        }
    }
    int currentIndex =  (int)[itemsArray indexOfObject:[newsListWithMRBanners objectAtIndex:indexPath.row]];
    int newindex;
    newindex= (repateCount>0) ? currentIndex+((int)currentIndex/(int)repateCount) : currentIndex;
    
    if(newindex>=0)
    {
        NSArray *viewControllers = [NSArray arrayWithObject: [[VideoDetailsViewController alloc] initWithVideoIndex:newindex withVideosList:itemsWithAdsArray]];
        
        
        self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];self.pageController.view.backgroundColor=[UIColor blackColor];
        
        self.pageController.dataSource = self;
        self.pageController.view.frame=self.view.bounds;
        [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
        [navigationController pushViewController:self.pageController animated:YES];
    }
    
    
    
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *keyWord= searchBar.text;
    if (![keyWord isEqualToString:@""]) {
        VideoSearchViewController *searchVC=[[VideoSearchViewController alloc] initWithKeyWord:keyWord];
        [self.navigationController pushViewController:searchVC animated:YES];
        
    }
}

#pragma mark touch on table view to hide search bar
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

#pragma mark UIPageViewController dataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int index = [(VideoDetailsViewController *)viewController currentNewsIndex];
    
    
    index--;
    
    if (index<0) {
        return nil;
    }
    else{
        VideoDetailsViewController *childViewController =  [[VideoDetailsViewController alloc] initWithVideoIndex:index withVideosList:itemsWithAdsArray];
        
        return childViewController;
    }
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    int index = [(VideoDetailsViewController *)viewController currentNewsIndex];
    
    index++;
    if (index>=itemsWithAdsArray.count) {
        return nil;
    }
    
    else{
        
        VideoDetailsViewController *childViewController = [[VideoDetailsViewController alloc] initWithVideoIndex:index withVideosList:itemsWithAdsArray];
        
        
        return childViewController;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark GADBanner Delegate implementation
- (void)adView:(DFPBannerView *)banner didFailToReceiveAdWithError:(GADRequestError *)error
{
    //  [self.errorLbl setText:[NSString stringWithFormat:@"%@",error]];
    
}
- (void)adViewDidReceiveAd:(DFPBannerView *)bannerView
{
    
}
#pragma mark - Create Custom Dialogue
- (void)showReloadAlert
{
    alertView = [[CustomIOSAlertView alloc] init];
    ReloadViewController * reloadViewController = [[ReloadViewController alloc]init];
    [alertView setContainerView:reloadViewController.view];
    _canLoadMore = YES;
    [reloadViewController.retryBtn addTarget:self action:@selector(updateArray:) forControlEvents:UIControlEventTouchUpInside];
    [alertView setButtonTitles:nil];
    [alertView setUseMotionEffects:true];
    [alertView show];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    if( self.champId != 0||self.sectionId!= 0)
    {
//        if (targetContentOffset->y > 0){
//            //NSLog(@"up");
//            self.tableView.scrollEnabled=YES;
//        }
//        else if (targetContentOffset->y == 0){
//            self.tableView.scrollEnabled=NO;
//        }
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
