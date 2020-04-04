//
//	StandingsMatchCenter.h
//
//	Create by Nada Gamal on 18/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Standing.h"

@interface StandingsMatchCenter : NSObject

@property (nonatomic, strong) NSArray * standings;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end