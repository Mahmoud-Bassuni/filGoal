//
//	PredictSponsor.h
//
//	Create by Nada Gamal on 21/5/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface PredictSponsor : NSObject

@property (nonatomic, strong) NSArray * champsIds;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
