//
//	Country.h
//
//	Create by Nada Gamal on 27/6/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Country : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * flag;
@property (nonatomic, strong) NSString * ip;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end