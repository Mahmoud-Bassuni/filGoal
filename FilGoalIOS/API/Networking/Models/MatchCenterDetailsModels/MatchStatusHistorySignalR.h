//
//	MatchStatusHistory.h
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface MatchStatusHistorySignalR : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isCounterEnabled;
@property (nonatomic, assign) NSInteger matchId;
@property (nonatomic, assign) NSInteger matchStatusId;
@property (nonatomic, assign) NSInteger matchStatusMaxTime;
@property (nonatomic, strong) NSString * matchStatusName;
@property (nonatomic, strong) NSString * startAt;
@property (nonatomic, strong) UIColor * matchStatusColor;
@property (nonatomic, assign) NSInteger  matchStatusIndicatorId;
@property (nonatomic, assign) MatchStatus  currentMatchStatus;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
