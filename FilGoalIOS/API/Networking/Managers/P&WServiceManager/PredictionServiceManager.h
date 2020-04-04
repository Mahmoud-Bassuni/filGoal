//
//  PredictionServiceManager.h
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 5/10/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PredictionServiceManager : AFHTTPSessionManager
+(void)getToken:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
+(void)getActiveChampionships:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
+(void)getUserStatisticsUsingMatchId:(NSInteger)matchId succuss:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

@end
