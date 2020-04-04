//
//	Player.m
//
//	Create by Nada Gamal on 25/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Player.h"

NSString *const kPlayerBio = @"bio";
NSString *const kPlayerCareerData = @"careerData";
NSString *const kPlayerCountryId = @"countryId";
NSString *const kPlayerCountryName = @"countryName";
NSString *const kPlayerDateOfBirth = @"dateOfBirth";
NSString *const kPlayerFacebook = @"facebook";
NSString *const kPlayerIdField = @"id";
NSString *const kPlayerInstagram = @"instagram";
NSString *const kPlayerName = @"name";
NSString *const kPlayerNationalities = @"nationalities";
NSString *const kPlayerNickName = @"nickName";
NSString *const kPlayerShortName = @"shortName";
NSString *const kPlayerSlug = @"slug";
NSString *const kPlayerSnapChat = @"snapChat";
NSString *const kPlayerTwitter = @"twitter";
NSString *const kPlayerPositionId = @"playerPositionId";

NSString *const kkPlayerName = @"playerName";
NSString *const kkPlayerShirtNumber = @"shirtNumber";
NSString *const kkPlayerPositionName = @"playerPositionName";

NSString *const kkPlayerIdField = @"playerId";


@interface Player ()
@end
@implementation Player
@synthesize playerId = _playerId;
@synthesize clubId = _clubId;
@synthesize playerPicture = _playerPicture;
@synthesize champID = _champID;
@synthesize aClubName = _aClubName;
@synthesize champname = _champname;
@synthesize clubLogo = _clubLogo;
@synthesize aName = _aName;
@synthesize goals = _goals;



/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPlayerBio] isKindOfClass:[NSNull class]]){
		self.bio = dictionary[kPlayerBio];
	}	
	if(dictionary[kPlayerCareerData] != nil && [dictionary[kPlayerCareerData] isKindOfClass:[NSArray class]]){
		NSArray * careerDataDictionaries = dictionary[kPlayerCareerData];
		NSMutableArray * careerDataItems = [NSMutableArray array];
		for(NSDictionary * careerDataDictionary in careerDataDictionaries){
			CareerData * careerDataItem = [[CareerData alloc] initWithDictionary:careerDataDictionary];
			[careerDataItems addObject:careerDataItem];
		}
		self.careerData = careerDataItems;
	}
	if(![dictionary[kPlayerCountryId] isKindOfClass:[NSNull class]]){
		self.countryId = [dictionary[kPlayerCountryId] integerValue];
	}
    if(![dictionary[kPlayerPositionId] isKindOfClass:[NSNull class]]){
        self.playerPositionId = [dictionary[kPlayerPositionId] integerValue];
    }
	if(![dictionary[kPlayerCountryName] isKindOfClass:[NSNull class]]){
		self.countryName = dictionary[kPlayerCountryName];
	}	
	if(![dictionary[kPlayerDateOfBirth] isKindOfClass:[NSNull class]]){
		self.dateOfBirth = dictionary[kPlayerDateOfBirth];
	}	
	if(![dictionary[kPlayerFacebook] isKindOfClass:[NSNull class]]){
		self.facebook = dictionary[kPlayerFacebook];
	}	
	if(![dictionary[kPlayerIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kPlayerIdField] integerValue];
	}

	if(![dictionary[kPlayerInstagram] isKindOfClass:[NSNull class]]){
		self.instagram = dictionary[kPlayerInstagram];
	}	
	if(![dictionary[kPlayerName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kPlayerName];
	}
    if(![dictionary[kkPlayerName] isKindOfClass:[NSNull class]]){
        self.playerName = dictionary[kkPlayerName];
    }
	if(![dictionary[kPlayerNationalities] isKindOfClass:[NSNull class]]){
		self.nationalities = dictionary[kPlayerNationalities];
	}	
	if(![dictionary[kPlayerNickName] isKindOfClass:[NSNull class]]){
		self.nickName = dictionary[kPlayerNickName];
	}	
	if(![dictionary[kPlayerShortName] isKindOfClass:[NSNull class]]){
		self.shortName = dictionary[kPlayerShortName];
	}	
	if(![dictionary[kPlayerSlug] isKindOfClass:[NSNull class]]){
		self.slug = dictionary[kPlayerSlug];
	}	
	if(![dictionary[kPlayerSnapChat] isKindOfClass:[NSNull class]]){
		self.snapChat = dictionary[kPlayerSnapChat];
	}	
	if(![dictionary[kPlayerTwitter] isKindOfClass:[NSNull class]]){
		self.twitter = dictionary[kPlayerTwitter];
	}
    if(![dictionary[kkPlayerShirtNumber] isKindOfClass:[NSNull class]]){
    self.shirtNumber = [[dictionary objectForKey:kkPlayerShirtNumber] intValue];
    }

    if(![dictionary[kkPlayerPositionName] isKindOfClass:[NSNull class]]){
        self.positionName = dictionary[kkPlayerPositionName];
    }
    ///////// Convert ISO Date to NSDate and setting match date and time values
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
   // [formatter setLocale:[NSLocale currentLocale]];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDate * date = [formatter dateFromString:self.dateOfBirth];
    self.dateOfBirth = [outputFormatter stringFromDate:date];
    // old scorers model
    self.playerId = [[dictionary objectForKey:@"PlayerId"] intValue];
    self.playerIdd = [[dictionary objectForKey:kkPlayerIdField] intValue];

    self.clubId = [[dictionary objectForKey:@"ClubId"] intValue];
    self.playerPicture = [self objectOrNilForKey:@"PlayerPicture" fromDictionary:dictionary];
    self.champID = [[dictionary objectForKey:@"ChampID"] intValue];
    self.aClubName = [self objectOrNilForKey:@"AClubName" fromDictionary:dictionary];
    self.champname = [self objectOrNilForKey:@"Champname" fromDictionary:dictionary];
    self.clubLogo = [self objectOrNilForKey:@"ClubLogo" fromDictionary:dictionary];
    self.aName = [self objectOrNilForKey:@"AName" fromDictionary:dictionary];
    self.goals = [[dictionary objectForKey:@"Goals"] intValue];
    if(self.careerData.count>1)
    {
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"from"
                                                                    ascending: NO];
       self.careerData = [self.careerData sortedArrayUsingDescriptors:@[sortOrder]];
    }
    
	return self;
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
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithInt:self.playerId] forKey:@"PlayerId"];
    [mutableDict setValue:[NSNumber numberWithInt:self.clubId] forKey:@"ClubId"];
    [mutableDict setValue:self.playerPicture forKey:@"PlayerPicture"];
    [mutableDict setValue:[NSNumber numberWithInt:self.champID] forKey:@"ChampID"];
    [mutableDict setValue:self.aClubName forKey:@"AClubName"];
    [mutableDict setValue:self.champname forKey:@"Champname"];
    [mutableDict setValue:self.clubLogo forKey:@"ClubLogo"];
    [mutableDict setValue:self.aName forKey:@"AName"];
    [mutableDict setValue:[NSNumber numberWithInt:self.goals] forKey:@"Goals"];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}
@end
