//
//	MatchDetails.h
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "MatchStatistic.h"
#import "MatchStatusHistory.h"
#import "MatchTeamsSquad.h"

@interface MatchCenterDetails : NSObject

@property (nonatomic, assign) NSInteger awayMatchId;
@property (nonatomic, assign) NSInteger awayPenaltyScore;
@property (nonatomic, assign) NSInteger awayScore;
@property (nonatomic, assign) NSInteger awayTeamCoachId;
@property (nonatomic, strong) NSString * awayTeamCoachName;
@property (nonatomic, assign) NSInteger awayTeamFormationId;
@property (nonatomic, strong) NSString * awayTeamFormationName;
@property (nonatomic, assign) NSInteger awayTeamId;
@property (nonatomic, strong) NSString * awayTeamLogoUrl;
@property (nonatomic, strong) NSString * awayTeamName;
@property (nonatomic, assign) NSInteger championshipId;
@property (nonatomic, strong) NSString * championshipName;
@property (nonatomic, assign) NSInteger coverageTypeId;
@property (nonatomic, strong) NSString * coverageTypeName;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSString * dateStr;
@property (nonatomic, strong) NSString * longDateStr;
@property (nonatomic, assign) NSInteger finalAwayPenaltyScore;
@property (nonatomic, assign) NSInteger finalAwayScore;
@property (nonatomic, assign) NSInteger finalHomePenaltyScore;
@property (nonatomic, assign) NSInteger finalHomeScore;
@property (nonatomic, assign) NSInteger homeMatchId;
@property (nonatomic, assign) NSInteger homePenaltyScore;
@property (nonatomic, assign) NSInteger homeScore;
@property (nonatomic, assign) NSInteger homeTeamCoachId;
@property (nonatomic, strong) NSString * homeTeamCoachName;
@property (nonatomic, assign) NSInteger homeTeamFormationId;
@property (nonatomic, strong) NSString * homeTeamFormationName;
@property (nonatomic, assign) NSInteger homeTeamId;
@property (nonatomic, strong) NSString * homeTeamLogoUrl;
@property (nonatomic, strong) NSString * homeTeamName;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isAwayMatch;
@property (nonatomic, assign) BOOL isDelayed;
@property (nonatomic, strong) NSArray * matchStatistics;
@property (nonatomic, strong) NSArray * matchStatusHistory;
@property (nonatomic, strong) NSArray * matchTeamsSquads;
@property (nonatomic, assign) NSInteger  orderInRound;
@property (nonatomic, assign) NSInteger refereeId;
@property (nonatomic, strong) NSString * refereeName;
@property (nonatomic, assign) NSInteger roundId;
@property (nonatomic, assign) NSInteger groupId;

@property (nonatomic, assign) BOOL roundIsGroups;
@property (nonatomic, strong) NSString * roundName;
@property (nonatomic, assign) NSInteger roundOrder;
@property (nonatomic, assign) NSInteger stadiumId;
@property (nonatomic, strong) NSString * stadiumName;
@property (nonatomic, strong) NSArray * tvCoverage;
@property (nonatomic, assign) NSInteger  week;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, assign) NSInteger  championOrder;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
