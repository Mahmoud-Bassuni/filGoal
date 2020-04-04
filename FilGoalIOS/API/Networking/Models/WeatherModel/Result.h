//
//	Result.h
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Channel.h"

@interface Result : NSObject

@property (nonatomic, strong) Channel * channel;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end