//
//	MatchEvents.m
//
//	Create by Nada Gamal on 11/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchEvents.h"

//NSString *const kMatchEventsMatchEvents = @"MatchEvents";

@interface MatchEvents ()
{
    NSMutableArray * actionsInTheSameMinuite;
    NSMutableArray * firstHalfMatchStatuesList;
    NSMutableArray * secHalfMatchStatuesList;
    NSMutableArray * firstExtraHalfMatchStatuesList;
    NSMutableArray * secExtraHalfMatchStatuesList;
    NSMutableArray * breakMatchStatuesList;
    
    NSMutableDictionary * firstHalfMatchStatuesDic;
    NSMutableDictionary * secHalfMatchStatuesDic;
    NSMutableDictionary * firstExtraHalfMatchStatuesDic;
    NSMutableDictionary * secExtraHalfMatchStatuesDic;
    NSMutableDictionary * breakMatchStatuesDic;
    

}
@end
@implementation MatchEvents




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    MatchEvent * nextMatchEventsItem;
    MatchEvent * matchEventsItem;
    self = [super init];
    self.eventsWithStatusList=[[NSMutableDictionary alloc]init];
    if(dictionary != nil && [dictionary isKindOfClass:[NSArray class]]){
        NSArray * matchEventsDictionaries = dictionary;
        NSMutableArray * matchEventsItems = [NSMutableArray array];
        //for(NSDictionary * matchEventsDictionary in matchEventsDictionaries){
        firstHalfMatchStatuesList=[[NSMutableArray alloc]init];
        secHalfMatchStatuesList=[[NSMutableArray alloc]init];
        firstExtraHalfMatchStatuesList=[[NSMutableArray alloc]init];
        secExtraHalfMatchStatuesList=[[NSMutableArray alloc]init];
        breakMatchStatuesList=[[NSMutableArray alloc]init];
        
        firstHalfMatchStatuesDic=[[NSMutableDictionary alloc]init];
        secHalfMatchStatuesDic=[[NSMutableDictionary alloc]init];
        firstExtraHalfMatchStatuesDic=[[NSMutableDictionary alloc]init];
        secExtraHalfMatchStatuesDic=[[NSMutableDictionary alloc]init];
        breakMatchStatuesDic=[[NSMutableDictionary alloc]init];
        

        for(int i=0;i<matchEventsDictionaries.count;i++){
            actionsInTheSameMinuite=[[NSMutableArray alloc]init];
            _eventWithStatusSet=[[NSMutableArray alloc]init];

            matchEventsItem=[[MatchEvent alloc]init];
            nextMatchEventsItem=[[MatchEvent alloc]init];
            //matchEventsItem.matchStatusHistory=self.matchStatusHistory;
           // nextMatchEventsItem.matchStatusHistory=self.matchStatusHistory;
            matchEventsItem = [[MatchEvent alloc] initWithDictionary:[matchEventsDictionaries objectAtIndex:i] ];
            if(i+1<matchEventsDictionaries.count)
                nextMatchEventsItem = [[MatchEvent alloc] initWithDictionary:[matchEventsDictionaries objectAtIndex:i+1] ];
            
            if(matchEventsItem.time == nextMatchEventsItem.time)
            {
                [actionsInTheSameMinuite addObject:matchEventsItem];
                
                [actionsInTheSameMinuite addObject:nextMatchEventsItem];
                ++i;
            }
            else
                [actionsInTheSameMinuite addObject:matchEventsItem];
            
            [matchEventsItems addObject:actionsInTheSameMinuite];
            if([matchEventsItem.matchStatusName isEqualToString:@"الشوط الاول"])
            {
                [firstHalfMatchStatuesList addObject:actionsInTheSameMinuite];
                
                [firstHalfMatchStatuesDic setObject:firstHalfMatchStatuesList forKey:@"الشوط الاول"];
            }
         
            else    if([matchEventsItem.matchStatusName isEqualToString:@"الشوط الثاني"])
            {
                //[actionsWithMatchStatusList addObject:[NSDictionary dictionaryWithObject:actionsInTheSameMinuite forKey:@"الشوط الثاني"]];
                [secHalfMatchStatuesList addObject:actionsInTheSameMinuite];
                [secHalfMatchStatuesDic setObject:secHalfMatchStatuesList forKey:@"الشوط الثاني"];

            }
            else if([matchEventsItem.matchStatusName isEqualToString:@"الشوط الاضافي الاول"])
            {
                [firstExtraHalfMatchStatuesList addObject:actionsInTheSameMinuite];
                [firstExtraHalfMatchStatuesDic setObject:firstExtraHalfMatchStatuesList forKey:@"الشوط الاضافي الاول"];

                
            }
            else if([matchEventsItem.matchStatusName isEqualToString:@"الشوط الاضافي الثاني"])
            {
                [secExtraHalfMatchStatuesList addObject:actionsInTheSameMinuite];
                [secExtraHalfMatchStatuesDic setObject:secExtraHalfMatchStatuesList forKey:@"الشوط الاضافي الثاني"];


                
            }
            else if([matchEventsItem.matchStatusName isEqualToString:@"استراحة"])
            {
                [breakMatchStatuesList addObject:actionsInTheSameMinuite];
                [breakMatchStatuesDic setObject:breakMatchStatuesList forKey:@"استراحة"];

                
            }
            if(firstHalfMatchStatuesDic.count>0)
            [self.eventWithStatusSet addObject:firstHalfMatchStatuesDic];
            if(secHalfMatchStatuesDic.count>0)
                [self.eventWithStatusSet addObject:secHalfMatchStatuesDic];
            if(firstExtraHalfMatchStatuesDic.count>0)
                [self.eventWithStatusSet addObject:firstExtraHalfMatchStatuesDic];
            if(secExtraHalfMatchStatuesDic.count>0)
                [self.eventWithStatusSet addObject:secExtraHalfMatchStatuesDic ];
            if(breakMatchStatuesDic.count>0)
                [self.eventWithStatusSet addObject:breakMatchStatuesDic ];



        }

        
        self.matchEvents =self.eventWithStatusSet;
    }
    return self;
}


@end