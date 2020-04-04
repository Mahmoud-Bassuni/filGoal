//
//  MatchEventsWithStatusHistory.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/10/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchEventsWithStatusHistory.h"

@implementation MatchEventsWithStatusHistory
-(id)initWithMatchEvents:(NSArray *)matchEvents andMatchStatusHistory:(NSMutableArray *)matchStatusHistory andIsAfterMatch:(BOOL) isFromAfterMatch
{
    self.matchEvents=matchEvents;
    self.isFromAfterMatchView=isFromAfterMatch;
    self.matchEventsGroupedByStatuesList=[[NSMutableArray alloc]init];
    self.mainMatchEventsGroupedByStatuesList=[[NSMutableArray alloc]init];
    self.matchEvent=[[MatchEvent alloc]init];
    self.matchStatusHistoryList=matchStatusHistory;
    
    for(int i=0;i<self.matchEvents.count;i++)
    {
        
        self.matchEvent=[matchEvents objectAtIndex:i];
        if(![ self.matchEvent.matchStatusName isEqualToString:@"الشوط الاول"])
        {
            [self addMatchMaxStatusTimeToEventTime:self.matchEvent andMatchEvents:self.matchEvents];
        }
        else
        {
            self.matchEvent.matchStatusestime=self.matchEvent.matchStatusMaxTime;

        }
        
    }
    
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"time"
                                                                ascending: NO];
    matchEvents = [matchEvents sortedArrayUsingDescriptors:@[sortOrder]];
    self.matchEvents=matchEvents;
    [self groupEventsByStatusHistory];
    return self;
}
-(void) groupEventsByStatusHistory
{
    NSMutableArray * statusWithEventsList=[[NSMutableArray alloc]init];
    NSMutableArray * mainStatusWithEventsList=[[NSMutableArray alloc]init];
    // NSMutableDictionary * eventsDic=[[NSMutableDictionary alloc]init];
    for(MatchStatusHistory * matchStatus in self.matchStatusHistoryList)
    {
        statusWithEventsList=[[NSMutableArray alloc]init];
         mainStatusWithEventsList=[[NSMutableArray alloc]init];
        self.goalsList = [[NSMutableArray alloc]init];
        for(MatchEvent * matchEvent in self.matchEvents)
        {
            //                // to add only red and yellow cards and change event type , Goal
            if((matchEvent.matchEventTypeId==KGoals)||(matchEvent.matchEventTypeId==KReverseGoal)||(matchEvent.matchEventTypeId==KMakePlenty))
            {
                [self.goalsList addObject:matchEvent];
            }
            if([matchEvent.matchStatusName isEqualToString:matchStatus.matchStatusName]&&((matchEvent.matchEventTypeId==KGoals)||(matchEvent.matchEventTypeId==KYellowCard)||(matchEvent.matchEventTypeId==KRedCard)||(matchEvent.matchEventTypeId==KChange)||(matchEvent.matchEventTypeId==KReverseGoal)||(matchEvent.matchEventTypeId==KMakePlenty)))
            {
                [mainStatusWithEventsList addObject:matchEvent];
                [statusWithEventsList addObject:matchEvent];
                
                
            }
            else if([matchEvent.matchStatusName isEqualToString:matchStatus.matchStatusName])
                
            {
                [statusWithEventsList addObject:matchEvent];
            }
        }
        if(statusWithEventsList.count>0)
            [self.matchEventsGroupedByStatuesList addObject:[NSDictionary dictionaryWithObject:statusWithEventsList forKey:matchStatus.matchStatusName]];
        if(mainStatusWithEventsList.count>0)
            [self.mainMatchEventsGroupedByStatuesList addObject:[NSDictionary dictionaryWithObject:mainStatusWithEventsList forKey:matchStatus.matchStatusName]];
    }
}
-(void) addMatchMaxStatusTimeToEventTime:(MatchEvent*)matchEvent andMatchEvents:(NSArray*)matchComments
{
    matchEvent.matchStatusestime=matchEvent.matchStatusMaxTime;
    for(int i=self.matchStatusHistoryList.count-1;i>=0;i--)
    {
        MatchStatusHistory* matchStatusObj=(MatchStatusHistory*)[self.matchStatusHistoryList objectAtIndex:i];
       if([matchStatusObj.matchStatusName isEqualToString:matchEvent.matchStatusName])
       {
           for(int j=i;j<self.matchStatusHistoryList.count;j++)
           {
               MatchStatusHistory* matchStatusObject=(MatchStatusHistory*)[self.matchStatusHistoryList objectAtIndex:j];
               if(! [matchStatusObject.matchStatusName isEqualToString:matchEvent.matchStatusName])
               {
               matchEvent.time+=matchStatusObject.matchStatusMaxTime;
               matchEvent.matchStatusestime+=matchStatusObject.matchStatusMaxTime;
               }

           }

           break;
           
       }

        //        if(matchStatusObj.matchStatusMaxTime !=0&&![matchEvent.matchStatusName isEqualToString:matchStatusObj.matchStatusName]&&matchEvent.time<=matchStatusObj.matchStatusMaxTime)

       // if(matchStatusObj.matchStatusMaxTime !=0&&![matchEvent.matchStatusName isEqualToString:matchStatusObj.matchStatusName]&&matchStatusObj.idField<= matchEvent.matchStatusId)
            
//        {
//            matchEvent.time+=matchStatusObj.matchStatusMaxTime;
//           // break;
//        }
        
    }
    
}
@end
