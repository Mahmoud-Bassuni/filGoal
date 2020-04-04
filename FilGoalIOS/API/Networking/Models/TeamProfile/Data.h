//
//	Data.h
//
//	Create by Nada Gamal on 27/7/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "CareerData.h"

@interface Data : NSObject

@property (nonatomic, strong) NSObject * achievements;
@property (nonatomic, strong) NSArray * careerData;
@property (nonatomic, assign) NSInteger cityId;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, assign) NSInteger countryId;
@property (nonatomic, strong) NSString * countryName;
@property (nonatomic, assign) NSInteger founded;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * slug;
@property (nonatomic, assign) NSInteger teamTypeId;
@property (nonatomic, strong) NSString * teamTypeName;
@property (nonatomic, strong) NSString * website;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end