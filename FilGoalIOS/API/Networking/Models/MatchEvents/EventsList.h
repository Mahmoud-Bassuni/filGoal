//
//	EventsList.h
//
//	Create by Nada Gamal on 4/9/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "MatchEvent.h"

@interface EventsList : NSObject

@property (nonatomic, copy) NSArray * events;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
