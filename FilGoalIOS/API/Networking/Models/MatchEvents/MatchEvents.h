//
//	MatchEvents.h
//
//	Create by Nada Gamal on 11/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "MatchEvent.h"

@interface MatchEvents : NSObject

@property (nonatomic, weak) NSMutableArray * matchEvents;
@property (nonatomic, strong) NSMutableDictionary * eventsWithStatusList;
@property (nonatomic,strong)  NSMutableArray * eventWithStatusSet;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
//@property (strong,nonatomic) NSMutableArray * matchStatusHistory;

@end
