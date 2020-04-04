//
//	Channel.m
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Channel.h"

@interface Channel ()
@end
@implementation Channel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"image"] isKindOfClass:[NSNull class]]){
		self.image = [[Image alloc] initWithDictionary:dictionary[@"image"]];
	}

	if(![dictionary[@"item"] isKindOfClass:[NSNull class]]){
		self.item = [[ItemWeather alloc] initWithDictionary:dictionary[@"item"]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.image != nil){
		dictionary[@"image"] = [self.image toDictionary];
	}
	if(self.item != nil){
		dictionary[@"item"] = [self.item toDictionary];
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
	if(self.image != nil){
		[aCoder encodeObject:self.image forKey:@"image"];
	}
	if(self.item != nil){
		[aCoder encodeObject:self.item forKey:@"item"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.image = [aDecoder decodeObjectForKey:@"image"];
	self.item = [aDecoder decodeObjectForKey:@"item"];
	return self;

}
@end