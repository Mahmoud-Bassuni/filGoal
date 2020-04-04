//
//	Data.h
//
//	Create by Nada Gamal on 30/7/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Team.h"
#import "Stage.h"
@interface ChampionShipData : NSObject

@property (nonatomic, assign) NSInteger championshipTypeId;
@property (nonatomic, strong) NSString * championshipTypeName;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger seasonId;
@property (nonatomic, strong) NSString * seasonName;
@property (nonatomic, strong) NSString * slug;
@property (nonatomic, assign) NSInteger weeks;
@property (nonatomic, strong) NSArray * teams;
@property (nonatomic, strong) NSArray * rounds;
@property (nonatomic, strong) NSArray * stages;
@property (nonatomic, assign) NSInteger currentWeek;
@property (nonatomic, assign) NSInteger currentRoundId;
@property (nonatomic, strong) NSString * currentRoundName;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
