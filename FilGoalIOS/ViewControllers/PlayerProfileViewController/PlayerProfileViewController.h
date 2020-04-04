//
//  PlayerProfileViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/25/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "UIImageView+WebCache.h"
#import "PlayerStatisticsTableViewHeader.h"
#import "PlayerProfileStatisticsCell.h"
#import "PlayerProfile.h"
@interface PlayerProfileViewController : ParentViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *sponsorImg;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UIImageView *playerImgView;
@property (strong, nonatomic) IBOutlet UIImageView *teamLogoImgView;
@property (strong, nonatomic) IBOutlet UILabel *playerNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *playerTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *teamNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *playerNationalityLbl;
@property (strong, nonatomic) IBOutlet UILabel *playerBirthdateLbl;
@property (strong, nonatomic) IBOutlet UILabel *playerBirthPlace;
@property (strong, nonatomic) IBOutlet UIView *teamLogoView;
@property (strong, nonatomic) IBOutlet UILabel *tShirtNumberLbl;
@property (strong, nonatomic) IBOutlet UIView *propertiesView;
@property (strong, nonatomic) IBOutlet UILabel *nOfPlayedMatchesLbl;
@property (strong, nonatomic) IBOutlet UILabel *nOfGoalsLbl;
@property (strong, nonatomic) IBOutlet UILabel *nOfYellowCards;
@property (strong, nonatomic) IBOutlet UILabel *nOfRedCardsLbl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)  Player * player;
@property (assign,nonatomic)  int  playerId;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *twitterBtn;
@property (weak, nonatomic) IBOutlet UIButton *facebookBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *largeActivityIndicator;

#pragma mark - Header View 
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerTitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;





@end
