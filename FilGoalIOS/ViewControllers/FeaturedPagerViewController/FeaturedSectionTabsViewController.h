//
//  FeaturedSectionTabsViewController.h
//  Reyada
//
//  Created by Ahmed Kotb on 5/4/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "XLButtonBarPagerTabStripViewController.h"

@interface FeaturedSectionTabsViewController : XLButtonBarPagerTabStripViewController<XLPagerTabStripViewControllerDelegate>
@property (nonatomic,strong) UIColor * indicatorColor;
@property (nonatomic,strong) NSMutableArray * childViewControllers;
@property (weak, nonatomic) IBOutlet UIScrollView *containerView;
@property (nonatomic,strong) NSArray * tabsTitles;
@property(nonatomic,assign) BOOL isFromFeaturedSection;
@property (nonatomic, assign) NSInteger selectedTabIndex;
@property (strong,nonatomic) NSDate * selectedDate;

@end
