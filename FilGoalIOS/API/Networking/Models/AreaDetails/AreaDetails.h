//
//	AreaDetails.h
//
//	Create by Nada Gamal on 16/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface AreaDetails : NSObject

@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@property (nonatomic, strong) NSString * region;
@property (nonatomic, strong) NSString * timezone;
@property (nonatomic, strong) NSString * zipcode;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end