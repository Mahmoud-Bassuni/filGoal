//
//  ChampMatchesViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"


@interface ChampMatchesViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong,nonatomic) ChampionShipData * champion;
- (IBAction)filterBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (weak, nonatomic) IBOutlet UILabel *nOfGoalsLbl;
@property (weak, nonatomic) IBOutlet UILabel *nOfMatchesLbl;
@property (weak, nonatomic) IBOutlet UILabel *nOfYellowCardsLbl;
@property (strong, nonatomic) IBOutlet UILabel *nOfRedCardsLbl;
@property (strong, nonatomic) NSArray *aggregatedCards;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;
@end
