//
//  PlayerProfileStatisticsCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/25/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "PlayerProfileStatisticsCell.h"

@implementation PlayerProfileStatisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) initWithPlayerStatistics :(PlayerProfileStatistic*) model
{
    self.nOfRedCardsLbl.text = [NSString stringWithFormat:@"%li",(long)model.redCards];
    self.nOfGoalsLbl.text = [NSString stringWithFormat:@"%li",(long)model.goals];
    self.nOfYellowCardsLbl.text = [NSString stringWithFormat:@"%li",(long)model.yellowCards];
    self.nOfPlayedMatchesLbl.text = [NSString stringWithFormat:@"%li",(long)model.played];
    self.championNameLbl.text = model.championshipName;
    self.teamNameLbl.text = model.teamName;

}

@end
