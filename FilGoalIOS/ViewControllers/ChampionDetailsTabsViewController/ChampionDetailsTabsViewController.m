//
//  ChampionDetailsTabsViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/16/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ChampionDetailsTabsViewController.h"
#import "TeamsListViewController.h"
#import "ChampionshipDaweryStandingsViewController.h"
#import "ChampionshipGroupStandingsViewController.h"
#import "ChampMatchesViewController.h"
#import "NewScorersViewController.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationController+Transparency.h"
#import "ChampionshipHeader.h"
#import "SponsorOverlayView.h"
#import "FilGoalIOS-Swift.h"

#define NAVBAR_CHANGE_POINT 50
@interface ChampionDetailsTabsViewController ()
{
    NSArray * championships;
    NSArray * aggregatedCards;
     AppDelegate *appDelegate;
    BOOL isViewLoaded;
    ChampionshipHeader * stretchyHeaderView;
}
@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;

@end

@implementation ChampionDetailsTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isViewLoaded = YES;
    [self getChampionshipInfoAPI];
    [self setNavigationBtns];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //self.tabsTopSpaceConstraint.constant=20;
    [self getChampionDetailsAPI];
    
    self.selectedTabIndex = 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    // stretchyHeaderView.championshipNameLbl.hidden=NO;

    ////SMGL New Banner (Edit)
    //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    //[GetAppDelegate().getSelectedNavigationController.navigationBar setShadowImage:[UIImage new]];
    //GetAppDelegate().getSelectedNavigationController.navigationBar.translucent = YES;
    //
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (stretchyHeaderView != nil)
        stretchyHeaderView.championBgImgView.hidden=NO;
}

-(void)checkIfSelectFirstScreen {
    // Delay execution of my block for 0.6 seconds.
    __weak ChampionDetailsTabsViewController *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        ChampionDetailsTabsViewController *strongSelf = weakSelf;
        if (strongSelf.selectedTabIndex != 0 && strongSelf.segmentedPager != nil) {
            [strongSelf.segmentedPager.pager reloadData];
            strongSelf.segmentedPager.segmentedControl.selectedSegmentIndex = strongSelf.childViewControllers.count - 1;
            [strongSelf.segmentedPager.pager showPageAtIndex:strongSelf.childViewControllers.count - 1 animated:NO];
            strongSelf.selectedTabIndex = 0;
        }
    });
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    ////SMGL New Banner (Edit)
    //if(self.navigationController.viewControllers.count == 1)
    //{
    //    [self setNavigationBarBackgroundImage];
    //}
    //else if((self.navigationController.viewControllers.count>0 && ![self.navigationController.viewControllers isKindOfClass:[ChampionDetailsTabsViewController class]]))
    //{
    //    [self.navigationController.navigationBar setTranslucent:NO];
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor mainAppDarkGrayColor]];
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    //}
    //
}
#pragma mark - Right Navigation Buttons
-(void)setNavigationBtns
{
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.bounds = CGRectMake(Screenwidth-40, 0, 16, 18);
    self.navigationItem.rightBarButtonItems=@[ [[UIBarButtonItem alloc] initWithCustomView:shareBtn]];

}
- (IBAction)shareBtnPressed:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.filgoal.com/championships/%li",(long)self.champion.idField]];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[self.champion.name, url]
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

-(void)getChampionDetailsAPI
{
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"Id eq %li",(long)self.champion.idField],@"Id,Name,ChampionshipTypeId,ChampionshipTypeName,Weeks,Order",@"Rounds,Stages($expand=Groups($expand=Teams),Rounds)",@"Order asc"] forKeys:@[@"$filter",@"$select",@"$expand",@"$orderby"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:ChampionshipsAPI,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"Championship" andAuthenticationType:SportesEngineAPIs success:^(Championship * success)
     {
         if(success != nil && success.data.count>0)
         {
             championships = [[NSArray alloc]initWithArray:success.data];
             self.champion = [championships objectAtIndex:0];
             [self getLatestPlayedMatch];

         }
         
     }failure:^(NSError *error) {
         IBGLog(@"CHampionshipDetails API Error  : %@",error);
     }];
}
// In case of dawery we need to get the latest played match to get current week 
-(void)getLatestPlayedMatch
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    //[outputFormatter setLocale:[NSLocale currentLocale]];
    //&$select=RoundId,Week&$orderby=Week desc,RoundId desc&$top=1
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %ld and Date lt %@ and HomeScore ne null",(long)self.champion.idField,[outputFormatter stringFromDate:[NSDate date]]],@"RoundId,Week",@"1",@"Week desc,RoundId desc"] forKeys:@[@"$filter",@"$select",@"$top",@"$orderby"]];
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
-(void)getChampionshipInfoAPI
{
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:AggregatedEventsAPI,[WServicesManager getSportsEngineApiBaseURL],self.champion.idField] andParameters:nil WithObjectName:nil andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         NSArray * results = success;
         if(results != nil && results.count>0)
         {
             aggregatedCards=[[NSArray alloc]initWithArray:results];
         }
         
     }failure:^(NSError *error) {
         IBGLog(@"AggregatedEvents API Error  : %@",error);
     }];
}



-(void)createTabsView
{
    
    [self.activityIndicator stopAnimating];
    BOOL haveBannersListView= YES;
    if([Global getInstance].appInfo.specialSection.isActive&&[Global getInstance].appInfo.specialSection.isTabActive&&((self.sectionId==[Global getInstance].appInfo.specialSection.sectionID)))
    {
        haveBannersListView=YES;
    }
    else
    {
        haveBannersListView=NO;
    }
    self.childViewControllers = [[NSMutableArray alloc]init];
    if(haveBannersListView)
    {
        BannersListViewController * bannerListViewController=[[BannersListViewController alloc]init];
        bannerListViewController.title=@"محتوي تفاعلي";
        [self.childViewControllers addObject:bannerListViewController];
    }
    
    NewScorersViewController * scorersViewController=[[NewScorersViewController alloc]init];
    scorersViewController.championships = [[NSArray alloc]init];
    scorersViewController.isFromChampionshipSection = YES;
    scorersViewController.champName=self.champion.name;
    scorersViewController.champId = (int)self.champion.idField;
    scorersViewController.title=@"الهدافون";
    [self.childViewControllers addObject:scorersViewController];
    
    TeamsListViewController * teamsVC = [[TeamsListViewController alloc]init];
    teamsVC.title = @"الفرق";
    teamsVC.champId =(int)self.champion.idField;
    [self.childViewControllers addObject:teamsVC];
    
    GalleriesViewController * galleriesVC = [[GalleriesViewController alloc]init];
    galleriesVC.title=@"الصور";
    galleriesVC.champName=self.champion.name;
    galleriesVC.champId = (int)self.champion.idField;
    [self.childViewControllers addObject:galleriesVC];
    
    VideosViewController* videosListScreen=[[VideosViewController alloc]init];
    videosListScreen.title=@"فيديوهات";
    videosListScreen.champName=self.champion.name;
    videosListScreen.champId = (int)self.champion.idField;
    
    videosListScreen.sectionId=0;
    videosListScreen.index=2;
    [self.childViewControllers addObject:videosListScreen];
    
    NewsHomeViewController* newsListScreen=[[NewsHomeViewController alloc]initWithSectionId:0 TypeId:1];
    newsListScreen.title=@"أخبار";
    newsListScreen.index=1;
    newsListScreen.champName=self.champion.name;
    newsListScreen.champId = (int)self.champion.idField;
    [self.childViewControllers addObject:newsListScreen];

    ChampMatchesViewController * matchesVC = [[ChampMatchesViewController alloc]init];
    matchesVC.title = @"المباريات";
    matchesVC.champion = self.champion;
    matchesVC.aggregatedCards=aggregatedCards;
    [self.childViewControllers addObject:matchesVC];
    
    if(self.champion.championshipTypeId == ChampionshipTypeDawery && self.champion.currentWeek != 0 )
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
    if(self.sectionId !=0)
    {
        HomeViewController * homeNewsListScreen=[[HomeViewController alloc]initHomeViewWithSectionId:(int)self.sectionId andChampions:self.champIds];
        homeNewsListScreen.title=@"الرئيسية";
        homeNewsListScreen.sectionId=(int)self.sectionId;
        [self.childViewControllers addObject:homeNewsListScreen];
    }
    
    // Parallax Header
    [self.view addSubview:self.segmentedPager];
    self.segmentedPager.delegate=self;
    self.segmentedPager.parallaxHeader.view = [self addHeaderView];
    self.segmentedPager.parallaxHeader.mode = MXParallaxHeaderModeFill;
    self.segmentedPager.parallaxHeader.height = 280;
    self.segmentedPager.parallaxHeader.minimumHeight = 64;
    // Segmented Control customization
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:  [UIFont fontWithName:@"DINNextLTArabic-Medium" size:14.0]};
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor mainAppYellowColor],NSFontAttributeName:  [UIFont fontWithName:@"DINNextLTArabic-Medium" size:14.0]};
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor mainAppYellowColor];
    //self.segmentedPager.delegate=self;
    //if(self.selectedTabIndex != 0)
    //    self.segmentedPager.pager.index= self.childViewControllers.count-self.selectedTabIndex;
    //else
    //    self.segmentedPager.pager.index= self.childViewControllers.count-1;
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
- (void)viewWillLayoutSubviews {
    //CGFloat topbarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height + (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    CGFloat topbarHeight = 0;
    self.segmentedPager.frame = (CGRect){
        .origin = CGPointMake(0, topbarHeight), //CGPointZero, //SMGL New Banner (Edit)
        .size   = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-topbarHeight) //self.view.frame.size //SMGL New Banner (Edit)
    };
    [super viewWillLayoutSubviews];
    
}

#pragma mark Properties

- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {
        
        _segmentedPager = [[MXSegmentedPager alloc] init];
        _segmentedPager.delegate    = self;
        _segmentedPager.dataSource  = self;
       // self.segmentedPager.hidden = YES;
    }
    return _segmentedPager;
}

#pragma mark <MXSegmentedPagerDelegate>

- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 30.f;
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
   // NSLog(@"%@ page selected.", title);
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didScrollWithParallaxHeader:(MXParallaxHeader *)parallaxHeader {
    //NSLog(@"progress %f", parallaxHeader.progress);
    //NSLog(@"%f, %f, %f, %f", parallaxHeader.view.frame.size.height, parallaxHeader.contentView.frame.size.height, parallaxHeader.height, parallaxHeader.minimumHeight);
    MXScrollView *scrollView = segmentedPager.subviews.firstObject;

    
    if (parallaxHeader.progress == 0.0) { //0.05 //==0.0 SMGL New Banner (Edit)
        stretchyHeaderView.championshipNameLbl.textColor=[UIColor clearColor];

        if([AppSponsors isChampionActiveUsingId:self.champion.idField])
        {
            //stretchyHeaderView.championshipNameLbl.hidden=YES; SMGL New Banner (Edit)
            //stretchyHeaderView.championBgImgView.hidden=YES; SMGL New Banner (Edit)
            NSString * sponsorUrl=[AppSponsors getSpecialChampionshipBannerImagePathUsingId:self.champion.idField];
            stretchyHeaderView.champs_id = self.champion.idField;
            //SMGL New Banner (New)
            [stretchyHeaderView.championBgImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat: sponsorUrl]] placeholderImage:[UIImage imageNamed:@"match_holder_ios"]
                                                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                                               [stretchyHeaderView.champImgIndicator stopAnimating];
                                                            stretchyHeaderView.championBgImgView.backgroundColor = [UIColor blackColor];
                stretchyHeaderView.championBgImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, parallaxHeader.minimumHeight);
                
                stretchyHeaderView.championBgImgView.image = [image resizeImageScaledToWidthWithWidth:self.view.frame.size.width];
                stretchyHeaderView.championBgImgView.contentMode = UIViewContentModeScaleToFill;
            }];
            //
            if (sponsorUrl != nil) {
                //[self setNavigationBarBackgroundImage:sponsorUrl];// SMGL New Banner (Edit)
            } else {
                //[self setNavigationBarBackgroundImage];// SMGL New Banner (Edit)
            }
        }
        else {
            //[self setNavigationBarBackgroundImage];// SMGL New Banner (Edit)
            [self getNavigationBarBackgroundImage:^(UIImage * _Nullable image) {
                stretchyHeaderView.championBgImgView.backgroundColor = [UIColor blackColor];
                
                stretchyHeaderView.championBgImgView.image = [image resizeImageScaledToWidthWithWidth:self.view.frame.size.width]; //image
                stretchyHeaderView.championBgImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, parallaxHeader.minimumHeight);

                //[stretchyHeaderView.championBgImgView setImage:image];
                //stretchyHeaderView.champImgView.image = image;
            }];
        }
    }
    else if (parallaxHeader.progress > 0.0 &&
             scrollView.contentOffset.y < -(parallaxHeader.minimumHeight * 1.35) &&
             stretchyHeaderView.championBgImgView.backgroundColor != [UIColor clearColor]) {
        //0.0 //> 0.5 // SMGL New Banner (Edit)
        
        //stretchyHeaderView.championshipNameLbl.textColor=[UIColor blackColor];
        //stretchyHeaderView.championshipNameLbl.hidden=NO;
        //stretchyHeaderView.championBgImgView.hidden=NO;
        
        //SMGL New Banner (Edit)
        //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
        //[GetAppDelegate().getSelectedNavigationController.navigationBar setShadowImage:[UIImage new]];
        //GetAppDelegate().getSelectedNavigationController.navigationBar.translucent = YES;
        //
        
        //SMGL New Banner (New)
        [stretchyHeaderView setSponserBgImage];
        stretchyHeaderView.championBgImgView.backgroundColor = [UIColor clearColor];
        
        stretchyHeaderView.championBgImgView.frame = CGRectMake(0, 0, self.view.frame.size.width, parallaxHeader.height);

        /*[stretchyHeaderView.champImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%ld.png",CHAMP_IMAGES_BASE_URL,(long)self.champion.idField]] placeholderImage:[UIImage imageNamed:@"match_holder_ios"]
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                                      [stretchyHeaderView.champImgIndicator stopAnimating];
                                                  }];*/
        
    }
    
    stretchyHeaderView.championBgImgView.contentMode = UIViewContentModeScaleAspectFill;//UIViewContentModeTop;//UIViewContentModeScaleAspectFill; //UIViewContentModeScaleToFill;

    /*for (MXScrollView *scrollView in segmentedPager.subviews) {
     NSLog(@"---- view: %@ \n", scrollView);
     NSLog(@"---- scrollView.contentOffset.y: %f \n", scrollView.contentOffset.y);
     }*/
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


#pragma mark Handle Scrollview Delegates
-(UIView*)addHeaderView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    stretchyHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"ChampionshipHeader" owner:self options:nil]objectAtIndex:0];
    stretchyHeaderView.champion=self.champion;
    [stretchyHeaderView.championshipNameLbl setText:self.champion.name];
    [stretchyHeaderView setSponserBgImage];
    [stretchyHeaderView.champImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%ld.png",CHAMP_IMAGES_BASE_URL,(long)self.champion.idField]] placeholderImage:[UIImage imageNamed:@"match_holder_ios"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                    [stretchyHeaderView.champImgIndicator stopAnimating];
                                }];
    
    return stretchyHeaderView;
}


#pragma mark - NavigationBar Images - Completion
typedef void (^onComplete) (UIImage * __nullable image);
-(void)getNavigationBarBackgroundImage:(nullable onComplete)completionHandler {
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(image);
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (image && finished) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //Commented beacuse this line was somehow decreassing the image quality when it was getting retrived
                            //[[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                            completionHandler(image);
                        });
                    }
                }];
            });
        }
    }
    else {
        if (IS_IPHONE_4) {
            completionHandler([UIImage imageNamed:@"Nav4"]);
        } else if(IS_IPHONE_5) {
            completionHandler([UIImage imageNamed:@"Nav5"]);
        } else if (IS_IPHONE_6) {
            completionHandler([UIImage imageNamed:@"Nav6"]);
        } else {
            completionHandler([UIImage imageNamed:@"Nav6+"]);
        }
    }
}

#pragma mark - NavigationBar Images without Completion

-(void)setNavigationBarBackgroundImage
{
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (image && finished) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //Commented beacuse this line was somehow decreassing the image quality when it was getting retrived
                            //[[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                            
                            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                        });
                    }
                }];
            });
        }
    }
    else {
        if (IS_IPHONE_4) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
        } else if(IS_IPHONE_5) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
        } else if (IS_IPHONE_6) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
        } else if (IS_IPHONE_6_PLUS) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
        } else {
            //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
            UIImage *image = [[UIImage imageNamed:@"Nav6+"] resizeImageScaledToWidthWithWidth: [UIScreen mainScreen].bounds.size.width];
            [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        }
    }
}

-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl
{
    ////SMGL New Banner (Edit)
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
