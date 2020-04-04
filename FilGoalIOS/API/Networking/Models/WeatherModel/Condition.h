//
//	Condition.h
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Condition : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * temp;
@property (nonatomic, strong) NSString * text;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end