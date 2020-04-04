//
//  MatchEventsWithStatusHistory.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/10/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchEvent.h"
@interface MatchEventsWithStatusHistory : NSObject
-(id)initWithMatchEvents:(NSArray *)matchEvents andMatchStatusHistory:(NSMutableArray *)matchStatusHistory andIsAfterMatch:(BOOL) isFromAfterMatch;
@property (nonatomic,strong) NSArray * matchEvents;
@property (nonatomic,strong) MatchEvent * matchEvent;
@property (nonatomic,strong) NSMutableArray * matchStatusHistoryList;
@property (nonatomic,strong) NSMutableArray * matchEventsGroupedByStatuesList;
@property (nonatomic,strong) NSMutableArray * mainMatchEventsGroupedByStatuesList;
@property (nonatomic,strong) NSMutableArray * goalsList;

@property (nonatomic,assign) BOOL isFromAfterMatchView;


@end
