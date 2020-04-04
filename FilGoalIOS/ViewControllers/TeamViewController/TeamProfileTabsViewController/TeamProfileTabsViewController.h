//
//  TeamProfileTabsViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/12/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamStandingsViewController.h"
#import "TeamMatchesViewController.h"
@interface TeamProfileTabsViewController : XLButtonBarPagerTabStripViewController<XLPagerTabStripViewControllerDelegate>
@property (assign, nonatomic) int teamId;
@property(nonatomic,strong) NSArray * championships;
@property(nonatomic,strong) NSMutableArray * childViewControllers;

@end
