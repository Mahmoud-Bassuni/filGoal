//
//	PlayersStatistic.m
//
//	Create by Mohamed Mansour on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PlayersStatistic.h"

NSString *const kPlayersStatisticEventTypeId = @"eventTypeId";
NSString *const kPlayersStatisticEventTypeName = @"eventTypeName";
NSString *const kPlayersStatisticFirstPersonId = @"homeTeamPersonId";
//NSString *const kPlayersStatisticFirstPersonLogoUrl = @"firstPersonLogoUrl";
NSString *const kPlayersStatisticFirstPersonName = @"homeTeamPersonName";
//NSString *const kPlayersStatisticFirstTeamId = @"homeTeamPersonId";
NSString *const kPlayersStatisticFirstValue = @"homeTeamValue";
NSString *const kPlayersStatisticSecondPersonId = @"awayTeamPersonId";
//NSString *const kPlayersStatisticSecondPersonLogoUrl = @"secondPersonLogoUrl";
NSString *const kPlayersStatisticSecondPersonName = @"awayTeamPersonName";
//NSString *const kPlayersStatisticSecondTeamId = @"secondTeamId";
NSString *const kPlayersStatisticSecondValue = @"awayTeamValue";

@interface PlayersStatistic ()
@end
@implementation PlayersStatistic




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPlayersStatisticEventTypeId] isKindOfClass:[NSNull class]]){
		self.eventTypeId = [dictionary[kPlayersStatisticEventTypeId] integerValue];
	}

	if(![dictionary[kPlayersStatisticEventTypeName] isKindOfClass:[NSNull class]]){
		self.eventTypeName = dictionary[kPlayersStatisticEventTypeName];
	}	
	if(![dictionary[kPlayersStatisticFirstPersonId] isKindOfClass:[NSNull class]]){
		self.firstPersonId = [dictionary[kPlayersStatisticFirstPersonId]integerValue];
	}	
//	if(![dictionary[kPlayersStatisticFirstPersonLogoUrl] isKindOfClass:[NSNull class]]){
//		self.firstPersonLogoUrl = dictionary[kPlayersStatisticFirstPersonLogoUrl];
//	}	
	if(![dictionary[kPlayersStatisticFirstPersonName] isKindOfClass:[NSNull class]]){
		self.firstPersonName = dictionary[kPlayersStatisticFirstPersonName];
	}	
//	if(![dictionary[kPlayersStatisticFirstTeamId] isKindOfClass:[NSNull class]]){
//		self.firstTeamId = [dictionary[kPlayersStatisticFirstTeamId] integerValue];
//	}

	if(![dictionary[kPlayersStatisticFirstValue] isKindOfClass:[NSNull class]]){
		self.firstValue = [dictionary[kPlayersStatisticFirstValue] integerValue];
	}

	if(![dictionary[kPlayersStatisticSecondPersonId] isKindOfClass:[NSNull class]]){
		self.secondPersonId = [dictionary[kPlayersStatisticSecondPersonId]integerValue];
	}	
//	if(![dictionary[kPlayersStatisticSecondPersonLogoUrl] isKindOfClass:[NSNull class]]){
//		self.secondPersonLogoUrl = dictionary[kPlayersStatisticSecondPersonLogoUrl];
//	}	
	if(![dictionary[kPlayersStatisticSecondPersonName] isKindOfClass:[NSNull class]]){
		self.secondPersonName = dictionary[kPlayersStatisticSecondPersonName];
	}	
//	if(![dictionary[kPlayersStatisticSecondTeamId] isKindOfClass:[NSNull class]]){
//		self.secondTeamId = [dictionary[kPlayersStatisticSecondTeamId] integerValue];
//	}

	if(![dictionary[kPlayersStatisticSecondValue] isKindOfClass:[NSNull class]]){
		self.secondValue = [dictionary[kPlayersStatisticSecondValue] integerValue];
	}

	return self;
}
@end