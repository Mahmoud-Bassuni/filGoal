//
//	EventsList.m
//
//	Create by Nada Gamal on 4/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "EventsList.h"

//NSString *const kEventsListEvents = @"Events";

@interface EventsList ()
@end
@implementation EventsList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary != nil && [dictionary isKindOfClass:[NSArray class]]){
		NSArray * eventsDictionaries = dictionary;
		NSMutableArray * eventsItems = [NSMutableArray array];
		for(NSDictionary * eventsDictionary in eventsDictionaries){
			MatchEvent * eventsItem = [[MatchEvent alloc] initWithDictionary:eventsDictionary];
			[eventsItems addObject:eventsItem];
		}
		self.events = eventsItems;
	}
	return self;
}



@end