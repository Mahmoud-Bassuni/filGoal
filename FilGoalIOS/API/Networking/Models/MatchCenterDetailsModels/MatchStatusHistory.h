//
//	MatchStatusHistory.h
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface MatchStatusHistory : NSObject
typedef  NS_ENUM(NSUInteger, MatchStatus)
{
    KMatchNotStarted =1,
    KMatchSoon =2,
    KMatchFirstHalf =3,
    KMatchBreak = 4,
    KMatchSecondHalf =5,
    KMatchFirstExtraHalf =6,
    KMatchSecondExtraHalf =7,
    KPlenties =8,
    KMatchEnd =9,
    KMatchStopped =10,
    KMatchPostponed =11,
    KMatchCancelled =12,
    
};
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isCounterEnabled;
@property (nonatomic, assign) NSInteger matchId;
@property (nonatomic, assign) NSInteger matchStatusId;
@property (nonatomic, assign) NSInteger matchStatusMaxTime;
@property (nonatomic, strong) NSString * matchStatusName;
@property (nonatomic, strong) NSString * startAt;
@property (nonatomic, assign) MatchStatus  currentMatchStatus;
@property (nonatomic, strong) UIColor * matchStatusColor;
@property (nonatomic, assign) NSInteger  matchStatusIndicatorId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end