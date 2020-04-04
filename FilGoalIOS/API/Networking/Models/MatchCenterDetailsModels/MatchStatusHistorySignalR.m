//
//	MatchStatusHistory.m
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchStatusHistorySignalR.h"

NSString *const kMatchStatusHistoryIdFieldd = @"Id";
NSString *const kMatchStatusHistoryIsCounterEnabledd = @"IsCounterEnabled";
NSString *const kMatchStatusHistoryMatchIdd = @"MatchId";
NSString *const kMatchStatusHistoryMatchStatusIdd = @"MatchStatusId";
NSString *const kMatchStatusHistoryMatchStatusMaxTimee = @"MatchStatusMaxTime";
NSString *const kMatchStatusHistoryMatchStatusNamee = @"MatchStatusName";
NSString *const kMatchStatusHistoryStartAtt = @"StartAt";
NSString *const kMatchDetailsMatchStatusIndicatorIdd = @"MatchStatusIndicatorId";

@interface MatchStatusHistorySignalR ()
@end
@implementation MatchStatusHistorySignalR




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if(![dictionary[kMatchDetailsMatchStatusIndicatorIdd] isKindOfClass:[NSNull class]]){
        self.matchStatusIndicatorId = [dictionary[kMatchDetailsMatchStatusIndicatorIdd] integerValue];;
    }
    
	if(![dictionary[kMatchStatusHistoryIdFieldd] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchStatusHistoryIdFieldd] integerValue];
	}

	if(![dictionary[kMatchStatusHistoryIsCounterEnabledd] isKindOfClass:[NSNull class]]){
		self.isCounterEnabled = [dictionary[kMatchStatusHistoryIsCounterEnabledd] boolValue];
	}

	if(![dictionary[kMatchStatusHistoryMatchIdd] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kMatchStatusHistoryMatchIdd] integerValue];
	}

	if(![dictionary[kMatchStatusHistoryMatchStatusIdd] isKindOfClass:[NSNull class]]){
		self.matchStatusId = [dictionary[kMatchStatusHistoryMatchStatusIdd] integerValue];
        self.currentMatchStatus=self.matchStatusId;

	}

	if(![dictionary[kMatchStatusHistoryMatchStatusMaxTimee] isKindOfClass:[NSNull class]]){
		self.matchStatusMaxTime = [dictionary[kMatchStatusHistoryMatchStatusMaxTimee]integerValue];
	}	
	if(![dictionary[kMatchStatusHistoryMatchStatusNamee] isKindOfClass:[NSNull class]]){
		self.matchStatusName = dictionary[kMatchStatusHistoryMatchStatusNamee];
	}	
	if(![dictionary[kMatchStatusHistoryStartAtt] isKindOfClass:[NSNull class]]){
		self.startAt = dictionary[kMatchStatusHistoryStartAtt];
	}
    switch (self.currentMatchStatus) {
        case KMatchNotStarted:
            self.matchStatusColor=[UIColor colorWithRed:0.85 green:0.51 blue:0.14 alpha:1.0];;
            break;
        case KMatchSoon:
            self.matchStatusColor=[UIColor colorWithRed:0.85 green:0.51 blue:0.14 alpha:1.0];;
            break;
        case KMatchFirstHalf:
            self.matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchBreak:
            self.matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchSecondHalf:
            self.matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchFirstExtraHalf:
            self.matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchSecondExtraHalf:
            self.matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KPlenties:
            self.matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchEnd:
            self.matchStatusColor=[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0];
            break;
        case KMatchStopped:
            self.matchStatusColor=[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0];
            break;
        case KMatchPostponed:
            self.matchStatusColor=[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0];
            break;
        case KMatchCancelled:
            self.matchStatusColor=[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0];
            break;
            
        default:
            break;
    }

   	return self;
}

@end
