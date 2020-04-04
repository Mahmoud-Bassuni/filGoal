//
//  MatchTabsViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/6/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLButtonBarPagerTabStripViewController.h"
#import "MatchCenterDetails.h"
@interface MatchDetailsTabsViewController : XLButtonBarPagerTabStripViewController<XLPagerTabStripViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray * matchStatusHistoryList;
@property (nonatomic,strong) NSMutableArray * childViewControllers;
@property (nonatomic,strong) MatchCenterDetails * matchCenterItem;
//@property(nonatomic,assign) BOOL isFromMatchEventsTabs;


@end
