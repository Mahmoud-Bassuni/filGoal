//
//	MatchEvent.h
//
//	Create by Nada Gamal on 11/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface MatchEventSignalR : NSObject

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
