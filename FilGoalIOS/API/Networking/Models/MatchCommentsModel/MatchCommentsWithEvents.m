//
//  MatchCommentsWithEvents.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCommentsWithEvents.h"

@implementation MatchCommentsWithEvents
-(id)initWithMatchComments:(NSMutableArray*)matchComments andEvents:(NSArray*)matchEvents andMatchStatusHistory:(NSMutableArray*) matchStatusHistory{
    self = [super init];
    self.matchStatusHistoryList=matchStatusHistory;
    self.matchComment=[[MatchComment alloc]init];
    self.matchCommentsList=[[NSMutableArray alloc]init];
    self.matchEvent=[[MatchEvent alloc]init];
    self.matchCommentsWithEvents=[[NSMutableArray alloc]init];
    self.matchEvents=matchEvents;
    for(int i=0;i<matchComments.count;i++)
    {
        
        self.matchComment=[matchComments objectAtIndex:i];
        [self addMatchEventsObjToComments:self.matchComment];
        if(![ self.matchComment.matchStatusName isEqualToString:@"الشوط الاول"])
        {
            [self addMatchMaxStatusTimeToCommentTime:self.matchComment andMatchComments:matchComments];
        }
        else
        {
            self.matchComment.matchStatusestime=self.matchComment.matchStatusMaxTime;
        }
  
    }


//    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"time"
//                                                                ascending: NO];
//    matchComments =(NSMutableArray*) [matchComments sortedArrayUsingDescriptors:@[sortOrder]];
    self.matchComments=matchComments;
  //  [self  groupCommentsByStatusHistory];
    return self;
}
-(void) addMatchMaxStatusTimeToCommentTime:(MatchComment*)matchComment andMatchComments:(NSMutableArray*)matchComments
{
    matchComment.matchStatusestime=matchComment.matchStatusMaxTime;
    for(int i=self.matchStatusHistoryList.count-1;i>=0;i--)
    {
        MatchStatusHistory* matchStatusObj=(MatchStatusHistory*)[self.matchStatusHistoryList objectAtIndex:i];
        if([matchStatusObj.matchStatusName isEqualToString:matchComment.matchStatusName])
        {
            for(int j=i;j<self.matchStatusHistoryList.count;j++)
            {
                MatchStatusHistory* matchStatusObject=(MatchStatusHistory*)[self.matchStatusHistoryList objectAtIndex:j];
                if(! [matchStatusObject.matchStatusName isEqualToString:matchComment.matchStatusName])
                {
                    matchComment.time+=matchStatusObject.matchStatusMaxTime;
                    matchComment.matchStatusestime+=matchStatusObject.matchStatusMaxTime;
                }
                
            }
            
            break;
            
        }
    }
    
}
-(void) groupCommentsByStatusHistory
{
    NSMutableArray * commentsListWithStatues=[[NSMutableArray alloc]init];
    // NSMutableDictionary * eventsDic=[[NSMutableDictionary alloc]init];
    for(MatchStatusHistory * matchStatus in self.matchStatusHistoryList)
    {
        commentsListWithStatues=[[NSMutableArray alloc]init];
        for(MatchComment * matchComment in self.matchComments)
        {
      if(matchComment.matchStatusId==matchStatus.idField)
                
            {
                [commentsListWithStatues addObject:matchComment];
            }
        }
        
        if(commentsListWithStatues.count>0)
        {
            
        //    [self.matchCommentsList addObject:[NSDictionary dictionaryWithObject:commentsListWithStatues forKey:matchStatus.matchStatusName]];
            [self.matchCommentsList addObjectsFromArray:commentsListWithStatues];

        }

    }
  //  NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"time"
                                                              //  ascending: NO];
   // self.matchCommentsList =[NSMutableArray arrayWithArray: [self.matchCommentsList sortedArrayUsingDescriptors:@[sortOrder]]];

    self.matchComments=[NSMutableArray arrayWithArray:self.matchCommentsList];
}

-(void) addMatchEventsObjToComments:(MatchComment*)matchComment
{
    
    for(int i=0;i<self.matchEvents.count;i++)
    {
        MatchEvent * item =[self.matchEvents objectAtIndex:i];
        if(matchComment.matchEventId==item.idField)
        {
            matchComment.matchEvent=item;
        }
     
    }
}
@end
