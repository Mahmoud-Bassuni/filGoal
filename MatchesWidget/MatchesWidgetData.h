//
//  MatchesWidgetData.h
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/2/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MatchesWidgetData : NSObject


+ (void)getWidgetMatchesData: (NSURL *)widgetMatchUrl  success:(void (^)(NSArray* matchesArray))success failure:(void (^)(NSError *error))failure;

@end
