//
//	Channel.h
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Image.h"
#import "ItemWeather.h"

@interface Channel : NSObject

@property (nonatomic, strong) Image * image;
@property (nonatomic, strong) ItemWeather * item;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end