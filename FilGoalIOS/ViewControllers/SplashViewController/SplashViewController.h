//
//  MainViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/16/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppInfo.h"
#import "GAITrackedViewController.h"
#import "ParentViewController.h"
#import "HomeViewController.h"
#import "AreaDetails.h"
#import "SettingsViewController.h"
@interface SplashViewController : ParentViewController<UIWebViewDelegate>
@property(nonatomic,retain) AppInfo *appInfo;
@property(nonatomic,retain) IBOutlet UIImageView *sponser;
@property(nonatomic,retain) IBOutlet UIImageView *bg;
@property(nonatomic,strong)NSMutableArray * searchItems;
@property(nonatomic,retain) HomeViewController *homeViewController;
@property (nonatomic, strong) NSDate *lastVersionCheckPerformedOnDate;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) AreaDetails * areaDetails;
@end

