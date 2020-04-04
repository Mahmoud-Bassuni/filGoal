//
//  TeamStatisticsBarChartCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/23/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "TeamStatisticsBarChartCell.h"

@implementation TeamStatisticsBarChartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithMatchStatistics:(MatchStatistic *)item
{
    NSInteger totalValue = item.homeTeamValue + item.awayTeamValue;
    float homeTeamValue = (float)item.homeTeamValue/totalValue;
    float awayTeamValue = (float) item.awayTeamValue/totalValue;
    [self.eventTypeLbl setText:item.matchStatisticsTypeName];
    [self.homeTeamValueLbl setText:[NSString stringWithFormat:@"%li",(long)item.homeTeamValue]];
    [self.awayTeamValueLbl setText:[NSString stringWithFormat:@"%li",(long)item.awayTeamValue]];
    [self.homeProgressView setProgress:homeTeamValue];
    [self.awayProgressView setProgress:awayTeamValue];
}
@end
