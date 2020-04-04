//
//	Stage.h
//
//	Create by Nada Gamal on 25/10/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Round.h"

@interface Stage : NSObject

@property (nonatomic, assign) NSInteger championshipId;
@property (nonatomic, strong) NSArray * groups;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isCustomGroupOrdering;
@property (nonatomic, assign) BOOL isGroups;
@property (nonatomic, assign) BOOL isPlayOffs;
@property (nonatomic, assign) BOOL isShowResult;
@property (nonatomic, strong) NSObject * numberOfGroups;
@property (nonatomic, strong) NSObject * numberOfTeams;
@property (nonatomic, strong) NSArray * rounds;

-(NSDictionary *)toDictionary;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
