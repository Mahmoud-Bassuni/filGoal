//
//	MatchEvent.m
//
//	Create by Nada Gamal on 11/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchEvent.h"

NSString *const kMatchEventIdField = @"id";
NSString *const kMatchEventMatchEventTypeId = @"matchEventTypeId";
NSString *const kMatchEventMatchEventTypeName = @"matchEventTypeName";
NSString *const kMatchEventMatchId = @"matchId";
NSString *const kMatchEventMatchStatusId = @"matchStatusId";
NSString *const kMatchEventMatchStatusMaxTime = @"matchStatusMaxTime";
NSString *const kMatchEventMatchStatusName = @"matchStatusName";
NSString *const kMatchEventNumberOfComments = @"numberOfComments";
NSString *const kMatchEventPlayerAId = @"playerAId";
NSString *const kMatchEventPlayerALogoUrl = @"playerALogoUrl";
NSString *const kMatchEventPlayerAName = @"playerAName";
NSString *const kMatchEventPlayerARoleName = @"playerARoleName";
NSString *const kMatchEventPlayerBId = @"playerBId";
NSString *const kMatchEventPlayerBLogoUrl = @"playerBLogoUrl";
NSString *const kMatchEventPlayerBName = @"playerBName";
NSString *const kMatchEventPlayerBRoleName = @"playerBRoleName";
NSString *const kMatchEventTeamId = @"teamId";
NSString *const kMatchEventTeamName = @"teamName";
NSString *const kMatchEventTime = @"time";

@interface MatchEvent ()
@end
@implementation MatchEvent




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMatchEventIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchEventIdField] integerValue];
	}

	if(![dictionary[kMatchEventMatchEventTypeId] isKindOfClass:[NSNull class]]){
		self.matchEventTypeId = [dictionary[kMatchEventMatchEventTypeId] integerValue];
        self.matchEventType=self.matchStatusId;
	}

	if(![dictionary[kMatchEventMatchEventTypeName] isKindOfClass:[NSNull class]]){
		self.matchEventTypeName = dictionary[kMatchEventMatchEventTypeName];
	}	
	if(![dictionary[kMatchEventMatchId] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kMatchEventMatchId] integerValue];
	}

	if(![dictionary[kMatchEventMatchStatusId] isKindOfClass:[NSNull class]]){
		self.matchStatusId = [dictionary[kMatchEventMatchStatusId] integerValue];
	}

	if(![dictionary[kMatchEventMatchStatusMaxTime] isKindOfClass:[NSNull class]]){
		self.matchStatusMaxTime = [dictionary[kMatchEventMatchStatusMaxTime] integerValue];
	}

	if(![dictionary[kMatchEventMatchStatusName] isKindOfClass:[NSNull class]]){
		self.matchStatusName = dictionary[kMatchEventMatchStatusName];
	}	
	if(![dictionary[kMatchEventNumberOfComments] isKindOfClass:[NSNull class]]){
		self.numberOfComments = [dictionary[kMatchEventNumberOfComments] integerValue];
	}

	if(![dictionary[kMatchEventPlayerAId] isKindOfClass:[NSNull class]]){
		self.playerAId = [dictionary[kMatchEventPlayerAId] integerValue];
	}

	if(![dictionary[kMatchEventPlayerALogoUrl] isKindOfClass:[NSNull class]]){
		self.playerALogoUrl = dictionary[kMatchEventPlayerALogoUrl];
	}	
	if(![dictionary[kMatchEventPlayerAName] isKindOfClass:[NSNull class]]){
		self.playerAName = dictionary[kMatchEventPlayerAName];
	}	
	if(![dictionary[kMatchEventPlayerARoleName] isKindOfClass:[NSNull class]]){
		self.playerARoleName = dictionary[kMatchEventPlayerARoleName];
	}	
	if(![dictionary[kMatchEventPlayerBId] isKindOfClass:[NSNull class]]){
		self.playerBId = [dictionary[kMatchEventPlayerBId] integerValue];
	}

	if(![dictionary[kMatchEventPlayerBLogoUrl] isKindOfClass:[NSNull class]]){
		self.playerBLogoUrl = dictionary[kMatchEventPlayerBLogoUrl];
	}	
	if(![dictionary[kMatchEventPlayerBName] isKindOfClass:[NSNull class]]){
		self.playerBName = dictionary[kMatchEventPlayerBName];
	}	
	if(![dictionary[kMatchEventPlayerBRoleName] isKindOfClass:[NSNull class]]){
		self.playerBRoleName = dictionary[kMatchEventPlayerBRoleName];
	}	
	if(![dictionary[kMatchEventTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kMatchEventTeamId] integerValue];
	}

	if(![dictionary[kMatchEventTeamName] isKindOfClass:[NSNull class]]){
		self.teamName = dictionary[kMatchEventTeamName];
	}	
	if(![dictionary[kMatchEventTime] isKindOfClass:[NSNull class]]){
		self.time = [dictionary[kMatchEventTime] integerValue];
       // self.time = [self getMatchTime:[dictionary[kMatchEventTime] integerValue]];

	}

	return self;
}



@end
