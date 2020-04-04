//
//  AppDelegate.h
//  hrm
//
//  Created by MohamedMansour on 3/24/13.
//  Copyright (c) 2013 MohamedMansour. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NewsItem.h"
#import "VideoItem.h"
#import "Section.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <CoreData/CoreData.h>
#import "MatchCenterDetails.h"
#import "NewsDetailsViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Album.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIWebViewDelegate,CSSearchableIndexDelegate,UNUserNotificationCenterDelegate>

{
    NSURLRequest *request;
    NSString *urlString;
    NSURL *url;
}
@property(nonatomic,assign) BOOL isFromForceTouch;
@property(nonatomic,assign) int item;
@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong) IBOutlet UITabBarController * tabbarController;
@property(nonatomic,assign) BOOL isFullScreen;
@property (nonatomic, strong) NewsItem *newsItem;
@property (nonatomic, strong) VideoItem *videoItem;
@property (strong,nonatomic) MatchCenterDetails * matchItemm;
@property(nonatomic,assign) BOOL isActiveMode;
@property (strong,nonatomic) Section * sectionItem;
@property (strong,nonatomic) NSString * notificationUrl;

@property(nonatomic,strong) NSDictionary * userInfo;
@property(nonatomic,assign) BOOL haveNoti;
@property(nonatomic,assign) BOOL isActive;
@property(nonatomic,assign) BOOL isFromUnviersalLinks;
@property(nonatomic,strong) NSURL * universalLinkUrl;

@property(nonatomic,assign) BOOL isFromSpotLightSearch;
@property(nonatomic,assign) BOOL isFromNewsWidget;
@property(nonatomic,assign) BOOL isFromMatchesWidget;
@property(nonatomic, assign)BOOL isToMatchDetails;
@property (nonatomic, assign) BOOL isAppLoaded;
@property (strong, nonatomic) NewsDetailsViewController *newsDetails;
@property(nonatomic,strong) NSString * Keyword;
@property(nonatomic,strong)NSMutableArray * searchItems;
@property(nonatomic,assign) BOOL isFirstLaunch;
@property(nonatomic,assign) BOOL isFromUniversalLinks;
@property(nonatomic,assign) BOOL isLaunched;
@property (nonatomic,strong) Champion * champion;
@property (nonatomic,strong) NSString * userActivityType;
@property (nonatomic,strong) NSString * matchesDate;
@property (nonatomic,strong) NSString * notifURL;

@property (nonatomic,strong) Section * section;
@property(nonatomic,strong) UIWebView *effectiveMeasurementWebView;
@property (nonatomic,strong)  Album * albumItem;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)handelNoti:(NSDictionary *)userInfo;
-(void)handleSpotLightSearchWithKeyword:(NSString*)keyword;
-(void) setRootViewController: (UIViewController *) viewController;
-(void)setTabBarViewController;
-(UINavigationController*) getSelectedNavigationController;

@end
