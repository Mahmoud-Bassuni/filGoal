//
//  MainSectionViewController.m
//  Reyada
//
//  Created by Nada Gamal on 8/23/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//
#import "FilGoalIOS-Swift.h"

#import "MainSectionViewController.h"
#import "SectionHeaderView.h"
#import "TeamsListViewController.h"
#import "ChampionshipHeader.h"
@interface MainSectionViewController ()

{
    UIButton * rightBarButton;
    NSString* url;
    UIButton * leftBarButton;
    BannersListViewController * bannerListViewController;
    BOOL haveBannersListView;
    BOOL haveChampionship;
    SectionHeaderView * headerView ;
    NSArray * aggregatedCards;
    ChampionshipHeader * stretchyHeaderView;
}
@end

@implementation MainSectionViewController
-(id)initWithSection:(Section*)section
{
    self = [super init];
    if (self) {
        self.section=[[Section alloc]init];
        self.champion=[[ChampionShipData alloc]init];
        self.section=section;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // self.title = self.section.sectionName;
    self.childViewControllers=[[NSMutableArray alloc]init];

        if([Global getInstance].appInfo.specialSection.isActive&&[Global getInstance].appInfo.specialSection.isTabActive&&((self.section.sectionId==[Global getInstance].appInfo.specialSection.sectionID)))
        {
            haveBannersListView=YES;
        }
        else
        {
            haveBannersListView=NO;
        }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickMore:) name:@"TabIndex" object:nil];
    if(self.section.champIds.count==1)
    {
        // Section assigned to one champion
        ChampId * champItem=self.section.champIds[0];
        self.champion=[[ChampionShipData alloc]init];
        self.champion.idField=champItem.champID;
        self.champion.name=self.section.sectionName;
        haveChampionship=YES;
    }
    else
    {
        haveChampionship=NO;
    }
    if(self.childViewControllers.count==0)
    {
        if(haveChampionship)
        {
            [self getChampionDetailsAPI];
        }
        else
            [self createTabsView];
        
    }
    
    self.selectedTabIndex = 1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //Transparent Navigationbar
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //self.navigationController.navigationBar.translucent = YES;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if(stretchyHeaderView != nil)
        stretchyHeaderView.championBgImgView.hidden=NO;
    
    [self checkIfSelectFirstScreen];
}
-(void)viewWillDisappear:(BOOL)animated
{
    /*if(self.navigationController.viewControllers.count == 1)
    {
        [self setNavigationBarBackgroundImage];
    }
    else if((self.navigationController.viewControllers.count>0 && ![self.navigationController.viewControllers isKindOfClass:[ChampionDetailsTabsViewController class]]))
    {
        [self.navigationController.navigationBar setTranslucent:NO];
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBarTintColor:[UIColor mainAppDarkGrayColor]];
        [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    }*/
    [[NSNotificationCenter defaultCenter]removeObserver:@"TabIndex"];
  //  [[NSNotificationCenter defaultCenter]removeObserver:@"EnableScroll"];

}

-(void)checkIfSelectFirstScreen {
    
    // Delay execution of my block for 0.8 seconds.
    __weak MainSectionViewController *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        MainSectionViewController *strongSelf = weakSelf;
        if (strongSelf.selectedTabIndex != 0 && strongSelf.segmentedPager != nil) {
            [strongSelf.segmentedPager.pager reloadData];
            strongSelf.segmentedPager.segmentedControl.selectedSegmentIndex = strongSelf.childViewControllers.count - 1;
            [strongSelf.segmentedPager.pager showPageAtIndex:strongSelf.childViewControllers.count - 1 animated:NO];
            strongSelf.selectedTabIndex = 0;
        }
    });
}

-(void)createTabsView
{
    [self.activityIndicator stopAnimating];
    if(self.sectionId == 0)
    {
        self.sectionId = (int)self.section.sectionId;
    }
    if(haveBannersListView)
    {
        bannerListViewController=[[BannersListViewController alloc]init];
        bannerListViewController.title=@"محتوي تفاعلي";
        [self.childViewControllers addObject:bannerListViewController];
    }
    
   

     if(self.champion.idField!=0)
    {
        
        NewScorersViewController * scorersVC =[[NewScorersViewController alloc]init];
        scorersVC.championships = [[NSArray alloc]init];
        scorersVC.isFromChampionshipSection = YES;
        scorersVC.champId = (int)self.champion.idField;
        scorersVC.title=@"الهدافون";
        [self.childViewControllers addObject:scorersVC];
        
        TeamsListViewController * teamsVC = [[TeamsListViewController alloc]init];
        teamsVC.title = @"الفرق";
        teamsVC.champId =(int)self.champion.idField;
        [self.childViewControllers addObject:teamsVC];
        
    }
    
    GalleriesViewController * galleriesViewController = [[GalleriesViewController alloc]init];
    galleriesViewController.title = @"صور";
    galleriesViewController.sectionName=self.section.sectionName;
    galleriesViewController.sectionId =(int)self.section.sectionId;
    [self.childViewControllers addObject:galleriesViewController];
    
    VideosViewController* videosListScreen=[[VideosViewController alloc]init];
    videosListScreen.title=@"فيديوهات";
    videosListScreen.sectionName=self.section.sectionName;
    videosListScreen.sectionId=self.sectionId;
    videosListScreen.index=2;
    [self.childViewControllers addObject:videosListScreen];
    
    NewsHomeViewController* newsListScreen=[[NewsHomeViewController alloc]initWithSectionId:self.sectionId TypeId:1];
    newsListScreen.title=@"أخبار";
    newsListScreen.sectionName=self.section.sectionName;
    newsListScreen.index=1;
    [self.childViewControllers addObject:newsListScreen];
    
    if(self.section.champIds.count>1)
    {
        self.champion = nil;
        MatchesViewController *   matchesViewController=[[MatchesViewController alloc] init];
        matchesViewController.title=@"مباريات";
        matchesViewController.sectionChampions = self.section.champIds;
        [self.childViewControllers addObject:matchesViewController];
    }
    else if(self.champion.idField!=0)
    {
        if(self.champion.championshipTypeId == ChampionshipTypeDawery)
        {
            ChampionshipDaweryStandingsViewController * dawerystandingsVC = [[ChampionshipDaweryStandingsViewController alloc]init];
            dawerystandingsVC.title = @"الترتيب";
            dawerystandingsVC.championshipItem = self.champion;
            [self.childViewControllers addObject:dawerystandingsVC];
            
        }
        else
        {
            ChampionshipGroupStandingsViewController * standingsVC = [[ChampionshipGroupStandingsViewController alloc]init];
            standingsVC.title = @"الترتيب";
            standingsVC.championshipItem = self.champion;
            [self.childViewControllers addObject:standingsVC];
            
        }
        
        self.champion.idField= self.section.champId;
        ChampMatchesViewController * matchesVC = [[ChampMatchesViewController alloc]init];
        matchesVC.title = @"مباريات";
        matchesVC.champion = self.champion;
        matchesVC.aggregatedCards=aggregatedCards;
        [self.childViewControllers addObject:matchesVC];
        
    }
    
    HomeViewController * homeNewsListScreen=[[HomeViewController alloc]initHomeViewWithSectionId:self.sectionId andChampions:self.section.champIds];
    homeNewsListScreen.title=@"الرئيسية";
    homeNewsListScreen.sectionName=self.section.sectionName;
    homeNewsListScreen.sectionId=self.sectionId;
    homeNewsListScreen.index=0;
    [self.childViewControllers addObject:homeNewsListScreen];
     
    // Parallax Header
    [self.view addSubview:self.segmentedPager];
    self.segmentedPager.parallaxHeader.view = [self addHeaderView];
    self.segmentedPager.parallaxHeader.mode = MXParallaxHeaderModeTop;
    if(self.section.champIds.count==1){
        self.segmentedPager.parallaxHeader.height = 276;
    } else {
        self.segmentedPager.parallaxHeader.height = 160; //was 100;
    }
        
    self.segmentedPager.parallaxHeader.minimumHeight = 64;
    // Segmented Control customization
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:  [UIFont fontWithName:@"DINNextLTArabic-Medium" size:14.0]};
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor mainAppYellowColor],NSFontAttributeName:  [UIFont fontWithName:@"DINNextLTArabic-Medium" size:14.0]};
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor mainAppYellowColor];
    self.segmentedPager.delegate=self;
    if(self.selectedTabIndex != 0) {
        //SMGL self.segmentedPager.pager.index= self.childViewControllers.count-self.selectedTabIndex;
        [self.segmentedPager.pager showPageAtIndex:self.childViewControllers.count-self.selectedTabIndex animated:YES];
    } else {
        //SMGl self.segmentedPager.pager.index= self.childViewControllers.count-1;
        [self.segmentedPager.pager showPageAtIndex:self.childViewControllers.count-1 animated:YES];
        
    }
    self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(4, 4, 0, 4);
    self.segmentedPager.segmentedControl.frame = CGRectMake(0, 0, Screenwidth, 40);
    self.segmentedPager.segmentedControl.selectionIndicatorHeight=2.0;

    [self checkIfSelectFirstScreen];
}

-(UIView*)addHeaderView
{   //Will Look Like Championships in more menu - will have middle circle image
    if(self.section.champIds.count==1)
    {
        stretchyHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"ChampionshipHeader" owner:self options:nil]objectAtIndex:0];
        stretchyHeaderView.sectionId=self.section.sectionId;
        stretchyHeaderView.championshipNameLbl.text= @"";//self.section.sectionName;
        [stretchyHeaderView setSponserBgImage];
        [stretchyHeaderView.champImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%ld.png",CHAMP_IMAGES_BASE_URL,(long)self.champion.idField]] placeholderImage:[UIImage imageNamed:@"match_holder_ios"]
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                                      [stretchyHeaderView.champImgIndicator stopAnimating];
                                                  }];
        
        return stretchyHeaderView;
    }
    //Will Look Like Sections in more menu - only the background image
    else {
        headerView = [[[NSBundle mainBundle]loadNibNamed:@"SectionHeaderView" owner:self options:nil]objectAtIndex:0];
        headerView.sectionName = @"";//self.section.sectionName;
        headerView.sectionId=self.section.sectionId;
        headerView.section_id = self.section.sectionId;
        [headerView setSectionBgImage];
        return headerView;
    }
}


-(void) checkIsSpecialSection
{
    if([Global getInstance].appInfo.specialSection.isActive&&(((self.section.sectionId==[Global getInstance].appInfo.specialSection.sectionID))||([Global getInstance].appInfo.specialSection.champID==self.champion.idField) ))
    {
        self.specialSectionBanner.hidden=NO;
        self.sectionNameView.hidden=YES;
        [self.specialSectionBanner sd_setImageWithURL:[NSURL URLWithString:[Global getInstance].appInfo.specialSection.bannerArtWorkImg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            cacheType=SDImageCacheTypeMemory;
            self.sponsorImageConstraintHeight.constant = 67;
            
        }];
    }
    else
    {
        [self setScreenSponsor];
    }
}

-(void)setScreenSponsor
{
    AppInfo *appInfo= [Global getInstance].appInfo;
    NSString * sponsorUrl;
    if (appInfo.sponsor.isActive==1) {
        sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
        if (IS_IPHONE_6_PLUS) {
            sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header6plus@3x.png",appInfo.sponsor.imgsBaseUrl];
        }
        else if (IS_IPHONE_6)
        {
            sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header6@2x.png",appInfo.sponsor.imgsBaseUrl];
        }
        else
        {
            sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
        }
        
        [self.specialSectionBanner sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImageConstraintHeight.constant = 25;
            
        }];
    }
    else{
        self.sponsorImageConstraintHeight.constant = 0;
        
    }
    if([sponsorUrl isEqualToString:@""]||sponsorUrl==nil)
    {
        self.sponsorImageConstraintHeight.constant = 0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupChampionTabs
{
    UINavigationController * navigationController = GetAppDelegate().getSelectedNavigationController;
    ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
    detailsScreen.champion = self.champion;
    [navigationController pushViewController:detailsScreen animated:YES];
}


- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)clickMore:(NSNotification*)note
{
    int sectionId=[[note object]intValue];
    
        if (sectionId==4) {
            if(self.champion.idField != 0){
                [self.segmentedPager.pager showPageAtIndex:[self getSelectedChildControllerIndex:[ChampMatchesViewController class]] animated:YES];

            }
            else
                [self.segmentedPager.pager showPageAtIndex:[self getSelectedChildControllerIndex:[MatchesViewController class]] animated:YES];
        }
        else if(sectionId==2){
            [self.segmentedPager.pager showPageAtIndex:[self getSelectedChildControllerIndex:[VideosViewController class]] animated:YES];

        }
        else if(sectionId==1){
            [self.segmentedPager.pager showPageAtIndex:[self getSelectedChildControllerIndex:[NewsHomeViewController class]] animated:YES];

        }
        else if(sectionId==3){
            [self.segmentedPager.pager showPageAtIndex:[self getSelectedChildControllerIndex:[GalleriesViewController class]] animated:YES];

        }

}
-(NSInteger)getSelectedChildControllerIndex:(Class)className
{
    for (int i=0; i<self.childViewControllers.count; i++) {
        if([className isEqual:[[self.childViewControllers objectAtIndex:i]class]])
        {
            return i;
        }
    }
    return 0;
}
-(void)getLatestPlayedMatch
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    
    NSDictionary * paramDic= [[NSDictionary alloc]initWithObjects:@[
                                                                    [NSString stringWithFormat:@"championshipId eq %ld and Date lt %@ and HomeScore ne null",(long)self.champion.idField,[outputFormatter stringFromDate:[NSDate date]]], //@"championshipId eq %ld and Date lt %@ and HomeScore ne null and IsDelayed eq false"
                                                                    @"Week,RoundId", //@"Week,RoundId,RoundName"
                                                                    @"Week desc,RoundId desc", //@"Date desc"
                                                                    @"1"]
                                                          forKeys:@[
                                                                    @"$filter",
                                                                    @"$select",
                                                                    @"$orderby",
                                                                    @"$top"]];
    NSString *url = [NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL],self.champion.idField];
    
    [WServicesManager getDataWithURLString:url andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(MatchesList * success)
     {
         if(success != nil && success.matches.count>0)
         {
             MatchCenterDetails * matchItem = success.matches[0];
             self.champion.currentWeek = matchItem.week;
             self.champion.currentRoundId = matchItem.roundId;
             self.champion.currentRoundName = matchItem.roundName;
             [self createTabsView];
         }
         else
         {
             self.champion.currentWeek = 1;
             self.champion.currentRoundId = 0;
             [self createTabsView];
         }
         
     }failure:^(NSError *error) {
         IBGLog(@"Get Current week API Error  : %@",error);
     }];
    
}
-(void)getChampionDetailsAPI
{
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"Id eq %li",(long)self.champion.idField],@"Id,Name,ChampionshipTypeId,ChampionshipTypeName,Weeks",@"Rounds,Stages($expand=Groups($expand=Teams),Rounds)"] forKeys:@[@"$filter",@"$select",@"$expand"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:ChampionshipsAPI,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"Championship" andAuthenticationType:SportesEngineAPIs success:^(Championship * success)
     {
         if(success != nil && success.data.count>0)
         {
             NSArray * championships = [[NSArray alloc]initWithArray:success.data];
             self.champion = [championships objectAtIndex:0];
             [self getChampionshipInfoAPI];
         }
         
     }failure:^(NSError *error) {
         IBGLog(@"CHampionshipDetails API Error  : %@",error);
     }];
}

-(void)getChampionshipInfoAPI
{
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:AggregatedEventsAPI,[WServicesManager getSportsEngineApiBaseURL],self.champion.idField] andParameters:nil WithObjectName:nil andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         NSArray * results = success;
         if(results != nil && results.count>0)
         {
             aggregatedCards=[[NSArray alloc]initWithArray:results];
         }
         [self getLatestPlayedMatch];
         
     }failure:^(NSError *error) {
         IBGLog(@"AggregatedEvents API Error  : %@",error);
         [self getLatestPlayedMatch];
     }];
}



- (void)viewWillLayoutSubviews {
    self.segmentedPager.frame = (CGRect){
        .origin = CGPointZero,
        .size   = self.view.frame.size
    };
    [super viewWillLayoutSubviews];
}

#pragma mark Properties

- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {
        
        // Set a segmented pager below the cover
        _segmentedPager = [[MXSegmentedPager alloc] init];
        _segmentedPager.delegate    = self;
        _segmentedPager.dataSource  = self;
    }
    return _segmentedPager;
}

#pragma mark <MXSegmentedPagerDelegate>

- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 30.f;
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@ page selected.", title);
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didScrollWithParallaxHeader:(MXParallaxHeader *)parallaxHeader {
    //NSLog(@"progress %f", parallaxHeader.progress);
    
    if(parallaxHeader.progress<=0.05){ //==0.0
        headerView.sectionNameLbl.textColor=[UIColor clearColor];
        NSString * sponsorUrl=[AppSponsors getSpecialSectionBannerImagePathUsingId:self.sectionId];
        
        __weak __typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakSelf) strongSelf = weakSelf;

            if (stretchyHeaderView != nil) {
                //stretchyHeaderView.championBgImgView.hidden=YES;
            
                if([AppSponsors isSectionActiveUsingId: strongSelf.section.sectionId] && sponsorUrl!=nil)
                {
                    //[self setNavigationBarBackgroundImage:sponsorUrl];
                    __weak __typeof(self) weakSelf = strongSelf;
                    [strongSelf setNavigationBarBackgroundImage:sponsorUrl completion:^(UIImage * _Nullable image) {
                        __strong __typeof(weakSelf) strongSelf = weakSelf;
                        stretchyHeaderView.championBgImgView.frame = CGRectMake(0, 0, strongSelf.view.frame.size.width, parallaxHeader.minimumHeight);
                        stretchyHeaderView.championBgImgView.backgroundColor = [UIColor blackColor];
                        stretchyHeaderView.championBgImgView.image = [image resizeImageScaledToWidthWithWidth:strongSelf.view.frame.size.width]; //image;
                    }];
                }
                else{
                    headerView.sectionNameLbl.hidden=YES;
                    __weak __typeof(self) weakSelf = strongSelf;
                    [strongSelf setNavigationBarBackgroundImageCompletion:^(UIImage * _Nullable image) {
                        __strong __typeof(weakSelf) strongSelf = weakSelf;
                        stretchyHeaderView.championBgImgView.frame = CGRectMake(0, 0, strongSelf.view.frame.size.width, parallaxHeader.minimumHeight);
                        stretchyHeaderView.championBgImgView.backgroundColor = [UIColor blackColor];
                        stretchyHeaderView.championBgImgView.image = [image resizeImageScaledToWidthWithWidth:strongSelf.view.frame.size.width];//image;
                    }];
                    //[self setNavigationBarBackgroundImage];
                }
            } else {
                headerView.sectionNameLbl.hidden=YES;
                __weak __typeof(self) weakSelf = strongSelf;
                [strongSelf setNavigationBarBackgroundImageCompletion:^(UIImage * _Nullable image) {
                    __strong __typeof(weakSelf) strongSelf = weakSelf;
                    headerView.sectionImgView.frame = CGRectMake(0, 0, strongSelf.view.frame.size.width, parallaxHeader.minimumHeight);
                    headerView.sectionImgView.backgroundColor = [UIColor blackColor];
                    headerView.sectionImgView.image = [image resizeImageScaledToWidthWithWidth:strongSelf.view.frame.size.width];//image;
                    
                }];
                //[self setNavigationBarBackgroundImage];
            }
        });
    }
    else if(parallaxHeader.progress > 0.5){//0.5
        if(stretchyHeaderView != nil) {
            stretchyHeaderView.championBgImgView.hidden=NO;
        
            headerView.sectionNameLbl.hidden=NO;
            headerView.sectionNameLbl.textColor=[UIColor blackColor];
            
            //Transparent NavigationBar
            //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
            //[GetAppDelegate().getSelectedNavigationController.navigationBar setShadowImage:[UIImage new]];
            //GetAppDelegate().getSelectedNavigationController.navigationBar.translucent = YES;
            
            
            
            [stretchyHeaderView setSponserBgImage];
            stretchyHeaderView.championBgImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, stretchyHeaderView.championBgImgView.image.size.height);
            /*[stretchyHeaderView.championBgImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%ld.png",CHAMP_IMAGES_BASE_URL,(long)self.champion.idField]] placeholderImage:[UIImage imageNamed:@"match_holder_ios"]
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                                          [stretchyHeaderView.champImgIndicator stopAnimating];
                                                      }];*/
        } else {
            headerView.sectionImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, parallaxHeader.height);
            [headerView setSectionBgImage];
        }
    }
}

#pragma mark <MXSegmentedPagerDataSource>

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return self.childViewControllers.count;
}

- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    UIViewController * viewController = [self.childViewControllers objectAtIndex:index];
    return viewController.title;
}

- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    UIViewController * viewController = [self.childViewControllers objectAtIndex:index];
    return viewController.view;
}


#pragma mark - NavigationBar Images - Completion
typedef void (^onComplete) (UIImage * __nullable image);
-(void)setNavigationBarBackgroundImageCompletion:(nullable onComplete)completionHandler
{
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
                completionHandler(image);
            });
            
        }
        else
        {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    //Commented beacuse this line was somehow decreassing the image quality when it was getting retrived
                    //[[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                        completionHandler(image);
                    });
                }
            }];
        }
    }
    else{
        if(IS_IPHONE_4) {
            //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
            completionHandler([UIImage imageNamed:@"Nav4"]);
        } else if(IS_IPHONE_5) {
            //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
            completionHandler([UIImage imageNamed:@"Nav5"]);
        } else if (IS_IPHONE_6) {
            //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
            completionHandler([UIImage imageNamed:@"Nav6"]);
        }  else if (IS_IPHONE_6_PLUS) {
            completionHandler([UIImage imageNamed:@"Nav6+"]);
        } else {
            //UIImage *image = [[UIImage imageNamed:@"Nav6+"] resizeImageScaledToWidthWithWidth: [UIScreen mainScreen].bounds.size.width];
            CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                     ([UIApplication sharedApplication].statusBarFrame.size.height +(self.navigationController.navigationBar.frame.size.height ?: 0.0)));
            UIImage *image = [[UIImage imageNamed:@"NavX"] resizeImageWithTargetSize:size];
            completionHandler(image);
        }

    }
    
}
-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl completion:(nullable onComplete)completionHandler
{
    UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:mainSponsorUrl];
    if(image == nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:mainSponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[SDImageCache sharedImageCache] storeImage:image forKey:mainSponsorUrl toDisk:YES];
                        //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                        completionHandler(image);
                    });
                    
                }
            }];
            
        });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
            completionHandler(image);
        });
    }
}

#pragma mark - NavigationBar Images - without Completion
-(void)setNavigationBarBackgroundImage
{
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
                stretchyHeaderView.championBgImgView.backgroundColor = [UIColor blackColor];
                stretchyHeaderView.championBgImgView.image = image;
            });
            
        }
        else
        {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    //Commented beacuse this line was somehow decreassing the image quality when it was getting retrived
                    //[[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                    });
                }
            }];
        }
    }
    else{
        if(IS_IPHONE_4) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
        } else if(IS_IPHONE_5) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
        } else if (IS_IPHONE_6) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
        } else if (IS_IPHONE_6_PLUS) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
        } else {
            //UIImage *image = [[UIImage imageNamed:@"Nav6+"] resizeImageScaledToWidthWithWidth: [UIScreen mainScreen].bounds.size.width];
            CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                     ([UIApplication sharedApplication].statusBarFrame.size.height +(self.navigationController.navigationBar.frame.size.height ?: 0.0)));
            UIImage *image = [[UIImage imageNamed:@"NavX"] resizeImageWithTargetSize:size];  
            [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        }

    }
    
}
-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl
{
    UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:mainSponsorUrl];
    if(image == nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:mainSponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[SDImageCache sharedImageCache] storeImage:image forKey:mainSponsorUrl toDisk:YES];
                        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                    });
                    
                }
            }];
            
        });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        });
    }
}


@end
