//
//	Message.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Message : NSObject

@property (nonatomic, assign) NSInteger isActive;
@property (nonatomic, assign) NSInteger isRepeated;
@property (nonatomic, strong) NSString * msg;
@property (nonatomic, assign) NSInteger msgId;
@property (nonatomic, strong) NSString * msgUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end