//
//	FeaturedMenuItem.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FeaturedMenuItem.h"

NSString *const kFeaturedMenuItemIdField = @"id";
NSString *const kFeaturedMenuItemImgBaseUrl = @"img_base_url";
NSString *const kFeaturedMenuItemIsActive = @"is_active";
NSString *const kFeaturedMenuItemTitle = @"title";
NSString *const kFeaturedMenuItemType = @"type";

@interface FeaturedMenuItem ()
@end
@implementation FeaturedMenuItem




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kFeaturedMenuItemIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kFeaturedMenuItemIdField] integerValue];
	}

	if(![dictionary[kFeaturedMenuItemImgBaseUrl] isKindOfClass:[NSNull class]]){
		self.imgBaseUrl = dictionary[kFeaturedMenuItemImgBaseUrl];
	}	
	if(![dictionary[kFeaturedMenuItemIsActive] isKindOfClass:[NSNull class]]){
		self.isActive = [dictionary[kFeaturedMenuItemIsActive] integerValue];
	}

	if(![dictionary[kFeaturedMenuItemTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kFeaturedMenuItemTitle];
	}	
	if(![dictionary[kFeaturedMenuItemType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kFeaturedMenuItemType] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kFeaturedMenuItemIdField] = @(self.idField);
	if(self.imgBaseUrl != nil){
		dictionary[kFeaturedMenuItemImgBaseUrl] = self.imgBaseUrl;
	}
	dictionary[kFeaturedMenuItemIsActive] = @(self.isActive);
	if(self.title != nil){
		dictionary[kFeaturedMenuItemTitle] = self.title;
	}
	dictionary[kFeaturedMenuItemType] = @(self.type);
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
	[aCoder encodeObject:@(self.idField) forKey:kFeaturedMenuItemIdField];	if(self.imgBaseUrl != nil){
		[aCoder encodeObject:self.imgBaseUrl forKey:kFeaturedMenuItemImgBaseUrl];
	}
	[aCoder encodeObject:@(self.isActive) forKey:kFeaturedMenuItemIsActive];	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kFeaturedMenuItemTitle];
	}
	[aCoder encodeObject:@(self.type) forKey:kFeaturedMenuItemType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [[aDecoder decodeObjectForKey:kFeaturedMenuItemIdField] integerValue];
	self.imgBaseUrl = [aDecoder decodeObjectForKey:kFeaturedMenuItemImgBaseUrl];
	self.isActive = [[aDecoder decodeObjectForKey:kFeaturedMenuItemIsActive] integerValue];
	self.title = [aDecoder decodeObjectForKey:kFeaturedMenuItemTitle];
	self.type = [[aDecoder decodeObjectForKey:kFeaturedMenuItemType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	FeaturedMenuItem *copy = [FeaturedMenuItem new];

	copy.idField = self.idField;
	copy.imgBaseUrl = [self.imgBaseUrl copy];
	copy.isActive = self.isActive;
	copy.title = [self.title copy];
	copy.type = self.type;

	return copy;
}
@end