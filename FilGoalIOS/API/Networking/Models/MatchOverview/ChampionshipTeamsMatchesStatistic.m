//
//	ChampionshipTeamsMatchesStatistic.m
//
//	Create by Mohamed Mansour on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ChampionshipTeamsMatchesStatistic.h"

NSString *const kChampionshipTeamsMatchesStatisticAwayTeamValue = @"awayTeamValue";
NSString *const kChampionshipTeamsMatchesStatisticHomeTeamValue = @"homeTeamValue";
NSString *const kChampionshipTeamsMatchesStatisticIdField = @"id";
NSString *const kChampionshipTeamsMatchesStatisticIsPercentage = @"isPercentage";
NSString *const kChampionshipTeamsMatchesStatisticMatchStatisticsTypeId = @"matchStatisticsTypeId";
NSString *const kChampionshipTeamsMatchesStatisticMatchStatisticsTypeName = @"matchStatisticsTypeName";

@interface ChampionshipTeamsMatchesStatistic ()
@end
@implementation ChampionshipTeamsMatchesStatistic




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kChampionshipTeamsMatchesStatisticAwayTeamValue] isKindOfClass:[NSNull class]]){
		self.awayTeamValue = [dictionary[kChampionshipTeamsMatchesStatisticAwayTeamValue] integerValue];
	}

	if(![dictionary[kChampionshipTeamsMatchesStatisticHomeTeamValue] isKindOfClass:[NSNull class]]){
		self.homeTeamValue = [dictionary[kChampionshipTeamsMatchesStatisticHomeTeamValue] integerValue];
	}

	if(![dictionary[kChampionshipTeamsMatchesStatisticIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kChampionshipTeamsMatchesStatisticIdField] integerValue];
	}

	if(![dictionary[kChampionshipTeamsMatchesStatisticIsPercentage] isKindOfClass:[NSNull class]]){
		self.isPercentage = [dictionary[kChampionshipTeamsMatchesStatisticIsPercentage] boolValue];
	}

	if(![dictionary[kChampionshipTeamsMatchesStatisticMatchStatisticsTypeId] isKindOfClass:[NSNull class]]){
		self.matchStatisticsTypeId = [dictionary[kChampionshipTeamsMatchesStatisticMatchStatisticsTypeId] integerValue];
	}

	if(![dictionary[kChampionshipTeamsMatchesStatisticMatchStatisticsTypeName] isKindOfClass:[NSNull class]]){
		self.matchStatisticsTypeName = dictionary[kChampionshipTeamsMatchesStatisticMatchStatisticsTypeName];
	}	
	return self;
}
@end