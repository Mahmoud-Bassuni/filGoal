//
//  TeamMatchesViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/8/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatcheCenterCellLoader.h"
#import "TappableSponsorImageView.h"

@interface TeamMatchesViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,XLPagerTabStripChildItem>
//@property (strong, nonatomic) NSMutableArray * groupedMatches;
@property (strong, nonatomic) NSString * viewType;
@property (strong, nonatomic) NSMutableArray * matchesList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (assign, nonatomic) int teamId;
@property (weak, nonatomic) IBOutlet UIButton *selectChampionshipBtn;
@property(assign,nonatomic) NSInteger champId;
- (IBAction)championshipsBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;
@property (strong, nonatomic) NSString * teamName;

@end
