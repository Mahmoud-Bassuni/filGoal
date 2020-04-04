//
//	Standing.m
//
//	Create by Nada Gamal on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Standing.h"

NSString *const kStandingChampionshipId = @"championshipId";
NSString *const kStandingChampionshipName = @"championshipName";
NSString *const kStandingDraws = @"draws";
NSString *const kStandingGoalsConceded = @"goalsConceded";
NSString *const kStandingGoalsScored = @"goalsScored";
NSString *const kStandingGroupId = @"groupId";
NSString *const kStandingGroupName = @"groupName";
NSString *const kStandingIdField = @"id";
NSString *const kStandingLoses = @"loses";
NSString *const kStandingOrderInGroup = @"orderInGroup";
NSString *const kStandingPlayedAway = @"playedAway";
NSString *const kStandingPlayedHome = @"playedHome";
NSString *const kStandingPoints = @"points";
NSString *const kStandingRank = @"rank";
NSString *const kStandingRoundId = @"roundId";
NSString *const kStandingRoundName = @"roundName";
NSString *const kStandingRoundOrder = @"roundOrder";
NSString *const kStandingRoundTypeName = @"roundTypeName";
NSString *const kStandingTeamId = @"teamId";
NSString *const kStandingTeamName = @"teamName";
NSString *const kStandingWeek = @"week";
NSString *const kStandingWins = @"wins";
NSString *const kStandingISRankUp = @"isRankUp";

@interface Standing ()
@end
@implementation Standing




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kStandingChampionshipId] isKindOfClass:[NSNull class]]){
		self.championshipId = [dictionary[kStandingChampionshipId] integerValue];
	}

	if(![dictionary[kStandingChampionshipName] isKindOfClass:[NSNull class]]){
		self.championshipName = dictionary[kStandingChampionshipName];
	}	
	if(![dictionary[kStandingDraws] isKindOfClass:[NSNull class]]){
		self.draws = [dictionary[kStandingDraws] integerValue];
	}

	if(![dictionary[kStandingGoalsConceded] isKindOfClass:[NSNull class]]){
		self.goalsConceded = [dictionary[kStandingGoalsConceded] integerValue];
	}

	if(![dictionary[kStandingGoalsScored] isKindOfClass:[NSNull class]]){
		self.goalsScored = [dictionary[kStandingGoalsScored] integerValue];
	}

	if(![dictionary[kStandingGroupId] isKindOfClass:[NSNull class]]){
		self.groupId = [dictionary[kStandingGroupId] integerValue];
	}

	if(![dictionary[kStandingGroupName] isKindOfClass:[NSNull class]]){
		self.groupName = dictionary[kStandingGroupName];
	}	
	if(![dictionary[kStandingIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kStandingIdField] integerValue];
	}

	if(![dictionary[kStandingLoses] isKindOfClass:[NSNull class]]){
		self.loses = [dictionary[kStandingLoses] integerValue];
	}

	if(![dictionary[kStandingOrderInGroup] isKindOfClass:[NSNull class]]){
		self.orderInGroup = dictionary[kStandingOrderInGroup];
	}	
	if(![dictionary[kStandingPlayedAway] isKindOfClass:[NSNull class]]){
		self.playedAway = [dictionary[kStandingPlayedAway] integerValue];
	}

	if(![dictionary[kStandingPlayedHome] isKindOfClass:[NSNull class]]){
		self.playedHome = [dictionary[kStandingPlayedHome] integerValue];
	}

	if(![dictionary[kStandingPoints] isKindOfClass:[NSNull class]]){
		self.points = [dictionary[kStandingPoints] integerValue];
	}

	if(![dictionary[kStandingRank] isKindOfClass:[NSNull class]]){
		self.rank = [dictionary[kStandingRank] integerValue];
	}

	if(![dictionary[kStandingRoundId] isKindOfClass:[NSNull class]]){
		self.roundId = [dictionary[kStandingRoundId] integerValue];
	}

	if(![dictionary[kStandingRoundName] isKindOfClass:[NSNull class]]){
		self.roundName = dictionary[kStandingRoundName];
	}	
	if(![dictionary[kStandingRoundOrder] isKindOfClass:[NSNull class]]){
		self.roundOrder = [dictionary[kStandingRoundOrder] integerValue];
	}

	if(![dictionary[kStandingRoundTypeName] isKindOfClass:[NSNull class]]){
		self.roundTypeName = dictionary[kStandingRoundTypeName];
	}	
	if(![dictionary[kStandingTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kStandingTeamId] integerValue];
	}

	if(![dictionary[kStandingTeamName] isKindOfClass:[NSNull class]]){
		self.teamName = dictionary[kStandingTeamName];
	}	
	if(![dictionary[kStandingWeek] isKindOfClass:[NSNull class]]){
		self.week = dictionary[kStandingWeek];
	}	
	if(![dictionary[kStandingWins] isKindOfClass:[NSNull class]]){
		self.wins = [dictionary[kStandingWins] integerValue];
	}
    if(![dictionary[kStandingISRankUp] isKindOfClass:[NSNull class]]){
        self.isRankUp = dictionary[kStandingISRankUp];;
    }
    else
    {
        
    }
	return self;
}
@end
