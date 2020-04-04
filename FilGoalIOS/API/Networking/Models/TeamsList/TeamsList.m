//
//	TeamsList.m
//
//	Create by Nada Gamal on 17/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TeamsList.h"

NSString *const kTeamsListCount = @"count";
NSString *const kTeamsListData = @"data";
NSString *const kTeamsListNextPageUri = @"nextPageUri";

@interface TeamsList ()
@end
@implementation TeamsList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTeamsListCount] isKindOfClass:[NSNull class]]){
		self.count = dictionary[kTeamsListCount];
	}	
	if(dictionary[kTeamsListData] != nil && [dictionary[kTeamsListData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kTeamsListData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			Team * dataItem = [[Team alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kTeamsListNextPageUri] isKindOfClass:[NSNull class]]){
		self.nextPageUri = dictionary[kTeamsListNextPageUri];
	}	
	return self;
}
@end
