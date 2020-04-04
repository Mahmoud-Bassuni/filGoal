//
//  UserMethods.m
//  SSOManager
//
//  Created by Nada Gamal on 11/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "UserMethods.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@implementation UserMethods
static NSString * const kUser=@"User";
static NSString * const kFileName=@"UserFile.txt";
static NSString * const kPreferences=@"Preferences";

+(void)storeUserWithUser:(User *)user
{
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setObject:user forKey:kUser];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:kFileName];
    [NSKeyedArchiver archiveRootObject:dataDict toFile:filePath];
}
+(User*)retrieveUserObject
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:kFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        User * user = [[User alloc]init];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSMutableDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        user =[savedData objectForKey:kUser];
        return user;
    }
    return nil;
}
+(BOOL)isUserLoggedIn
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:kFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        User * user = [[User alloc]init];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSMutableDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        user =[savedData objectForKey:kUser];
        if(user.username!= nil && user.password != nil)
        {
            return YES;
        }
    }
    return NO;
}
+(void)logout
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:kFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSMutableDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        User * user =[savedData objectForKey:kUser];
        if(user.isFromFacebook)
        {
            //We should logOut from FB session
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logOut];
            [FBSDKAccessToken setCurrentAccessToken:nil];
        }
        [[NSFileManager defaultManager]removeItemAtPath: filePath error:nil];
        user.teamsDic=[[NSMutableDictionary alloc]init];
        [[MyNetmeraUser alloc]updateUser:user];

       // [Netmera setEnabledReceivingPushNotifications:NO];

    }
}
+(void)getUserPreferencesWithUser:(User*)user handler:(void (^)(void))handler
{
    [SSOServiceManager getUserPreferences:^(id result) {
        NSMutableDictionary * teamsDic = [[NSMutableDictionary alloc]init];
        if([result isKindOfClass:[NSArray class]])
        {
        for(NSDictionary * item in result)
        {
            [teamsDic setObject:[[TeamPreference alloc]initWithDictionary:item] forKey:[item objectForKey:@"TeamId"]];
        }
        user.teamsDic = teamsDic;
        [self storeUserWithUser:user];
            //Update netmera users with followed Teams
        [[MyNetmeraUser alloc]updateUser:user];
        }
        handler();
    } failure:^(NSError *error) {
        
    }];
}
+(void)deleteTeam:(int)teamId handler:(void (^)(void))handler
{
    User * user =[self retrieveUserObject];
//   for(id item in user.teamsDic.allKeys)
//    {
//        NSLog(@"%@",[NSNumber numberWithLong:teamId]);
//        if([[NSNumber numberWithLong:teamId] isEqual:item])
//        {
//            NSLog(@"%@",[NSString stringWithFormat:@"%i",teamId]);
//            [user.teamsDic removeObjectForKey:item];
//            [self storeUserWithUser:user];
//            [[MyNetmeraUser alloc]updateUser:user];
//            break;
//
//        }
//    }
    if([user.teamsDic objectForKey:[NSNumber numberWithLong:teamId]]!=nil)
    [user.teamsDic removeObjectForKey:[NSNumber numberWithLong:teamId]];
    else
    [user.teamsDic removeObjectForKey:[NSString stringWithFormat:@"%i",teamId]];

    [self storeUserWithUser:user];
    [[MyNetmeraUser alloc]updateUser:user];
    [SSOServiceManager deleteTeamEventsWithTeamId:teamId success:^(id result) {

        handler();

    } failure:^(NSError *error) {
        handler();
    }];
}

+(void)updateUserTeamEvents:(TeamPreference*)team
{
    User * user =[self retrieveUserObject];
    [user.teamsDic setObject:team forKey:[NSNumber numberWithLong:team.teamId]];
    [self storeUserWithUser:user];
    //Update netmera users with followed Teams
    [[MyNetmeraUser alloc]updateUser:user];
    [self updateUserPreferencesWithEventIds:[team.eventIds allObjects] andTeamId:team.teamId andTeamName:team.teamName];
}
+(void)updateUserPreferencesWithEventIds:(NSArray*)eventsIds andTeamId:(NSUInteger)teamId andTeamName:(NSString*)teamName
{
    [SSOServiceManager updateTeamsEventsWithIds:eventsIds andTeamId:teamId andTeamName:teamName success:^(id result) {
        
    } failure:^(NSError *error) {
        IBGLog(@"%@", [NSString stringWithFormat:@"SSO-Update-Error %@",error.description]);
    }];
}
+(NSArray*)getTeamEventsIdsUsingTeamId:(NSInteger)teamId
{
    User * user = [self retrieveUserObject];
    for (TeamPreference * team in user.teamsDic.allValues) {
        if(team.teamId==teamId)
        {
            return [team.eventIds allObjects];
        }
    }
    return [[NSArray alloc]init];
}
@end
