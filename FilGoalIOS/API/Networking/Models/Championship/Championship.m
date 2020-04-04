//
//	Championship.m
//
//	Create by Nada Gamal on 30/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Championship.h"

NSString *const kChampionshipCount = @"count";
NSString *const kChampionshipData = @"data";
NSString *const kChampionshipNextPageUri = @"nextPageUri";

@interface Championship ()
@end
@implementation Championship




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kChampionshipCount] isKindOfClass:[NSNull class]]){
		self.count = dictionary[kChampionshipCount];
	}	
	if(dictionary[kChampionshipData] != nil && [dictionary[kChampionshipData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kChampionshipData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			ChampionShipData * dataItem = [[ChampionShipData alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kChampionshipNextPageUri] isKindOfClass:[NSNull class]]){
		self.nextPageUri = dictionary[kChampionshipNextPageUri];
	}	
	return self;
}
@end
