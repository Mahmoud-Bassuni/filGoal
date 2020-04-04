//
//	AppInfo.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AppInfo.h"

NSString *const kAppInfoIsBannerAdsEnabled = @"IsBannerAdsEnabled";
NSString *const kAppInfoIsSignalREnabled = @"IsSignalREnabled";
NSString *const kAppInfoLandingScreen = @"LandingScreen";
NSString *const kAppInfoOldAPIsBaseUrl = @"OldAPIsBaseUrl";
NSString *const kAppInfoSSOBaseUrl = @"SSOBaseUrl";
NSString *const kAppInfoSpecialSection = @"SpecialSection";
NSString *const kAppInfoSportesEngineBaseUrl = @"SportesEngineBaseUrl";
NSString *const kAppInfoAdsEnabledPerVersion = @"adsEnabledPerVersion";
NSString *const kAppInfoAdsNewsListingFrequencey = @"adsNewsListingFrequencey";
NSString *const kAppInfoAdsNumOfViews = @"adsNumOfViews";
NSString *const kAppInfoAdsRepeatCount = @"adsRepeatCount";
NSString *const kAppInfoAdsVideoListingFrequencey = @"adsVideoListingFrequencey";
NSString *const kAppInfoApp = @"app";
NSString *const kAppInfoFeaturedMenuItem = @"featured_menu_item";
NSString *const kAppInfoHMacAppId = @"hMacAppId";
NSString *const kAppInfoHMacAppKey = @"hMacAppKey";
NSString *const kAppInfoInterstatialAdsPattern = @"interstatialAdsPattern";
NSString *const kAppInfoIsPostquareActive = @"isPostquareActive";
NSString *const kAppInfoMessage = @"message";
NSString *const kAppInfoServerId = @"serverId";
NSString *const kAppInfoSponsor = @"sponsor";
NSString *const kAppInfoSponsorship = @"sponsorship";
NSString *const kAppInfoTags = @"tags";
NSString *const kAppInfoTimeoff = @"timeoff";
NSString *const kPredictBaseUrl = @"predictBaseURL";
NSString *const kChampsActive = @"isMenuChampActive";


@interface AppInfo ()
@end
@implementation AppInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAppInfoIsBannerAdsEnabled] isKindOfClass:[NSNull class]]){
		self.isBannerAdsEnabled = [dictionary[kAppInfoIsBannerAdsEnabled] boolValue];
	}

	if(![dictionary[kAppInfoIsSignalREnabled] isKindOfClass:[NSNull class]]){
		self.isSignalREnabled = [dictionary[kAppInfoIsSignalREnabled] boolValue];
	}
    if(![dictionary[kChampsActive] isKindOfClass:[NSNull class]]){
        self.isChampActive = [dictionary[kChampsActive] boolValue];
    }
	if(![dictionary[kAppInfoLandingScreen] isKindOfClass:[NSNull class]]){
		self.landingScreen = [[LandingScreen alloc] initWithDictionary:dictionary[kAppInfoLandingScreen]];
	}

	if(![dictionary[kAppInfoOldAPIsBaseUrl] isKindOfClass:[NSNull class]]){
		self.oldAPIsBaseUrl = dictionary[kAppInfoOldAPIsBaseUrl];
	}
    if(![dictionary[kPredictBaseUrl] isKindOfClass:[NSNull class]]){
        self.predictBaseURL = dictionary[kPredictBaseUrl];
    }
	if(![dictionary[kAppInfoSSOBaseUrl] isKindOfClass:[NSNull class]]){
		self.sSOBaseUrl = dictionary[kAppInfoSSOBaseUrl];
	}	
	if(![dictionary[kAppInfoSpecialSection] isKindOfClass:[NSNull class]]){
		self.specialSection = [[SpecialSection alloc] initWithDictionary:dictionary[kAppInfoSpecialSection]];
	}

	if(![dictionary[kAppInfoSportesEngineBaseUrl] isKindOfClass:[NSNull class]]){
		self.sportesEngineBaseUrl = dictionary[kAppInfoSportesEngineBaseUrl];
	}	
	if(dictionary[kAppInfoAdsEnabledPerVersion] != nil && [dictionary[kAppInfoAdsEnabledPerVersion] isKindOfClass:[NSArray class]]){
		NSArray * adsEnabledPerVersionDictionaries = dictionary[kAppInfoAdsEnabledPerVersion];
		NSMutableArray * adsEnabledPerVersionItems = [NSMutableArray array];
		for(NSDictionary * adsEnabledPerVersionDictionary in adsEnabledPerVersionDictionaries){
			AdsEnabledPerVersion * adsEnabledPerVersionItem = [[AdsEnabledPerVersion alloc] initWithDictionary:adsEnabledPerVersionDictionary];
			[adsEnabledPerVersionItems addObject:adsEnabledPerVersionItem];
		}
		self.adsEnabledPerVersion = adsEnabledPerVersionItems;
	}
	if(![dictionary[kAppInfoAdsNewsListingFrequencey] isKindOfClass:[NSNull class]]){
		self.adsNewsListingFrequencey = [dictionary[kAppInfoAdsNewsListingFrequencey] integerValue];
	}

	if(![dictionary[kAppInfoAdsNumOfViews] isKindOfClass:[NSNull class]]){
		self.adsNumOfViews = [dictionary[kAppInfoAdsNumOfViews] integerValue];
	}

	if(![dictionary[kAppInfoAdsRepeatCount] isKindOfClass:[NSNull class]]){
		self.adsRepeatCount = [dictionary[kAppInfoAdsRepeatCount] integerValue];
	}

	if(![dictionary[kAppInfoAdsVideoListingFrequencey] isKindOfClass:[NSNull class]]){
		self.adsVideoListingFrequencey = [dictionary[kAppInfoAdsVideoListingFrequencey] integerValue];
	}

	if(![dictionary[kAppInfoApp] isKindOfClass:[NSNull class]]){
		self.app = [[App alloc] initWithDictionary:dictionary[kAppInfoApp]];
	}

	if(![dictionary[kAppInfoFeaturedMenuItem] isKindOfClass:[NSNull class]]){
		self.featuredMenuItem = [[FeaturedMenuItem alloc] initWithDictionary:dictionary[kAppInfoFeaturedMenuItem]];
	}

	if(![dictionary[kAppInfoHMacAppId] isKindOfClass:[NSNull class]]){
		self.hMacAppId = dictionary[kAppInfoHMacAppId];
	}	
	if(![dictionary[kAppInfoHMacAppKey] isKindOfClass:[NSNull class]]){
		self.hMacAppKey = dictionary[kAppInfoHMacAppKey];
	}	
	if(![dictionary[kAppInfoInterstatialAdsPattern] isKindOfClass:[NSNull class]]){
		self.interstatialAdsPattern = dictionary[kAppInfoInterstatialAdsPattern];
	}	
	if(![dictionary[kAppInfoIsPostquareActive] isKindOfClass:[NSNull class]]){
		self.isPostquareActive = [dictionary[kAppInfoIsPostquareActive] integerValue];
	}

	if(![dictionary[kAppInfoMessage] isKindOfClass:[NSNull class]]){
		self.message = [[Message alloc] initWithDictionary:dictionary[kAppInfoMessage]];
	}

	if(![dictionary[kAppInfoServerId] isKindOfClass:[NSNull class]]){
		self.serverId = [dictionary[kAppInfoServerId] integerValue];
	}

	if(![dictionary[kAppInfoSponsor] isKindOfClass:[NSNull class]]){
		self.sponsor = [[Sponsor alloc] initWithDictionary:dictionary[kAppInfoSponsor]];
	}

	if(dictionary[kAppInfoSponsorship] != nil && [dictionary[kAppInfoSponsorship] isKindOfClass:[NSArray class]]){
		NSArray * sponsorshipDictionaries = dictionary[kAppInfoSponsorship];
		NSMutableArray * sponsorshipItems = [NSMutableArray array];
		for(NSDictionary * sponsorshipDictionary in sponsorshipDictionaries){
			Sponsorship * sponsorshipItem = [[Sponsorship alloc] initWithDictionary:sponsorshipDictionary];
			[sponsorshipItems addObject:sponsorshipItem];
		}
		self.sponsorship = sponsorshipItems;
	}
	if(![dictionary[kAppInfoTags] isKindOfClass:[NSNull class]]){
		self.tags = dictionary[kAppInfoTags];
	}	
	if(![dictionary[kAppInfoTimeoff] isKindOfClass:[NSNull class]]){
		self.timeoff = [dictionary[kAppInfoTimeoff] integerValue];
	}
  
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kAppInfoIsBannerAdsEnabled] = @(self.isBannerAdsEnabled);
	dictionary[kAppInfoIsSignalREnabled] = @(self.isSignalREnabled);
    dictionary[kChampsActive] = @(self.isChampActive);

	if(self.landingScreen != nil){
		dictionary[kAppInfoLandingScreen] = [self.landingScreen toDictionary];
	}
	if(self.oldAPIsBaseUrl != nil){
		dictionary[kAppInfoOldAPIsBaseUrl] = self.oldAPIsBaseUrl;
	}
    if(self.predictBaseURL != nil){
        dictionary[kPredictBaseUrl] = self.predictBaseURL;
    }
	if(self.sSOBaseUrl != nil){
		dictionary[kAppInfoSSOBaseUrl] = self.sSOBaseUrl;
	}
	if(self.specialSection != nil){
		dictionary[kAppInfoSpecialSection] = [self.specialSection toDictionary];
	}
	if(self.sportesEngineBaseUrl != nil){
		dictionary[kAppInfoSportesEngineBaseUrl] = self.sportesEngineBaseUrl;
	}
	if(self.adsEnabledPerVersion != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(AdsEnabledPerVersion * adsEnabledPerVersionElement in self.adsEnabledPerVersion){
			[dictionaryElements addObject:[adsEnabledPerVersionElement toDictionary]];
		}
		dictionary[kAppInfoAdsEnabledPerVersion] = dictionaryElements;
	}
	dictionary[kAppInfoAdsNewsListingFrequencey] = @(self.adsNewsListingFrequencey);
	dictionary[kAppInfoAdsNumOfViews] = @(self.adsNumOfViews);
	dictionary[kAppInfoAdsRepeatCount] = @(self.adsRepeatCount);
	dictionary[kAppInfoAdsVideoListingFrequencey] = @(self.adsVideoListingFrequencey);
	if(self.app != nil){
		dictionary[kAppInfoApp] = [self.app toDictionary];
	}
	if(self.featuredMenuItem != nil){
		dictionary[kAppInfoFeaturedMenuItem] = [self.featuredMenuItem toDictionary];
	}
	if(self.hMacAppId != nil){
		dictionary[kAppInfoHMacAppId] = self.hMacAppId;
	}
	if(self.hMacAppKey != nil){
		dictionary[kAppInfoHMacAppKey] = self.hMacAppKey;
	}
	if(self.interstatialAdsPattern != nil){
		dictionary[kAppInfoInterstatialAdsPattern] = self.interstatialAdsPattern;
	}
	dictionary[kAppInfoIsPostquareActive] = @(self.isPostquareActive);
	if(self.message != nil){
		dictionary[kAppInfoMessage] = [self.message toDictionary];
	}
	dictionary[kAppInfoServerId] = @(self.serverId);
	if(self.sponsor != nil){
		dictionary[kAppInfoSponsor] = [self.sponsor toDictionary];
	}
	if(self.sponsorship != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Sponsorship * sponsorshipElement in self.sponsorship){
			[dictionaryElements addObject:[sponsorshipElement toDictionary]];
		}
		dictionary[kAppInfoSponsorship] = dictionaryElements;
	}
	if(self.tags != nil){
		dictionary[kAppInfoTags] = self.tags;
	}
	dictionary[kAppInfoTimeoff] = @(self.timeoff);
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
	[aCoder encodeObject:@(self.isBannerAdsEnabled) forKey:kAppInfoIsBannerAdsEnabled];
    [aCoder encodeObject:@(self.isChampActive) forKey:kChampsActive];

    [aCoder encodeObject:@(self.isSignalREnabled) forKey:kAppInfoIsSignalREnabled];
    if(self.landingScreen != nil){
		[aCoder encodeObject:self.landingScreen forKey:kAppInfoLandingScreen];
	}

	if(self.oldAPIsBaseUrl != nil){
		[aCoder encodeObject:self.oldAPIsBaseUrl forKey:kAppInfoOldAPIsBaseUrl];
	}
	if(self.sSOBaseUrl != nil){
		[aCoder encodeObject:self.sSOBaseUrl forKey:kAppInfoSSOBaseUrl];
	}
    if(self.predictBaseURL != nil){
        [aCoder encodeObject:self.predictBaseURL forKey:kPredictBaseUrl];
    }
	if(self.specialSection != nil){
		[aCoder encodeObject:self.specialSection forKey:kAppInfoSpecialSection];
	}
	if(self.sportesEngineBaseUrl != nil){
		[aCoder encodeObject:self.sportesEngineBaseUrl forKey:kAppInfoSportesEngineBaseUrl];
	}
	if(self.adsEnabledPerVersion != nil){
		[aCoder encodeObject:self.adsEnabledPerVersion forKey:kAppInfoAdsEnabledPerVersion];
	}
	[aCoder encodeObject:@(self.adsNewsListingFrequencey) forKey:kAppInfoAdsNewsListingFrequencey];	[aCoder encodeObject:@(self.adsNumOfViews) forKey:kAppInfoAdsNumOfViews];	[aCoder encodeObject:@(self.adsRepeatCount) forKey:kAppInfoAdsRepeatCount];	[aCoder encodeObject:@(self.adsVideoListingFrequencey) forKey:kAppInfoAdsVideoListingFrequencey];	if(self.app != nil){
		[aCoder encodeObject:self.app forKey:kAppInfoApp];
	}
	if(self.featuredMenuItem != nil){
		[aCoder encodeObject:self.featuredMenuItem forKey:kAppInfoFeaturedMenuItem];
	}
	if(self.hMacAppId != nil){
		[aCoder encodeObject:self.hMacAppId forKey:kAppInfoHMacAppId];
	}
	if(self.hMacAppKey != nil){
		[aCoder encodeObject:self.hMacAppKey forKey:kAppInfoHMacAppKey];
	}
	if(self.interstatialAdsPattern != nil){
		[aCoder encodeObject:self.interstatialAdsPattern forKey:kAppInfoInterstatialAdsPattern];
	}
	[aCoder encodeObject:@(self.isPostquareActive) forKey:kAppInfoIsPostquareActive];	if(self.message != nil){
		[aCoder encodeObject:self.message forKey:kAppInfoMessage];
	}
	[aCoder encodeObject:@(self.serverId) forKey:kAppInfoServerId];	if(self.sponsor != nil){
		[aCoder encodeObject:self.sponsor forKey:kAppInfoSponsor];
	}
	if(self.sponsorship != nil){
		[aCoder encodeObject:self.sponsorship forKey:kAppInfoSponsorship];
	}
	if(self.tags != nil){
		[aCoder encodeObject:self.tags forKey:kAppInfoTags];
	}
	[aCoder encodeObject:@(self.timeoff) forKey:kAppInfoTimeoff];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.isBannerAdsEnabled = [[aDecoder decodeObjectForKey:kAppInfoIsBannerAdsEnabled] boolValue];
    self.isChampActive = [[aDecoder decodeObjectForKey:kChampsActive] boolValue];

	self.isSignalREnabled = [[aDecoder decodeObjectForKey:kAppInfoIsSignalREnabled] boolValue];
	self.landingScreen = [aDecoder decodeObjectForKey:kAppInfoLandingScreen];
	self.oldAPIsBaseUrl = [aDecoder decodeObjectForKey:kAppInfoOldAPIsBaseUrl];
    self.predictBaseURL = [aDecoder decodeObjectForKey:kPredictBaseUrl];
	self.sSOBaseUrl = [aDecoder decodeObjectForKey:kAppInfoSSOBaseUrl];
	self.specialSection = [aDecoder decodeObjectForKey:kAppInfoSpecialSection];
	self.sportesEngineBaseUrl = [aDecoder decodeObjectForKey:kAppInfoSportesEngineBaseUrl];
	self.adsEnabledPerVersion = [aDecoder decodeObjectForKey:kAppInfoAdsEnabledPerVersion];
	self.adsNewsListingFrequencey = [[aDecoder decodeObjectForKey:kAppInfoAdsNewsListingFrequencey] integerValue];
	self.adsNumOfViews = [[aDecoder decodeObjectForKey:kAppInfoAdsNumOfViews] integerValue];
	self.adsRepeatCount = [[aDecoder decodeObjectForKey:kAppInfoAdsRepeatCount] integerValue];
	self.adsVideoListingFrequencey = [[aDecoder decodeObjectForKey:kAppInfoAdsVideoListingFrequencey] integerValue];
	self.app = [aDecoder decodeObjectForKey:kAppInfoApp];
	self.featuredMenuItem = [aDecoder decodeObjectForKey:kAppInfoFeaturedMenuItem];
	self.hMacAppId = [aDecoder decodeObjectForKey:kAppInfoHMacAppId];
	self.hMacAppKey = [aDecoder decodeObjectForKey:kAppInfoHMacAppKey];
	self.interstatialAdsPattern = [aDecoder decodeObjectForKey:kAppInfoInterstatialAdsPattern];
	self.isPostquareActive = [[aDecoder decodeObjectForKey:kAppInfoIsPostquareActive] integerValue];
	self.message = [aDecoder decodeObjectForKey:kAppInfoMessage];
	self.serverId = [[aDecoder decodeObjectForKey:kAppInfoServerId] integerValue];
	self.sponsor = [aDecoder decodeObjectForKey:kAppInfoSponsor];
	self.sponsorship = [aDecoder decodeObjectForKey:kAppInfoSponsorship];
	self.tags = [aDecoder decodeObjectForKey:kAppInfoTags];
	self.timeoff = [[aDecoder decodeObjectForKey:kAppInfoTimeoff] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	AppInfo *copy = [AppInfo new];
	copy.isBannerAdsEnabled = self.isBannerAdsEnabled;
    copy.isChampActive = self.isChampActive;
	copy.isSignalREnabled = self.isSignalREnabled;
	copy.landingScreen = [self.landingScreen copy];
	copy.oldAPIsBaseUrl = [self.oldAPIsBaseUrl copy];
    copy.predictBaseURL = [self.predictBaseURL copy];
	copy.sSOBaseUrl = [self.sSOBaseUrl copy];
	copy.specialSection = [self.specialSection copy];
	copy.sportesEngineBaseUrl = [self.sportesEngineBaseUrl copy];
	copy.adsEnabledPerVersion = [self.adsEnabledPerVersion copy];
	copy.adsNewsListingFrequencey = self.adsNewsListingFrequencey;
	copy.adsNumOfViews = self.adsNumOfViews;
	copy.adsRepeatCount = self.adsRepeatCount;
	copy.adsVideoListingFrequencey = self.adsVideoListingFrequencey;
	copy.app = [self.app copy];
	copy.featuredMenuItem = [self.featuredMenuItem copy];
	copy.hMacAppId = [self.hMacAppId copy];
	copy.hMacAppKey = [self.hMacAppKey copy];
	copy.interstatialAdsPattern = [self.interstatialAdsPattern copy];
	copy.isPostquareActive = self.isPostquareActive;
	copy.message = [self.message copy];
	copy.serverId = self.serverId;
	copy.sponsor = [self.sponsor copy];
	copy.sponsorship = [self.sponsorship copy];
	copy.tags = [self.tags copy];
	copy.timeoff = self.timeoff;

	return copy;
}
@end
