//
//	MatchDetails.m
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchCenterDetails.h"
#import "Constants.h"
#import "TvCoverage.h"
NSString *const kMatchDetailsAwayMatchId = @"awayMatchId";
NSString *const kMatchDetailsAwayPenaltyScore = @"awayPenaltyScore";
NSString *const kMatchDetailsAwayScore = @"awayScore";
NSString *const kMatchDetailsAwayTeamCoachId = @"awayTeamCoachId";
NSString *const kMatchDetailsAwayTeamCoachName = @"awayTeamCoachName";
NSString *const kMatchDetailsAwayTeamFormationId = @"awayTeamFormationId";
NSString *const kMatchDetailsAwayTeamFormationName = @"awayTeamFormationName";
NSString *const kMatchDetailsAwayTeamId = @"awayTeamId";
NSString *const kMatchDetailsAwayTeamLogoUrl = @"awayTeamLogoUrl";
NSString *const kMatchDetailsAwayTeamName = @"awayTeamName";
NSString *const kMatchDetailsChampionshipId = @"championshipId";
NSString *const kMatchDetailsChampionshipName = @"championshipName";
NSString *const kMatchDetailsCoverageTypeId = @"coverageTypeId";
NSString *const kMatchDetailsCoverageTypeName = @"coverageTypeName";
NSString *const kMatchDetailsDate = @"date";
NSString *const kMatchDetailsFinalAwayPenaltyScore = @"finalAwayPenaltyScore";
NSString *const kMatchDetailsFinalAwayScore = @"finalAwayScore";
NSString *const kMatchDetailsFinalHomePenaltyScore = @"finalHomePenaltyScore";
NSString *const kMatchDetailsFinalHomeScore = @"finalHomeScore";
NSString *const kMatchDetailsHomeMatchId = @"homeMatchId";
NSString *const kMatchDetailsHomePenaltyScore = @"homePenaltyScore";
NSString *const kMatchDetailsHomeScore = @"homeScore";
NSString *const kMatchDetailsHomeTeamCoachId = @"homeTeamCoachId";
NSString *const kMatchDetailsHomeTeamCoachName = @"homeTeamCoachName";
NSString *const kMatchDetailsHomeTeamFormationId = @"homeTeamFormationId";
NSString *const kMatchDetailsHomeTeamFormationName = @"homeTeamFormationName";
NSString *const kMatchDetailsHomeTeamId = @"homeTeamId";
NSString *const kMatchDetailsHomeTeamLogoUrl = @"homeTeamLogoUrl";
NSString *const kMatchDetailsHomeTeamName = @"homeTeamName";
NSString *const kMatchDetailsIdField = @"id";
NSString *const kMatchDetailsIsAwayMatch = @"isAwayMatch";
NSString *const kMatchDetailsIsDelayed = @"isDelayed";
NSString *const kMatchDetailsMatchStatistics = @"matchStatistics";
NSString *const kMatchDetailsMatchStatusHistory = @"matchStatusHistory";
NSString *const kMatchDetailsMatchTeamsSquads = @"matchTeamsSquads";
NSString *const kMatchDetailsOrderInRound = @"orderInRound";
NSString *const kMatchDetailsRefereeId = @"refereeId";
NSString *const kMatchDetailsRefereeName = @"refereeName";
NSString *const kMatchDetailsRoundId = @"roundId";
NSString *const kMatchDetailsGroupId = @"groupId";

NSString *const kMatchDetailsRoundIsGroups = @"roundIsGroups";
NSString *const kMatchDetailsRoundName = @"roundName";
NSString *const kMatchDetailsRoundOrder = @"roundOrder";
NSString *const kMatchDetailsStadiumId = @"stadiumId";
NSString *const kMatchDetailsStadiumName = @"stadiumName";
NSString *const kMatchDetailsTvCoverage = @"tvCoverage";
NSString *const kMatchDetailsWeek = @"week";
NSString *const kChampionOrder = @"championshipOrder";


@interface MatchCenterDetails ()
@end
@implementation MatchCenterDetails




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
  
    
	if(![dictionary[kMatchDetailsAwayMatchId] isKindOfClass:[NSNull class]]){
		self.awayMatchId = [dictionary[kMatchDetailsAwayMatchId] integerValue];;
	}	
	if(![dictionary[kMatchDetailsAwayPenaltyScore] isKindOfClass:[NSNull class]]){
		self.awayPenaltyScore = [dictionary[kMatchDetailsAwayPenaltyScore] integerValue];
	}

	if(![dictionary[kMatchDetailsAwayScore] isKindOfClass:[NSNull class]]){
		self.awayScore = [dictionary[kMatchDetailsAwayScore] integerValue];
	}
    if(![dictionary[kChampionOrder] isKindOfClass:[NSNull class]]){
        self.championOrder = [dictionary[kChampionOrder] integerValue];
    }
	if(![dictionary[kMatchDetailsAwayTeamCoachId] isKindOfClass:[NSNull class]]){
		self.awayTeamCoachId = [dictionary[kMatchDetailsAwayTeamCoachId] integerValue];
	}	
	if(![dictionary[kMatchDetailsAwayTeamCoachName] isKindOfClass:[NSNull class]]){
		self.awayTeamCoachName = dictionary[kMatchDetailsAwayTeamCoachName];
	}	
	if(![dictionary[kMatchDetailsAwayTeamFormationId] isKindOfClass:[NSNull class]]){
		self.awayTeamFormationId = [dictionary[kMatchDetailsAwayTeamFormationId] integerValue];
	}

	if(![dictionary[kMatchDetailsAwayTeamFormationName] isKindOfClass:[NSNull class]]){
		self.awayTeamFormationName = dictionary[kMatchDetailsAwayTeamFormationName];
	}	
	if(![dictionary[kMatchDetailsAwayTeamId] isKindOfClass:[NSNull class]]){
		self.awayTeamId = [dictionary[kMatchDetailsAwayTeamId] integerValue];
	}

	if(![dictionary[kMatchDetailsAwayTeamLogoUrl] isKindOfClass:[NSNull class]]){
		self.awayTeamLogoUrl = dictionary[kMatchDetailsAwayTeamLogoUrl];
	}	
	if(![dictionary[kMatchDetailsAwayTeamName] isKindOfClass:[NSNull class]]){
		self.awayTeamName = dictionary[kMatchDetailsAwayTeamName];
	}	
	if(![dictionary[kMatchDetailsChampionshipId] isKindOfClass:[NSNull class]]){
		self.championshipId = [dictionary[kMatchDetailsChampionshipId] integerValue];
	}

	if(![dictionary[kMatchDetailsChampionshipName] isKindOfClass:[NSNull class]]){
		self.championshipName = dictionary[kMatchDetailsChampionshipName];
	}	
	if(![dictionary[kMatchDetailsCoverageTypeId] isKindOfClass:[NSNull class]]){
		self.coverageTypeId = [dictionary[kMatchDetailsCoverageTypeId] integerValue];
	}

	if(![dictionary[kMatchDetailsCoverageTypeName] isKindOfClass:[NSNull class]]){
		self.coverageTypeName = dictionary[kMatchDetailsCoverageTypeName];
	}	
	if(![dictionary[kMatchDetailsDate] isKindOfClass:[NSNull class]]){
		self.date = dictionary[kMatchDetailsDate];
	}	
	if(![dictionary[kMatchDetailsFinalAwayPenaltyScore] isKindOfClass:[NSNull class]]){
		self.finalAwayPenaltyScore = [dictionary[kMatchDetailsFinalAwayPenaltyScore] integerValue];
	}

	if(![dictionary[kMatchDetailsFinalAwayScore] isKindOfClass:[NSNull class]]){
		self.finalAwayScore = [dictionary[kMatchDetailsFinalAwayScore] integerValue];
	}

	if(![dictionary[kMatchDetailsFinalHomePenaltyScore] isKindOfClass:[NSNull class]]){
		self.finalHomePenaltyScore = [dictionary[kMatchDetailsFinalHomePenaltyScore] integerValue];
	}

	if(![dictionary[kMatchDetailsFinalHomeScore] isKindOfClass:[NSNull class]]){
		self.finalHomeScore = [dictionary[kMatchDetailsFinalHomeScore] integerValue];
	}

	if(![dictionary[kMatchDetailsHomeMatchId] isKindOfClass:[NSNull class]]){
		self.homeMatchId = [dictionary[kMatchDetailsHomeMatchId] integerValue];
	}	
	if(![dictionary[kMatchDetailsHomePenaltyScore] isKindOfClass:[NSNull class]]){
		self.homePenaltyScore = [dictionary[kMatchDetailsHomePenaltyScore] integerValue];
	}

	if(![dictionary[kMatchDetailsHomeScore] isKindOfClass:[NSNull class]]){
		self.homeScore = [dictionary[kMatchDetailsHomeScore] integerValue];
	}

	if(![dictionary[kMatchDetailsHomeTeamCoachId] isKindOfClass:[NSNull class]]){
		self.homeTeamCoachId = [dictionary[kMatchDetailsHomeTeamCoachId] integerValue];
	}

	if(![dictionary[kMatchDetailsHomeTeamCoachName] isKindOfClass:[NSNull class]]){
		self.homeTeamCoachName = dictionary[kMatchDetailsHomeTeamCoachName];
	}	
	if(![dictionary[kMatchDetailsHomeTeamFormationId] isKindOfClass:[NSNull class]]){
		self.homeTeamFormationId = [dictionary[kMatchDetailsHomeTeamFormationId] integerValue];
	}

	if(![dictionary[kMatchDetailsHomeTeamFormationName] isKindOfClass:[NSNull class]]){
		self.homeTeamFormationName = dictionary[kMatchDetailsHomeTeamFormationName];
	}	
	if(![dictionary[kMatchDetailsHomeTeamId] isKindOfClass:[NSNull class]]){
		self.homeTeamId = [dictionary[kMatchDetailsHomeTeamId] integerValue];
	}

	if(![dictionary[kMatchDetailsHomeTeamLogoUrl] isKindOfClass:[NSNull class]]){
		self.homeTeamLogoUrl = dictionary[kMatchDetailsHomeTeamLogoUrl];
	}	
	if(![dictionary[kMatchDetailsHomeTeamName] isKindOfClass:[NSNull class]]){
		self.homeTeamName = dictionary[kMatchDetailsHomeTeamName];
	}	
	if(![dictionary[kMatchDetailsIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchDetailsIdField] integerValue];
	}

	if(![dictionary[kMatchDetailsIsAwayMatch] isKindOfClass:[NSNull class]]){
		self.isAwayMatch = [dictionary[kMatchDetailsIsAwayMatch] boolValue];
	}

	if(![dictionary[kMatchDetailsIsDelayed] isKindOfClass:[NSNull class]]){
		self.isDelayed = [dictionary[kMatchDetailsIsDelayed] boolValue];
	}

	if(dictionary[kMatchDetailsMatchStatistics] != nil && [dictionary[kMatchDetailsMatchStatistics] isKindOfClass:[NSArray class]]){
		NSArray * matchStatisticsDictionaries = dictionary[kMatchDetailsMatchStatistics];
		NSMutableArray * matchStatisticsItems = [NSMutableArray array];
		for(NSDictionary * matchStatisticsDictionary in matchStatisticsDictionaries){
			MatchStatistic * matchStatisticsItem = [[MatchStatistic alloc] initWithDictionary:matchStatisticsDictionary];
			[matchStatisticsItems addObject:matchStatisticsItem];
		}
		self.matchStatistics = matchStatisticsItems;
	}
	if(dictionary[kMatchDetailsMatchStatusHistory] != nil && [dictionary[kMatchDetailsMatchStatusHistory] isKindOfClass:[NSArray class]]){
		NSArray * matchStatusHistoryDictionaries = dictionary[kMatchDetailsMatchStatusHistory];
		NSMutableArray * matchStatusHistoryItems = [NSMutableArray array];
		for(NSDictionary * matchStatusHistoryDictionary in matchStatusHistoryDictionaries){
			MatchStatusHistory * matchStatusHistoryItem = [[MatchStatusHistory alloc] initWithDictionary:matchStatusHistoryDictionary];
			[matchStatusHistoryItems addObject:matchStatusHistoryItem];
		}
		self.matchStatusHistory = matchStatusHistoryItems;
	}
	if(dictionary[kMatchDetailsMatchTeamsSquads] != nil && [dictionary[kMatchDetailsMatchTeamsSquads] isKindOfClass:[NSArray class]]){
		NSArray * matchTeamsSquadsDictionaries = dictionary[kMatchDetailsMatchTeamsSquads];
		NSMutableArray * matchTeamsSquadsItems = [NSMutableArray array];
		for(NSDictionary * matchTeamsSquadsDictionary in matchTeamsSquadsDictionaries){
			MatchTeamsSquad * matchTeamsSquadsItem = [[MatchTeamsSquad alloc] initWithDictionary:matchTeamsSquadsDictionary];
			[matchTeamsSquadsItems addObject:matchTeamsSquadsItem];
		}
		self.matchTeamsSquads = matchTeamsSquadsItems;
	}
	if(![dictionary[kMatchDetailsOrderInRound] isKindOfClass:[NSNull class]]){
		self.orderInRound = [dictionary[kMatchDetailsOrderInRound] integerValue];
	}	
	if(![dictionary[kMatchDetailsRefereeId] isKindOfClass:[NSNull class]]){
		self.refereeId = [dictionary[kMatchDetailsRefereeId] integerValue];
	}	
	if(![dictionary[kMatchDetailsRefereeName] isKindOfClass:[NSNull class]]){
		self.refereeName = dictionary[kMatchDetailsRefereeName];
	}	
	if(![dictionary[kMatchDetailsRoundId] isKindOfClass:[NSNull class]]){
		self.roundId = [dictionary[kMatchDetailsRoundId] integerValue];
	}
    if(![dictionary[kMatchDetailsGroupId] isKindOfClass:[NSNull class]]){
        self.groupId = [dictionary[kMatchDetailsGroupId] integerValue];
    }
	if(![dictionary[kMatchDetailsRoundIsGroups] isKindOfClass:[NSNull class]]){
		self.roundIsGroups = [dictionary[kMatchDetailsRoundIsGroups] boolValue];
	}

	if(![dictionary[kMatchDetailsRoundName] isKindOfClass:[NSNull class]]){
		self.roundName = dictionary[kMatchDetailsRoundName];
	}	
	if(![dictionary[kMatchDetailsRoundOrder] isKindOfClass:[NSNull class]]){
		self.roundOrder = [dictionary[kMatchDetailsRoundOrder] integerValue];
	}

	if(![dictionary[kMatchDetailsStadiumId] isKindOfClass:[NSNull class]]){
		self.stadiumId = [dictionary[kMatchDetailsStadiumId] integerValue];
	}

	if(![dictionary[kMatchDetailsStadiumName] isKindOfClass:[NSNull class]]){
		self.stadiumName = dictionary[kMatchDetailsStadiumName];
	}	
    if(dictionary[kMatchDetailsTvCoverage] != nil && [dictionary[kMatchDetailsTvCoverage] isKindOfClass:[NSArray class]]){
        NSArray * tvCoverageDictionaries = dictionary[kMatchDetailsTvCoverage];
        NSMutableArray * tvCoverageItems = [NSMutableArray array];
        for(NSDictionary * tvCoverageDictionary in tvCoverageDictionaries){
            TvCoverage * tvCoverageItem = [[TvCoverage alloc] initWithDictionary:tvCoverageDictionary];
            [tvCoverageItems addObject:tvCoverageItem];
        }
        self.tvCoverage = tvCoverageItems;
    }
	if(![dictionary[kMatchDetailsWeek] isKindOfClass:[NSNull class]]){
		self.week = [dictionary[kMatchDetailsWeek] integerValue];
	}
    ///////// Convert ISO Date to NSDate and setting match date and "time" values
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    //[formatter setLocale:[NSLocale currentLocale]];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    //Match Time with cairo time offset (+2)
    int offset;
    if([[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]==nil)
    {
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
        offset=[[defaults objectForKey:TIME_OFFSET]intValue];
    }
  else
  offset = [[[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]intValue];
    NSDate * datePlusTimeOffest = [[formatter dateFromString:self.date] dateByAddingTimeInterval:60*60*offset];
    [outputFormatter setLocale:usLocale];
    self.dateStr = [outputFormatter stringFromDate:datePlusTimeOffest];
    [outputFormatter setDateFormat:@"HH:mm"];
    self.time=[outputFormatter stringFromDate:datePlusTimeOffest];
    
    NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
    [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dtfrm setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ar"]];
    [dtfrm setDateFormat:@"EEEE dd MMMM yyyy"];
    // [dtfrm setDateStyle:NSDateFormatterLongStyle];
    self.longDateStr = [dtfrm stringFromDate:datePlusTimeOffest];
    
	return self;
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.awayPenaltyScore) forKey:kMatchDetailsAwayPenaltyScore];
    [aCoder encodeObject:@(self.awayScore) forKey:kMatchDetailsAwayScore];
    [aCoder encodeObject:@(self.awayTeamId) forKey:kMatchDetailsAwayTeamId];
    if(self.awayTeamName != nil){
        [aCoder encodeObject:self.awayTeamName forKey:kMatchDetailsAwayTeamName];
    }

    [aCoder encodeObject:@(self.championshipId) forKey:kMatchDetailsChampionshipId];
    if(self.championshipName != nil){
        [aCoder encodeObject:self.championshipName forKey:kMatchDetailsChampionshipName];
    }

    if(self.date != nil){
        [aCoder encodeObject:self.date forKey:kMatchDetailsDate];
    }
    [aCoder encodeObject:@(self.homePenaltyScore) forKey:kMatchDetailsHomePenaltyScore];

    [aCoder encodeObject:@(self.homeScore) forKey:kMatchDetailsHomeScore];    [aCoder encodeObject:@(self.homeTeamId) forKey:kMatchDetailsHomeTeamId];    if(self.homeTeamName != nil){
        [aCoder encodeObject:self.homeTeamName forKey:kMatchDetailsHomeTeamName];
    }

    [aCoder encodeObject:@(self.idField) forKey:kMatchDetailsIdField];
    if(self.matchStatusHistory != nil){
        [aCoder encodeObject:self.matchStatusHistory forKey:kMatchDetailsMatchStatusHistory];
    }
    if(self.roundName != nil){
        [aCoder encodeObject:self.roundName forKey:kMatchDetailsRoundName];
    }
    [aCoder encodeObject:@(self.week) forKey:kMatchDetailsWeek];


    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.awayPenaltyScore = [[aDecoder decodeObjectForKey:kMatchDetailsAwayPenaltyScore] integerValue];
    self.awayScore = [[aDecoder decodeObjectForKey:kMatchDetailsAwayScore] integerValue];
    self.awayTeamId = [[aDecoder decodeObjectForKey:kMatchDetailsAwayTeamId] integerValue];
    self.awayTeamName = [aDecoder decodeObjectForKey:kMatchDetailsAwayTeamName];
    //self.awayTeamSlug = [aDecoder decodeObjectForKey:kMatchDetailsAwayTeamSlug];
    self.championshipId = [[aDecoder decodeObjectForKey:kMatchDetailsChampionshipId] integerValue];
    self.championshipName = [aDecoder decodeObjectForKey:kMatchDetailsChampionshipName];
   // self.championshipSlug = [aDecoder decodeObjectForKey:kMatchDetailsChampionshipSlug];
    self.date = [aDecoder decodeObjectForKey:kMatchDetailsDate];
    self.homePenaltyScore = [[aDecoder decodeObjectForKey:kMatchDetailsHomePenaltyScore] integerValue];
    self.homeScore = [[aDecoder decodeObjectForKey:kMatchDetailsHomeScore] integerValue];
    self.homeTeamId = [[aDecoder decodeObjectForKey:kMatchDetailsHomeTeamId] integerValue];
    self.homeTeamName = [aDecoder decodeObjectForKey:kMatchDetailsHomeTeamName];
   // self.homeTeamSlug = [aDecoder decodeObjectForKey:kMatchDetailsHomeTeamSlug];
    self.idField = [[aDecoder decodeObjectForKey:kMatchDetailsIdField] integerValue];
    self.matchStatusHistory = [aDecoder decodeObjectForKey:kMatchDetailsMatchStatusHistory];
   // self.orderInDay = [[aDecoder decodeObjectForKey:kMatchDetailsOrderInDay] integerValue];
    self.roundName = [aDecoder decodeObjectForKey:kMatchDetailsRoundName];
    //self.slug = [aDecoder decodeObjectForKey:kMatchDetailsSlug];
    self.week = [[aDecoder decodeObjectForKey:kMatchDetailsWeek] integerValue];
    return self;
    
}

@end
