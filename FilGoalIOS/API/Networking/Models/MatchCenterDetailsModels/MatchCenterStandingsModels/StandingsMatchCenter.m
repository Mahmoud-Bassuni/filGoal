//
//	StandingsMatchCenter.m
//
//	Create by Nada Gamal on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "StandingsMatchCenter.h"

//NSString *const kStandingsMatchCenterStandings = @"Standings";

@interface StandingsMatchCenter ()
@end
@implementation StandingsMatchCenter




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary != nil && [dictionary isKindOfClass:[NSArray class]]){
		NSArray * standingsDictionaries = dictionary;
		NSMutableArray * standingsItems = [NSMutableArray array];
		for(NSDictionary * standingsDictionary in standingsDictionaries){
			Standing * standingsItem = [[Standing alloc] initWithDictionary:standingsDictionary];
			[standingsItems addObject:standingsItem];
		}
		self.standings = standingsItems;
        if(self.standings.count>3)
        {
           self.standings = [self.standings subarrayWithRange:NSMakeRange(0, 2)];

        }
	}
	return self;
}
@end
