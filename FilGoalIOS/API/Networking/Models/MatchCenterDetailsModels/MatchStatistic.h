//
//	MatchStatistic.h
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface MatchStatistic : NSObject

@property (nonatomic, assign) NSInteger awayTeamValue;
@property (nonatomic, assign) NSInteger homeTeamValue;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isPercentage;
@property (nonatomic, assign) NSInteger matchStatisticsTypeId;
@property (nonatomic, strong) NSString * matchStatisticsTypeName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end