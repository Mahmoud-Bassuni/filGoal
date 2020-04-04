//
//	ScorersList.m
//
//	Create by Nada Gamal on 7/8/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ScorersList.h"
#import "Scorer.h"
NSString *const kScorersListCount = @"count";
NSString *const kScorersListData = @"data";
NSString *const kScorersListNextPageUri = @"nextPageUri";

@interface ScorersList ()
@end
@implementation ScorersList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kScorersListCount] isKindOfClass:[NSNull class]]){
		self.count = dictionary[kScorersListCount];
	}	
	if(dictionary[kScorersListData] != nil && [dictionary[kScorersListData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kScorersListData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			Scorer * dataItem = [[Scorer alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kScorersListNextPageUri] isKindOfClass:[NSNull class]]){
		self.nextPageUri = dictionary[kScorersListNextPageUri];
	}	
	return self;
}
@end
