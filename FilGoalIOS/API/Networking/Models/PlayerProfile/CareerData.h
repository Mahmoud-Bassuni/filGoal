//
//	CareerData.h
//
//	Create by Nada Gamal on 25/7/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface CareerData : NSObject

@property (nonatomic, strong) NSString * from;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isLoaned;
@property (nonatomic, assign) NSInteger personId;
@property (nonatomic, strong) NSObject * personLogoUrl;
@property (nonatomic, strong) NSString * personName;
@property (nonatomic, assign) NSInteger personTypeId;
@property (nonatomic, strong) NSString * personTypeName;
@property (nonatomic, assign) NSInteger playerNumber;
@property (nonatomic, assign) NSInteger playerPositionId;
@property (nonatomic, strong) NSString * playerPositionName;
@property (nonatomic, assign) NSInteger teamId;
@property (nonatomic, strong) NSObject * teamLogoUrl;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSObject * to;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end