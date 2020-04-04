//
//	PlayersStatistic.h
//
//	Create by Nada Gamal on 16/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface PlayersStatistic : NSObject

@property (nonatomic, assign) NSInteger eventTypeId;
@property (nonatomic, strong) NSString * eventTypeName;
@property (nonatomic, assign) NSInteger firstPersonId;
@property (nonatomic, strong) NSString * firstPersonLogoUrl;
@property (nonatomic, strong) NSString * firstPersonName;
@property (nonatomic, assign) NSInteger firstTeamId;
@property (nonatomic, assign) NSInteger firstValue;
@property (nonatomic, assign) NSInteger secondPersonId;
@property (nonatomic, strong) NSString * secondPersonLogoUrl;
@property (nonatomic, strong) NSString * secondPersonName;
@property (nonatomic, assign) NSInteger secondTeamId;
@property (nonatomic, assign) NSInteger secondValue;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end