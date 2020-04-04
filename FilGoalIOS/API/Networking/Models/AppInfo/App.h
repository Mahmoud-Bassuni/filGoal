//
//	App.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface App : NSObject

@property (nonatomic, assign) NSInteger isActive;
@property (nonatomic, assign) NSInteger isCore;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, strong) NSString * storeUrl;
@property (nonatomic, strong) NSString * version;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end