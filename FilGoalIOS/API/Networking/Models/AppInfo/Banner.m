//
//	Banner.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Banner.h"

NSString *const kBannerImgUrl = @"imgUrl";
NSString *const kBannerPageUrl = @"pageUrl";
NSString *const kBannerTitle = @"title";

@interface Banner ()
@end
@implementation Banner




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kBannerImgUrl] isKindOfClass:[NSNull class]]){
		self.imgUrl = dictionary[kBannerImgUrl];
	}	
	if(![dictionary[kBannerPageUrl] isKindOfClass:[NSNull class]]){
		self.pageUrl = dictionary[kBannerPageUrl];
	}	
	if(![dictionary[kBannerTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kBannerTitle];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.imgUrl != nil){
		dictionary[kBannerImgUrl] = self.imgUrl;
	}
	if(self.pageUrl != nil){
		dictionary[kBannerPageUrl] = self.pageUrl;
	}
	if(self.title != nil){
		dictionary[kBannerTitle] = self.title;
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
	if(self.imgUrl != nil){
		[aCoder encodeObject:self.imgUrl forKey:kBannerImgUrl];
	}
	if(self.pageUrl != nil){
		[aCoder encodeObject:self.pageUrl forKey:kBannerPageUrl];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kBannerTitle];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.imgUrl = [aDecoder decodeObjectForKey:kBannerImgUrl];
	self.pageUrl = [aDecoder decodeObjectForKey:kBannerPageUrl];
	self.title = [aDecoder decodeObjectForKey:kBannerTitle];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Banner *copy = [Banner new];

	copy.imgUrl = [self.imgUrl copy];
	copy.pageUrl = [self.pageUrl copy];
	copy.title = [self.title copy];

	return copy;
}
@end