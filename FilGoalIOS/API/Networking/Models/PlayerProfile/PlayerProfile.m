//
//	PlayerProfile.m
//
//	Create by Nada Gamal on 16/8/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PlayerProfile.h"

NSString *const kPlayerProfileAge = @"Age";
NSString *const kPlayerProfileAlbums = @"Albums";
NSString *const kPlayerProfileBirthDate = @"BirthDate";
NSString *const kPlayerProfileGoals = @"Goals";
NSString *const kPlayerProfileIdField = @"Id";
NSString *const kPlayerProfileNews = @"News";
NSString *const kPlayerProfilePlayerPic = @"PlayerPic";
NSString *const kPlayerProfileRCards = @"RCards";
NSString *const kPlayerProfileTShirtNo = @"TShirtNo";
NSString *const kPlayerProfileVideos = @"Videos";
NSString *const kPlayerProfileYCards = @"YCards";
NSString *const kPlayerProfileClub = @"club";
NSString *const kPlayerProfileCountry = @"country";
NSString *const kPlayerProfileCountryId = @"countryId";
NSString *const kPlayerProfileName = @"name";
NSString *const kPlayerProfileNickname = @"nickname";
NSString *const kPlayerProfilePosition = @"position";
NSString *const kPlayerProfileProfile = @"profile";

@interface PlayerProfile ()
@end
@implementation PlayerProfile




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPlayerProfileAge] isKindOfClass:[NSNull class]]){
		self.age = [dictionary[kPlayerProfileAge] integerValue];
	}

	if(dictionary[kPlayerProfileAlbums] != nil && [dictionary[kPlayerProfileAlbums] isKindOfClass:[NSArray class]]){
		NSArray * albumsDictionaries = dictionary[kPlayerProfileAlbums];
		NSMutableArray * albumsItems = [NSMutableArray array];
		for(NSDictionary * albumsDictionary in albumsDictionaries){
			Album * albumsItem = [[Album alloc] initWithDictionary:albumsDictionary];
			[albumsItems addObject:albumsItem];
		}
		self.albums = albumsItems;
	}
	if(![dictionary[kPlayerProfileBirthDate] isKindOfClass:[NSNull class]]){
		self.birthDate = dictionary[kPlayerProfileBirthDate];
	}	
	if(![dictionary[kPlayerProfileGoals] isKindOfClass:[NSNull class]]){
		self.goals = [dictionary[kPlayerProfileGoals] integerValue];
	}

	if(![dictionary[kPlayerProfileIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kPlayerProfileIdField] integerValue];
	}

	if(dictionary[kPlayerProfileNews] != nil && [dictionary[kPlayerProfileNews] isKindOfClass:[NSArray class]]){
		NSArray * newsDictionaries = dictionary[kPlayerProfileNews];
		NSMutableArray * newsItems = [NSMutableArray array];
		for(NSDictionary * newsDictionary in newsDictionaries){
			NewsItem * newsItem = [[NewsItem alloc] initWithDictionary:newsDictionary];
			[newsItems addObject:newsItem];
		}
		self.news = newsItems;
	}
	if(![dictionary[kPlayerProfilePlayerPic] isKindOfClass:[NSNull class]]){
		self.playerPic = dictionary[kPlayerProfilePlayerPic];
	}	
	if(![dictionary[kPlayerProfileRCards] isKindOfClass:[NSNull class]]){
		self.rCards = [dictionary[kPlayerProfileRCards] integerValue];
	}

	if(![dictionary[kPlayerProfileTShirtNo] isKindOfClass:[NSNull class]]){
		self.tShirtNo = [dictionary[kPlayerProfileTShirtNo] integerValue];
	}

	if(dictionary[kPlayerProfileVideos] != nil && [dictionary[kPlayerProfileVideos] isKindOfClass:[NSArray class]]){
		NSArray * videosDictionaries = dictionary[kPlayerProfileVideos];
		NSMutableArray * videosItems = [NSMutableArray array];
		for(NSDictionary * videosDictionary in videosDictionaries){
			VideoItem * videosItem = [[VideoItem alloc] initWithDictionary:videosDictionary];
			[videosItems addObject:videosItem];
		}
		self.videos = videosItems;
	}
	if(![dictionary[kPlayerProfileYCards] isKindOfClass:[NSNull class]]){
		self.yCards = [dictionary[kPlayerProfileYCards] integerValue];
	}

	if(![dictionary[kPlayerProfileClub] isKindOfClass:[NSNull class]]){
		self.club = dictionary[kPlayerProfileClub];
	}	
	if(![dictionary[kPlayerProfileCountry] isKindOfClass:[NSNull class]]){
		self.country = dictionary[kPlayerProfileCountry];
	}	
	if(![dictionary[kPlayerProfileCountryId] isKindOfClass:[NSNull class]]){
		self.countryId = [dictionary[kPlayerProfileCountryId] integerValue];
	}

	if(![dictionary[kPlayerProfileName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kPlayerProfileName];
	}	
	if(![dictionary[kPlayerProfileNickname] isKindOfClass:[NSNull class]]){
		self.nickname = dictionary[kPlayerProfileNickname];
	}	
	if(![dictionary[kPlayerProfilePosition] isKindOfClass:[NSNull class]]){
		self.position = dictionary[kPlayerProfilePosition];
	}	
	if(![dictionary[kPlayerProfileProfile] isKindOfClass:[NSNull class]]){
		self.profile = dictionary[kPlayerProfileProfile];
	}	
	return self;
}
@end
