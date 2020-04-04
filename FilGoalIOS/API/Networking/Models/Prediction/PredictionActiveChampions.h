//
//	PredictionActiveChampions.h
//
//	Create by Nada Gamal on 10/5/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Result.h"

@interface PredictionActiveChampions : NSObject

@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, strong) NSArray * result;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger totalCount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end