//
//  TeamProfileDetailsViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 7/27/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamProfile.h"
#import "Data.h"
#import "PreviousMatchTableViewCell.h"
#import "ChampionshipHeaderViewCellTableViewCell.h"
@interface TeamProfileDetailsViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) TeamProfile * teamProfile;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *foundationDateLbl;
@property (strong, nonatomic) NSArray * championships;
@property (strong, nonatomic) NSArray * championshipsTitles;
@property (strong, nonatomic) NSMutableArray * standings;
@property (assign, nonatomic) int teamId;
@property (strong, nonatomic) NSString * teamName;

@end
