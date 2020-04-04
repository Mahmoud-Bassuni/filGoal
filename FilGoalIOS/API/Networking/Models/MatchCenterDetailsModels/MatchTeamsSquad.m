//
//	MatchTeamsSquad.m
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchTeamsSquad.h"

NSString *const kMatchTeamsSquadIdField = @"id";
NSString *const kMatchTeamsSquadIsSpare = @"isSpare";
NSString *const kMatchTeamsSquadMatchId = @"matchId";
NSString *const kMatchTeamsSquadOrder = @"order";
NSString *const kMatchTeamsSquadPersonId = @"personId";
NSString *const kMatchTeamsSquadPersonLogoUrl = @"personLogoUrl";
NSString *const kMatchTeamsSquadPersonName = @"personName";
NSString *const kMatchTeamsSquadPlayerPositionId = @"playerPositionId";
NSString *const kMatchTeamsSquadPlayerPositionName = @"playerPositionName";
NSString *const kMatchTeamsSquadShirtNumber = @"shirtNumber";
NSString *const kMatchTeamsSquadTeamId = @"teamId";

@interface MatchTeamsSquad ()
@end
@implementation MatchTeamsSquad




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    self.playerMatchEvents=[[NSMutableArray alloc]init];
	if(![dictionary[kMatchTeamsSquadIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchTeamsSquadIdField] integerValue];
	}

	if(![dictionary[kMatchTeamsSquadIsSpare] isKindOfClass:[NSNull class]]){
		self.isSpare = [dictionary[kMatchTeamsSquadIsSpare] boolValue];
	}

	if(![dictionary[kMatchTeamsSquadMatchId] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kMatchTeamsSquadMatchId] integerValue];
	}

	if(![dictionary[kMatchTeamsSquadOrder] isKindOfClass:[NSNull class]]){
		self.order = [dictionary[kMatchTeamsSquadOrder] integerValue];
	}

	if(![dictionary[kMatchTeamsSquadPersonId] isKindOfClass:[NSNull class]]){
		self.personId = [dictionary[kMatchTeamsSquadPersonId] integerValue];
	}

	if(![dictionary[kMatchTeamsSquadPersonLogoUrl] isKindOfClass:[NSNull class]]){
		self.personLogoUrl = dictionary[kMatchTeamsSquadPersonLogoUrl];
	}	
	if(![dictionary[kMatchTeamsSquadPersonName] isKindOfClass:[NSNull class]]){
		self.personName = dictionary[kMatchTeamsSquadPersonName];
	}	
	if(![dictionary[kMatchTeamsSquadPlayerPositionId] isKindOfClass:[NSNull class]]){
		self.playerPositionId = [dictionary[kMatchTeamsSquadPlayerPositionId] integerValue];
	}

	if(![dictionary[kMatchTeamsSquadPlayerPositionName] isKindOfClass:[NSNull class]]){
		self.playerPositionName = dictionary[kMatchTeamsSquadPlayerPositionName];
	}	
	if(![dictionary[kMatchTeamsSquadShirtNumber] isKindOfClass:[NSNull class]]){
		self.shirtNumber = [dictionary[kMatchTeamsSquadShirtNumber] integerValue];
	}

	if(![dictionary[kMatchTeamsSquadTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kMatchTeamsSquadTeamId] integerValue];
	}

	return self;
}
@end