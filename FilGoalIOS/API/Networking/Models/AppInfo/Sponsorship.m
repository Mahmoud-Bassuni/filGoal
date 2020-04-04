//
//	Sponsorship.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Sponsorship.h"

NSString *const kSponsorshipCoSponsor = @"co_sponsor";
NSString *const kSponsorshipMainSponsor = @"main_sponsor";
NSString *const kSponsorshipSponsorCountryCode = @"sponsor_country_code";
NSString *const kSponsorshipSponsorPath = @"sponsor_path";
NSString *const kRootClassLandingScreenWithVerticalButtons = @"LandingScreenWithVerticalButtons";

@interface Sponsorship ()
@end
@implementation Sponsorship




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kSponsorshipCoSponsor] isKindOfClass:[NSNull class]]){
		self.coSponsor = [[CoSponsor alloc] initWithDictionary:dictionary[kSponsorshipCoSponsor]];
	}

	if(![dictionary[kSponsorshipMainSponsor] isKindOfClass:[NSNull class]]){
		self.mainSponsor = [[MainSponsor alloc] initWithDictionary:dictionary[kSponsorshipMainSponsor]];
	}

	if(![dictionary[kSponsorshipSponsorCountryCode] isKindOfClass:[NSNull class]]){
		self.sponsorCountryCode = dictionary[kSponsorshipSponsorCountryCode];
	}	
	if(![dictionary[kSponsorshipSponsorPath] isKindOfClass:[NSNull class]]){
		self.sponsorPath = dictionary[kSponsorshipSponsorPath];
	}
    if(![dictionary[kRootClassLandingScreenWithVerticalButtons] isKindOfClass:[NSNull class]]){
        self.landingScreenWithVerticalButtons = [[LandingScreenWithVerticalButton alloc] initWithDictionary:dictionary[kRootClassLandingScreenWithVerticalButtons]];
    }
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.coSponsor != nil){
		dictionary[kSponsorshipCoSponsor] = [self.coSponsor toDictionary];
	}
	if(self.mainSponsor != nil){
		dictionary[kSponsorshipMainSponsor] = [self.mainSponsor toDictionary];
	}
	if(self.sponsorCountryCode != nil){
		dictionary[kSponsorshipSponsorCountryCode] = self.sponsorCountryCode;
	}
	if(self.sponsorPath != nil){
		dictionary[kSponsorshipSponsorPath] = self.sponsorPath;
	}
    if(self.landingScreenWithVerticalButtons != nil){
        dictionary[kRootClassLandingScreenWithVerticalButtons] = [self.landingScreenWithVerticalButtons toDictionary];
    }
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
	if(self.coSponsor != nil){
		[aCoder encodeObject:self.coSponsor forKey:kSponsorshipCoSponsor];
	}
	if(self.mainSponsor != nil){
		[aCoder encodeObject:self.mainSponsor forKey:kSponsorshipMainSponsor];
	}
	if(self.sponsorCountryCode != nil){
		[aCoder encodeObject:self.sponsorCountryCode forKey:kSponsorshipSponsorCountryCode];
	}
	if(self.sponsorPath != nil){
		[aCoder encodeObject:self.sponsorPath forKey:kSponsorshipSponsorPath];
	}
    if(self.landingScreenWithVerticalButtons != nil){
        [aCoder encodeObject:self.landingScreenWithVerticalButtons forKey:kRootClassLandingScreenWithVerticalButtons];
    }
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.coSponsor = [aDecoder decodeObjectForKey:kSponsorshipCoSponsor];
	self.mainSponsor = [aDecoder decodeObjectForKey:kSponsorshipMainSponsor];
	self.sponsorCountryCode = [aDecoder decodeObjectForKey:kSponsorshipSponsorCountryCode];
	self.sponsorPath = [aDecoder decodeObjectForKey:kSponsorshipSponsorPath];
    self.landingScreenWithVerticalButtons = [aDecoder decodeObjectForKey:kRootClassLandingScreenWithVerticalButtons];

	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Sponsorship *copy = [Sponsorship new];
    copy.landingScreenWithVerticalButtons = [self.landingScreenWithVerticalButtons copy];
	copy.coSponsor = [self.coSponsor copy];
	copy.mainSponsor = [self.mainSponsor copy];
	copy.sponsorCountryCode = [self.sponsorCountryCode copy];
	copy.sponsorPath = [self.sponsorPath copy];

	return copy;
}
@end
