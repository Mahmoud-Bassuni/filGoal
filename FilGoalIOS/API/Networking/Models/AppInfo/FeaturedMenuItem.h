//
//	FeaturedMenuItem.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface FeaturedMenuItem : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * imgBaseUrl;
@property (nonatomic, assign) NSInteger isActive;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end