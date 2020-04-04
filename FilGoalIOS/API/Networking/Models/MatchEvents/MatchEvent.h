//
//	MatchEvent.h
//
//	Create by Nada Gamal on 11/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface MatchEvent : NSObject
typedef  NS_ENUM(NSUInteger, MatchEventType)
{
    KGoals =1,
    KHelp =2,
    KYellowCard =3,
    KRedCard = 4,
    KChange =5,
    KInjuries =6,
    KPlentyKicks =7,
    KMakePlenty =8,
    KAddressPlenty =9,
    KCorner =10,
    KError =11,
    KWarmUp =12,
    KExpelledCoach =13,
    KFreeKick =14,
    KInDirectFreeKick =15,
    KSaveTarget =16,
    KShotInBar =17,
    KShotNextToTheBar =18,
    KOffside =19,
    KReverseGoal =20,
};
@property (nonatomic,assign) MatchEventType matchEventType;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger matchEventTypeId;
@property (nonatomic, strong) NSString * matchEventTypeName;
@property (nonatomic, assign) NSInteger matchId;
@property (nonatomic, assign) NSInteger matchStatusId;
@property (nonatomic, assign) NSInteger matchStatusMaxTime;
@property (nonatomic, strong) NSString * matchStatusName;
@property (nonatomic, assign) NSInteger numberOfComments;
@property (nonatomic, assign) NSInteger playerAId;
@property (nonatomic, strong) NSString * playerALogoUrl;
@property (nonatomic, strong) NSString * playerAName;
@property (nonatomic, strong) NSString * playerARoleName;
@property (nonatomic, assign) NSInteger playerBId;
@property (nonatomic, strong) NSString * playerBLogoUrl;
@property (nonatomic, strong) NSString * playerBName;
@property (nonatomic, strong) NSString * playerBRoleName;
@property (nonatomic, assign) NSInteger teamId;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger matchStatusestime;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
