//
//  MatchesWidgetDataHandler.m
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/4/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import "MatchesWidgetDataHandler.h"
#import "MatchesWidgetData.h"
#import "Constants.h"
@implementation MatchesWidgetDataHandler



static NSArray *allMatches;


+ (NSMutableArray *) getYesterdayMatches:(NSArray *)allMatches{
    NSArray   *yesterdayMatchestemp;
    if(allMatches.count>0)
   yesterdayMatchestemp=   [allMatches objectAtIndex:0];
    else
        yesterdayMatchestemp=[[NSArray alloc]init];
    NSMutableArray *yesterdayMatchesArray =[ [NSMutableArray alloc] init];
    
    long Count=[yesterdayMatchestemp  count];
    if (Count>3&&(IS_IPHONE_4||IS_IPHONE_5))
    {
        Count=3;
    }
    else if (Count>5&&(IS_IPHONE_6||IS_IPHONE_6_PLUS))
    {
        Count=5;
    }
    

    
    return yesterdayMatchesArray;

}

+ (NSMutableArray *) getTodayMatches:(NSArray *)allMatches{
    NSArray   *todayMatchestemp;
    if(allMatches.count>1)
   todayMatchestemp=[allMatches objectAtIndex:1];
    else
        todayMatchestemp=[[NSArray alloc]init];
    NSMutableArray *todayMatchesArray=[[NSMutableArray alloc] init];
    
    long Count=[todayMatchestemp  count];
    if (Count>3&&(IS_IPHONE_4||IS_IPHONE_5))
    {
        Count=3;
    }
    else if (Count>5&&(IS_IPHONE_6||IS_IPHONE_6_PLUS))
    {
        Count=5;
    }
    
   

    
    return todayMatchesArray;

}

+ (NSMutableArray *) getTomorrowMatches:(NSArray *)allMatches{
    
    NSArray   *tomorrowMatchestemp;
    if(allMatches.count>2)
   tomorrowMatchestemp=[allMatches objectAtIndex:2];
    else
        tomorrowMatchestemp=[[NSArray alloc]init];
    NSMutableArray *tomorrowMatchesArray=[[NSMutableArray alloc] init];
    
    long Count=[tomorrowMatchestemp  count];
    if (Count>3&&(IS_IPHONE_4||IS_IPHONE_5))
    {
        Count=3;
    }
    else if (Count>5&&(IS_IPHONE_6||IS_IPHONE_6_PLUS))
    {
        Count=5;
    }
    
   
    
    return tomorrowMatchesArray;


}

@end
