//
//	MatchStatistic.m
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchStatistic.h"

NSString *const kMatchStatisticAwayTeamValue = @"awayTeamValue";
NSString *const kMatchStatisticHomeTeamValue = @"homeTeamValue";
NSString *const kMatchStatisticIdField = @"id";
NSString *const kMatchStatisticIsPercentage = @"isPercentage";
NSString *const kMatchStatisticMatchStatisticsTypeId = @"matchStatisticsTypeId";
NSString *const kMatchStatisticMatchStatisticsTypeName = @"matchStatisticsTypeName";

@interface MatchStatistic ()
@end
@implementation MatchStatistic




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMatchStatisticAwayTeamValue] isKindOfClass:[NSNull class]]){
		self.awayTeamValue = [dictionary[kMatchStatisticAwayTeamValue] integerValue];
	}

	if(![dictionary[kMatchStatisticHomeTeamValue] isKindOfClass:[NSNull class]]){
		self.homeTeamValue = [dictionary[kMatchStatisticHomeTeamValue] integerValue];
	}

	if(![dictionary[kMatchStatisticIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchStatisticIdField] integerValue];
	}

	if(![dictionary[kMatchStatisticIsPercentage] isKindOfClass:[NSNull class]]){
		self.isPercentage = [dictionary[kMatchStatisticIsPercentage] boolValue];
	}

	if(![dictionary[kMatchStatisticMatchStatisticsTypeId] isKindOfClass:[NSNull class]]){
		self.matchStatisticsTypeId = [dictionary[kMatchStatisticMatchStatisticsTypeId] integerValue];
	}

	if(![dictionary[kMatchStatisticMatchStatisticsTypeName] isKindOfClass:[NSNull class]]){
		self.matchStatisticsTypeName = dictionary[kMatchStatisticMatchStatisticsTypeName];
	}	
	return self;
}
@end