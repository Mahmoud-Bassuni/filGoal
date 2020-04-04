//
//  ChampionshipDaweryStandingsViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"


@interface ChampionshipDaweryStandingsViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong, nonatomic) ChampionShipData * championshipItem;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;
@end
