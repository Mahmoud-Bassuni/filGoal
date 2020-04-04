//
//	PerContentTypeSponsor.m
//
//	Create by Nada Gamal on 27/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PerContentTypeSponsor.h"

NSString *const kPerContentTypeSponsorIsAlbumsActive = @"isAlbumsActive";
NSString *const kPerContentTypeSponsorIsFreeOpinionsActive = @"isFreeOpinionsActive";
NSString *const kPerContentTypeSponsorIsMatchesActive = @"isMatchesActive";
NSString *const kPerContentTypeSponsorIsNewsActive = @"isNewsActive";
NSString *const kPerContentTypeSponsorIsVideosActive = @"isVideosActive";

NSString *const kPerContentTypeSponsorNewsUrl = @"newsUrl";
NSString *const kPerContentTypeSponsorVideosUrl = @"videosUrl";
NSString *const kPerContentTypeSponsorAlbumsUrl = @"albumsUrl";
NSString *const kPerContentTypeSponsorMatchesUrl = @"matchesUrl";
NSString *const kPerContentTypeSponsorFreeOpinionsUrl = @"freeOpinionsUrl";

@interface PerContentTypeSponsor ()
@end
@implementation PerContentTypeSponsor


/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    //Bool
	if(![dictionary[kPerContentTypeSponsorIsAlbumsActive] isKindOfClass:[NSNull class]]){
		self.isAlbumsActive = [dictionary[kPerContentTypeSponsorIsAlbumsActive] boolValue];
	}
	if(![dictionary[kPerContentTypeSponsorIsFreeOpinionsActive] isKindOfClass:[NSNull class]]){
		self.isFreeOpinionsActive = [dictionary[kPerContentTypeSponsorIsFreeOpinionsActive] boolValue];
	}
	if(![dictionary[kPerContentTypeSponsorIsMatchesActive] isKindOfClass:[NSNull class]]){
		self.isMatchesActive = [dictionary[kPerContentTypeSponsorIsMatchesActive] boolValue];
	}
	if(![dictionary[kPerContentTypeSponsorIsNewsActive] isKindOfClass:[NSNull class]]){
		self.isNewsActive = [dictionary[kPerContentTypeSponsorIsNewsActive] boolValue];
	}
	if(![dictionary[kPerContentTypeSponsorIsVideosActive] isKindOfClass:[NSNull class]]){
		self.isVideosActive = [dictionary[kPerContentTypeSponsorIsVideosActive] boolValue];
	}
    
    //Urls
    if(![dictionary[kPerContentTypeSponsorNewsUrl] isKindOfClass:[NSNull class]]){
        self.newsUrl = dictionary[kPerContentTypeSponsorNewsUrl];
    }
    if(![dictionary[kPerContentTypeSponsorVideosUrl] isKindOfClass:[NSNull class]]){
        self.videosUrl = dictionary[kPerContentTypeSponsorVideosUrl];
    }
    if(![dictionary[kPerContentTypeSponsorAlbumsUrl] isKindOfClass:[NSNull class]]){
        self.albumsUrl = dictionary[kPerContentTypeSponsorAlbumsUrl];
    }
    if(![dictionary[kPerContentTypeSponsorMatchesUrl] isKindOfClass:[NSNull class]]){
        self.matchesUrl = dictionary[kPerContentTypeSponsorMatchesUrl];
    }
    if(![dictionary[kPerContentTypeSponsorFreeOpinionsUrl] isKindOfClass:[NSNull class]]){
        self.freeOpinionsUrl = dictionary[kPerContentTypeSponsorFreeOpinionsUrl];
    }
    
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    //Bool
	dictionary[kPerContentTypeSponsorIsAlbumsActive] = @(self.isAlbumsActive);
	dictionary[kPerContentTypeSponsorIsFreeOpinionsActive] = @(self.isFreeOpinionsActive);
	dictionary[kPerContentTypeSponsorIsMatchesActive] = @(self.isMatchesActive);
	dictionary[kPerContentTypeSponsorIsNewsActive] = @(self.isNewsActive);
	dictionary[kPerContentTypeSponsorIsVideosActive] = @(self.isVideosActive);
    //Urls
    dictionary[kPerContentTypeSponsorNewsUrl] = self.newsUrl;
    dictionary[kPerContentTypeSponsorVideosUrl] = self.videosUrl;
    dictionary[kPerContentTypeSponsorAlbumsUrl] = self.albumsUrl;
    dictionary[kPerContentTypeSponsorMatchesUrl] = self.matchesUrl;
    dictionary[kPerContentTypeSponsorFreeOpinionsUrl] = self.videosUrl;

    
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //Bool
	[aCoder encodeObject:@(self.isAlbumsActive) forKey:kPerContentTypeSponsorIsAlbumsActive];
    [aCoder encodeObject:@(self.isFreeOpinionsActive) forKey:kPerContentTypeSponsorIsFreeOpinionsActive];
    [aCoder encodeObject:@(self.isMatchesActive) forKey:kPerContentTypeSponsorIsMatchesActive];
    [aCoder encodeObject:@(self.isNewsActive) forKey:kPerContentTypeSponsorIsNewsActive];
    [aCoder encodeObject:@(self.isVideosActive) forKey:kPerContentTypeSponsorIsVideosActive];
    //Url
    [aCoder encodeObject:self.newsUrl forKey:kPerContentTypeSponsorNewsUrl];
    [aCoder encodeObject:self.videosUrl forKey:kPerContentTypeSponsorVideosUrl];
    [aCoder encodeObject:self.albumsUrl forKey:kPerContentTypeSponsorAlbumsUrl];
    [aCoder encodeObject:self.matchesUrl forKey:kPerContentTypeSponsorMatchesUrl];
    [aCoder encodeObject:self.videosUrl forKey:kPerContentTypeSponsorFreeOpinionsUrl];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
    //Bool
	self.isAlbumsActive = [[aDecoder decodeObjectForKey:kPerContentTypeSponsorIsAlbumsActive] boolValue];
	self.isFreeOpinionsActive = [[aDecoder decodeObjectForKey:kPerContentTypeSponsorIsFreeOpinionsActive] boolValue];
	self.isMatchesActive = [[aDecoder decodeObjectForKey:kPerContentTypeSponsorIsMatchesActive] boolValue];
	self.isNewsActive = [[aDecoder decodeObjectForKey:kPerContentTypeSponsorIsNewsActive] boolValue];
	self.isVideosActive = [[aDecoder decodeObjectForKey:kPerContentTypeSponsorIsVideosActive] boolValue];
    //Url
    self.newsUrl = [aDecoder decodeObjectForKey:kPerContentTypeSponsorNewsUrl];
    self.videosUrl = [aDecoder decodeObjectForKey:kPerContentTypeSponsorVideosUrl];
    self.albumsUrl = [aDecoder decodeObjectForKey:kPerContentTypeSponsorAlbumsUrl];
    self.matchesUrl = [aDecoder decodeObjectForKey:kPerContentTypeSponsorMatchesUrl];
    self.videosUrl = [aDecoder decodeObjectForKey:kPerContentTypeSponsorFreeOpinionsUrl];
    
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	PerContentTypeSponsor *copy = [PerContentTypeSponsor new];
    //Bool
	copy.isAlbumsActive = self.isAlbumsActive;
	copy.isFreeOpinionsActive = self.isFreeOpinionsActive;
	copy.isMatchesActive = self.isMatchesActive;
	copy.isNewsActive = self.isNewsActive;
	copy.isVideosActive = self.isVideosActive;
    //Url
    copy.newsUrl = self.newsUrl;
    copy.videosUrl = self.videosUrl;
    copy.albumsUrl = self.albumsUrl;
    copy.matchesUrl = self.matchesUrl;
    copy.videosUrl = self.videosUrl;
    
	return copy;
}
@end
