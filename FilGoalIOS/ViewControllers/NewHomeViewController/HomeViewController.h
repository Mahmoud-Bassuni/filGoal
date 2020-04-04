//
//  HomeViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 6/6/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeParts.h"
#import "HomeItems.h"
#import "FeaturedAreaSliderViewController.h"
#import "UIImageView+WebCache.h"
#import "SegmentButtonsHeader.h"
#import "MatchesWidgetViewController.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "BannersSliderViewController.h"
#import "NewUpdateViewController.h"
#import "Global.h"
#import "App.h"
#import "featuredPagerViewController.h"
#import "PagerViewController.h"
#import "SearchViewController.h"
#import "VideosViewController.h"
#import "NewsHomeViewController.h"
#import "UIViewController+ScrollingNavbar.h"

@interface HomeViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,XLPagerTabStripChildItem,GADDebugOptionsViewControllerDelegate, WKNavigationDelegate>
@property(assign,nonatomic) int sectionId;
@property(nonatomic,assign) int index;
@property(nonatomic,assign) BOOL isFirstLoad;
@property(nonatomic,strong) NSArray * sectionChampions;
@property (strong,nonatomic) NSDictionary * matchesDic;
@property (strong,nonatomic) MatchesWidgetViewController * widgetVC;
@property(nonatomic,assign) BOOL isFromLandingScreen;
@property (nonatomic, strong) NSDate *lastVersionCheckPerformedOnDate;
@property (assign,nonatomic) double matchesWidgetHeight;
@property (weak, nonatomic) IBOutlet UIImageView *specialSectionImgView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomTableViewSpaceConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *specialSectionSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSString * sectionName;
@property (strong, nonatomic) IBOutlet UIButton *testBtn;
- (IBAction)action:(id)sender;
-(id)initHomeViewWithSectionId:(int)sectionId andChampions:(NSArray*)champions;
@end
