//
//  MatchSquadWithEvents.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/7/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchSquadWithEvents : NSObject
-(id)initwithMatchSquad:(NSArray*)matchSquads andMatchEvents:(NSArray*)matchEvents andHomeTeamID:(NSInteger)homeTeamID andAwayTeamID:(NSInteger)awayTeamID;
@property(nonatomic,strong) NSArray * matchSquadsWithEvents;
@property(nonatomic,strong) NSMutableArray * homeTeamSquad;
@property(nonatomic,strong) NSMutableArray * awayTeamSquad;
@property(nonatomic,strong) NSMutableArray * homeSpareTeamSquad;
@property(nonatomic,strong) NSMutableArray * awaySpareTeamSquad;



@end
