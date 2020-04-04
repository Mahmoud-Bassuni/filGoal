//
//	Query.h
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Result.h"

@interface Query : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString * created;
@property (nonatomic, strong) NSString * lang;
@property (nonatomic, strong) Result * results;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end