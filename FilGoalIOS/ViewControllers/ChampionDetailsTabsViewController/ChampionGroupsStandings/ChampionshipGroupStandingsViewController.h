//
//  ChampionshipGroupStandingsViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"


@interface ChampionshipGroupStandingsViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;
- (IBAction)selectRoundBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectRoundBtn;
@property (strong, nonatomic) ChampionShipData * championshipItem;
@property (strong, nonatomic) IBOutlet UIButton *dropdownBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dropDownHeightConstraint;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;

@end
