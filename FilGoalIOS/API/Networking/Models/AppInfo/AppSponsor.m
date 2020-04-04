//
//	AppSponsor.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AppSponsor.h"

NSString *const kAppSponsorIsAppBarActive = @"isAppBarActive";
NSString *const kAppSponsorIsSplashActive = @"isSplashActive";
NSString *const kAppSponsorAppBarUrl = @"appBarUrl";


@interface AppSponsor ()
@end
@implementation AppSponsor




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAppSponsorIsAppBarActive] isKindOfClass:[NSNull class]]){
		self.isAppBarActive = [dictionary[kAppSponsorIsAppBarActive] boolValue];
	}

	if(![dictionary[kAppSponsorIsSplashActive] isKindOfClass:[NSNull class]]){
		self.isSplashActive = [dictionary[kAppSponsorIsSplashActive] boolValue];
	}
    
    if(![dictionary[kAppSponsorAppBarUrl] isKindOfClass:[NSNull class]]){
        self.appBarUrl = dictionary[kAppSponsorAppBarUrl];
    }

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kAppSponsorIsAppBarActive] = @(self.isAppBarActive);
	dictionary[kAppSponsorIsSplashActive] = @(self.isSplashActive);
    dictionary[kAppSponsorAppBarUrl] = self.appBarUrl;

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
	[aCoder encodeObject:@(self.isAppBarActive) forKey:kAppSponsorIsAppBarActive];	[aCoder encodeObject:@(self.isSplashActive) forKey:kAppSponsorIsSplashActive];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.isAppBarActive = [[aDecoder decodeObjectForKey:kAppSponsorIsAppBarActive] boolValue];
	self.isSplashActive = [[aDecoder decodeObjectForKey:kAppSponsorIsSplashActive] boolValue];
    self.appBarUrl = [[aDecoder decodeObjectForKey:kAppSponsorAppBarUrl] stringValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	AppSponsor *copy = [AppSponsor new];

	copy.isAppBarActive = self.isAppBarActive;
	copy.isSplashActive = self.isSplashActive;
    copy.appBarUrl = self.appBarUrl;
	return copy;
}
@end
