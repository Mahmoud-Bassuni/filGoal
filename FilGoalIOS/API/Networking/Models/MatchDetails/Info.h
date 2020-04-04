//
//  Info.h
//
//  Created by MacBookPro  on 5/21/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Info : NSObject <NSCoding>

@property (nonatomic, assign) double club1Id;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *champLogo;
@property (nonatomic, assign) id sClubScorePen;
@property (nonatomic, retain) NSString *fACoachName;
@property (nonatomic, retain) NSString *sClubLogo;
@property (nonatomic, assign) double sClubScoreResult;
@property (nonatomic, retain) NSString *sACoachName;
@property (nonatomic, retain) NSString *fClubLogo;
@property (nonatomic, assign) double sClubScoreLive;
@property (nonatomic, assign) double statusId;
@property (nonatomic, retain) NSString *champName;
@property (nonatomic, assign) double fClubScoreLive;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *sClubName;
@property (nonatomic, retain) NSString *formattedDate;
@property (nonatomic, assign) id numOfLiveMatches;
@property (nonatomic, assign) double fClubScoreResult;
@property (nonatomic, assign) double champid;
@property (nonatomic, assign) id fClubScorePen;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, retain) NSString *matchStatus;
@property (nonatomic, assign) double club2Id;
@property (nonatomic, assign) BOOL isLive;
@property (nonatomic, assign) id championshipsNumOfMatches;
@property (nonatomic, retain) NSString *fClubName;
@property (nonatomic, retain) NSString *place;

+ (Info *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
