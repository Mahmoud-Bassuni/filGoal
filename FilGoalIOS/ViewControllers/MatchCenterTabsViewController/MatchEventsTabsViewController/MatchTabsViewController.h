//
//  MatchTabsViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLButtonBarPagerTabStripViewController.h"
#import "MatchEventsWithStatusHistory.h"
#import "TappableSponsorImageView.h"


@interface MatchTabsViewController : XLButtonBarPagerTabStripViewController<XLPagerTabStripChildItem,XLPagerTabStripViewControllerDelegate>
@property(nonatomic,assign) int index;
@property (strong,nonatomic) MatchCenterDetails * matchItem;
@property (weak, nonatomic) IBOutlet UIView *tabsView;
@property (nonatomic,strong) NSMutableArray * childViewControllers;
@property(nonatomic,assign) BOOL isFromMatchEventsTabs;
@property(nonatomic,assign) BOOL isViewDidAppearCalledBefore;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;
@property (nonatomic,strong) MatchEventsWithStatusHistory * matchEventsWithStatusHistory;

@property (nonatomic,strong) NSMutableArray * matchStatusHistoryList;
@property (nonatomic,strong) NSArray * matchTeamsSquads;
@property (nonatomic,weak) NSArray * matchEvents;
@property (nonatomic,strong) NSArray * matchEventsList;

@property (nonatomic,strong) MatchCenterDetails* matchDetails;

@end
