//
//  LandingScreenViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "LandingScreenViewController.h"
#import "featuredPagerViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloader.h"
#import "UIButton+WebCache.h"
@interface LandingScreenViewController ()
{
    AppDelegate * appDelegate;
    UIImage * bgImage;
}
@end

@implementation LandingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [GAI sharedInstance].dispatchInterval = 20;
    [self.sectionBtn setBackgroundColor:[UIColor clearColor]];
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-697331-9"];
    
    bgImage=[[UIImage alloc]init];
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    if (IS_IPHONE_5) {
        bgImage =[UIImage imageNamed:@"splash.png"];
    }
    else if (IS_IPHONE_6)
    {
        bgImage =[UIImage imageNamed:@"750-x1334.png"];
        
    }
    else if (IS_IPHONE_6_PLUS)
    {
        bgImage =[UIImage imageNamed:@"1242-x2208.png"];
    }
    else {
        bgImage =[UIImage imageNamed:@"splash_960.png"];
    }
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"تم إيقاف البيانات الخلوية" message:@"قم بتشغيل البيانات الخلوية أو قم باستخدام Wi-Fi  للوصول الي البيانات" delegate:self cancelButtonTitle:nil otherButtonTitles:@"الاعدادات",nil];
        message.tag=1000;
        [message show];
    }
    else
    {
        [self loadLandingImages];
    }
    
  
    self.navigationController.navigationBarHidden=YES;
    [[UIApplication sharedApplication]setStatusBarHidden:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    

    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:[NSString stringWithFormat:@"iOS -Landing screen"]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];

}
-(void)loadLandingImages
{
//    if([Global getInstance].appInfo.landingScreen.buttonSectionName!=nil && ![[Global getInstance].appInfo.landingScreen.buttonSectionName isEqualToString:@""])
//        [self.sectionBtn setTitle:[Global getInstance].appInfo.landingScreen.buttonSectionName forState:UIControlStateNormal];

    [self.homeBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[AppSponsors getHomeBtnImageURL]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
    UIImage * backgroundImg = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"BackgroundImg"]];
    UIImage * sectionImg =[UIImage imageWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"SectionImg"]];
    if(backgroundImg!=nil &&[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]URLForKey:@"BackgroundUrl"]] isEqualToString:[AppSponsors getLandingBgImageURL]])
    {
        [self.backgroundImg setImage:backgroundImg];
        self.sectionBtn.hidden=NO;
        self.homeBtn.hidden=NO;
    }
    else
    {
        [self loadBackgroundImgAndSaveImage];
    }
    
    if(sectionImg!=nil &&[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]URLForKey:@"SectionImgUrl"]] isEqualToString:[AppSponsors getSectionBtnImageURL]])
    {
        [self.sectionBtn setBackgroundImage:sectionImg forState:UIControlStateNormal];

    }
    else
    {
        [self loadSectionImgAndSaveImage];
    }
    
    
    
}
-(void)loadSectionImgAndSaveImage
{
    NSString *strImgURLAsString =[AppSponsors getSectionBtnImageURL];
    [strImgURLAsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *imgURL = [NSURL URLWithString:strImgURLAsString];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            UIImage *img = [[UIImage alloc] initWithData:data];
            [self.sectionBtn setBackgroundImage:img forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults]setObject:UIImageJPEGRepresentation(img, 1.0) forKey:@"SectionImg"];
            [[NSUserDefaults standardUserDefaults]setURL:[NSURL URLWithString:[AppSponsors getSectionBtnImageURL]] forKey:@"SectionImgUrl"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
        }else{
            NSLog(@"%@",connectionError);
        }
    }];
}
-(void)loadBackgroundImgAndSaveImage
{
    NSString *strImgURLAsString = [AppSponsors getLandingBgImageURL];
    [strImgURLAsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *imgURL = [NSURL URLWithString:strImgURLAsString];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            UIImage *img = [[UIImage alloc] initWithData:data];
            [self.backgroundImg setImage:img];
            self.sectionBtn.hidden=NO;
            self.homeBtn.hidden=NO;
            [[NSUserDefaults standardUserDefaults]setObject:UIImageJPEGRepresentation(img, 1.0) forKey:@"BackgroundImg"];
            [[NSUserDefaults standardUserDefaults]setURL:[NSURL URLWithString:[AppSponsors getLandingBgImageURL]] forKey:@"BackgroundUrl"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
        }else{
            NSLog(@"%@",connectionError);
        }
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden=NO;
    [[UIApplication sharedApplication]setStatusBarHidden:NO];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(Section*)getSectionItemWithSectionID:(NSInteger)sectionID
{
    NSArray * sections = [Global getInstance].metaData.sections;
    for (int i=0; i<sections.count; i++) {
        if([(Section*)[sections objectAtIndex:i]sectionId]==sectionID)
        {
            return (Section*)[sections objectAtIndex:i];
        }
    }
    return nil;

}
-(void) handleLandingScreenButtonActionBasedOnID
{
    NSInteger type=[AppSponsors getLandingItem].type;
    NSInteger itemID=[AppSponsors getLandingItem].idField;
    switch (type) {
        case 1:
        {
            NewsItem * newsItem=[[NewsItem alloc]init];
            newsItem.newsId = (int)itemID;
          if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
              [self.navigationController pushViewController:[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:newsItem ] animated:YES];
          else
            [self.navigationController pushViewController:[[NewsDetailsViewController alloc] initWithNewsItem:newsItem ] animated:YES];
            break;

        }
        case 2:
        {
            VideoItem * videoItem=[[VideoItem alloc]init];
            videoItem.videoId = (int)itemID;
            VideoDetailsViewController * videoDetailsScreen =[[VideoDetailsViewController alloc]init];
            [self.navigationController pushViewController:videoDetailsScreen animated:YES];
            break;
            
        }
        case 3:
        {
            MatchCenterDetails * matchItem=[[MatchCenterDetails alloc]init];
            matchItem.idField=itemID;
            MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
            matchCenter.matchCenterDetails = matchItem;
            [self.navigationController pushViewController:matchCenter animated:YES];
            break;
            
        }
        case 4:
        {
            Section * item =[[Section alloc]init];
            item=[self getSectionItemWithSectionID:itemID];
           MainSectionViewController* mainSection=[[MainSectionViewController alloc]initWithSection:item];
            mainSection.section=item;
   
            [self.navigationController pushViewController:mainSection animated:YES];
            break;
            
        }
        case 5:
        {
//            AppInfo *appInfo= [Global getInstance].appInfo;
//            featuredPagerViewController *pager = [[featuredPagerViewController alloc]init];
//            pager.title=appInfo.iSection.homeFeaturedSection.featuredSection.sectionName;
//            pager.featuredSection=appInfo.iSection.homeFeaturedSection.featuredSection;
//            // pager.selectedDate=[[self dateFormatter]dateFromString:date];
//            pager.metaDataJsonUrl=appInfo.iSection. homeFeaturedSection.featuredSection.metaDataJsonUrl;
//            [self.navigationController pushViewController:pager animated:YES];

            break;
            
        }
        case 6:
        {
            GlobalViewController * webView=[[GlobalViewController alloc]init];
            webView.url=[NSURL URLWithString:[AppSponsors getLandingItem].pageUrl];
            [self.navigationController pushViewController:webView animated:YES];
            break;
        }
            
        default:
            break;
    }
    
    
}
- (IBAction)homeBtnPressed:(id)sender {
    [appDelegate setTabBarViewController];
}

- (IBAction)sectionBtnPressed:(id)sender {
    [appDelegate setTabBarViewController];
    UINavigationController * navigationController = appDelegate.tabbarController.selectedViewController;
    HomeViewController * homeScreen= (HomeViewController*)navigationController.topViewController;
    homeScreen.isFromLandingScreen=YES;
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
 if(alertView.tag==1000)
    {
        if(buttonIndex==0)
        {
//            if (&UIApplicationOpenSettingsURLString != NULL) {
//              //  NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
////                if ([[UIApplication sharedApplication] canOpenURL:url]) {
////                   // [[UIApplication sharedApplication] openURL:url];
////                } else {
////                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
////                }
//                // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
//                // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
//               // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                
//            }
        }
        else
        {
            if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus!=NotReachable) {
                [self loadLandingImages];
            }

            
        }
        
    }
    
    
    
}

@end
