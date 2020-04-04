//
//  ChampionshipAllmatchesViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 2/1/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"

@interface ChampionshipAllmatchesViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray * matchesList;
@property (assign, nonatomic) NSInteger  selectedWeek;
@property (strong, nonatomic) Round * selectedRound;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
- (IBAction)filterBtnPressed:(id)sender;
@property (assign, nonatomic) int teamId;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (strong,nonatomic) ChampionShipData * champion;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImg;
@property (strong, nonatomic) IBOutlet UIButton *groupsDropdownArrow;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *filtersBtnHeightConstraint;


@end
