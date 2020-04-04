//
//  featuredPagerViewController.h
//  
//
//  Created by Ahmed Kotb on 5/12/16.
//
//

#import <UIKit/UIKit.h>
#import "FeaturedSectionTabsViewController.h"
#import "XLPagerTabStripViewController.h"
#import "RamdanDayViewController.h"
#import "AppInfo.h"
#import "AfterSection.h"
#import "ParentViewController.h"
#import "FeaturedSection.h"
@class RamdanDayViewController;

@interface featuredPagerViewController : ParentViewController

@property (weak, nonatomic) IBOutlet UIView *tabsView;
@property (strong, nonatomic) AppInfo *appInfo;
@property (strong, nonatomic) AfterSection * afterSection;
@property (strong, nonatomic) AfterSection * beforeSection;
@property (strong, nonatomic) FeaturedSection * featuredSection;
@property (strong,nonatomic) NSDate * selectedDate;
@property (assign,nonatomic) NSInteger selectedIndex;
@property (assign,nonatomic) BOOL isFromPushNotification;
@property (strong, nonatomic) Component *component;

@property (strong, nonatomic) NSString * metaDataJsonUrl;
@property (weak, nonatomic) IBOutlet UIImageView *sponsorImg;
@property (strong, nonatomic) IBOutlet UIImageView *sectionBannerImgView;

@end
