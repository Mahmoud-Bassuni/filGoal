//
//	Data.m
//
//	Create by Nada Gamal on 30/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ChampionShipData.h"
#import "Round.h"
NSString *const kChampionDataChampionshipTypeId = @"championshipTypeId";
NSString *const kChampionDataChampionshipTypeName = @"championshipTypeName";
NSString *const kChampionDataIdField = @"id";
NSString *const kChampionDataName = @"name";
NSString *const kChampionDataSeasonId = @"seasonId";
NSString *const kChampionDataSeasonName = @"seasonName";
NSString *const kChampionDataSlug = @"slug";
NSString *const kChampionDataWeeks = @"weeks";
NSString *const kChampionTeams = @"teams";
NSString *const kChampionRounds = @"rounds";
NSString *const kDataStages = @"stages";


@interface ChampionShipData ()
@end
@implementation ChampionShipData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kChampionDataChampionshipTypeId] isKindOfClass:[NSNull class]]){
		self.championshipTypeId = [dictionary[kChampionDataChampionshipTypeId] integerValue];
	}

	if(![dictionary[kChampionDataChampionshipTypeName] isKindOfClass:[NSNull class]]){
		self.championshipTypeName = dictionary[kChampionDataChampionshipTypeName];
	}	
	if(![dictionary[kChampionDataIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kChampionDataIdField] integerValue];
	}

	if(![dictionary[kChampionDataName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kChampionDataName];
	}	
	if(![dictionary[kChampionDataSeasonId] isKindOfClass:[NSNull class]]){
		self.seasonId = [dictionary[kChampionDataSeasonId] integerValue];
	}

	if(![dictionary[kChampionDataSeasonName] isKindOfClass:[NSNull class]]){
		self.seasonName = dictionary[kChampionDataSeasonName];
	}	
	if(![dictionary[kChampionDataSlug] isKindOfClass:[NSNull class]]){
		self.slug = dictionary[kChampionDataSlug];
	}	
	if(![dictionary[kChampionDataWeeks] isKindOfClass:[NSNull class]]){
		self.weeks = [dictionary[kChampionDataWeeks] integerValue];
	}
    if(dictionary[kChampionTeams] != nil && [dictionary[kChampionTeams] isKindOfClass:[NSArray class]]){
        NSArray * teamsDictionaries = dictionary[kChampionTeams];
        NSMutableArray * teamsItems = [NSMutableArray array];
        for(NSDictionary * teamsDictionary in teamsDictionaries){
            Team * teamsItem = [[Team alloc] initWithDictionary:teamsDictionary];
            [teamsItems addObject:teamsItem];
        }
        self.teams = teamsItems;
    }
    
    if(dictionary[kChampionRounds] != nil && [dictionary[kChampionRounds] isKindOfClass:[NSArray class]]){
        NSArray * roundsDictionaries = dictionary[kChampionRounds];
        NSMutableArray * roundsItems = [NSMutableArray array];
        for(NSDictionary * roundsDictionary in roundsDictionaries){
            Round * roundsItem = [[Round alloc] initWithDictionary:roundsDictionary];
            [roundsItems addObject:roundsItem];
        }
        self.rounds = roundsItems;
    }
    
     if(dictionary[kDataStages] != nil && [dictionary[kDataStages] isKindOfClass:[NSArray class]]){
        NSMutableArray * dictionaryElements = dictionary[kDataStages];
         NSMutableArray * stageItems = [NSMutableArray array];
        for(NSDictionary * stagesElement in dictionaryElements){
            [stageItems addObject:[[Stage alloc] initWithDictionary:stagesElement]];
        }
        self.stages = stageItems;
    }
    
	return self;
}
@end
