//
//	ISection.h
//
//	Create by Nada Gamal on 2/7/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "FeaturedMenuItems.h"
#import "HomeFeaturedSection.h"

@interface ISection : NSObject

@property (nonatomic, strong) NSArray * featuredMenuItems;
@property (nonatomic, strong) HomeFeaturedSection * homeFeaturedSection;
@property (nonatomic, strong) NSString * endDate;
@property (nonatomic, strong) NSString * startDate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end