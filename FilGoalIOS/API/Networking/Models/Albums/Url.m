//
//	Url.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Url.h"

NSString *const kUrlCaption = @"caption";
NSString *const kUrlLarge = @"large";
NSString *const kUrlSmall = @"small";
NSString *const kUrlXlarge = @"xlarge";

@interface Url ()
@end
@implementation Url




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kUrlCaption] isKindOfClass:[NSNull class]]){
		self.caption = dictionary[kUrlCaption];
	}	
	if(![dictionary[kUrlLarge] isKindOfClass:[NSNull class]]){
		self.large = dictionary[kUrlLarge];
	}	
	if(![dictionary[kUrlSmall] isKindOfClass:[NSNull class]]){
		self.small = dictionary[kUrlSmall];
	}	
	if(![dictionary[kUrlXlarge] isKindOfClass:[NSNull class]]){
		self.xlarge = dictionary[kUrlXlarge];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.caption != nil){
		dictionary[kUrlCaption] = self.caption;
	}
	if(self.large != nil){
		dictionary[kUrlLarge] = self.large;
	}
	if(self.small != nil){
		dictionary[kUrlSmall] = self.small;
	}
	if(self.xlarge != nil){
		dictionary[kUrlXlarge] = self.xlarge;
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
	if(self.caption != nil){
		[aCoder encodeObject:self.caption forKey:kUrlCaption];
	}
	if(self.large != nil){
		[aCoder encodeObject:self.large forKey:kUrlLarge];
	}
	if(self.small != nil){
		[aCoder encodeObject:self.small forKey:kUrlSmall];
	}
	if(self.xlarge != nil){
		[aCoder encodeObject:self.xlarge forKey:kUrlXlarge];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.caption = [aDecoder decodeObjectForKey:kUrlCaption];
	self.large = [aDecoder decodeObjectForKey:kUrlLarge];
	self.small = [aDecoder decodeObjectForKey:kUrlSmall];
	self.xlarge = [aDecoder decodeObjectForKey:kUrlXlarge];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Url *copy = [Url new];

	copy.caption = [self.caption copy];
	copy.large = [self.large copy];
	copy.small = [self.small copy];
	copy.xlarge = [self.xlarge copy];

	return copy;
}
@end