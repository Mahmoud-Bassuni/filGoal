//
//  Info.m
//
//  Created by MacBookPro  on 5/21/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Info.h"


@interface Info ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Info

@synthesize club1Id = _club1Id;
@synthesize time = _time;
@synthesize champLogo = _champLogo;
@synthesize sClubScorePen = _sClubScorePen;
@synthesize fACoachName = _fACoachName;
@synthesize sClubLogo = _sClubLogo;
@synthesize sClubScoreResult = _sClubScoreResult;
@synthesize sACoachName = _sACoachName;
@synthesize fClubLogo = _fClubLogo;
@synthesize sClubScoreLive = _sClubScoreLive;
@synthesize statusId = _statusId;
@synthesize champName = _champName;
@synthesize fClubScoreLive = _fClubScoreLive;
@synthesize date = _date;
@synthesize sClubName = _sClubName;
@synthesize formattedDate = _formattedDate;
@synthesize numOfLiveMatches = _numOfLiveMatches;
@synthesize fClubScoreResult = _fClubScoreResult;
@synthesize champid = _champid;
@synthesize fClubScorePen = _fClubScorePen;
@synthesize iDProperty = _iDProperty;
@synthesize matchStatus = _matchStatus;
@synthesize club2Id = _club2Id;
@synthesize isLive = _isLive;
@synthesize championshipsNumOfMatches = _championshipsNumOfMatches;
@synthesize fClubName = _fClubName;
@synthesize place = _place;


+ (Info *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Info *instance = [[Info alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.club1Id = [[dict objectForKey:@"club1Id"] doubleValue];
            self.time = [self objectOrNilForKey:@"Time" fromDictionary:dict];
            self.champLogo = [self objectOrNilForKey:@"ChampLogo" fromDictionary:dict];
            self.sClubScorePen = [self objectOrNilForKey:@"SClubScorePen" fromDictionary:dict];
            self.fACoachName = [self objectOrNilForKey:@"FACoachName" fromDictionary:dict];
            self.sClubLogo = [self objectOrNilForKey:@"SClubLogo" fromDictionary:dict];
            self.sClubScoreResult = [[dict objectForKey:@"SClubScoreResult"] doubleValue];
            self.sACoachName = [self objectOrNilForKey:@"SACoachName" fromDictionary:dict];
            self.fClubLogo = [self objectOrNilForKey:@"FClubLogo" fromDictionary:dict];
            self.sClubScoreLive = [[dict objectForKey:@"SClubScoreLive"] doubleValue];
            self.statusId = [[dict objectForKey:@"statusId"] doubleValue];
            self.champName = [self objectOrNilForKey:@"ChampName" fromDictionary:dict];
            self.fClubScoreLive = [[dict objectForKey:@"FClubScoreLive"] doubleValue];
            self.date = [self objectOrNilForKey:@"Date" fromDictionary:dict];
            self.sClubName = [self objectOrNilForKey:@"SClubName" fromDictionary:dict];
            self.formattedDate = [self objectOrNilForKey:@"FormattedDate" fromDictionary:dict];
            self.numOfLiveMatches = [self objectOrNilForKey:@"NumOfLiveMatches" fromDictionary:dict];
            self.fClubScoreResult = [[dict objectForKey:@"FClubScoreResult"] doubleValue];
            self.champid = [[dict objectForKey:@"Champid"] doubleValue];
            self.fClubScorePen = [self objectOrNilForKey:@"FClubScorePen" fromDictionary:dict];
            self.iDProperty = [[dict objectForKey:@"ID"] doubleValue];
            self.matchStatus = [self objectOrNilForKey:@"MatchStatus" fromDictionary:dict];
            self.club2Id = [[dict objectForKey:@"club2Id"] doubleValue];
            self.isLive = [[dict objectForKey:@"isLive"] boolValue];
            self.championshipsNumOfMatches = [self objectOrNilForKey:@"ChampionshipsNumOfMatches" fromDictionary:dict];
            self.fClubName = [self objectOrNilForKey:@"FClubName" fromDictionary:dict];
            self.place = [self objectOrNilForKey:@"Place" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.club1Id] forKey:@"club1Id"];
    [mutableDict setValue:self.time forKey:@"Time"];
    [mutableDict setValue:self.champLogo forKey:@"ChampLogo"];
    [mutableDict setValue:self.sClubScorePen forKey:@"SClubScorePen"];
    [mutableDict setValue:self.fACoachName forKey:@"FACoachName"];
    [mutableDict setValue:self.sClubLogo forKey:@"SClubLogo"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sClubScoreResult] forKey:@"SClubScoreResult"];
    [mutableDict setValue:self.sACoachName forKey:@"SACoachName"];
    [mutableDict setValue:self.fClubLogo forKey:@"FClubLogo"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sClubScoreLive] forKey:@"SClubScoreLive"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.statusId] forKey:@"statusId"];
    [mutableDict setValue:self.champName forKey:@"ChampName"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fClubScoreLive] forKey:@"FClubScoreLive"];
    [mutableDict setValue:self.date forKey:@"Date"];
    [mutableDict setValue:self.sClubName forKey:@"SClubName"];
    [mutableDict setValue:self.formattedDate forKey:@"FormattedDate"];
    [mutableDict setValue:self.numOfLiveMatches forKey:@"NumOfLiveMatches"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fClubScoreResult] forKey:@"FClubScoreResult"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.champid] forKey:@"Champid"];
    [mutableDict setValue:self.fClubScorePen forKey:@"FClubScorePen"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:@"ID"];
    [mutableDict setValue:self.matchStatus forKey:@"MatchStatus"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.club2Id] forKey:@"club2Id"];
    [mutableDict setValue:[NSNumber numberWithBool:self.isLive] forKey:@"isLive"];
    [mutableDict setValue:self.championshipsNumOfMatches forKey:@"ChampionshipsNumOfMatches"];
    [mutableDict setValue:self.fClubName forKey:@"FClubName"];
    [mutableDict setValue:self.place forKey:@"Place"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.club1Id = [aDecoder decodeDoubleForKey:@"club1Id"];
    self.time = [aDecoder decodeObjectForKey:@"time"];
    self.champLogo = [aDecoder decodeObjectForKey:@"champLogo"];
    self.sClubScorePen = [aDecoder decodeObjectForKey:@"sClubScorePen"];
    self.fACoachName = [aDecoder decodeObjectForKey:@"fACoachName"];
    self.sClubLogo = [aDecoder decodeObjectForKey:@"sClubLogo"];
    self.sClubScoreResult = [aDecoder decodeDoubleForKey:@"sClubScoreResult"];
    self.sACoachName = [aDecoder decodeObjectForKey:@"sACoachName"];
    self.fClubLogo = [aDecoder decodeObjectForKey:@"fClubLogo"];
    self.sClubScoreLive = [aDecoder decodeDoubleForKey:@"sClubScoreLive"];
    self.statusId = [aDecoder decodeDoubleForKey:@"statusId"];
    self.champName = [aDecoder decodeObjectForKey:@"champName"];
    self.fClubScoreLive = [aDecoder decodeDoubleForKey:@"fClubScoreLive"];
    self.date = [aDecoder decodeObjectForKey:@"date"];
    self.sClubName = [aDecoder decodeObjectForKey:@"sClubName"];
    self.formattedDate = [aDecoder decodeObjectForKey:@"formattedDate"];
    self.numOfLiveMatches = [aDecoder decodeObjectForKey:@"numOfLiveMatches"];
    self.fClubScoreResult = [aDecoder decodeDoubleForKey:@"fClubScoreResult"];
    self.champid = [aDecoder decodeDoubleForKey:@"champid"];
    self.fClubScorePen = [aDecoder decodeObjectForKey:@"fClubScorePen"];
    self.iDProperty = [aDecoder decodeDoubleForKey:@"iDProperty"];
    self.matchStatus = [aDecoder decodeObjectForKey:@"matchStatus"];
    self.club2Id = [aDecoder decodeDoubleForKey:@"club2Id"];
    self.isLive = [aDecoder decodeBoolForKey:@"isLive"];
    self.championshipsNumOfMatches = [aDecoder decodeObjectForKey:@"championshipsNumOfMatches"];
    self.fClubName = [aDecoder decodeObjectForKey:@"fClubName"];
    self.place = [aDecoder decodeObjectForKey:@"place"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_club1Id forKey:@"club1Id"];
    [aCoder encodeObject:_time forKey:@"time"];
    [aCoder encodeObject:_champLogo forKey:@"champLogo"];
    [aCoder encodeObject:_sClubScorePen forKey:@"sClubScorePen"];
    [aCoder encodeObject:_fACoachName forKey:@"fACoachName"];
    [aCoder encodeObject:_sClubLogo forKey:@"sClubLogo"];
    [aCoder encodeDouble:_sClubScoreResult forKey:@"sClubScoreResult"];
    [aCoder encodeObject:_sACoachName forKey:@"sACoachName"];
    [aCoder encodeObject:_fClubLogo forKey:@"fClubLogo"];
    [aCoder encodeDouble:_sClubScoreLive forKey:@"sClubScoreLive"];
    [aCoder encodeDouble:_statusId forKey:@"statusId"];
    [aCoder encodeObject:_champName forKey:@"champName"];
    [aCoder encodeDouble:_fClubScoreLive forKey:@"fClubScoreLive"];
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeObject:_sClubName forKey:@"sClubName"];
    [aCoder encodeObject:_formattedDate forKey:@"formattedDate"];
    [aCoder encodeObject:_numOfLiveMatches forKey:@"numOfLiveMatches"];
    [aCoder encodeDouble:_fClubScoreResult forKey:@"fClubScoreResult"];
    [aCoder encodeDouble:_champid forKey:@"champid"];
    [aCoder encodeObject:_fClubScorePen forKey:@"fClubScorePen"];
    [aCoder encodeDouble:_iDProperty forKey:@"iDProperty"];
    [aCoder encodeObject:_matchStatus forKey:@"matchStatus"];
    [aCoder encodeDouble:_club2Id forKey:@"club2Id"];
    [aCoder encodeBool:_isLive forKey:@"isLive"];
    [aCoder encodeObject:_championshipsNumOfMatches forKey:@"championshipsNumOfMatches"];
    [aCoder encodeObject:_fClubName forKey:@"fClubName"];
    [aCoder encodeObject:_place forKey:@"place"];
}


@end
