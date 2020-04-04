//
//  ChampionDetailsTabsViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/16/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MXSegmentedPager/MXSegmentedPager.h>

//This was inheriting from UIViewController but i ( MAHMOUD SMGL ) changed it to ParentViewController so we can use the new method for banner view
@interface ChampionDetailsTabsViewController : ParentViewController<UIGestureRecognizerDelegate,MXSegmentedPagerDelegate,MXSegmentedPagerDataSource> //UIViewController
@property (strong, nonatomic) NSMutableArray * childViewControllers;
@property (strong,nonatomic) ChampionShipData * champion;
@property (assign,nonatomic) NSInteger sectionId;
@property (strong, nonatomic) NSArray * champIds;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,assign) int selectedTabIndex;

@end
