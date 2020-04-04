//
//  TeamStandingsHeaderCell.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamStandingsHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *champNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *teamRankLbl;
@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *pointsLbl;
@property (weak, nonatomic) IBOutlet UILabel *playedLbl;
@property (weak, nonatomic) IBOutlet UILabel *winLbl;
@property (weak, nonatomic) IBOutlet UILabel *lossLbl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
-(void) initWithTeamStandingItem :(Standing*)item;
- (IBAction)homeTeamBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *homeTeamBtn;
@end
