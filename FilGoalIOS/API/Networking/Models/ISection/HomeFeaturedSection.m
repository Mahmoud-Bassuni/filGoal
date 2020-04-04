//
//	HomeFeaturedSection.m
//
//	Create by Nada Gamal on 2/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "HomeFeaturedSection.h"

@interface HomeFeaturedSection ()
@end
@implementation HomeFeaturedSection




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"featuredSection"] isKindOfClass:[NSNull class]]){
		self.featuredSection = [[FeaturedSection alloc] initWithDictionary:dictionary[@"section"]];
	}

	if(![dictionary[@"img_base_url"] isKindOfClass:[NSNull class]]){
		self.imgBaseUrl = dictionary[@"img_base_url"];
	}	
	if(![dictionary[@"isActive"] isKindOfClass:[NSNull class]]){
		self.isActive = [dictionary[@"isActive"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.featuredSection != nil){
		dictionary[@"featuredSection"] = [self.featuredSection toDictionary];
	}
	if(self.imgBaseUrl != nil){
		dictionary[@"img_base_url"] = self.imgBaseUrl;
	}
	dictionary[@"isActive"] = @(self.isActive);
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
	if(self.featuredSection != nil){
		[aCoder encodeObject:self.featuredSection forKey:@"featuredSection"];
	}
	if(self.imgBaseUrl != nil){
		[aCoder encodeObject:self.imgBaseUrl forKey:@"img_base_url"];
	}
	[aCoder encodeObject:@(self.isActive) forKey:@"isActive"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.featuredSection = [aDecoder decodeObjectForKey:@"featuredSection"];
	self.imgBaseUrl = [aDecoder decodeObjectForKey:@"img_base_url"];
	self.isActive = [[aDecoder decodeObjectForKey:@"isActive"] integerValue];
	return self;

}
@end