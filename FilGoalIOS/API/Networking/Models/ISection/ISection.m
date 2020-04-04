//
//	ISection.m
//
//	Create by Nada Gamal on 2/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ISection.h"

@interface ISection ()
@end
@implementation ISection




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[@"FeaturedMenuItems"] != nil && [dictionary[@"FeaturedMenuItems"] isKindOfClass:[NSArray class]]){
		NSArray * featuredMenuItemsDictionaries = dictionary[@"FeaturedMenuItems"];
		NSMutableArray * featuredMenuItemsItems = [NSMutableArray array];
		for(NSDictionary * featuredMenuItemsDictionary in featuredMenuItemsDictionaries){
			FeaturedMenuItems * featuredMenuItemsItem = [[FeaturedMenuItems alloc] initWithDictionary:featuredMenuItemsDictionary];
			[featuredMenuItemsItems addObject:featuredMenuItemsItem];
		}
		self.featuredMenuItems = featuredMenuItemsItems;
	}
	if(![dictionary[@"HomeFeaturedSection"] isKindOfClass:[NSNull class]]){
		self.homeFeaturedSection = [[HomeFeaturedSection alloc] initWithDictionary:dictionary[@"HomeFeaturedSection"]];
	}

	if(![dictionary[@"endDate"] isKindOfClass:[NSNull class]]){
		self.endDate = dictionary[@"endDate"];
	}	
	if(![dictionary[@"startDate"] isKindOfClass:[NSNull class]]){
		self.startDate = dictionary[@"startDate"];
	}	
//	if(![dictionary[@"iSection"] isKindOfClass:[NSNull class]]){
//		self.iSection = [[ISection alloc] initWithDictionary:dictionary[@"iSection"]];
//	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.featuredMenuItems != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(FeaturedMenuItems * featuredMenuItemsElement in self.featuredMenuItems){
			[dictionaryElements addObject:[featuredMenuItemsElement toDictionary]];
		}
		dictionary[@"FeaturedMenuItems"] = dictionaryElements;
	}
	if(self.homeFeaturedSection != nil){
		dictionary[@"HomeFeaturedSection"] = [self.homeFeaturedSection toDictionary];
	}
	if(self.endDate != nil){
		dictionary[@"endDate"] = self.endDate;
	}
	if(self.startDate != nil){
		dictionary[@"startDate"] = self.startDate;
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
	if(self.featuredMenuItems != nil){
		[aCoder encodeObject:self.featuredMenuItems forKey:@"FeaturedMenuItems"];
	}
	if(self.homeFeaturedSection != nil){
		[aCoder encodeObject:self.homeFeaturedSection forKey:@"HomeFeaturedSection"];
	}
	if(self.endDate != nil){
		[aCoder encodeObject:self.endDate forKey:@"endDate"];
	}
	if(self.startDate != nil){
		[aCoder encodeObject:self.startDate forKey:@"startDate"];
	}


}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.featuredMenuItems = [aDecoder decodeObjectForKey:@"FeaturedMenuItems"];
	self.homeFeaturedSection = [aDecoder decodeObjectForKey:@"HomeFeaturedSection"];
	self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
	self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
	return self;

}
@end