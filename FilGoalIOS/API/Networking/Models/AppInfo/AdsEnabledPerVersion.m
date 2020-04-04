//
//	AdsEnabledPerVersion.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AdsEnabledPerVersion.h"

NSString *const kAdsEnabledPerVersionIsAdsEnabled = @"isAdsEnabled";
NSString *const kAdsEnabledPerVersionIsPagerAdsEnabled = @"isPagerAdsEnabled";
NSString *const kAdsEnabledPerVersionIsSponsorEnabled = @"isSponsorEnabled";
NSString *const kAdsEnabledPerVersionVersionCode = @"version_code";

@interface AdsEnabledPerVersion ()
@end
@implementation AdsEnabledPerVersion




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAdsEnabledPerVersionIsAdsEnabled] isKindOfClass:[NSNull class]]){
		self.isAdsEnabled = [dictionary[kAdsEnabledPerVersionIsAdsEnabled] integerValue];
	}

	if(![dictionary[kAdsEnabledPerVersionIsPagerAdsEnabled] isKindOfClass:[NSNull class]]){
		self.isPagerAdsEnabled = [dictionary[kAdsEnabledPerVersionIsPagerAdsEnabled] integerValue];
	}

	if(![dictionary[kAdsEnabledPerVersionIsSponsorEnabled] isKindOfClass:[NSNull class]]){
		self.isSponsorEnabled = [dictionary[kAdsEnabledPerVersionIsSponsorEnabled] integerValue];
	}

	if(![dictionary[kAdsEnabledPerVersionVersionCode] isKindOfClass:[NSNull class]]){
		self.versionCode = dictionary[kAdsEnabledPerVersionVersionCode];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kAdsEnabledPerVersionIsAdsEnabled] = @(self.isAdsEnabled);
	dictionary[kAdsEnabledPerVersionIsPagerAdsEnabled] = @(self.isPagerAdsEnabled);
	dictionary[kAdsEnabledPerVersionIsSponsorEnabled] = @(self.isSponsorEnabled);
	if(self.versionCode != nil){
		dictionary[kAdsEnabledPerVersionVersionCode] = self.versionCode;
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
	[aCoder encodeObject:@(self.isAdsEnabled) forKey:kAdsEnabledPerVersionIsAdsEnabled];	[aCoder encodeObject:@(self.isPagerAdsEnabled) forKey:kAdsEnabledPerVersionIsPagerAdsEnabled];	[aCoder encodeObject:@(self.isSponsorEnabled) forKey:kAdsEnabledPerVersionIsSponsorEnabled];	if(self.versionCode != nil){
		[aCoder encodeObject:self.versionCode forKey:kAdsEnabledPerVersionVersionCode];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.isAdsEnabled = [[aDecoder decodeObjectForKey:kAdsEnabledPerVersionIsAdsEnabled] integerValue];
	self.isPagerAdsEnabled = [[aDecoder decodeObjectForKey:kAdsEnabledPerVersionIsPagerAdsEnabled] integerValue];
	self.isSponsorEnabled = [[aDecoder decodeObjectForKey:kAdsEnabledPerVersionIsSponsorEnabled] integerValue];
	self.versionCode = [aDecoder decodeObjectForKey:kAdsEnabledPerVersionVersionCode];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	AdsEnabledPerVersion *copy = [AdsEnabledPerVersion new];

	copy.isAdsEnabled = self.isAdsEnabled;
	copy.isPagerAdsEnabled = self.isPagerAdsEnabled;
	copy.isSponsorEnabled = self.isSponsorEnabled;
	copy.versionCode = [self.versionCode copy];

	return copy;
}
@end