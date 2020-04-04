//
//	AfterSection.h
//
//	Create by Mohamed Mansour on 16/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface AfterSection : NSObject

@property (nonatomic, strong) NSString * src;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end