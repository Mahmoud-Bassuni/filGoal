//
//  AppDelegate.m
//  hrm
//
//  Created by MohamedMansour on 3/24/13.
//  Copyright (c) 2013 MohamedMansour. All rights reserved.
//
#import "FilGoalIOS-Swift.h"


#import "AppDelegate.h"
#import "WServicesManager.h"
#import "Global.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MainSectionViewController.h"
#import <Instabug/Instabug.h>
#import "NewsDetailsViewController.h"
#import "VideoDetailsViewController.h"
#import "SplashViewController.h"
#import "Reachability.h"
#import "NewsVideoWebViewController.h"
#import "iRate.h"
#import <Netmera/Netmera.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "MatchesViewController.h"
#import "PartMatches.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import <CoreSpotlight/CoreSpotlight.h>
#include <MobileCoreServices/UTCoreTypes.h>
#include <MobileCoreServices/UTType.h>
#import "SearchViewController.h"
//#import "EmTracker.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworkReachabilityManager.h"
//#import <NewRelicAgent/NewRelic.h>
#import "featuredPagerViewController.h"
#import "WServicesManager.h"
#import "AFOAuthCredential.h"
#import "MatchCenterTabsViewController.h"
#import <FirebaseAppIndexing/FirebaseAppIndexing.h>
#import <TeadsSDK/TeadsSDK.h>
#import "Section.h"
#import "SVWebViewController.h"
#import "NewsSectionId.h"
#import "GlobalViewController.h"
#import "NewsVideoWebViewControlleriOS8.h"
#import "EmTracker.h"
#import "WeekMatchesViewController.h"
#import "MoreViewController.h"
#import "AFNetworkActivityLogger.h"
#import "AFNetworkActivityConsoleLogger.h"
#import <InMobiSDK/InMobiSDK.h>
#import "PredictionServiceManager.h"
#import "FilGoalIOS-Swift.h"

@import Firebase;
@implementation AppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
NSString * const NotificationCategoryIdent  = @"Read Later";
NSString * const NotificationActionOneIdent = @"مشاهدة لاحقا";

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray *restorableObjects))restorationHandler
{
    NSString *activityType = userActivity.activityType;
    NSMutableArray * keywords;
    NSMutableArray * jsonTags=[[[[Global getInstance]appInfo]tags]mutableCopy];
    NSMutableArray * tempArray=[NSMutableArray arrayWithArray:jsonTags];
    
    if(tempArray.count>0)
        keywords=[[NSMutableArray alloc]initWithArray:tempArray];
    else
        keywords=[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"Keywords"]];
    
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        self.userActivityType = userActivity.activityType;
        if(userActivity.webpageURL.absoluteString != nil)
        {
            _isFromUniversalLinks=YES;
            _universalLinkUrl=userActivity.webpageURL;
            [UniversalLinks handleUniversalLinksWithUrlString:userActivity.webpageURL.absoluteString andIsRedirectedUrl:NO];
        }
    }
    else
    {
        if ([[userActivity activityType] isEqualToString:activityType]) {
            NSString *uniqueIdentifier = [userActivity.userInfo objectForKey:CSSearchableItemActivityIdentifier];
            
            self.Keyword=[keywords objectAtIndex:[uniqueIdentifier integerValue] ];
            
            if (self.isAppLoaded)
            {
                self.isFromSpotLightSearch=YES;
                
                
            }
            else
            {
                self.isFromSpotLightSearch=NO;
                [self handleSpotLightSearchWithKeyword:self.Keyword];
            }
        }
    }
    
    
    return YES;
}
-(void)loadAppIndexing
{
    [[FIRAppIndexing sharedInstance] registerApp:497717534];
    
}

-(void)handleSpotLightSearchWithKeyword:(NSString*)keyword
{
    SearchViewController * searchView=[[SearchViewController alloc]initWithKeyWord:keyword andTypeId:newsType];
    searchView.isFromSpotLightSearch=YES;
    [self.getSelectedNavigationController pushViewController:searchView animated:YES];
}
-(BOOL)handleURLWith:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSUserDefaults *defaultsMatches = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    if([[NSString stringWithFormat:@"%@",url]isEqualToString:@"FilgoalWidget://com.sarmady.NewsWidget"])
    {
        [self setWidgetNewsItem:defaultsMatches];
        
        if (_isFirstLaunch)
        {
            _isFirstLaunch=NO;
            self.isFromNewsWidget=YES;
            self.isFromSpotLightSearch=NO;
            self.haveNoti=NO;
        }
        else
        {
            self.isFromNewsWidget=NO;
            NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:self.newsItem ];
            NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:self.newsItem ];
            newsDetailsScreen.isFromNewsWidget=YES;
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
                [self.getSelectedNavigationController pushViewController:newsDetailsScreenWebView animated:YES];
            else
                [self.getSelectedNavigationController pushViewController:newsDetailsScreen animated:YES];
        }
        
        
    }
    else if([[NSString stringWithFormat:@"%@",url.absoluteString.lowercaseString]containsString:@"filgoal://"])
    {
        [UniversalLinks handleUniversalLinksWithUrlString:url.absoluteString andIsRedirectedUrl:NO];
    }
    else if ([[url absoluteString]containsString:@"facebook"])
    {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation
                ];
    }
    else if (defaultsMatches != nil)
    {
        BOOL isMore=[defaultsMatches boolForKey:@"isMore"];
        
        if (isMore==NO&&!_isActive) {
            [self loadWidget];
        }
        else if (isMore==YES&&!_isFirstLaunch)
        {
            self.isFromNewsWidget=NO;
            [defaultsMatches setBool:NO forKey:@"isMore"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            UINavigationController * navigationContoller = [[self.tabbarController viewControllers]objectAtIndex:2];
            [navigationContoller popToRootViewControllerAnimated:YES];
            [self.tabbarController setSelectedIndex:2];
        }
        else if(isMore==YES&&_isFirstLaunch)
        {
            self.isFromMatchesWidget=YES;
            self.isActive=NO;
            [defaultsMatches setBool:NO forKey:@"isMore"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else {
            
            _isActive=NO;
            MatchCenterDetails *match2;
            NSData *object = [defaultsMatches objectForKey:@"MatchWidget"];
            if(![object isKindOfClass:[NSNumber class]])
                match2 = (MatchCenterDetails *)[NSKeyedUnarchiver unarchiveObjectWithData:object];
            self.isToMatchDetails = YES;
            self.matchItemm = match2;
            self.isFromMatchesWidget=NO;
            self.isFromSpotLightSearch=NO;
            self.haveNoti=NO;
            
        }
        
    }
    return YES;
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleURLWith:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
     if ([[url absoluteString]containsString:@"facebook"])
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                       annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    else
    {
        return [self handleURLWith:application openURL:url sourceApplication:nil annotation:nil];


    }
}


-(void)setWidgetNewsItem:(NSUserDefaults*)defaults
{
    self.newsItem=[[NewsItem alloc] init];
    self.newsItem.newsId = (int)[defaults integerForKey:@"news_id"];
    NSObject *receivedNewsSectionId = [defaults objectForKey:@"newsSectionId"];
    NSMutableArray * parsedNewsSectionId=[[NSMutableArray alloc]init];
    if ([receivedNewsSectionId isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNewsSectionId) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNewsSectionId addObject:[NewsSectionId modelObjectWithDictionary:item]];
            }
        }
    } else if ([receivedNewsSectionId isKindOfClass:[NSDictionary class]]) {
        [parsedNewsSectionId addObject:[NewsSectionId modelObjectWithDictionary:(NSDictionary *)receivedNewsSectionId]];
    }
    
    self.newsItem.newsSectionId = [NSArray arrayWithArray:parsedNewsSectionId];
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
}
-(void)handelNoti:(NSDictionary *)userInfo{
    NSString* url=[userInfo objectForKey:@"url"];
    if(url == nil)
    {
        url = [[userInfo objectForKey:@"_nm"]objectForKey:@"dl"];
    }
    if(url != nil)
    {
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:[NSString stringWithFormat:@"iOS-PushNotification-Closed-%@",url]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"BackgroundMode"])
        {
            self.notifURL=[[NSString alloc]initWithString: url];
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"BackgroundMode"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSString* title=@"";
           if(userInfo!=nil&&[userInfo valueForKey:@"aps"]!=nil&&[[userInfo valueForKey:@"aps"] objectForKey:@"alert"]!=nil)
             title = [[[userInfo valueForKey:@"aps"] objectForKey:@"alert"]objectForKey:@"body"];
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:title message:@"" delegate:self cancelButtonTitle:@"الغاء" otherButtonTitles: @"عرض",nil];
            message.tag=1;
            [message show];
        }
        else
        {
         [UniversalLinks handleUniversalLinksWithUrlString:url andIsRedirectedUrl:NO];
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if(buttonIndex==1)
        {
            [UniversalLinks handleUniversalLinksWithUrlString:self.notifURL andIsRedirectedUrl:NO];
        }
    }
}
#pragma - mark iOS 10 notifications
- (void)userNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog( @"Handle push from foreground" );
    // custom code to handle push while app is in the foreground
    NSDictionary * userInfo=notification.request.content.userInfo;
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"BackgroundMode"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if([[[userInfo objectForKey:@"aps"]objectForKey:@"category"]isEqualToString:@"BookmarkAction"])
    {
        [self saveNotificationForLaterRead:userInfo];
    }
    else
        [self handelNoti:userInfo];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler
{
    NSDictionary * userInfo=response.notification.request.content.userInfo;
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"BackgroundMode"];
//
//    [[NSUserDefaults standardUserDefaults]synchronize];
    if (_isActiveMode  )
    {
        if([[[userInfo objectForKey:@"aps"]objectForKey:@"category"]isEqualToString:@"1"])
        {
            [self saveNotificationForLaterRead:userInfo];
        }
        else
            [self handelNoti:userInfo];
    }
    else
    {
        if([[[userInfo objectForKey:@"aps"]objectForKey:@"category"]isEqualToString:@"BookmarkAction"])
        {
            [self saveNotificationForLaterRead:userInfo];
        }
        else
        {
            self.haveNoti=YES;
            self.userInfo=userInfo;
        }
        
    }
    
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler
{

    if (application.applicationState == UIApplicationStateBackground) {
       // handler(UIBackgroundFetchResultNoData);
        return;
    }
    else
    {
        if(_isActiveMode == NO)
            _isActiveMode = (application.applicationState == UIApplicationStateActive);
        
        if (_isActiveMode &&!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO( @"10.0" ) )
        {
            if(![[userInfo objectForKey:@"Type"]isEqualToString:@"7"]&&(self.userInfo==nil))
                
                [self handelNoti:userInfo];
            else
            {
                
                
            }
        }
    }
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *deviceTokenStr = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self saveUserDataWithDeviceToken:deviceTokenStr];
}
-(void) initCache
{
    //    int cacheSizeMemory = 100*1024*1024; // 100 MB
    //    int cacheSizeDisk = 32*1024*1024; // 32MB
    //    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory
    //                                                         diskCapacity:cacheSizeDisk
    //                                                             diskPath:nil];
    // [NSURLCache setSharedURLCache:URLCache];
    //  sleep(1);
    // NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    //[NSURLCache setSharedURLCache:sharedCache];
    
}
- (void)requestReview {
    // [SKStoreReviewController requestReview];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    TestVM *ss =  [[TestVM alloc] init];
//    //[ss getData];
//    [ss getSection];
    [IMSdk initWithAccountID:@"ac693ce04f344d629fb6f9cc4fbf53c7"];
    //Set log level to Debug
    [IMSdk setLogLevel:kIMSDKLogLevelDebug];
    [FIRApp configure];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[SDImageCache sharedImageCache]clearDisk];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self setInstaBugKey];
    [self loadAppIndexing];
    [self setEffectiveMessureSettings];
    [self initCache];
    [self setNavigationSettings:application];
    
    self.isAppLoaded = YES;
    self.isLaunched = YES;
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.FilGoal.NewsWidget"];
    NSUserDefaults *defaultsMatches = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    
    bool isFromNewsWidget= [defaults boolForKey:@"IsFromNewsWidget"];
    bool isFromMatchesWidget= [defaultsMatches boolForKey:@"IsFromMatchesWidget"];
    self.isToMatchDetails = NO;
   // self.isToNewsDetails = NO;
    self.isFirstLaunch=YES;
    if(isFromNewsWidget||isFromMatchesWidget)
    {
        _isActive=YES;
        [defaultsMatches setBool:NO forKey:@"IsFromMatchesWidget"];
        [defaults setBool:NO forKey:@"IsFromNewsWidget"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        // self.isToMatchDetails=YES;
    }
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"BackgroundMode"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [Fabric with:@[CrashlyticsKit]];
    [self handlePushNotificationsLaunchingMode:launchOptions];
   // [self registerInteractivePushNotificationsButtons];
    self.isFullScreen=NO;
    CGRect frame=[[UIScreen mainScreen] bounds];
    if([[UIDevice currentDevice].systemVersion floatValue]>6.0)
    {
        frame.origin.y+=20;
        frame.size.height-=20;
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[[SplashViewController alloc]init]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    self.window.rootViewController = self.navigationController;

    [self check3DTouchComptibilityAndCreateShortcutMenuOnAppIcon:launchOptions];
    [self setTextAndFontAndBGColor];
    [self setNetmeraKey];
    [self mointeringAFNetworkingLogs];
    [self setGoogleAnalyticsSettings];
    [self setIRateConfigurations];
    [self registerNotificationsForiOS10Devices];
    [self requestNativeRatting];
    //[self setStatusBarBackgroundColor: [UIColor colorWithWhite:0 alpha:0.5]]; // SMGL Was
    [self setStatusBarBackgroundColor: [UIColor colorWithWhite:0.15 alpha:0.85]]; // SMGL became
    [self mointeringAFNetworkingLogs];
 
//    [[FBSDKApplicationDelegate sharedInstance] application:application
//                             didFinishLaunchingWithOptions:launchOptions];
//    [Appsee start:@"07bb3ef22a194b49ad0ec801950e7ac6"];
//    [Appsee setDelegate:self];
//    [Appsee setDebugToNSLog:YES];

//    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//    NSString *userId = [tracker get:kGAIUserId];

    return YES;
}


#pragma mark - set background color for status bar
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    //UIView *statusBar;
    
    if (@available(iOS 13, *)) {
        //statusBar = [UIWindowLevelS];
        //statusBar.backgroundColor = color
    } else {
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = color;
        }
    } 
    
}
-(void) requestNativeRatting
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10"))
    {
//        [Netmera getInstallationId];
        int shortestTime = 50;
        int longestTime = 500;
        int timeInterval = arc4random_uniform(longestTime - shortestTime) + shortestTime;
        
        [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(requestReview) userInfo:nil repeats:NO];
    }
}
-(void) registerNotificationsForiOS10Devices
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
                
            }
        }];
    }
    else {
        UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                        UIUserNotificationTypeSound|
                                        UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types
                                                     categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }
}
-(void)check3DTouchComptibilityAndCreateShortcutMenuOnAppIcon:(NSDictionary *)launchOptions
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9")) {
        
        [self createShortcutItem];
        
        UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
        if (item) {
            _isActive=YES;
            
        } else {
            
            
        }
    }
}
-(void)registerInteractivePushNotificationsButtons
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")){
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationCategoriesWithCompletionHandler:^(NSSet<UNNotificationCategory *> * _Nonnull categories) {
            UNNotificationAction* myAction = [UNNotificationAction actionWithIdentifier:@"ReadLaterButton" title:@"مشاهدة لاحقا" options:(UNNotificationActionOptionDestructive)];

            UNNotificationCategory* myCategory = [UNNotificationCategory categoryWithIdentifier:@"BookmarkAction" actions:@[myAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
                NSSet *categoriess = [NSSet setWithObject:myCategory];
            
            [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categoriess];
            
        }];
    }
    else
    {
        UIMutableUserNotificationAction *action1;
        action1 = [[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeBackground];
        [action1 setTitle:@"مشاهدة لاحقا"];
        [action1 setIdentifier:@"ReadLaterButton"];
        [action1 setDestructive:YES];
        [action1 setAuthenticationRequired:NO];
        UIMutableUserNotificationCategory *actionCategory;
        actionCategory = [[UIMutableUserNotificationCategory alloc] init];
        [actionCategory setIdentifier:@"BookmarkAction"];
        [actionCategory setActions:@[action1]
                        forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:actionCategory];
        UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                        UIUserNotificationTypeSound|
                                        UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types
                                                     categories:categories];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
}
-(void)handlePushNotificationsLaunchingMode:(NSDictionary *)launchOptions
{
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo != nil)
    {
        IBGLogDebug(@"Netmera UserInfo : %@",userInfo.description);
        
        
    }
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    
    if(userInfo||localNotification.userInfo) {
        // Notification Message
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"BackgroundMode"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.haveNoti=YES;
        self.userInfo=userInfo;
        if(self.userInfo == nil)
            self.userInfo = localNotification.userInfo;
        
        
    }
}
-(void)setIRateConfigurations
{
    //==== iRate configuration ==============//
    [iRate sharedInstance].usesUntilPrompt = 4; // tell the user to rate after 4 times
    [iRate sharedInstance].daysUntilPrompt = 0; // tell the user to rate after 0 days
    [iRate sharedInstance].remindPeriod=30;    // remind him after 30 days if he pressed "later
}
-(void)setInstaBugKey
{
    [Instabug startWithToken:@"7c6abf6905743c00e101b3f97e8058d8" invocationEvent:IBGInvocationEventShake];
    [Instabug setLocale:IBGLocaleArabic];
    [Instabug setUserStepsEnabled:YES];
    [Instabug setCrashReportingEnabled:YES];
    [Instabug setNetworkLoggingEnabled:YES];
   
}
//Font and color for news details
-(void)setTextAndFontAndBGColor
{
    [Global getInstance].bgcolor=[UIColor whiteColor];
    [Global getInstance].textColor=@"black";
    [Global getInstance].fontSize=17;
    
}
-(void)setNetmeraKey
{
    [Netmera start];
    [Netmera setAPIKey:@"GJw0IxvZPXVNhNd_qMbvyrEQhjRMj7nE1FS5gAFVcG0NMwLT57ZQGg"];
    [Netmera setLogLevel:(NetmeraLogLevelDebug)];
    [Netmera requestLocationAuthorization];

}
-(void)mointeringAFNetworkingLogs
{
    AFNetworkActivityConsoleLogger *consoleLogger = [AFNetworkActivityConsoleLogger new];
    [consoleLogger setLevel:AFLoggerLevelError];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    [[AFNetworkActivityLogger sharedLogger] addLogger:consoleLogger];
    
}
-(void)setGoogleAnalyticsSettings
{
    //Google Analytics
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    [GAI sharedInstance].dispatchInterval = 20;
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-697331-9"];
//    [[GAI sharedInstance] trackerWithTrackingId:@"UA-66619211-1"];
//    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//    [tracker set:kGAIClientId
//           value:@"01111867882"];
//    [tracker set:kGAIUserId
//           value:@"01111867882"];
}

-(void)setNavigationSettings:(UIApplication*)application
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
    });
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    [[UINavigationBar appearance] setBarTintColor:[UIColor darkGrayColor]];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
    if(IS_IPHONE_4)
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
    else if(IS_IPHONE_5)
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
    else if (IS_IPHONE_6)
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
    else if (IS_IPHONE_6_PLUS)
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
    else {
        //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
        //UIImage *image = [[UIImage imageNamed:@"Nav6"] resizeImageScaledToWidthWithWidth: [UIScreen mainScreen].bounds.size.width];
        
        CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                 ([UIApplication sharedApplication].statusBarFrame.size.height +(self.navigationController.navigationBar.frame.size.height ?: 0.0)));
        
        
        UIImage *image = [[UIImage imageNamed:@"NavX"] resizeImageWithTargetSize:size];
        //UIImage *image = [[UIImage imageNamed:@"Nav4"] scaleImageToSize: size];
        
        [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBackgroundColor:[UIColor blackColor]];
    }

    
    self.navigationController.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];

}
-(void)setEffectiveMessureSettings
{
//    EmTracker *tracker = [EmTracker sharedInstance];
//    [tracker configure:@"FilgoalMobileApp" tld:@"filgoal.com" sdkKey:@"2da9a01d-0fc7-4902-8d34-9f37d5bc55f6"];
//    tracker.verbose = YES;
//    [tracker trackDefault];
    
}


-(void)setRootViewController:(UIViewController *)viewController{
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = self.navigationController;
    
}


- (void)loadWidget{
    
    MatchCenterDetails *match2;
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    if(![defaults boolForKey: @"isMore"])
    {
        NSData *object = [defaults objectForKey:@"MatchWidget"];
        if(![object isKindOfClass:[NSNumber class]])
            match2 = (MatchCenterDetails *)[NSKeyedUnarchiver unarchiveObjectWithData:object];
        // self.isToMatchDetails = YES;
        self.matchItemm = (MatchCenterDetails*)match2;
        
        MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
        matchCenter.matchCenterDetails = match2;
        [self.getSelectedNavigationController pushViewController:matchCenter animated:YES];
        
    }
    else
    {
        NSData *data ;
        NSArray *savedArray ;
        PartMatches * partMatch=[[PartMatches alloc]init];
        if([defaults integerForKey:@"SelectedTab"]==1)
        {
            data = [defaults objectForKey:@"TommorowMatches"];
            savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            partMatch.tommorrow=savedArray;
            //  matchView.matches=partMatch;
            
        }
        else if([defaults integerForKey:@"SelectedTab"]==2)
        {
            data = [defaults objectForKey:@"TodayMatches"];
            savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            partMatch.today=savedArray;
            //  matchView.matches=partMatch;
        }
        else
        {
            data = [defaults objectForKey:@"YestardayMatches"];
            savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            partMatch.yesterday=savedArray;
            // matchView.matches=partMatch;
        }
        //  matchView.sectionId=0;
        if(self.navigationController.viewControllers.count>0)
        {
            self.tabbarController.selectedIndex = 2;
        }
        
        
    }
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
- (void)willEnterFullscreen:(NSNotification*)notification
{
    self.isFullScreen = YES;
}

- (void)willExitFullscreen:(NSNotification*)notification
{
    self.isFullScreen = NO;
    
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration{
    
    
    
    
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window

{
    
    if (([[self.navigationController visibleViewController] isKindOfClass:[NewsVideoWebViewController class]])||[[self.navigationController visibleViewController] isKindOfClass:[NewsVideoWebViewControlleriOS8 class]])
        
        return ( UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskPortrait);
    
    
    
    else
    {
        if (self.isFullScreen)
        {
            
            return UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskPortrait;
            
        }else{
            
            return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
            
        }
    }
    
}



- (BOOL)shouldAutorotate {
    if (([[self.navigationController visibleViewController] isKindOfClass:[NewsVideoWebViewController class]])||([[self.navigationController visibleViewController] isKindOfClass:[SVWebViewController class]])||([[self.navigationController visibleViewController] isKindOfClass:[GlobalViewController class]])||[[self.navigationController visibleViewController] isKindOfClass:[NewsVideoWebViewControlleriOS8 class]]){
        
        return YES;
    }
    else{
        if (self.isFullScreen)
        {
            return YES;
        }else{
            return NO;
        }
    }
    
}



- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [self.managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BookmarkItem" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BookmarkItem.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


-(void) saveNotificationForLaterRead : (NSDictionary *) dictionary
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject * item = [NSEntityDescription insertNewObjectForEntityForName:@"NotificationItem" inManagedObjectContext:context];
    [item setValue:[[[dictionary objectForKey:@"_nm"]objectForKey:@"prms"]objectForKey:@"id"]  forKey:@"itemID"];
    [item setValue:[[[dictionary valueForKey:@"aps"]objectForKey:@"alert"]objectForKey:@"body"] forKey:@"itemTxt"];
    [item setValue:[[[dictionary objectForKey:@"_nm"]objectForKey:@"prms"]objectForKey:@"type"] forKey:@"itemType"];
    [item setValue:[[[dictionary objectForKey:@"_nm"]objectForKey:@"prms"]objectForKey:@"image"] forKey:@"itemImgUrl"];
    [item setValue:FALSE forKey:@"markAsRead"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ar"]];
    formatter.dateFormat = @"yyyy/MM/dd hh:mm a";
    NSString *string = [formatter stringFromDate:[NSDate date]];
    [item setValue:string forKey:@"itemDate"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSDKAppEvents activateApp];
   // Get SportesEngine Token
    
//    AFOAuthCredential *credential =
//    [AFOAuthCredential retrieveCredentialWithIdentifier:kCrednitialIdentifier];
//    [AFOAuthCredential deleteCredentialWithIdentifier:kCrednitialIdentifier];
    
    //SMGL Get The Token
    [WServicesManager getToken];
    
    // Get Predictions Token
    AFOAuthCredential *predictCredential =
    [AFOAuthCredential retrieveCredentialWithIdentifier:kPredictCrednitialIdentifier];
    if([predictCredential isExpired]||predictCredential==nil)
    {
        [AFOAuthCredential deleteCredentialWithIdentifier:kPredictCrednitialIdentifier];
        [PredictionServiceManager getToken:^(id result) {
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    if(self.isActive){
        
        self.isAppLoaded = YES;
    }
    else{
        
        self.isAppLoaded = NO;
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    _isActiveMode=YES;
    self.isAppLoaded = NO;
    // test NetWorkLayer by Bassuni
    // NetWorkLayer --------------------
    FilgoalVM *ss =  [[FilgoalVM alloc] init];
       //[ss getData];
       [ss getSection];
    // -----------------------------
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    self.isLaunched = NO;
    _isActiveMode=YES;
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)createShortcutItem {
    
    // create several (dynamic) shortcut items
    UIApplicationShortcutIcon * newsIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"أخبار"];
    UIApplicationShortcutIcon * videosIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"فيديوهات"];
    UIApplicationShortcutIcon * matchesIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"مباريات"];
    
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"1" localizedTitle:@" اخبار الاهلي" localizedSubtitle:@"" icon:newsIcon userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"2" localizedTitle:@"فيديوهات" localizedSubtitle:@"" icon:videosIcon userInfo:nil];
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"3" localizedTitle:@"مباريات" localizedSubtitle:@"" icon:matchesIcon userInfo:nil];
    UIMutableApplicationShortcutItem *item4 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"4" localizedTitle:@" اخبار الزمالك" localizedSubtitle:@"" icon:newsIcon userInfo:nil];
    // add all items to an array
    NSArray *items = @[item4,item1, item2, item3];
    
    [UIApplication sharedApplication].shortcutItems = items;
    
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    self.item=[shortcutItem.type intValue];
    
    NSArray *items = @[@"", @"Matches List", @"Video List",@"ALAhli-News",@"AlZamalek-News"];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"iOS-3DTouch"   // Event category (required)
                                                          action: @"AppIcon-3DTouch" // Event action (required)
                                                           label: [NSString stringWithFormat:@"iOS-3DTouch- %@",[items objectAtIndex:self.item]]
                                                           value:nil] build]];
    if (self.isActive) {
        
        self.isActive=NO;
        self.isFromForceTouch=YES;
    }
    else
    {
        self.isFromForceTouch=NO;
        
        [self handle3DTouch:self.item];
    }
    
}

-(void)handle3DTouch:(int)item
{
    NSArray *items = @[@"ALAhli-News",@"AlZamalek-News", @"Videos", @"Matches"];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"iOS-3DTouch"    // Event category (required)
                                                          action:@"AppIcon-3DTouch"  // Event action (required)
                                                           label: [NSString stringWithFormat:@"AppIcon-3DTouch with item =%@",[items objectAtIndex:item-1] ]
                                                           value:nil] build]];
    if(item==1)
    {
        //search for alahly news
        SearchViewController * searchView=[[SearchViewController alloc]initWithKeyWord:@"الاهلي" andTypeId:newsType];
        searchView.isFromForceTouch=true;
        [self.getSelectedNavigationController pushViewController:searchView animated:YES];
        
        
    }
    else if (item==2)
    {
        //videos
        [self.tabbarController setSelectedIndex:1];
    }
    else if (item==3)
    {
        //matches
        [self.tabbarController setSelectedIndex:2];
    }
    else if(item==4)
    {
        SearchViewController * searchView=[[SearchViewController alloc]initWithKeyWord:@"الزمالك" andTypeId:newsType];
        searchView.isFromForceTouch=true;
        [self.getSelectedNavigationController pushViewController:searchView animated:YES];
        
    }
    
}

-(void)setupTeadsSDK
{
    [TeadsSDK setLogLevel:TeadslogLevelVerbose];
    
}


-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (application.applicationState == UIApplicationStateInactive )
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"BackgroundMode"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else if(application.applicationState == UIApplicationStateActive )
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"BackgroundMode"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self handelNoti:notification.userInfo];
    }
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler
{

}
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)(void))completionHandler{
    if (application.applicationState == UIApplicationStateInactive )
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"BackgroundMode"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        NSLog(@"app not running");
    }
    else if(application.applicationState == UIApplicationStateActive )
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"BackgroundMode"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self handelNoti:notification.userInfo];
    }
    
}





- (void)searchableIndex:(nonnull CSSearchableIndex *)searchableIndex reindexAllSearchableItemsWithAcknowledgementHandler:(nonnull void (^)(void))acknowledgementHandler { 
    
}
-(void)setTabBarViewController
{
    UINavigationController * homeNavigation = [[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]initHomeViewWithSectionId:0 andChampions:@[]]];
    homeNavigation.tabBarItem.image = [[UIImage imageNamed:@"home"]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // homeNavigation.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    homeNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"homeH"]
                                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNavigation.tabBarItem.title = @"الرئسية";
    UINavigationController * newsNavigation = [[UINavigationController alloc]initWithRootViewController:[[NewsHomeVC alloc] init]];
   // UINavigationController * newsNavigation = [[UINavigationController alloc]initWithRootViewController:[[NewsHomeViewController alloc]initWithSectionId:0 TypeId:newsType]];
    newsNavigation.tabBarItem.image = [[UIImage imageNamed:@"news"]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    newsNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"newsH"]
                                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // newsNavigation.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    newsNavigation.tabBarItem.title = @"أخبار";
    
    UINavigationController * matchesNavigation = [[UINavigationController alloc]initWithRootViewController:[[WeekMatchesViewController alloc]init]];
    matchesNavigation.tabBarItem.image = [[UIImage imageNamed:@"match"]
                                          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    matchesNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"matchH"]
                                                  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // matchesNavigation.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    matchesNavigation.tabBarItem.title = @"مباريات";
    
    UINavigationController * videosNavigation = [[UINavigationController alloc]initWithRootViewController:[[VideosViewController alloc]initWithSectionId:0]];
    videosNavigation.tabBarItem.image = [[UIImage imageNamed:@"video"]
                                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    videosNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"videosH"]
                                                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //  videosNavigation.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    videosNavigation.tabBarItem.title = @"فيديوهات";
    
    UINavigationController * settingsNavigation = [[UINavigationController alloc]initWithRootViewController:[[MoreViewController alloc]init]];
    
    settingsNavigation.tabBarItem.image = [[UIImage imageNamed:@"menu"]
                                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    settingsNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"menuH"]
                                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //settingsNavigation.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    settingsNavigation.tabBarItem.title = @"المزيد";
    
    self.tabbarController = [[UITabBarController alloc]init];
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"DINNextLTW23Regular" size:13.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.tabbarController.viewControllers = @[settingsNavigation,videosNavigation,matchesNavigation,newsNavigation,homeNavigation];
    [self.tabbarController.tabBar setBarTintColor:[UIColor blackColor]];
    [self.tabbarController setSelectedIndex:4];
    self.tabbarController.tabBar.barStyle = UIBarStyleBlack;
    [self.tabbarController.tabBar setTintColor:[UIColor mainAppYellowColor]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    self.window.rootViewController = self.tabbarController;
    
}

#pragma mark - Get Selected Naviagtion Controller
-(UINavigationController*) getSelectedNavigationController
{
    UINavigationController * navigationContoller = [[self.tabbarController viewControllers]objectAtIndex:self.tabbarController.selectedIndex];
    
    return navigationContoller;
}

#pragma mark set Netmera User
-(void)saveUserDataWithDeviceToken:(NSString*)deviceToken
{
    // Set user's properties
    MyNetmeraUser * user = [[MyNetmeraUser alloc]init];
    user.userId = deviceToken;
    user.language = NSLocaleIdentifier;

}

- (void) handleWebViewPresentationForPushObject:(NetmeraPushObject *)object {
    // Present your web view UI
   GlobalViewController *vc = [[GlobalViewController alloc] init];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:vc animated:YES completion:nil];
}

#pragma mark - AppSee Delegate methods
//-(BOOL)appseeSessionStarting
//{
//    return YES;
//}
//
//-(void)appseeSessionStarted:(NSString *)sessionId videoRecorded:(BOOL)isVideoRecorded
//{
//    // Use sesssionId and isVideoRecorded
//}
//
//-(BOOL)appseeSessionEnding:(NSString *)sessionId
//{
//    return YES;
//}
//
//-(void)appseeSessionEnded:(NSString *)sessionId
//{
//    // Use sesssionId and isVideoRecorded
//}
//
//-(NSString *)appseeScreenDetected:(NSString *)screenName
//{
//    // Default implementation should keep screen as is
//    return screenName;
//}

@end
