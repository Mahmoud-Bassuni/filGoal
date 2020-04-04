//
//  PredictionServiceManager.m
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 5/10/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import "PredictionServiceManager.h"
#import "PredictionActiveChampions.h"
#import "PredictionStatistics.h"
static const NSString * kClientId = @"A80AFFA3-F5D8-47E0-897D-24DE682D5C0C";
static const NSString * kClientSecret = @"6aSq9&NQ0v*#";

@implementation PredictionServiceManager
+(NSString*)getApiBaseURL{
    if([Global getInstance].appInfo.predictBaseURL != nil)
        return [Global getInstance].appInfo.predictBaseURL;
    else
    return @"https://predict.filgoal.com/";
}
+(AFHTTPSessionManager*)initSessionManager{
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kPredictCrednitialIdentifier];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken] forHTTPHeaderField:@"Authorization"];
    return manager;
}

+(void)getToken:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    AFOAuth2Manager *OAuth2Manager = [[AFOAuth2Manager alloc] initWithBaseURL:[NSURL URLWithString:[self getApiBaseURL]]];
    NSDictionary * param = @{@"username":@"predictIOS",@"password": @"901A8WMz&Bpc", @"grant_type": @"password",@"client_id": kClientId, @"client_secret":kClientSecret};
    [OAuth2Manager setUseHTTPBasicAuthentication:YES];
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"token" parameters:param success:^(AFOAuthCredential * _Nonnull credential) {
        [AFOAuthCredential storeCredential:credential
                            withIdentifier:kPredictCrednitialIdentifier];
        success(credential);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
+(void)getActiveChampionships:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self getApiBaseURL],@"champ/getactive"];
    AFHTTPSessionManager * manager = [self initSessionManager];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        PredictionActiveChampions * prediction = [[PredictionActiveChampions alloc]initWithDictionary:responseObject];
        success(prediction);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];
}
+(void)getUserStatisticsUsingMatchId:(NSInteger)matchId succuss:(void (^)( id result))success failure:(void (^)(NSError *error))failure{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self getApiBaseURL],@"match/statistics"];
    NSDictionary * param = @{@"matchId":[NSString stringWithFormat:@"%li",(long)matchId]};
    AFHTTPSessionManager * manager = [self initSessionManager];
    [manager GET:urlString parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        PredictionStatistics * prediction = [[PredictionStatistics alloc]initWithDictionary:responseObject];
        success(prediction);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        failure(error);
    }];

}

@end
