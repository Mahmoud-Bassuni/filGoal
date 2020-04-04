//
//	FeaturedCompontent.m
//
//	Create by Mohamed Mansour on 4/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FeaturedCompontent.h"

@interface FeaturedCompontent ()
@end
@implementation FeaturedCompontent




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[@"component"] != nil && [dictionary[@"component"] isKindOfClass:[NSArray class]]){
		NSArray * componentDictionaries = dictionary[@"component"];
		NSMutableArray * componentItems = [NSMutableArray array];
		for(NSDictionary * componentDictionary in componentDictionaries){
			Component * componentItem = [[Component alloc] initWithDictionary:componentDictionary];
			[componentItems addObject:componentItem];
		}
		self.component = componentItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.component != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Component * componentElement in self.component){
			[dictionaryElements addObject:[componentElement toDictionary]];
		}
		dictionary[@"component"] = dictionaryElements;
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
	if(self.component != nil){
		[aCoder encodeObject:self.component forKey:@"component"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.component = [aDecoder decodeObjectForKey:@"component"];
	return self;

}
@end