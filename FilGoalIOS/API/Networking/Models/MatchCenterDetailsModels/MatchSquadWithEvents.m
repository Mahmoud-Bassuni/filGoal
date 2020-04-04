//
//  MatchSquadWithEvents.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/7/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchSquadWithEvents.h"
#import "MatchTeamsSquad.h"
#import "MatchEvent.h"

@implementation MatchSquadWithEvents
-(id)initwithMatchSquad:(NSArray*)matchSquads andMatchEvents:(NSArray*)matchEvents andHomeTeamID:(NSInteger)homeTeamID andAwayTeamID:(NSInteger)awayTeamID{
    
    id obj = [self init];
    self.awayTeamSquad=[[NSMutableArray alloc]init];
    self.homeTeamSquad=[[NSMutableArray alloc]init];
    self.awaySpareTeamSquad=[[NSMutableArray alloc]init];
    self.homeSpareTeamSquad=[[NSMutableArray alloc]init];
    if (obj) {
        for(int i=0;i<matchSquads.count;i++)
        {
            [self findeventForPlayerAtSquad:[matchSquads objectAtIndex:i] andMatchEvents:matchEvents];
            [self arrangeTeamSquad:[matchSquads objectAtIndex:i] withHomeTeamID:homeTeamID andAwayID:awayTeamID];
        }
        self.matchSquadsWithEvents=matchSquads;
    }

    return obj;
}
//To Divide the returned data to home team squad array and away team squad array and spare arrays for home and away teams also
-(void)arrangeTeamSquad:(MatchTeamsSquad*) matchTeamSquad withHomeTeamID:(NSInteger) homeTeamID andAwayID:(NSInteger) awayTeamID
{
    if(matchTeamSquad.teamId==homeTeamID&&!matchTeamSquad.isSpare)
    {
        [self.homeTeamSquad addObject:matchTeamSquad];
    }
    else if(matchTeamSquad.teamId==homeTeamID&&matchTeamSquad.isSpare)
    {
        [self.homeSpareTeamSquad addObject:matchTeamSquad];

    }
    else if(matchTeamSquad.teamId==awayTeamID&&!matchTeamSquad.isSpare)
    {
        [self.awayTeamSquad addObject:matchTeamSquad];
        
    }
    else if(matchTeamSquad.teamId==awayTeamID&&matchTeamSquad.isSpare)
    {
        [self.awaySpareTeamSquad addObject:matchTeamSquad];
        
    }
}
-(void)findeventForPlayerAtSquad:(MatchTeamsSquad*) matchTeamSquad andMatchEvents:(NSArray*)matchEvents
{
    for(MatchEvent * event in matchEvents)
    {
        if((event.matchEventTypeId==1)||(event.matchEventTypeId==3)||(event.matchEventTypeId==4)||(event.matchEventTypeId==5))
        {
        if(matchTeamSquad.personId==event.playerAId)
        {
                [matchTeamSquad.playerMatchEvents addObject:event];
        }
        else  if(matchTeamSquad.personId==event.playerBId)
        {
            [matchTeamSquad.playerMatchEvents addObject:event];

        }
        }
        
    }
    
}
@end
