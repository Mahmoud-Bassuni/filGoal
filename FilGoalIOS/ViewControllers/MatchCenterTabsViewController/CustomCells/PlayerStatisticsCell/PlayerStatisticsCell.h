//
//  PlayerStatisticsCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/18/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerStatisticsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *firstPlayerLogoImg;
@property (weak, nonatomic) IBOutlet UIImageView *secPlayerLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *nOfFirstPlayerGoalsLbl;
@property (weak, nonatomic) IBOutlet UILabel *nOfSecPlayerGoalsLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstPlayerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *secPlayerNameLbl;
@property (strong, nonatomic) IBOutlet UIButton *firstPlayerBtn;
@property (strong, nonatomic) IBOutlet UIButton *secPlayerBtn;

@property (weak, nonatomic) IBOutlet UILabel *eventTypeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogoImg;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogoImg;
- (IBAction)secPlayerBtnPressed:(id)sender;
- (IBAction)firstPlayerBtnPressed:(id)sender;
-(void)initWithPlayerStatistics:(PlayersStatistic*)item andMatchItem:(MatchCenterDetails*) matchItem;
@end
