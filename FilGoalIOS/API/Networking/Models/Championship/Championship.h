//
//	Championship.h
//
//	Create by Nada Gamal on 30/7/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "ChampionShipData.h"

@interface Championship : NSObject

@property (nonatomic, strong) NSObject * count;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSObject * nextPageUri;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
