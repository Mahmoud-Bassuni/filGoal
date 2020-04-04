//
//	PlayerProfileStatistic.m
//
//	Create by Nada Gamal on 26/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PlayerProfileStatistic.h"

NSString *const kPlayerProfileStatisticChampionshipId = @"championshipId";
NSString *const kPlayerProfileStatisticChampionshipName = @"championshipName";
NSString *const kPlayerProfileStatisticChampionshipSlug = @"championshipSlug";
NSString *const kPlayerProfileStatisticGoals = @"goals";
NSString *const kPlayerProfileStatisticPlayed = @"played";
NSString *const kPlayerProfileStatisticRedCards = @"redCards";
NSString *const kPlayerProfileStatisticTeamId = @"teamId";
NSString *const kPlayerProfileStatisticTeamName = @"teamName";
NSString *const kPlayerProfileStatisticTeamSlug = @"teamSlug";
NSString *const kPlayerProfileStatisticYellowCards = @"yellowCards";

@interface PlayerProfileStatistic ()
@end
@implementation PlayerProfileStatistic




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPlayerProfileStatisticChampionshipId] isKindOfClass:[NSNull class]]){
		self.championshipId = [dictionary[kPlayerProfileStatisticChampionshipId] integerValue];
	}

	if(![dictionary[kPlayerProfileStatisticChampionshipName] isKindOfClass:[NSNull class]]){
		self.championshipName = dictionary[kPlayerProfileStatisticChampionshipName];
	}	
	if(![dictionary[kPlayerProfileStatisticChampionshipSlug] isKindOfClass:[NSNull class]]){
		self.championshipSlug = dictionary[kPlayerProfileStatisticChampionshipSlug];
	}	
	if(![dictionary[kPlayerProfileStatisticGoals] isKindOfClass:[NSNull class]]){
		self.goals = [dictionary[kPlayerProfileStatisticGoals] integerValue];
	}

	if(![dictionary[kPlayerProfileStatisticPlayed] isKindOfClass:[NSNull class]]){
		self.played = [dictionary[kPlayerProfileStatisticPlayed] integerValue];
	}

	if(![dictionary[kPlayerProfileStatisticRedCards] isKindOfClass:[NSNull class]]){
		self.redCards = [dictionary[kPlayerProfileStatisticRedCards] integerValue];
	}

	if(![dictionary[kPlayerProfileStatisticTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kPlayerProfileStatisticTeamId] integerValue];
	}

	if(![dictionary[kPlayerProfileStatisticTeamName] isKindOfClass:[NSNull class]]){
		self.teamName = dictionary[kPlayerProfileStatisticTeamName];
	}	
	if(![dictionary[kPlayerProfileStatisticTeamSlug] isKindOfClass:[NSNull class]]){
		self.teamSlug = dictionary[kPlayerProfileStatisticTeamSlug];
	}	
	if(![dictionary[kPlayerProfileStatisticYellowCards] isKindOfClass:[NSNull class]]){
		self.yellowCards = [dictionary[kPlayerProfileStatisticYellowCards] integerValue];
	}

	return self;
}
@end