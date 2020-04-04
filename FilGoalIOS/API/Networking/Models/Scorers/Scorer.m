//
//	Data.m
//
//	Create by Nada Gamal on 7/8/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Scorer.h"

NSString *const kScorerGoals = @"goals";
NSString *const kScorerGoalscoringPercentage = @"goalscoringPercentage";
NSString *const kScorerIdField = @"id";
NSString *const kScorerName = @"name";
NSString *const kScorerPlayed = @"played";
NSString *const kScorerSlug = @"slug";
NSString *const kScorerTeamId = @"teamId";
NSString *const kScorerTeamName = @"teamName";
NSString *const kScorerTeamSlug = @"teamSlug";

@interface Scorer ()
@end
@implementation Scorer




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kScorerGoals] isKindOfClass:[NSNull class]]){
		self.goals = [dictionary[kScorerGoals] integerValue];
	}

	if(![dictionary[kScorerGoalscoringPercentage] isKindOfClass:[NSNull class]]){
		self.goalscoringPercentage = [dictionary[kScorerGoalscoringPercentage] floatValue];
	}

	if(![dictionary[kScorerIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kScorerIdField] integerValue];
	}

	if(![dictionary[kScorerName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kScorerName];
	}	
	if(![dictionary[kScorerPlayed] isKindOfClass:[NSNull class]]){
		self.played = [dictionary[kScorerPlayed] integerValue];
	}

	if(![dictionary[kScorerSlug] isKindOfClass:[NSNull class]]){
		self.slug = dictionary[kScorerSlug];
	}	
	if(![dictionary[kScorerTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kScorerTeamId] integerValue];
	}

	if(![dictionary[kScorerTeamName] isKindOfClass:[NSNull class]]){
		self.teamName = dictionary[kScorerTeamName];
	}	
	if(![dictionary[kScorerTeamSlug] isKindOfClass:[NSNull class]]){
		self.teamSlug = dictionary[kScorerTeamSlug];
	}	
	return self;
}
@end
