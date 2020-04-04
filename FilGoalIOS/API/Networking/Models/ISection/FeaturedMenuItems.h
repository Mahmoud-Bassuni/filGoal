//
//	FeaturedMenuItems.h
//
//	Create by Mohamed Mansour on 2/7/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "FeaturedSection.h"

@interface FeaturedMenuItems : NSObject

@property (nonatomic, strong) FeaturedSection * featuredSection;
@property (nonatomic, strong) NSString * imgBaseUrl;
@property (nonatomic, assign) BOOL isActive;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end