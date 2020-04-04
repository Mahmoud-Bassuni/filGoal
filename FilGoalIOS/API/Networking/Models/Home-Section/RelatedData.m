//
//	RelatedData.m
//
//	Create by Nada Gamal on 27/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "RelatedData.h"

NSString *const kRelatedDataChampionships = @"Championships";
NSString *const kRelatedDataMatches = @"Matches";
NSString *const kRelatedDataPeople = @"People";
NSString *const kRelatedDataTeams = @"Teams";

@interface RelatedData ()
@end
@implementation RelatedData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kRelatedDataChampionships] != nil && [dictionary[kRelatedDataChampionships] isKindOfClass:[NSArray class]]){
		NSArray * championshipsDictionaries = dictionary[kRelatedDataChampionships];
		NSMutableArray * championshipsItems = [NSMutableArray array];
		for(NSDictionary * championshipsDictionary in championshipsDictionaries){
			ChampionShipData * championshipsItem = [[ChampionShipData alloc] initWithDictionary:championshipsDictionary];
			[championshipsItems addObject:championshipsItem];
		}
		self.championships = championshipsItems;
	}
	if(dictionary[kRelatedDataMatches] != nil && [dictionary[kRelatedDataMatches] isKindOfClass:[NSArray class]]){
		NSArray * matchesDictionaries = dictionary[kRelatedDataMatches];
		NSMutableArray * matchesItems = [NSMutableArray array];
		for(NSDictionary * matchesDictionary in matchesDictionaries){
			MatchCenterDetails * matchesItem = [[MatchCenterDetails alloc] initWithDictionary:matchesDictionary];
			[matchesItems addObject:matchesItem];
		}
		self.matches = matchesItems;
	}
	if(dictionary[kRelatedDataPeople] != nil && [dictionary[kRelatedDataPeople] isKindOfClass:[NSArray class]]){
		NSArray * peopleDictionaries = dictionary[kRelatedDataPeople];
		NSMutableArray * peopleItems = [NSMutableArray array];
		for(NSDictionary * peopleDictionary in peopleDictionaries){
			Player * peopleItem = [[Player alloc] initWithDictionary:peopleDictionary];
			[peopleItems addObject:peopleItem];
		}
		self.people = peopleItems;
	}
	if(dictionary[kRelatedDataTeams] != nil && [dictionary[kRelatedDataTeams] isKindOfClass:[NSArray class]]){
		NSArray * teamsDictionaries = dictionary[kRelatedDataTeams];
		NSMutableArray * teamsItems = [NSMutableArray array];
		for(NSDictionary * teamsDictionary in teamsDictionaries){
			Team * teamsItem = [[Team alloc] initWithDictionary:teamsDictionary];
			[teamsItems addObject:teamsItem];
		}
		self.teams = teamsItems;
	}
	return self;
}



@end
