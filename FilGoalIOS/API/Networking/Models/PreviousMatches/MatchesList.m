//
//	PreviousMatches.m
//
//	Create by Mohamed Mansour on 18/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchesList.h"

//NSString *const kPreviousMatchesCount = @"count";
NSString *const kPreviousMatchesData = @"data";
NSString *const kPreviousMatchesNextPageUri = @"nextPageUri";

@interface MatchesList ()
@end
@implementation MatchesList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    self.dates = [[NSMutableArray alloc]init];
//    if(![dictionary[kPreviousMatchesCount] isKindOfClass:[NSNull class]]){
//        self.count = [dictionary[kPreviousMatchesCount]intValue];
//    }    
	if(dictionary[kPreviousMatchesData] != nil && [dictionary[kPreviousMatchesData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kPreviousMatchesData];
        self.matchItems = [[NSMutableArray alloc]init];
		for(NSDictionary * dataDictionary in dataDictionaries){
			MatchCenterDetails * matchItem = [[MatchCenterDetails alloc] initWithDictionary:dataDictionary];
			[self.matchItems addObject:matchItem];
            if(matchItem.dateStr != nil)
                [self.dates addObject:matchItem.dateStr];
            
        }
		self.matches = self.matchItems;
//        if(self.matches.count>3)
//        {
//            self.matches = [self.matches subarrayWithRange:NSMakeRange(0, 2)];
//            
//        }
	}
	if(![dictionary[kPreviousMatchesNextPageUri] isKindOfClass:[NSNull class]]){
		self.nextPageUri = dictionary[kPreviousMatchesNextPageUri];
	}	
	return self;
}
-(NSArray*)getMatchesListByDate:(NSString*)selectedDate andMatches:(NSArray*) matches
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * otherSelectedDate = [outputFormatter dateFromString:selectedDate];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    selectedDate = [outputFormatter stringFromDate:otherSelectedDate];
    NSMutableArray * matchesList = [[NSMutableArray alloc]init];
    for(MatchCenterDetails * matchItem in matches)
    {
        if([matchItem.dateStr isEqualToString:selectedDate])
        {
            [matchesList addObject:matchItem];
        }
      
    }
    return matchesList;
}
-(NSDictionary*)getMatchesWidget:(NSArray*) matches andYestardayDate:(NSString*)yesterdayDate andTomorrowDate:(NSString*)tomorrowDate
{
    NSMutableArray * yesterdayMatches = [[NSMutableArray alloc]init];
    NSMutableArray * todayMatches = [[NSMutableArray alloc]init];
    NSMutableArray * tomorrowMatches = [[NSMutableArray alloc]init];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [outputFormatter setLocale:usLocale];
    NSDate * otherYesterdayDate = [outputFormatter dateFromString:yesterdayDate];
    NSDate * otherTomorrowDate = [outputFormatter dateFromString:tomorrowDate];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    
    yesterdayDate = [outputFormatter stringFromDate:otherYesterdayDate];
    tomorrowDate = [outputFormatter stringFromDate:otherTomorrowDate];
    NSString * todayDate = [outputFormatter stringFromDate:[NSDate date]];
    
    for(MatchCenterDetails * matchItem in matches)
    {
        if([matchItem.dateStr rangeOfString:yesterdayDate].location != NSNotFound)
        {
            [yesterdayMatches addObject:matchItem];
        }
        else    if([matchItem.dateStr rangeOfString:tomorrowDate].location != NSNotFound)
        {
            [tomorrowMatches addObject:matchItem];
        }
        else  if([matchItem.dateStr rangeOfString:todayDate].location != NSNotFound)
        {
            [todayMatches addObject:matchItem];
        }
    }
    NSDictionary * outputDic = [[NSDictionary alloc]initWithObjects:@[yesterdayMatches,todayMatches,tomorrowMatches] forKeys:@[@"yesterday",@"today",@"tomorrow"]];
    return outputDic;
}
@end
