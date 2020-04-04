//
//	PredictionStatistics.m
//
//	Create by Nada Gamal on 13/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PredictionStatistics.h"

NSString *const kPredictionStatisticsAwayTeamWin = @"awayTeamWin";
NSString *const kPredictionStatisticsAwayTeamWinPercentage = @"awayTeamWinPercentage";
NSString *const kPredictionStatisticsHomeTeamWin = @"homeTeamWin";
NSString *const kPredictionStatisticsHomeTeamWinPercentage = @"homeTeamWinPercentage";
NSString *const kPredictionStatisticsMatchDraw = @"matchDraw";
NSString *const kPredictionStatisticsMatchDrawPercentage = @"matchDrawPercentage";

@interface PredictionStatistics ()
@end
@implementation PredictionStatistics




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPredictionStatisticsAwayTeamWin] isKindOfClass:[NSNull class]]){
		self.awayTeamWin = [dictionary[kPredictionStatisticsAwayTeamWin] integerValue];
	}

	if(![dictionary[kPredictionStatisticsAwayTeamWinPercentage] isKindOfClass:[NSNull class]]){
		self.awayTeamWinPercentage = [dictionary[kPredictionStatisticsAwayTeamWinPercentage] integerValue];
	}

	if(![dictionary[kPredictionStatisticsHomeTeamWin] isKindOfClass:[NSNull class]]){
		self.homeTeamWin = [dictionary[kPredictionStatisticsHomeTeamWin] integerValue];
	}

	if(![dictionary[kPredictionStatisticsHomeTeamWinPercentage] isKindOfClass:[NSNull class]]){
		self.homeTeamWinPercentage = [dictionary[kPredictionStatisticsHomeTeamWinPercentage] integerValue];
	}

	if(![dictionary[kPredictionStatisticsMatchDraw] isKindOfClass:[NSNull class]]){
		self.matchDraw = [dictionary[kPredictionStatisticsMatchDraw] integerValue];
	}

	if(![dictionary[kPredictionStatisticsMatchDrawPercentage] isKindOfClass:[NSNull class]]){
		self.matchDrawPercentage = [dictionary[kPredictionStatisticsMatchDrawPercentage] integerValue];
	}

	return self;
}
@end