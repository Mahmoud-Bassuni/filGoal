//
//  MainSectionViewController.h
//  Reyada
//
//  Created by Nada Gamal on 8/23/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewScorersViewController.h"
#import "GSKStretchyHeaderView/GSKStretchyHeaderView.h"
#import <MXSegmentedPager/MXSegmentedPager.h>

@interface MainSectionViewController :UIViewController<MXSegmentedPagerDataSource,MXSegmentedPagerDelegate>
@property (strong, nonatomic) IBOutlet UIView *tabsView;
@property(nonatomic,assign) int sectionId;
@property(nonatomic,assign) int selectedTabIndex;

@property(nonatomic,assign) int sectionType;
@property(nonatomic,assign) BOOL showRotationIcon;
@property(nonatomic,assign) BOOL isFromHome;
@property(nonatomic,assign) BOOL hasMultiChamps;
@property(nonatomic,strong) ChampionShipData * champion;
@property(nonatomic,strong) Section * section;
@property(nonatomic,assign) BOOL isTabsLoaded;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabsTopSpaceConstraint;
@property (nonatomic,strong) CAPSPageMenu *pageMenu;
@property (strong, nonatomic) NSMutableArray * childViewControllers;
@property(nonatomic,retain) IBOutlet UIImageView *sponser;
@property (weak, nonatomic) IBOutlet UILabel *sectionNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *champLogoImg;
-(id)initWithSection:(Section*)section;
@property (strong, nonatomic) IBOutlet UIImageView *specialSectionBanner;
@property (strong, nonatomic) IBOutlet UIView *sectionNameView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImageConstraintHeight;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;

@end
