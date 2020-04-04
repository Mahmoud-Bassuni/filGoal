//
//	MatchOverview.m
//
//	Create by Mohamed Mansour on 16/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchOverview.h"
#import "Standing.h"
NSString *const kMatchOverviewChampionshipId = @"championshipId";
NSString *const kMatchOverviewChampionshipTeamsMatchesStatistics = @"championshipTeamsMatchesStatistics";
NSString *const kMatchOverviewFirstTeamHeighestScore = @"homeTeamHeighestScoreMatch";
NSString *const kMatchOverviewFirstTeamId = @"homeTeamId";
NSString *const kMatchOverviewPlayersStatistics = @"playersStatistics";
NSString *const kMatchOverviewSecondTeamHeighestScore = @"awayTeamHeighestScoreMatch";
NSString *const kMatchOverviewSecondTeamId = @"awayTeamId";
NSString *const kMatchOverviewWinsComparison = @"winsComparison";
NSString *const kTeamStandings = @"standings";

@interface MatchOverview ()
@end
@implementation MatchOverview




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMatchOverviewChampionshipId] isKindOfClass:[NSNull class]]){
		self.championshipId = [dictionary[kMatchOverviewChampionshipId] integerValue];
	}

	if(dictionary[kMatchOverviewChampionshipTeamsMatchesStatistics] != nil && [dictionary[kMatchOverviewChampionshipTeamsMatchesStatistics] isKindOfClass:[NSArray class]]){
		NSArray * championshipTeamsMatchesStatisticsDictionaries = dictionary[kMatchOverviewChampionshipTeamsMatchesStatistics];
		NSMutableArray * championshipTeamsMatchesStatisticsItems = [NSMutableArray array];
		for(NSDictionary * championshipTeamsMatchesStatisticsDictionary in championshipTeamsMatchesStatisticsDictionaries){
			ChampionshipTeamsMatchesStatistic * championshipTeamsMatchesStatisticsItem = [[ChampionshipTeamsMatchesStatistic alloc] initWithDictionary:championshipTeamsMatchesStatisticsDictionary];
			[championshipTeamsMatchesStatisticsItems addObject:championshipTeamsMatchesStatisticsItem];
		}
		self.championshipTeamsMatchesStatistics = championshipTeamsMatchesStatisticsItems;
	}
	if(![dictionary[kMatchOverviewFirstTeamHeighestScore] isKindOfClass:[NSNull class]]){
		self.firstTeamHeighestScore = [[FirstTeamHeighestScore alloc] initWithDictionary:dictionary[kMatchOverviewFirstTeamHeighestScore]];
	}

	if(![dictionary[kMatchOverviewFirstTeamId] isKindOfClass:[NSNull class]]){
		self.firstTeamId = [dictionary[kMatchOverviewFirstTeamId] integerValue];
	}

	if(dictionary[kMatchOverviewPlayersStatistics] != nil && [dictionary[kMatchOverviewPlayersStatistics] isKindOfClass:[NSArray class]]){
		NSArray * playersStatisticsDictionaries = dictionary[kMatchOverviewPlayersStatistics];
		NSMutableArray * playersStatisticsItems = [NSMutableArray array];
		for(NSDictionary * playersStatisticsDictionary in playersStatisticsDictionaries){
			PlayersStatistic * playersStatisticsItem = [[PlayersStatistic alloc] initWithDictionary:playersStatisticsDictionary];
			[playersStatisticsItems addObject:playersStatisticsItem];
		}
		self.playersStatistics = playersStatisticsItems;
//        if(self.playersStatistics.count>3)
//        {
//            self.playersStatistics = [self.playersStatistics subarrayWithRange:NSMakeRange(0, 2)];
//            
//        }
        
	}
	if(![dictionary[kMatchOverviewSecondTeamHeighestScore] isKindOfClass:[NSNull class]]){
		self.secondTeamHeighestScore = [[FirstTeamHeighestScore alloc] initWithDictionary:dictionary[kMatchOverviewSecondTeamHeighestScore]];
	}

	if(![dictionary[kMatchOverviewSecondTeamId] isKindOfClass:[NSNull class]]){
		self.secondTeamId = [dictionary[kMatchOverviewSecondTeamId] integerValue];
	}

	if(![dictionary[kMatchOverviewWinsComparison] isKindOfClass:[NSNull class]]){
		self.winsComparison = [[WinsComparison alloc] initWithDictionary:dictionary[kMatchOverviewWinsComparison]];
	}
	if(dictionary[kTeamStandings] != nil && [dictionary[kTeamStandings] isKindOfClass:[NSArray class]]){
       	NSArray * standingsListDictionary = dictionary[kTeamStandings];
        NSMutableArray * standingItems = [NSMutableArray array];
        for(NSDictionary * standingDic in standingsListDictionary){
           Standing * item = [[Standing alloc] initWithDictionary:standingDic];
            [standingItems addObject:item];
        }
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"rank"
                                                                    ascending: YES];
        standingItems = [standingItems sortedArrayUsingDescriptors:@[sortOrder]];
        self.standings=standingItems;
    }
	return self;
}
@end
