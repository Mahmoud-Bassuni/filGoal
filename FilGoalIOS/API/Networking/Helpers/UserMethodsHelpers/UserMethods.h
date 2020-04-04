//
//  UserMethods.h
//  SSOManager
//
//  Created by Nada Gamal on 11/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "TeamPreference.h"

@interface UserMethods : NSObject
+(BOOL) isUserLoggedIn;
+ (void)logout;
+(User*)retrieveUserObject;
+(void)storeUserWithUser:(User*)user;
+(void)getUserPreferencesWithUser:(User*)user handler:(void (^)(void))handler;
+(NSArray*)getTeamEventsIdsUsingTeamId:(NSInteger)teamId;
+(void)deleteTeam:(int)teamId handler:(void (^)(void))handler;
+(void)updateUserTeamEvents:(TeamPreference*)team;
+(void)updateUserPreferencesWithEventIds:(NSArray*)eventsIds andTeamId:(NSUInteger)teamId andTeamName:(NSString*)teamName;
@end
