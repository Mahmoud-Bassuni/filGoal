//
//  PlayerProfileStatisticsCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/25/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerProfileStatistic.h"
@interface PlayerProfileStatisticsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *championNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *teamNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *nOfGoalsLbl;
@property (strong, nonatomic) IBOutlet UILabel *nOfYellowCardsLbl;
@property (strong, nonatomic) IBOutlet UILabel *nOfRedCardsLbl;
@property (weak, nonatomic) IBOutlet UILabel *nOfPlayedMatchesLbl;
-(void) initWithPlayerStatistics :(PlayerProfileStatistic*) model;
@end
