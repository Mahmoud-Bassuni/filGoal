//
//	HomeFeaturedSection.h
//
//	Create by Nada Gamal on 2/7/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "FeaturedSection.h"

@interface HomeFeaturedSection : NSObject

@property (nonatomic, strong) FeaturedSection * featuredSection;
@property (nonatomic, strong) NSString * imgBaseUrl;
@property (nonatomic, assign) NSInteger isActive;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end