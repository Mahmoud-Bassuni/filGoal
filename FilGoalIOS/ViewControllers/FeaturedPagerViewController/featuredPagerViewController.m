//
//  featuredPagerViewController.m
//
//
//  Created by Ahmed Kotb on 5/12/16.
//
//

#import "featuredPagerViewController.h"
#import "AppDelegate.h"
#import "TabsViewController.h"
//#import "WebServiceManager.h"
#import "FeaturedSectionItems.h"
#import "pagerItems.h"
#import "FeaturedWebViewViewController.h"
#import "FeaturedBeforeViewController.h"
#import "FeaturedAfterViewController.h"
#import "Global.h"
#import "WServicesManager.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "Sponsor.h"
@interface featuredPagerViewController ()
{
    
    AppDelegate *appdelegate;
    NSArray *PagerTitles;
    UIButton * rightBarButton;
    NSString * sponserUrl;
    NSString * baseUrl;
    NSInteger selectedIndex;
   // BeforeViewController * beforeVC;
    
}

@end

@implementation featuredPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(translateViewToTop:) name:@"ScrollUpNotification" object:nil];

    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.sectionBannerImgView.hidden=YES;

    NSDictionary * dict=[[NSDictionary alloc]initWithObjects:@[self.metaDataJsonUrl] forKeys:@[@"JsonUrl"]];
    [WServicesManager getsectionItems:dict success:^(FeaturedSectionItems *section) {
        
        PagerTitles = [[NSArray alloc]init];
        PagerTitles = section.section;
        baseUrl=section.baseUrl;
        self.afterSection=section.afterSection;
        self.beforeSection=section.beforeSection;
        
        [self setupTabsViewController];
        
    } failure:^(NSError *error) {

        
    }];
    appdelegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appdelegate.isFullScreen=NO;
    

    
    
    
}
-(void)loadBannerImage
{
    AppInfo *appInfo= [Global getInstance].appInfo;
    if(!IS_IPHONE_6_PLUS)
    {
         NSString *url=[NSString stringWithFormat:@"%@%@.png",self.featuredSection.sectionBannarImgBaseUrl,@"@2x"];
      //  NSString *url=@"http://api.filgoal.com/MobileAppResources/iOS/images/SectionSponsor/GilletteStrip.png";

        [self.sectionBannerImgView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //self.sponserImageView.contentMode=UIViewContentModeScaleAspectFill;
            
        }];
        
    }
    else
    {
        NSString *url=[NSString stringWithFormat:@"%@%@.png",self.featuredSection.sectionBannarImgBaseUrl,@"@3x"];
        [self.sectionBannerImgView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //self.sponserImageView.contentMode=UIViewContentModeScaleAspectFill;
            
        }];
        
    }
    
    if (appInfo.sponsor.isActive==1) {
        if ([sponserUrl length] == 0)
        {
            NSString *url=[NSString stringWithFormat:@"%@/MainSponsor/HomeStrip.png",appInfo.sponsor.imgsBaseUrl];
            
            
            [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                // self.sponserImageView.contentMode=UIViewContentModeScaleAspectFit;
                
            }];
        }
        else
        {
            [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:sponserUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                
            }];
        }
    }
    else{
        self.sectionBannerImgView.frame=CGRectMake(self.sectionBannerImgView.frame.origin.x, self.sectionBannerImgView.frame.origin.y-25, self.sectionBannerImgView.frame.size.width, self.sectionBannerImgView.frame.size.height);
        
        self.tabsView.frame=CGRectMake(self.tabsView.frame.origin.x, self.sectionBannerImgView.frame.origin.y+self.sectionBannerImgView.frame.size.height, self.tabsView.frame.size.width,  self.tabsView.frame.size.height+25);
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0]];
    
    [self loadBannerImage];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

}
-(void)viewDidDisappear:(BOOL)animated
{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0]];
    UIButton *logoView = [[UIButton alloc] initWithFrame:CGRectMake(0,0,85,17)] ;
    [logoView setBackgroundImage:[UIImage imageNamed:@"filgoal_tab_bar_logo"] forState:UIControlStateNormal];
    [logoView setUserInteractionEnabled:NO];
    self.navigationItem.titleView = logoView;


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTabsViewController {
    
    //  TabsViewController * matchesTabsViewController=[[TabsViewController alloc]init];
    
    NSMutableArray *childViewControllers = [[NSMutableArray alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *today = [NSDate date];
    NSString *todaysString = [formatter stringFromDate:today];
    NSDate *todaysDate = [formatter dateFromString:todaysString];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    self.appInfo = [Global getInstance].appInfo;
    FeaturedAfterViewController *afterView;
    afterView.sponserUrl=sponserUrl;
    NSMutableArray *dates = [[NSMutableArray alloc]init];
    NSDate *endDate = [NSDate date];
    NSDate *startDate = [NSDate date];
    if([startDate compare:[NSDate date]]==NSOrderedDescending){
        FeaturedWebViewViewController *webView = [[FeaturedWebViewViewController alloc]init];
        webView.sponserUrl=sponserUrl;
        webView.url = _beforeSection.src;
        webView.title = _beforeSection.title;
        [self addChildViewController:webView];
        self.sectionBannerImgView.hidden=YES;
        [webView.view setFrame:CGRectMake(0, 0, Screenwidth, self.tabsView.frame.size.height)];
        [self.tabsView addSubview:webView.view];
        [self.tabsView bringSubviewToFront:webView.view];
        self.tabsView.hidden = YES;
        self.tabsView.frame=CGRectMake(self.tabsView.frame.origin.x, self.sectionBannerImgView.frame.origin.y, self.tabsView.frame.size.width,  self.tabsView.frame.size.height+self.sectionBannerImgView.frame.size.height);
        [self.view bringSubviewToFront:self.tabsView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tabsView.hidden =NO;
        });
        
        [webView didMoveToParentViewController:self];
        // [childViewControllers addObject:beforeVC];
        
    }
    else
    {
        self.sectionBannerImgView.hidden=NO;
        self.tabsView.frame=CGRectMake(self.tabsView.frame.origin.x, self.sectionBannerImgView.frame.origin.y+self.sectionBannerImgView.frame.size.height, self.tabsView.frame.size.width,  self.tabsView.frame.size.height);
        for (int i=0; i<PagerTitles.count; i++) {
            pagerItems *item=[PagerTitles objectAtIndex:i];
            NSDate *componentDate = [formatter dateFromString:item.date];
            
            
            
            if(item.type == 1 && ([todaysDate compare:componentDate]==NSOrderedSame || [todaysDate compare:componentDate]==NSOrderedDescending )){
                
                RamdanDayViewController* ramdanSection= [[RamdanDayViewController alloc] initWithNibName:@"RamdanDayViewController" bundle:nil];
                ramdanSection.sponserUrl=sponserUrl;
                ramdanSection.source = item.source;
                ramdanSection.title = item.title;
                ramdanSection.baseUrl=baseUrl;
                ramdanSection.isFromPushNotification=YES;
                if(self.component!=nil)
                ramdanSection.componentt=self.component;
                ramdanSection.itemDate = item.date;
                [dates addObject:componentDate];
                [childViewControllers addObject:ramdanSection];
                
            }
            else if(item.type == 2 &&  ([todaysDate compare:componentDate]==NSOrderedSame || [todaysDate compare:componentDate]==NSOrderedDescending )){
                
                FeaturedWebViewViewController *webView = [[FeaturedWebViewViewController alloc]init];
                webView.sponserUrl=sponserUrl;
                webView.url = item.source;
                webView.title = item.title;
                [dates addObject:componentDate];
                webView.itemDate = item.date;
                [childViewControllers addObject:webView];
                
            }
            
            
            if([self.selectedDate compare:componentDate]==NSOrderedSame&&self.selectedDate!=nil)
            {
                self.selectedIndex=PagerTitles.count-i;
            }
            [dates sortUsingSelector:@selector(compare:)];
            
            
            
            
        }
        if([endDate compare:[NSDate date]]==NSOrderedAscending){
            if(self.afterSection.type==2)
            {
                FeaturedWebViewViewController *webView = [[FeaturedWebViewViewController alloc]init];
                webView.sponserUrl=sponserUrl;
                webView.url = _afterSection.src;
                webView.title = _afterSection.title;
                [childViewControllers addObject:webView];
                
            }
            else
                
                if(self.afterSection.type==1)
                {
                    RamdanDayViewController* ramdanSection= [[RamdanDayViewController alloc] initWithNibName:@"RamdanDayViewController" bundle:nil];
                    ramdanSection.sponserUrl=sponserUrl;
                    ramdanSection.source = _afterSection.src;
                    ramdanSection.title = _afterSection.title;
                    ramdanSection.baseUrl=baseUrl;
                    ramdanSection.isFromPushNotification=YES;
                    if(self.component!=nil)
                        ramdanSection.componentt=self.component;
                    [childViewControllers addObject:ramdanSection];
                    
                }
            
            
            // afterView = [[FeaturedAfterViewController alloc]init];
            // afterView.sponserUrl=url;
            // afterView.title=self.afterSection.title;
            //  afterView.afterSection=self.afterSection;
        }
        
        FeaturedSectionTabsViewController *tabsViewController;
        tabsViewController = [[FeaturedSectionTabsViewController alloc]init];
        tabsViewController.selectedTabIndex=self.selectedIndex;
        tabsViewController.selectedDate=self.selectedDate;
        //tabsViewController.buttonBarView.isFromFeaturedSeaction=YES
        tabsViewController.isFromFeaturedSection = YES;
        tabsViewController.selectedTabIndex=self.selectedIndex;
        childViewControllers=[[[childViewControllers reverseObjectEnumerator] allObjects] mutableCopy];
        tabsViewController.childViewControllers = childViewControllers;
        [self addChildViewController:tabsViewController];
        [tabsViewController.view setFrame:CGRectMake(0, 0, Screenwidth, self.tabsView.frame.size.height)];
        [self.tabsView addSubview:tabsViewController.view];
        [self.tabsView bringSubviewToFront:tabsViewController.view];
        self.tabsView.hidden = YES;
        [self.view bringSubviewToFront:self.tabsView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tabsView.hidden =NO;
        });
        
        [tabsViewController didMoveToParentViewController:self];
        
    }
    
}


-(void)translateViewToTop:(NSNotification*)notification
{
    BOOL scrollUp= [[notification.object objectForKey:@"scroll"] boolValue];
    if (scrollUp)
    {
        
        [UIView animateWithDuration:0.4
                         animations:^{
                             //self.champLogoView.transform = CGAffineTransformScale(CGAffineTransformIdentity,self.champLogoView.transform.tx-2, self.champLogoView.transform.ty-2);
                             [UIView animateWithDuration:0.5
                                              animations:^{
                                                  //self.clubInfoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                                              } completion:^(BOOL finished) {
                                              }];
                             
                             
                             [self.tabsView setFrame:CGRectMake(0, self.sectionBannerImgView.frame.origin.y, self.tabsView.frame.size.width, self.tabsView.frame.size.height+self.sectionBannerImgView.frame.size.height)];
                             
                         }
                         completion:^(BOOL finished){
                             self.sectionBannerImgView.hidden=YES;
                         }];
        
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(translateViewToTop:)
                                                     name:@"ScrollDownNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ScrollUpNotification" object:nil];
        
    }
    else
    {
        [UIView animateWithDuration:0.4
                         animations:^{
                            // self.clubInfoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
//                             [UIView animateWithDuration:0.5
//                                              animations:^{
//                                                //  self.clubInfoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
//                                              } completion:^(BOOL finished) {
//                                                  
//                                              }];
                             //   self.champLogoView.transform = CGAffineTransformScale(CGAffineTransformIdentity,self.champLogoView.transform.tx+2, self.champLogoView.transform.ty+2);
                             self.sectionBannerImgView.hidden=NO;
                             [self.tabsView setFrame:CGRectMake(self.tabsView.frame.origin.x, self.sectionBannerImgView.frame.origin.y+self.sectionBannerImgView.frame.size.height, self.tabsView.frame.size.width, self.tabsView.frame.size.height-self.sectionBannerImgView.frame.size.height)];
                             
                         }
                         completion:^(BOOL finished){
                             
                         }];
        
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ScrollDownNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(translateViewToTop:)
                                                     name:@"ScrollUpNotification"
                                                   object:nil];
    }
}


@end
