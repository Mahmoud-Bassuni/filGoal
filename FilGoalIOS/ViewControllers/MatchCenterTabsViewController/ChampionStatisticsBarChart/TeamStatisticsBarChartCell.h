//
//  TeamStatisticsBarChartCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/23/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamStatisticsBarChartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *homeTeamValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *eventTypeLbl;
@property (weak, nonatomic) IBOutlet UIProgressView *homeProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *awayProgressView;
-(void) initWithMatchStatistics:(MatchStatistic*) item;
@end
