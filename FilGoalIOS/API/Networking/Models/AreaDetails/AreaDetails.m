//
//	AreaDetails.m
//
//	Create by Nada Gamal on 16/3/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AreaDetails.h"

@interface AreaDetails ()
@end
@implementation AreaDetails




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"city"] isKindOfClass:[NSNull class]]){
		self.city = dictionary[@"city"];
	}	
	if(![dictionary[@"code"] isKindOfClass:[NSNull class]]){
		self.code = dictionary[@"code"];
	}	
	if(![dictionary[@"country"] isKindOfClass:[NSNull class]]){
		self.country = dictionary[@"country"];
	}	
	if(![dictionary[@"latitude"] isKindOfClass:[NSNull class]]){
		self.latitude = [dictionary[@"latitude"] floatValue];
	}

	if(![dictionary[@"longitude"] isKindOfClass:[NSNull class]]){
		self.longitude = [dictionary[@"longitude"] floatValue];
	}

	if(![dictionary[@"region"] isKindOfClass:[NSNull class]]){
		self.region = dictionary[@"region"];
	}	
	if(![dictionary[@"timezone"] isKindOfClass:[NSNull class]]){
		self.timezone = dictionary[@"timezone"];
	}	
	if(![dictionary[@"zipcode"] isKindOfClass:[NSNull class]]){
		self.zipcode = dictionary[@"zipcode"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.city != nil){
		dictionary[@"city"] = self.city;
	}
	if(self.code != nil){
		dictionary[@"code"] = self.code;
	}
	if(self.country != nil){
		dictionary[@"country"] = self.country;
	}
	dictionary[@"latitude"] = @(self.latitude);
	dictionary[@"longitude"] = @(self.longitude);
	if(self.region != nil){
		dictionary[@"region"] = self.region;
	}
	if(self.timezone != nil){
		dictionary[@"timezone"] = self.timezone;
	}
	if(self.zipcode != nil){
		dictionary[@"zipcode"] = self.zipcode;
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
	if(self.city != nil){
		[aCoder encodeObject:self.city forKey:@"city"];
	}
	if(self.code != nil){
		[aCoder encodeObject:self.code forKey:@"code"];
	}
	if(self.country != nil){
		[aCoder encodeObject:self.country forKey:@"country"];
	}
	[aCoder encodeObject:@(self.latitude) forKey:@"latitude"];	[aCoder encodeObject:@(self.longitude) forKey:@"longitude"];	if(self.region != nil){
		[aCoder encodeObject:self.region forKey:@"region"];
	}
	if(self.timezone != nil){
		[aCoder encodeObject:self.timezone forKey:@"timezone"];
	}
	if(self.zipcode != nil){
		[aCoder encodeObject:self.zipcode forKey:@"zipcode"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.city = [aDecoder decodeObjectForKey:@"city"];
	self.code = [aDecoder decodeObjectForKey:@"code"];
	self.country = [aDecoder decodeObjectForKey:@"country"];
	self.latitude = [[aDecoder decodeObjectForKey:@"latitude"] floatValue];
	self.longitude = [[aDecoder decodeObjectForKey:@"longitude"] floatValue];
	self.region = [aDecoder decodeObjectForKey:@"region"];
	self.timezone = [aDecoder decodeObjectForKey:@"timezone"];
	self.zipcode = [aDecoder decodeObjectForKey:@"zipcode"];
	return self;

}
@end