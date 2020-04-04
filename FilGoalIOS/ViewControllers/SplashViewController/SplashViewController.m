//
//  MainViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/16/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "SplashViewController.h"
#import "WServicesManager.h"
#import "Global.h"
#import "App.h"
#import "Sponsor.h"
#import "Message.h"
#import "FeaturedMenuItem.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import "Constants.h"
#import "LandingScreenViewController.h"
#import "NewUpdateViewController.h"
#import "MoreViewController.h"
#import "AppInfoHelper.h"
@import Firebase;
@interface SplashViewController ()
{
    NSMutableArray * titlesList;
    NSMutableArray * descriptionList;
    NSMutableArray * keywords;
    LandingScreenViewController * landingScreen;
    NSString * ip;
}
@end

@implementation SplashViewController
NSString * const itemDomain = @"fr.sophiacom.Spotlight";
NSString * const itemType = @"item.type.employee";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([defaults objectForKey:@"WidgetCheck"]) {
            [defaults removeObjectForKey:@"WidgetCheck"];
            [defaults synchronize];
        }
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
}
- (void)viewDidLoad
{
    self.screenName = [NSString stringWithFormat:@"iOS-Splash Screen"];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS-Splash Screen"
                                     }];
    landingScreen=[[LandingScreenViewController alloc]init];
    [super viewDidLoad];
    if (IS_IPHONE_5) {
        [self.bg setImage:[UIImage imageNamed:@"splash.png"]];
    }
    else if (IS_IPHONE_6)
    {
        [self.bg setImage:[UIImage imageNamed:@"750-x1334.png"]];
    }
    else if (IS_IPHONE_6_PLUS)
    {
        [self.bg setImage:[UIImage imageNamed:@"1242-x2208.png"]];
        
    }
    else {
        [self.bg setImage:[UIImage imageNamed:@"splash_960.png"]];
    }
    
    [self.navigationController.navigationBar setHidden:YES];
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"تم إيقاف البيانات الخلوية" message:@"قم بتشغيل البيانات الخلوية أو قم باستخدام Wi-Fi  للوصول الي البيانات" delegate:self cancelButtonTitle:@"أعد المحاولة" otherButtonTitles:@"الاعدادات",nil];
        message.tag=1000;
        [message show];
    }
    else
    [self loadAppInfo];
    
}
-(void)getAppInfo
{
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"تم إيقاف البيانات الخلوية" message:@"قم بتشغيل البيانات الخلوية أو قم باستخدام Wi-Fi  للوصول الي البيانات" delegate:self cancelButtonTitle:@"أعد المحاولة" otherButtonTitles:@"الاعدادات",nil];
        message.tag=1000;
        [message show];
        
    }
    else{
        
        [WServicesManager getDataWithURLString:AppInfo_URL andParameters:nil WithObjectName:@"AppInfo" andAuthenticationType:NoAuth success:^(AppInfo *appInfo)
         {
             __weak typeof(self) weakSelf = self;
            [Global getInstance].appInfo=appInfo;
            IBGLog(@"AppInfo response : %@",appInfo);
             IBGLogDebug(@"AppInfo response : %@",appInfo);

            [weakSelf loadMetaData];
            [weakSelf initializeIntersitialAdsPattern];
            [weakSelf loadSponsor];
            [weakSelf setUpSpotLightSearch];
            
        } failure:^(NSError *error) {
            
            __weak typeof(self) weakSelf = self;
            //UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"لم يتم العثور علي البيانات  " message:[error description] delegate:self cancelButtonTitle:@"موافق" otherButtonTitles:nil];
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"لم يتم العثور علي البيانات  " message: @"" delegate:weakSelf cancelButtonTitle:@"موافق" otherButtonTitles:nil];
            [message show];
            IBGLog(@"AppInfo Error : %@",error.description);
            //IBGLogDebug(@"AppInfo Error : %@",error.description);
            
        }];
    }
}

-(void)loadSponsor
{
    if([AppSponsors isSplashSponsorActive])
    {
    [self.sponser sd_setImageWithURL:[NSURL URLWithString:[AppSponsors getSplashSponsorImagePath]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __weak typeof(self) weakSelf = self;
        weakSelf.sponser.contentMode=UIViewContentModeScaleToFill;
    }];
    }

}
-(void)hideSplash
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    if (self.appInfo.app.isActive==1) {
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        //I checked version because we have 2 alerts one for iOS 7 and the other alert from type of uialertcontroller which supported by OS greater than or equal 8.0
        if(![self.appInfo.app.version isEqualToString:version]&&IOS_VERSION_LOWER_THAN_8){
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:self.appInfo.app.msg message:nil delegate:self cancelButtonTitle:@"الغاء" otherButtonTitles: @"تنزيل التحديث",nil];
            message.tag=1;
            [message show];
        }
        else{
            [self.navigationController popToRootViewControllerAnimated:NO];
            if (self.homeViewController==nil)
                self.homeViewController=[[HomeViewController alloc]initHomeViewWithSectionId:0 andChampions:@[]];
            if([AppSponsors isLandingScreenActive]&&!appDelegate.haveNoti&&!appDelegate.isFromForceTouch&&!appDelegate.isFromNewsWidget&&!appDelegate.isFromMatchesWidget&&!appDelegate.isFromUnviersalLinks&&!appDelegate.isFromSpotLightSearch&&!appDelegate.isToMatchDetails)
                [appDelegate setRootViewController:landingScreen];
            else
                [appDelegate setTabBarViewController];
               // [appDelegate setRootViewController:self.homeViewController];
            
        }
    }
    
    
    else{
        [self.navigationController popToRootViewControllerAnimated:NO];

        if (self.homeViewController==nil)
            self.homeViewController=[[HomeViewController alloc]initHomeViewWithSectionId:0 andChampions:@[]];
        if([AppSponsors isLandingScreenActive]&&!appDelegate.haveNoti&&!appDelegate.isFromForceTouch&&!appDelegate.isFromNewsWidget&&!appDelegate.isFromMatchesWidget&&!appDelegate.isFromUniversalLinks&&!appDelegate.isFromSpotLightSearch&&!appDelegate.isToMatchDetails)
            [appDelegate setRootViewController:landingScreen];
        else
            [appDelegate setTabBarViewController];
            //[appDelegate setRootViewController:self.homeViewController];
        
    }
    if(appDelegate.isFromUniversalLinks)
    {
        appDelegate.isFromUniversalLinks=NO;
         [UniversalLinks handleUniversalLinksWithUrlString:appDelegate.universalLinkUrl.absoluteString andIsRedirectedUrl:NO];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //IBGLog(@"IP is %@",ip);
    
}
-(void)loadMetaData
{
    NSDictionary *dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0",nil] forKeys:[NSArray arrayWithObjects:@"countryId", nil] ];
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MetaDataAPI,[WServicesManager getApiBaseURL]] andParameters:dictionary WithObjectName:@"MetaData" andAuthenticationType:CMSAPIs
       success:^(MetaData *metaData)
     {
         __weak typeof(self) weakSelf = self;
        [weakSelf saveData:[Global getInstance].appInfo andMetaData:metaData];
        [weakSelf.activityIndicator stopAnimating];
        [Global getInstance].metaData=metaData;
        if([Global getInstance].appInfo.message.isActive)
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:[[Global getInstance].appInfo.message msg] message:nil delegate:weakSelf cancelButtonTitle:@"موافق" otherButtonTitles:nil];
            [message setTag:5];
            [message show];
        }
        
        else
        {
           // [self performSelector:@selector(hideSplash) withObject:nil afterDelay:0.0];
            [weakSelf getTimeOffest];

        }
        
        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Splash Screen"  ApiError:@"Success"];

        
    } failure:^(NSError *error) {
        __weak typeof(self) weakSelf = self;
        IBGLog(@"MetaData Error  : %@",error);
        IBGLogDebug(@"MetaData Error  : %@",error);

        [self sendAppSpeedTimeIntervalWithTime:[weakSelf stopMeasuring] AndScreenName:@"Splash Screen"  ApiError:[NSString stringWithFormat:@"Failure with error %@",error.description]];

        
    }];
}
-(void)setUpSpotLightSearch
{
    NSMutableArray * jsonTags=[[[[Global getInstance]appInfo]tags]mutableCopy];
    NSMutableArray * tempArray=[NSMutableArray arrayWithArray:jsonTags];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        
        if(tempArray.count>0)
        {
            
            titlesList=[[NSMutableArray alloc]initWithArray:tempArray];
            descriptionList=[[NSMutableArray alloc]initWithArray:tempArray];;
            keywords=[[NSMutableArray alloc]initWithArray:tempArray];
            [[NSUserDefaults standardUserDefaults]setObject:keywords forKey:@"Keywords"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else
        {
            titlesList=[[NSMutableArray alloc]init];
            descriptionList=[[NSMutableArray alloc]init];;
            keywords=[[NSMutableArray alloc]init];
        }
        
        _searchItems=[[NSMutableArray alloc]init];
        for (int i=0;i<titlesList.count;i++) {
            CSSearchableItemAttributeSet* attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:itemType];
            attributeSet.title = [titlesList objectAtIndex:i];;
            attributeSet.contentDescription = [descriptionList objectAtIndex:i];
            attributeSet.keywords = [titlesList objectAtIndex:i];
            //userActivity.contentAttributeSet=attributeSet;89
            CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:[NSString stringWithFormat:@"%d",i] domainIdentifier:itemDomain attributeSet:attributeSet];
            //        // Set properties that describe the activity and that can be used in search.
            [_searchItems addObject:item];
        }
        
        [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:_searchItems completionHandler: ^(NSError * __nullable error) {
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    
                });
            }
        }];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    
    if (alertView.tag==1) {
        if (buttonIndex==1) {
            
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appInfo.app.storeUrl]];
            if (self.appInfo.app.isCore==1) {
                [self.navigationController popToRootViewControllerAnimated:NO];
                
            }
            else{
            }
        }
        else{
            if (self.appInfo.app.isCore==1) {
                [self.navigationController popToRootViewControllerAnimated:NO];
                
            }
            else{
                if (self.homeViewController==nil)
                    self.homeViewController=[[HomeViewController alloc]initHomeViewWithSectionId:0 andChampions:@[]];
                if([AppSponsors isLandingScreenActive]&&!appDelegate.haveNoti&&!appDelegate.isFromForceTouch&&!appDelegate.isFromNewsWidget&&!appDelegate.isFromMatchesWidget&&!appDelegate.isFromUnviersalLinks&&!appDelegate.isFromSpotLightSearch&&!appDelegate.isToMatchDetails)
                    [appDelegate setRootViewController:landingScreen];
                else
                    //[appDelegate setRootViewController:self.homeViewController];
                    [appDelegate setTabBarViewController];
            }
        }
    }
    else if (alertView.tag==2) {
        if (buttonIndex==1) {
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appInfo.message.msgUrl]];
            
        }
        else{
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }
        
    }
    else if (alertView.tag==3) {
        
        
    }
    else if(alertView.tag==1000)
    {
        if(buttonIndex==1)
        {
            if (&UIApplicationOpenSettingsURLString != NULL) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            }
        }
        else
        {
            [self loadMetaData];
            [self getAppInfo];
            
        }
        
    }
    else if (alertView.tag == 2000)
    {
        // time offset changed alert
        if(buttonIndex==0)
        {
            [AppInfoHelper saveAreaDetails:self.areaDetails];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                __weak typeof(self) weakSelf = self;
                [weakSelf performSelector:@selector(hideSplash) withObject:nil afterDelay:0.0];
            });
        }
        else
        {
            [appDelegate setTabBarViewController];
            [appDelegate.tabbarController setSelectedIndex:0];
            UINavigationController * navigationController = appDelegate.tabbarController.selectedViewController;
            MoreViewController * moreViewController = (MoreViewController*)navigationController.topViewController;
            moreViewController.isShowed = YES;
            
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveData :(AppInfo*) appInfo andMetaData :(MetaData*)metaData {
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    if (appInfo != nil) {
        [dataDict setObject:appInfo forKey:@"AppInfo"];
    }
    if(metaData !=nil)
    {
        [dataDict setObject:metaData forKey:@"MetaData"];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    
    [NSKeyedArchiver archiveRootObject:dataDict toFile:filePath];
}
-(void) loadAppInfo
{
    self.appInfo=[[AppInfo alloc]init];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([savedData objectForKey:@"AppInfo"] != nil) {
            self.appInfo =[savedData objectForKey:@"AppInfo"];
            [Global getInstance].appInfo=self.appInfo;
            [Global getInstance].freqIndex=0;
            [Global getInstance].viewsCount=0;
        }
        if ([savedData objectForKey:@"MetaData"] != nil) {
            [Global getInstance].metaData =[savedData objectForKey:@"MetaData"];
            
        }
        if([savedData objectForKey:@"MetaData"] != nil&&[savedData objectForKey:@"AppInfo"] != nil)
        {
            if([Global getInstance].appInfo.message.isActive)
            {
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:[[Global getInstance].appInfo.message msg] message:nil delegate:self cancelButtonTitle:@"موافق" otherButtonTitles:nil];
                [message setTag:5];
                [message show];
                if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                    [[NSFileManager defaultManager]removeItemAtPath: filePath error:nil];
                }
                
            }
            else if(![self.appInfo.app.version isEqualToString:version]&&self.appInfo.app.isActive)
            {
                //core update and it will close the app
            
                [self showNewUpdateAlert:self.appInfo.app.isCore];
                
            }
            else
            {
                //[self performSelector:@selector(hideSplash) withObject:nil afterDelay:0.0];
                [self getTimeOffest];//
                
            }
            [self loadSponsor];//

        }
        else if([savedData objectForKey:@"MetaData"] == nil || [savedData objectForKey:@"AppInfo"] == nil)
        {
            [self getAppInfo];
            
        }
        
    }
    else
    {
        [self getAppInfo];
    }
}

-(void)showNewUpdateAlert : (BOOL)withCore
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NewUpdateViewController *controller = [[NewUpdateViewController alloc]init];
    CGRect rect;
    rect = CGRectMake(0, 0, 280, 321);
    [controller setPreferredContentSize:rect.size];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Update Available" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:controller forKey:@"contentViewController"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"إلغاء" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (withCore) {
          exit(0);
        }
        else{
           
      //  [self getAppInfo];
        [self getTimeOffest];//
       

        }
        
//        [self getTimeOffest];
//        [self loadSponsor];
    }];
    [alertController addAction:cancelAction];
    [appDelegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - Add Update Alert
#pragma mark - check version weekly
//- (void)checkVersionWeekly
//{
//    /*
//     On app's first launch, lastVersionCheckPerformedOnDate isn't set.
//     Avoid false-positive fulfilment of second condition in this method.
//     Also, performs version check on first launch.
//     */
//    self.lastVersionCheckPerformedOnDate=[[NSUserDefaults standardUserDefaults]objectForKey:NEW_UPDATE_STORED_DATE];
//    if (![self lastVersionCheckPerformedOnDate]) {
//
//        // Set Initial Date
//        self.lastVersionCheckPerformedOnDate = [NSDate date];
//
//        // Perform First Launch Check
//        [self checkVersion];
//    }
//
//    // If weekly condition is satisfied, perform version check
//    if ([self numberOfDaysElapsedBetweenLastVersionCheckDate] > 7) {
//        [self checkVersion];
//    }
//}
- (NSUInteger)numberOfDaysElapsedBetweenLastVersionCheckDate
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitDay
                                                      fromDate:[self lastVersionCheckPerformedOnDate]
                                                        toDate:[NSDate date]
                                                       options:0];
    return [components day];
}
//-(void)checkVersion
//{
//    [self showNewUpdateAlert:false];
//    self.lastVersionCheckPerformedOnDate = [NSDate date];
//    [[NSUserDefaults standardUserDefaults] setObject:[self lastVersionCheckPerformedOnDate] forKey:NEW_UPDATE_STORED_DATE];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//}
-(void)initializeIntersitialAdsPattern
{
    [Global getInstance].selectedIntersitialIndex = 0;
    if([Global getInstance].appInfo.interstatialAdsPattern.count>0)
        [Global getInstance].screenViewsCount = [[Global getInstance].appInfo.interstatialAdsPattern[[Global getInstance].selectedIntersitialIndex]intValue];
    
}


- (void)externalIPAddress {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *theURL = [[NSURL alloc] initWithString:@"http://ip-api.com/line/?fields=query"];
        NSString* myIP = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:theURL] encoding:NSUTF8StringEncoding];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            // Manipulate the ip on the main queue
            ip = myIP;
            IBGLog(@" IP is %@",myIP);


        });
    });
}




#pragma mark - Timezone

-(void)getTimeOffest
{
    [WServicesManager getDataWithURLString:kGetAreaDetails andParameters:nil WithObjectName:@"AreaDetails" andAuthenticationType:NoAuth success:^(AreaDetails * areaDetails)
     {
         __weak typeof(self) weakSelf = self;
        [weakSelf.activityIndicator stopAnimating];
         weakSelf.areaDetails = areaDetails;
         Country * countryItem=[[Country alloc]init];
         if([AppInfoHelper getCountry].code != nil)
         {
         [Global getInstance].country=[AppInfoHelper getCountry];
         }
        if(![areaDetails.country isEqualToString:countryItem.name]&&countryItem.name!=nil)
        {
            if(![[NSUserDefaults standardUserDefaults]boolForKey:@"IsMessageShowed"])
            {
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@""
                                                                          message:[NSString stringWithFormat:@"أنت تحاول الولوج من %@، هل ترغب في تعديل الإعدادات الخاصة بك وفقًا لهذه الدولة؟",areaDetails.country]
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"نعم"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action)
            {
                [AppInfoHelper saveAreaDetails:areaDetails];
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    __weak typeof(self) weakSelf = self;
                    [weakSelf performSelector:@selector(hideSplash) withObject:nil afterDelay:0.0];
                });
            }];
            
            UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"لا"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action)
            {
                __weak typeof(self) weakSelf = self;
                [alert dismissViewControllerAnimated:YES completion:nil];
                [weakSelf performSelector:@selector(hideSplash) withObject:nil afterDelay:0.0];

            }];
            
            UIAlertAction* settingsBtn = [UIAlertAction actionWithTitle:@"الضبط يدويا"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action)
                                       {
                                           [GetAppDelegate() setTabBarViewController];
                                           [GetAppDelegate().tabbarController setSelectedIndex:0];
                                           UINavigationController * navigationController = GetAppDelegate().tabbarController.selectedViewController;
                                           MoreViewController * moreViewController = (MoreViewController*)navigationController.topViewController;
                                           moreViewController.isShowed = YES;
                                       }];
            [alert addAction:yesButton];
            [alert addAction:settingsBtn];
            [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:^{
                [[NSUserDefaults standardUserDefaults]setBool:YES  forKey:@"IsMessageShowed"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }];
            }
            else
            {
                [self performSelector:@selector(hideSplash) withObject:nil afterDelay:0.0];

            }
        }
         
        else
        {
            //
            [AppInfoHelper saveAreaDetails:areaDetails];
            [self performSelector:@selector(hideSplash) withObject:nil afterDelay:0.0];

        }
        
    } failure:^(NSError *error) {
        __weak typeof(self) weakSelf = self;
        [weakSelf performSelector:@selector(hideSplash) withObject:nil afterDelay:0.0];

    }];
    
}




@end
