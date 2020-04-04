//
//  SSOServiceManager.h
//  
//
//  Created by Nada Gamal on 11/21/17.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "AFOAuth2Manager.h"
#import "UserMethods.h"

@interface SSOServiceManager : NSObject
+(NSString*)getSSOBaseUrl;
+(void)registerUserWith:(User*)user success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
+(void)LoginWithUser:(User*)user success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;
+(void)fbLoginWithUser:(User*)user success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;
+(void)forgotPassword:(NSString*)emailTxt success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
+(void)changePasswordWithOldPassword:(NSString*)oldPasswordTxt andNewPassword:(NSString*)newPasswordTxt success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

#pragma mark - SSO Preferences APIs
+(void)getUserPreferences:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
+(void)addEventsWithEventsIds:(NSArray*)events andTeamId:(NSInteger)teamId andTeamName:(NSString*)teamName success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
+(void)updateTeamsEventsWithIds:(NSArray*)events andTeamId:(NSInteger)teamId andTeamName:(NSString*)teamName success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

+(void)deleteEventWithEventId:(NSInteger)eventId andTeamId:(NSInteger)teamId success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
+(void)deleteTeamEventsWithTeamId:(NSInteger)teamId success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

+(void)loadAFNetwotkingSettings;
@end
