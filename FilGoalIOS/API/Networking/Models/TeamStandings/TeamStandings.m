//
//	TeamStandings.m
//
//	Create by Nada Gamal on 8/8/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TeamStandings.h"

NSString *const kTeamStandingsCount = @"count";
NSString *const kTeamStandingsData = @"data";
NSString *const kTeamStandingsNextPageUri = @"nextPageUri";

@interface TeamStandings ()
@end
@implementation TeamStandings




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTeamStandingsCount] isKindOfClass:[NSNull class]]){
		self.count = dictionary[kTeamStandingsCount];
	}	
	if(dictionary[kTeamStandingsData] != nil && [dictionary[kTeamStandingsData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kTeamStandingsData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			Standing * dataItem = [[Standing alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kTeamStandingsNextPageUri] isKindOfClass:[NSNull class]]){
		self.nextPageUri = dictionary[kTeamStandingsNextPageUri];
	}	
	return self;
}
@end
