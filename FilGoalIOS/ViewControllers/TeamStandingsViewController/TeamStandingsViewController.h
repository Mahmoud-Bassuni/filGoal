//
//  TeamStandingsViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/8/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamStandings.h"
#import "StandingsCell.h"
#import "DOPDropDownMenu.h"
@interface TeamStandingsViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,XLPagerTabStripChildItem>
@property (strong, nonatomic) NSArray * championships;
@property (strong, nonatomic) NSArray * championshipsTitles;
@property (strong, nonatomic) NSMutableArray * standings;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (assign, nonatomic) int teamId;
@property (strong, nonatomic) NSString* teamName;
@property (nonatomic, strong) DOPDropDownMenu *menu;

@end
