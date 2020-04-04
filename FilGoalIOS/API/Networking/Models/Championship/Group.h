//
//	Group.h
//
//	Create by Nada Gamal on 29/10/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Team.h"

@interface Group : NSObject

@property (nonatomic, assign) NSInteger championshipStageId;
@property (nonatomic, strong) NSObject * cultureData;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSArray * teams;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
