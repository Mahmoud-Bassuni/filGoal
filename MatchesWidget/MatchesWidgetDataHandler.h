//
//  MatchesWidgetDataHandler.h
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/4/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchesWidgetDataHandler : NSObject


+ (NSMutableArray *) getYesterdayMatches:(NSArray *)allMatches;

+ (NSMutableArray *) getTodayMatches:(NSArray *)allMatches;

+ (NSMutableArray *) getTomorrowMatches:(NSArray *)allMatches;

@end
