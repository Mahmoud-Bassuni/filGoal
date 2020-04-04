//
//	FeaturedCompontent.h
//
//	Create by Mohamed Mansour on 4/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Component.h"

@interface FeaturedCompontent : NSObject

@property (nonatomic, strong) NSArray * component;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end