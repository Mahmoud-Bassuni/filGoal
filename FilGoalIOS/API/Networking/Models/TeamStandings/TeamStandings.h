//
//	TeamStandings.h
//
//	Create by Nada Gamal on 8/8/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Standing.h"

@interface TeamStandings : NSObject

@property (nonatomic, strong) NSObject * count;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSObject * nextPageUri;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
