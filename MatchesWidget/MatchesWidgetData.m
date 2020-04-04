//
//  MatchesWidgetData.m
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/2/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import "MatchesWidgetData.h"

@implementation MatchesWidgetData

+ (void)getWidgetMatchesData: (NSURL *)widgetMatchUrl  success:(void (^)(NSArray* matchesArray))success failure:(void (^)(NSError *error))failure{

    NSError *error;
    NSString *stringFromFileAtURL = [[NSString alloc]
                                     initWithContentsOfURL:widgetMatchUrl
                                     encoding:NSUTF8StringEncoding
                                     error:&error];
    stringFromFileAtURL=[stringFromFileAtURL stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    
    if (stringFromFileAtURL == nil) {
      failure(error);
    }
    
    else {
        NSData *jsonData = [stringFromFileAtURL dataUsingEncoding:NSUTF8StringEncoding];
        NSError *e;
        NSDictionary *matchesDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&e];
        
        NSArray *yesterdayArray=[matchesDictionary objectForKey:@"yesterday"];
        
        NSArray *todayArray  =   [matchesDictionary objectForKey:@"today"];
       
        NSArray *tomorrowArray=[matchesDictionary objectForKey:@"tomorrow"];
        
        NSArray *allMatches=[NSArray arrayWithObjects:yesterdayArray,todayArray,tomorrowArray, nil];
        
        success(allMatches);
    }
}
@end
