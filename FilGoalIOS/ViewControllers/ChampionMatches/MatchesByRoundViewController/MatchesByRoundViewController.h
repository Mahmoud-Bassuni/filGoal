//
//  MatchesByRoundViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/26/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchesByRoundViewController : ParentViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong, nonatomic) IBOutlet UIButton *dropdownMenuBtn;
@property (strong,nonatomic) ChampionShipData * champion;
@property (strong, nonatomic) IBOutlet UIButton *groupsDropDownBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *groupsBtnHeight;
@property (strong, nonatomic) IBOutlet UIButton *groupsDropdownArrow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *sponsorImg;
- (IBAction)groupsDropDownBtnPressed:(id)sender;
- (IBAction)dropdownBtnPressed:(id)sender;
@end
