//
//	FirstTeamHeighestScore.m
//
//	Create by Mohamed Mansour on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FirstTeamHeighestScore.h"

NSString *const kFirstTeamHeighestScoreAwayScore = @"awayScore";
NSString *const kFirstTeamHeighestScoreAwayTeamId = @"awayTeamId";
NSString *const kFirstTeamHeighestScoreAwayTeamLogoUrl = @"awayTeamLogoUrl";
NSString *const kFirstTeamHeighestScoreAwayTeamName = @"awayTeamName";
NSString *const kFirstTeamHeighestScoreChampionshipId = @"championshipId";
NSString *const kFirstTeamHeighestScoreChampionshipName = @"championshipName";
NSString *const kFirstTeamHeighestScoreHomeScore = @"homeScore";
NSString *const kFirstTeamHeighestScoreHomeTeamId = @"homeTeamId";
NSString *const kFirstTeamHeighestScoreHomeTeamLogoUrl = @"homeTeamLogoUrl";
NSString *const kFirstTeamHeighestScoreHomeTeamName = @"homeTeamName";
NSString *const kFirstTeamHeighestScoreMatchId = @"matchId";

@interface FirstTeamHeighestScore ()
@end
@implementation FirstTeamHeighestScore




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kFirstTeamHeighestScoreAwayScore] isKindOfClass:[NSNull class]]){
		self.awayScore = [dictionary[kFirstTeamHeighestScoreAwayScore] integerValue];
	}

	if(![dictionary[kFirstTeamHeighestScoreAwayTeamId] isKindOfClass:[NSNull class]]){
		self.awayTeamId = [dictionary[kFirstTeamHeighestScoreAwayTeamId] integerValue];
	}

	if(![dictionary[kFirstTeamHeighestScoreAwayTeamLogoUrl] isKindOfClass:[NSNull class]]){
		self.awayTeamLogoUrl = dictionary[kFirstTeamHeighestScoreAwayTeamLogoUrl];
	}	
	if(![dictionary[kFirstTeamHeighestScoreAwayTeamName] isKindOfClass:[NSNull class]]){
		self.awayTeamName = dictionary[kFirstTeamHeighestScoreAwayTeamName];
	}	
	if(![dictionary[kFirstTeamHeighestScoreChampionshipId] isKindOfClass:[NSNull class]]){
		self.championshipId = [dictionary[kFirstTeamHeighestScoreChampionshipId] integerValue];
	}

	if(![dictionary[kFirstTeamHeighestScoreChampionshipName] isKindOfClass:[NSNull class]]){
		self.championshipName = dictionary[kFirstTeamHeighestScoreChampionshipName];
	}	
	if(![dictionary[kFirstTeamHeighestScoreHomeScore] isKindOfClass:[NSNull class]]){
		self.homeScore = [dictionary[kFirstTeamHeighestScoreHomeScore] integerValue];
	}

	if(![dictionary[kFirstTeamHeighestScoreHomeTeamId] isKindOfClass:[NSNull class]]){
		self.homeTeamId = [dictionary[kFirstTeamHeighestScoreHomeTeamId] integerValue];
	}

	if(![dictionary[kFirstTeamHeighestScoreHomeTeamLogoUrl] isKindOfClass:[NSNull class]]){
		self.homeTeamLogoUrl = dictionary[kFirstTeamHeighestScoreHomeTeamLogoUrl];
	}	
	if(![dictionary[kFirstTeamHeighestScoreHomeTeamName] isKindOfClass:[NSNull class]]){
		self.homeTeamName = dictionary[kFirstTeamHeighestScoreHomeTeamName];
	}	
	if(![dictionary[kFirstTeamHeighestScoreMatchId] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kFirstTeamHeighestScoreMatchId] integerValue];
	}

	return self;
}
@end