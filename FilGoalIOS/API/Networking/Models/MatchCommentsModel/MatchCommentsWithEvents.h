//
//  MatchCommentsWithEvents.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchEvent.h"
#import "MatchComment.h"

@interface MatchCommentsWithEvents : NSObject
-(id)initWithMatchComments:(NSMutableArray*)matchComments andEvents:(NSArray*)matchEvents andMatchStatusHistory:(NSMutableArray*) matchStatusHistory;
@property(nonatomic,strong) MatchComment * matchComment;
@property(nonatomic,strong) MatchEvent * matchEvent;
@property(nonatomic,strong) NSMutableArray * matchEvents;
@property(nonatomic,strong) NSMutableArray * matchComments;
@property(nonatomic,strong) NSMutableArray * matchCommentsList;
@property (nonatomic,strong) NSMutableArray * matchStatusHistoryList;
@property(nonatomic,strong) NSMutableArray * matchCommentsWithEvents;

@end
