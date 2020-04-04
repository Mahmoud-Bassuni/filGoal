//
//	Country.m
//
//	Create by Nada Gamal on 27/6/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Country.h"

NSString *const kCountryCode = @"code";
NSString *const kCountryFlag = @"flag";
NSString *const kCountryIp = @"ip";
NSString *const kCountryName = @"name";

@interface Country ()
@end
@implementation Country




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCountryCode] isKindOfClass:[NSNull class]]){
		self.code = dictionary[kCountryCode];
	}	
	if(![dictionary[kCountryFlag] isKindOfClass:[NSNull class]]){
		self.flag = dictionary[kCountryFlag];
	}	
	if(![dictionary[kCountryIp] isKindOfClass:[NSNull class]]){
		self.ip = dictionary[kCountryIp];
	}	
	if(![dictionary[kCountryName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kCountryName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.code != nil){
		dictionary[kCountryCode] = self.code;
	}
	if(self.flag != nil){
		dictionary[kCountryFlag] = self.flag;
	}
	if(self.ip != nil){
		dictionary[kCountryIp] = self.ip;
	}
	if(self.name != nil){
		dictionary[kCountryName] = self.name;
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
	if(self.code != nil){
		[aCoder encodeObject:self.code forKey:kCountryCode];
	}
	if(self.flag != nil){
		[aCoder encodeObject:self.flag forKey:kCountryFlag];
	}
	if(self.ip != nil){
		[aCoder encodeObject:self.ip forKey:kCountryIp];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kCountryName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.code = [aDecoder decodeObjectForKey:kCountryCode];
	self.flag = [aDecoder decodeObjectForKey:kCountryFlag];
	self.ip = [aDecoder decodeObjectForKey:kCountryIp];
	self.name = [aDecoder decodeObjectForKey:kCountryName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Country *copy = [Country new];

	copy.code = [self.code copyWithZone:zone];
	copy.flag = [self.flag copyWithZone:zone];
	copy.ip = [self.ip copyWithZone:zone];
	copy.name = [self.name copyWithZone:zone];

	return copy;
}
@end