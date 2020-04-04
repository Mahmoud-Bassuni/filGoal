//
//	ChampId.h
//
//	Create by Mohamed Mansour on 3/7/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface ChampId : NSObject

@property (nonatomic, assign) NSInteger champID;
@property (nonatomic, assign) NSInteger displayOrder;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end