//
//	MatchEvent.m
//
//	Create by Nada Gamal on 11/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchEventSignalR.h"

NSString *const kMatchEventIdFieldd = @"Id";
NSString *const kMatchEventMatchEventTypeIdd = @"MatchEventTypeId";
NSString *const kMatchEventMatchEventTypeNamee = @"MatchEventTypeName";
NSString *const kMatchEventMatchIdd = @"MatchId";
NSString *const kMatchEventMatchStatusIdd = @"MatchStatusId";
NSString *const kMatchEventMatchStatusMaxTimee = @"MatchStatusMaxTime";
NSString *const kMatchEventMatchStatusNamee = @"MatchStatusName";
NSString *const kMatchEventNumberOfCommentss = @"NumberOfComments";
NSString *const kMatchEventPlayerAIdd = @"PlayerAId";
NSString *const kMatchEventPlayerALogoUrll = @"PlayerALogoUrl";
NSString *const kMatchEventPlayerANamee = @"PlayerAName";
NSString *const kMatchEventPlayerARoleNamee = @"PlayerARoleName";
NSString *const kMatchEventPlayerBIdd = @"PlayerBId";
NSString *const kMatchEventPlayerBLogoUrll = @"PlayerBLogoUrl";
NSString *const kMatchEventPlayerBNamee = @"PlayerBName";
NSString *const kMatchEventPlayerBRoleNamee = @"PlayerBRoleName";
NSString *const kMatchEventTeamIdd = @"TeamId";
NSString *const kMatchEventTeamNamee = @"TeamName";
NSString *const kMatchEventTimee = @"Time";

@interface MatchEventSignalR ()
@end
@implementation MatchEventSignalR




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMatchEventIdFieldd] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchEventIdFieldd] integerValue];
	}

	if(![dictionary[kMatchEventMatchEventTypeIdd] isKindOfClass:[NSNull class]]){
		self.matchEventTypeId = [dictionary[kMatchEventMatchEventTypeIdd] integerValue];
        self.matchEventType=self.matchStatusId;
	}

	if(![dictionary[kMatchEventMatchEventTypeNamee] isKindOfClass:[NSNull class]]){
		self.matchEventTypeName = dictionary[kMatchEventMatchEventTypeNamee];
	}	
	if(![dictionary[kMatchEventMatchIdd] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kMatchEventMatchIdd] integerValue];
	}

	if(![dictionary[kMatchEventMatchStatusIdd] isKindOfClass:[NSNull class]]){
		self.matchStatusId = [dictionary[kMatchEventMatchStatusIdd] integerValue];
	}

	if(![dictionary[kMatchEventMatchStatusMaxTimee] isKindOfClass:[NSNull class]]){
		self.matchStatusMaxTime = [dictionary[kMatchEventMatchStatusMaxTimee] integerValue];
	}

	if(![dictionary[kMatchEventMatchStatusNamee] isKindOfClass:[NSNull class]]){
		self.matchStatusName = dictionary[kMatchEventMatchStatusNamee];
	}	
	if(![dictionary[kMatchEventNumberOfCommentss] isKindOfClass:[NSNull class]]){
		self.numberOfComments = [dictionary[kMatchEventNumberOfCommentss] integerValue];
	}

	if(![dictionary[kMatchEventPlayerAIdd] isKindOfClass:[NSNull class]]){
		self.playerAId = [dictionary[kMatchEventPlayerAIdd] integerValue];
	}

	if(![dictionary[kMatchEventPlayerALogoUrll] isKindOfClass:[NSNull class]]){
		self.playerALogoUrl = dictionary[kMatchEventPlayerALogoUrll];
	}	
	if(![dictionary[kMatchEventPlayerANamee] isKindOfClass:[NSNull class]]){
		self.playerAName = dictionary[kMatchEventPlayerANamee];
	}	
	if(![dictionary[kMatchEventPlayerARoleNamee] isKindOfClass:[NSNull class]]){
		self.playerARoleName = dictionary[kMatchEventPlayerARoleNamee];
	}	
	if(![dictionary[kMatchEventPlayerBIdd] isKindOfClass:[NSNull class]]){
		self.playerBId = [dictionary[kMatchEventPlayerBIdd] integerValue];
	}

	if(![dictionary[kMatchEventPlayerBLogoUrll] isKindOfClass:[NSNull class]]){
		self.playerBLogoUrl = dictionary[kMatchEventPlayerBLogoUrll];
	}	
	if(![dictionary[kMatchEventPlayerBNamee] isKindOfClass:[NSNull class]]){
		self.playerBName = dictionary[kMatchEventPlayerBNamee];
	}	
	if(![dictionary[kMatchEventPlayerBRoleNamee] isKindOfClass:[NSNull class]]){
		self.playerBRoleName = dictionary[kMatchEventPlayerBRoleNamee];
	}	
	if(![dictionary[kMatchEventTeamIdd] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kMatchEventTeamIdd] integerValue];
	}

	if(![dictionary[kMatchEventTeamNamee] isKindOfClass:[NSNull class]]){
		self.teamName = dictionary[kMatchEventTeamNamee];
	}	
	if(![dictionary[kMatchEventTimee] isKindOfClass:[NSNull class]]){
		self.time = [dictionary[kMatchEventTimee] integerValue];
       // self.time = [self getMatchTime:[dictionary[kMatchEventTime] integerValue]];

	}

	return self;
}

//To accumlate match time with match status time
//-(int)getMatchTime:(NSInteger) eventMatchTime
//{
//    int maxMatchTime=0;
//    int  matchTime;
//    if([self.matchStatusName isEqualToString:@"الشوط الاول"])
//    {
//        matchTime=eventMatchTime;
//    }
//    else
//    {
//        if(self.matchStatusHistory.count>0)
//        {
//            
//            for(int i=0;i<self.matchStatusHistory.count;i++)
//            {
//                MatchStatusHistory* matchStatusObj=(MatchStatusHistory*)[self.matchStatusHistory objectAtIndex:i];
//                if(![self.matchStatusName isEqualToString:matchStatusObj.matchStatusName]&&matchStatusObj.matchStatusMaxTime !=0)
//                {
//                    maxMatchTime+=matchStatusObj.matchStatusMaxTime;
//                }
//                
//            }
//            
//        }
//    }
//    matchTime=maxMatchTime+ (int)self.time;
//    return matchTime;
//}

@end
