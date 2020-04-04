//
//	Url.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Url : NSObject

@property (nonatomic, strong) NSString * caption;
@property (nonatomic, strong) NSString * large;
@property (nonatomic, strong) NSString * small;
@property (nonatomic, strong) NSString * xlarge;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end