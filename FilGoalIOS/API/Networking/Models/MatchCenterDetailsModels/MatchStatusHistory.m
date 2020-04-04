//
//	MatchStatusHistory.m
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchStatusHistory.h"
#import "UIColor+AppColor.h"

NSString *const kMatchStatusHistoryIdField = @"id";
NSString *const kMatchStatusHistoryIsCounterEnabled = @"isCounterEnabled";
NSString *const kMatchStatusHistoryMatchId = @"matchId";
NSString *const kMatchStatusHistoryMatchStatusId = @"matchStatusId";
NSString *const kMatchStatusHistoryMatchStatusMaxTime = @"matchStatusMaxTime";
NSString *const kMatchStatusHistoryMatchStatusName = @"matchStatusName";
NSString *const kMatchStatusHistoryStartAt = @"startAt";
NSString *const kMatchDetailsMatchStatusIndicatorId = @"matchStatusIndicatorId";

@interface MatchStatusHistory ()
@end
@implementation MatchStatusHistory




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    if(![dictionary[kMatchDetailsMatchStatusIndicatorId] isKindOfClass:[NSNull class]]){
        self.matchStatusIndicatorId = [dictionary[kMatchDetailsMatchStatusIndicatorId] integerValue];;
    }
    
	if(![dictionary[kMatchStatusHistoryIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchStatusHistoryIdField] integerValue];
	}

	if(![dictionary[kMatchStatusHistoryIsCounterEnabled] isKindOfClass:[NSNull class]]){
		self.isCounterEnabled = [dictionary[kMatchStatusHistoryIsCounterEnabled] boolValue];
	}

	if(![dictionary[kMatchStatusHistoryMatchId] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kMatchStatusHistoryMatchId] integerValue];
	}

	if(![dictionary[kMatchStatusHistoryMatchStatusId] isKindOfClass:[NSNull class]]){
		self.matchStatusId = [dictionary[kMatchStatusHistoryMatchStatusId] integerValue];
        self.currentMatchStatus=self.matchStatusId;
	}

	if(![dictionary[kMatchStatusHistoryMatchStatusMaxTime] isKindOfClass:[NSNull class]]){
		self.matchStatusMaxTime = [dictionary[kMatchStatusHistoryMatchStatusMaxTime]integerValue];
	}	
	if(![dictionary[kMatchStatusHistoryMatchStatusName] isKindOfClass:[NSNull class]]){
		self.matchStatusName = dictionary[kMatchStatusHistoryMatchStatusName];
	}	
	if(![dictionary[kMatchStatusHistoryStartAt] isKindOfClass:[NSNull class]]){
		self.startAt = dictionary[kMatchStatusHistoryStartAt];
	}
    
    switch (self.currentMatchStatus) {
        case KMatchNotStarted:
            self.matchStatusColor=[UIColor mainAppYellowColor];;
            break;
        case KMatchSoon:
            self.matchStatusColor=[UIColor mainAppYellowColor];
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


/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.idField) forKey:kMatchStatusHistoryIdField];
    [aCoder encodeObject:@(self.isCounterEnabled) forKey:kMatchStatusHistoryIsCounterEnabled];
    [aCoder encodeObject:@(self.matchId) forKey:kMatchStatusHistoryMatchId];
    [aCoder encodeObject:@(self.matchStatusId) forKey:kMatchStatusHistoryMatchStatusId];
    [aCoder encodeObject:@(self.matchStatusIndicatorId) forKey:kMatchDetailsMatchStatusIndicatorId];
    [aCoder encodeObject:@(self.matchStatusMaxTime) forKey:kMatchStatusHistoryMatchStatusMaxTime];

    if(self.matchStatusName != nil){
        [aCoder encodeObject:self.matchStatusName forKey:kMatchStatusHistoryMatchStatusName];
    }
    if(self.startAt != nil){
        [aCoder encodeObject:self.startAt forKey:kMatchStatusHistoryStartAt];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.idField = [[aDecoder decodeObjectForKey:kMatchStatusHistoryIdField] integerValue];
    self.isCounterEnabled = [[aDecoder decodeObjectForKey:kMatchStatusHistoryIsCounterEnabled] boolValue];
    self.matchId = [[aDecoder decodeObjectForKey:kMatchStatusHistoryMatchId] integerValue];
    self.matchStatusId = [[aDecoder decodeObjectForKey:kMatchStatusHistoryMatchStatusId] integerValue];
    self.matchStatusIndicatorId = [[aDecoder decodeObjectForKey:kMatchDetailsMatchStatusIndicatorId] integerValue];
    self.matchStatusMaxTime = [[aDecoder decodeObjectForKey:kMatchStatusHistoryMatchStatusMaxTime]integerValue];
    self.matchStatusName = [aDecoder decodeObjectForKey:kMatchStatusHistoryMatchStatusName];
    self.startAt = [aDecoder decodeObjectForKey:kMatchStatusHistoryStartAt];
    return self;
    
}


@end
