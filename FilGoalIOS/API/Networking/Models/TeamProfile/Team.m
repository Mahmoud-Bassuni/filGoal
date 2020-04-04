//
//	Team.m
//
//	Create by Nada Gamal on 6/8/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Team.h"

NSString *const kTeamChampionshipId = @"championshipId";
NSString *const kTeamIdField = @"id";
NSString *const kTeamPlayers = @"players";
NSString *const kTeamTeamId = @"teamId";
NSString *const kTeamTeamName = @"teamName";

@interface Team ()
@end
@implementation Team




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTeamChampionshipId] isKindOfClass:[NSNull class]]){
		self.championshipId = [dictionary[kTeamChampionshipId] integerValue];
	}

	if(![dictionary[kTeamIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kTeamIdField] integerValue];
	}

	if(dictionary[kTeamPlayers] != nil && [dictionary[kTeamPlayers] isKindOfClass:[NSArray class]]){
		NSArray * playersDictionaries = dictionary[kTeamPlayers];
		NSMutableArray * playersItems = [NSMutableArray array];
		for(NSDictionary * playersDictionary in playersDictionaries){
			Player * playersItem = [[Player alloc] initWithDictionary:playersDictionary];
			[playersItems addObject:playersItem];
		}
		self.players = playersItems;
	}
	if(![dictionary[kTeamTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kTeamTeamId] integerValue];
	}

	if(![dictionary[kTeamTeamName] isKindOfClass:[NSNull class]]){
		self.teamName = dictionary[kTeamTeamName];
	}	
	return self;
}
@end