//
//	TeamProfile.m
//
//	Create by Nada Gamal on 27/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TeamProfile.h"

NSString *const kTeamProfileCount = @"count";
NSString *const kTeamProfileData = @"data";
NSString *const kTeamProfileNextPageUri = @"nextPageUri";

@interface TeamProfile ()
@end
@implementation TeamProfile




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTeamProfileCount] isKindOfClass:[NSNull class]]){
		self.count = dictionary[kTeamProfileCount];
	}	
	if(dictionary[kTeamProfileData] != nil && [dictionary[kTeamProfileData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kTeamProfileData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			Data * dataItem = [[Data alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kTeamProfileNextPageUri] isKindOfClass:[NSNull class]]){
		self.nextPageUri = dictionary[kTeamProfileNextPageUri];
	}	
	return self;
}
@end