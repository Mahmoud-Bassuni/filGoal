//
//    Round.h
//
//    Create by Nada Gamal on 25/10/2017
//    Copyright © 2017. All rights reserved.
//

//    Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Round : NSObject

@property (nonatomic, assign) NSInteger championshipId;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger stageId;
@property (nonatomic, strong) NSString * roundNumber;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) BOOL isHomeAway;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) NSInteger roundTypeId;
@property (nonatomic, strong) NSString * roundTypeName;
@property (nonatomic, strong) NSString * uniqueStamp;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
