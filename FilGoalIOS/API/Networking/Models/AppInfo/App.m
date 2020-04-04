//
//	App.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "App.h"

NSString *const kAppIsActive = @"is_active";
NSString *const kAppIsCore = @"is_core";
NSString *const kAppMsg = @"msg";
NSString *const kAppStoreUrl = @"store_url";
NSString *const kAppVersion = @"version";

@interface App ()
@end
@implementation App




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kAppIsActive] isKindOfClass:[NSNull class]]){
		self.isActive = [dictionary[kAppIsActive] integerValue];
	}

	if(![dictionary[kAppIsCore] isKindOfClass:[NSNull class]]){
		self.isCore = [dictionary[kAppIsCore] integerValue];
	}

	if(![dictionary[kAppMsg] isKindOfClass:[NSNull class]]){
		self.msg = dictionary[kAppMsg];
	}	
	if(![dictionary[kAppStoreUrl] isKindOfClass:[NSNull class]]){
		self.storeUrl = dictionary[kAppStoreUrl];
	}	
	if(![dictionary[kAppVersion] isKindOfClass:[NSNull class]]){
		self.version = dictionary[kAppVersion];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kAppIsActive] = @(self.isActive);
	dictionary[kAppIsCore] = @(self.isCore);
	if(self.msg != nil){
		dictionary[kAppMsg] = self.msg;
	}
	if(self.storeUrl != nil){
		dictionary[kAppStoreUrl] = self.storeUrl;
	}
	if(self.version != nil){
		dictionary[kAppVersion] = self.version;
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
	[aCoder encodeObject:@(self.isActive) forKey:kAppIsActive];	[aCoder encodeObject:@(self.isCore) forKey:kAppIsCore];	if(self.msg != nil){
		[aCoder encodeObject:self.msg forKey:kAppMsg];
	}
	if(self.storeUrl != nil){
		[aCoder encodeObject:self.storeUrl forKey:kAppStoreUrl];
	}
	if(self.version != nil){
		[aCoder encodeObject:self.version forKey:kAppVersion];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.isActive = [[aDecoder decodeObjectForKey:kAppIsActive] integerValue];
	self.isCore = [[aDecoder decodeObjectForKey:kAppIsCore] integerValue];
	self.msg = [aDecoder decodeObjectForKey:kAppMsg];
	self.storeUrl = [aDecoder decodeObjectForKey:kAppStoreUrl];
	self.version = [aDecoder decodeObjectForKey:kAppVersion];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	App *copy = [App new];

	copy.isActive = self.isActive;
	copy.isCore = self.isCore;
	copy.msg = [self.msg copy];
	copy.storeUrl = [self.storeUrl copy];
	copy.version = [self.version copy];

	return copy;
}
@end