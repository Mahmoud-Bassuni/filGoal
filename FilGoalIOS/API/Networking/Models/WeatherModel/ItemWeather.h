//
//	Item.h
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Condition.h"
#import "Forecast.h"
#import "Guid.h"

@interface ItemWeather : NSObject

@property (nonatomic, strong) Condition * condition;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) NSArray * forecast;
@property (nonatomic, strong) Guid * guid;
@property (nonatomic, strong) NSString * lat;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * longField;
@property (nonatomic, strong) NSString * pubDate;
@property (nonatomic, strong) NSString * title;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end