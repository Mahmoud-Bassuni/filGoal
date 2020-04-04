//
//  MyNetmeraUser.m
//  Akhbarak
//
//  Created by Nada Gamal on 10/23/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "MyNetmeraUser.h"

@implementation MyNetmeraUser
+ (NSDictionary *)keyPathPropertySelectorMapping {
    return @{
             @"pce" : NSStringFromSelector(@selector(matchStatus)),
             @"pcc" : NSStringFromSelector(@selector(matchEvent)),
             @"pcd" : NSStringFromSelector(@selector(matchFinalScore)),
             @"pcb" : NSStringFromSelector(@selector(matchTeamSquads)),
             };
}
-(void)updateUserWithTeam:(TeamPreference*)team
{
    NSDictionary *dic;
    NSMutableArray * teamList = [[NSMutableArray alloc]init];
    if(team != nil)
       [teamList addObject:team];
    if(team.eventIds.count>0)
    {
        dic=[self groupTeamEventsIntoArrays:teamList];
    }
    self.matchTeamSquads = [dic objectForKey:@"MatchTeamSquad"];
    self.matchStatus = [dic objectForKey:@"MatchStatus"];
    self.matchEvent = [dic objectForKey:@"MatchEvents"];
    self.matchFinalScore = [dic objectForKey:@"MatchFinalScore"];
    if([UserMethods retrieveUserObject].username!=nil)
        self.email=[UserMethods retrieveUserObject].username;
    [Netmera updateUser:self];
}
-(void)updateUser:(User*)user
{
    NSDictionary *dic;
    if(user.teamsDic.allValues.count>0)
    {
      dic=[self groupTeamEventsIntoArrays:user.teamsDic.allValues];
    }
    self.matchTeamSquads = [dic objectForKey:@"MatchTeamSquad"];
    self.matchStatus = [dic objectForKey:@"MatchStatus"];
    self.matchEvent = [dic objectForKey:@"MatchEvents"];
    self.matchFinalScore = [dic objectForKey:@"MatchFinalScore"];
    if([UserMethods retrieveUserObject].username!=nil)
        self.email=[UserMethods retrieveUserObject].username;
    self.userId=user.userId;
    if([UserMethods retrieveUserObject]==nil)
    {
        self.matchTeamSquads =  [NSNull null];
        self.matchStatus =  [NSNull null];
        self.matchEvent =  [NSNull null];
        self.matchFinalScore =  [NSNull null];
    }
   
    [Netmera updateUser:self];
}
-(NSDictionary*)groupTeamEventsIntoArrays:(NSArray*)list
{
    NSMutableArray * matchStatusList=[[NSMutableArray alloc]init];
    NSMutableArray * matchEvents=[[NSMutableArray alloc]init];
    NSMutableArray * matchFinalScores=[[NSMutableArray alloc]init];
    NSMutableArray * matchTeamSquads=[[NSMutableArray alloc]init];
    NSMutableDictionary * eventsDic=[[NSMutableDictionary alloc]init];
    for(TeamPreference * item in list)
    {
        for (id eventItem in item.eventIds) {
            if([eventItem intValue] == ID_TEAM_PREFERENCE_MATCH_STATUS)
            {
                [matchStatusList addObject:[NSString stringWithFormat:@"team%ld",(long)item.teamId]];
            }
            else if([eventItem intValue] == ID_TEAM_PREFERENCE_MATCH_EVENTS)
            {
                [matchEvents addObject:[NSString stringWithFormat:@"team%ld",(long)item.teamId]];
            }
            else if([eventItem intValue] == ID_TEAM_PREFERENCE_MATCH_FINAL_SCORE)
            {
                [matchFinalScores addObject:[NSString stringWithFormat:@"team%ld",(long)item.teamId]];
            }
            else if([eventItem intValue] == ID_TEAM_PREFERENCE_MATCH_SQUAD)
            {
                [matchTeamSquads addObject:[NSString stringWithFormat:@"team%ld",(long)item.teamId]];
            }
        }
    }
    [eventsDic setObject:matchStatusList forKey:@"MatchStatus"];
    [eventsDic setObject:matchTeamSquads forKey:@"MatchTeamSquad"];
    [eventsDic setObject:matchFinalScores forKey:@"MatchFinalScore"];
    [eventsDic setObject:matchEvents forKey:@"MatchEvents"];

    return [[NSDictionary alloc]initWithDictionary:eventsDic];

}
@end
