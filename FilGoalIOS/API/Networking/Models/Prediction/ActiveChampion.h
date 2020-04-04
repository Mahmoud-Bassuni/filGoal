//
//	Result.h
//
//	Create by Nada Gamal on 10/5/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface ActiveChampion : NSObject

@property (nonatomic, assign) NSInteger champId;
@property (nonatomic, strong) NSArray * roundIds;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
