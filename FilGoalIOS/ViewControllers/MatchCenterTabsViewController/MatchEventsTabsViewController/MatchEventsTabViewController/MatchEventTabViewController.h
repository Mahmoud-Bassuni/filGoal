//
//  MatchEventTabViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/14/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchEventsWithStatusHistory.h"
@interface MatchEventTabViewController :ParentViewController<XLPagerTabStripChildItem,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate>
@property (weak,nonatomic)NSArray * matchEventsList;
//@property (weak,nonatomic)NSArray * matchEventsList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray * matchActionsList;
@property (strong,nonatomic) NSMutableArray * matchStatusHistory;
@property (strong,nonatomic) MatchCenterDetails * matchItem;
@property (nonatomic,strong) NSMutableArray * matchEventsGroupedByStatuesList;
@property (assign,nonatomic) BOOL isFromAfterMatchView;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (nonatomic,strong) MatchEventsWithStatusHistory * matchEventsWithStatusHistory;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;



@end
