//
//	MatchOverview.h
//
//	Create by Mohamed Mansour on 16/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "ChampionshipTeamsMatchesStatistic.h"
#import "FirstTeamHeighestScore.h"
#import "PlayersStatistic.h"
#import "FirstTeamHeighestScore.h"
#import "WinsComparison.h"

@interface MatchOverview : NSObject

@property (nonatomic, assign) NSInteger championshipId;
@property (nonatomic, strong) NSArray * championshipTeamsMatchesStatistics;
@property (nonatomic, strong) NSArray * standings;

@property (nonatomic, strong) FirstTeamHeighestScore * firstTeamHeighestScore;
@property (nonatomic, assign) NSInteger firstTeamId;
@property (nonatomic, strong) NSArray * playersStatistics;
@property (nonatomic, strong) FirstTeamHeighestScore * secondTeamHeighestScore;
@property (nonatomic, assign) NSInteger secondTeamId;
@property (nonatomic, strong) WinsComparison * winsComparison;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
