//
//	WinsComparison.m
//
//	Create by Mohamed Mansour on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "WinsComparison.h"

NSString *const kWinsComparisonDraws = @"draws";
NSString *const kWinsComparisonFirstTeamWins = @"homeTeamWins";
NSString *const kWinsComparisonSecondTeamWins = @"awayTeamWins";
NSString *const kWinsComparisonTotalMatches = @"totalMatches";

@interface WinsComparison ()
@end
@implementation WinsComparison




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWinsComparisonDraws] isKindOfClass:[NSNull class]]){
		self.draws = [dictionary[kWinsComparisonDraws] integerValue];
	}

	if(![dictionary[kWinsComparisonFirstTeamWins] isKindOfClass:[NSNull class]]){
		self.firstTeamWins = [dictionary[kWinsComparisonFirstTeamWins] integerValue];
	}

	if(![dictionary[kWinsComparisonSecondTeamWins] isKindOfClass:[NSNull class]]){
		self.secondTeamWins = [dictionary[kWinsComparisonSecondTeamWins] integerValue];
	}

	if(![dictionary[kWinsComparisonTotalMatches] isKindOfClass:[NSNull class]]){
		self.totalMatches = [dictionary[kWinsComparisonTotalMatches] integerValue];
	}

	return self;
}
@end