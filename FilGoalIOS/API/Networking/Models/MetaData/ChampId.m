//
//	ChampId.m
//
//	Create by Mohamed Mansour on 3/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ChampId.h"

@interface ChampId ()
@end
@implementation ChampId




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"ChampID"] isKindOfClass:[NSNull class]]){
		self.champID = [dictionary[@"ChampID"] integerValue];
	}

	if(![dictionary[@"DisplayOrder"] isKindOfClass:[NSNull class]]){
		self.displayOrder = [dictionary[@"DisplayOrder"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[@"ChampID"] = @(self.champID);
	dictionary[@"DisplayOrder"] = @(self.displayOrder);
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
	[aCoder encodeObject:@(self.champID) forKey:@"ChampID"];	[aCoder encodeObject:@(self.displayOrder) forKey:@"DisplayOrder"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.champID = [[aDecoder decodeObjectForKey:@"ChampID"] integerValue];
	self.displayOrder = [[aDecoder decodeObjectForKey:@"DisplayOrder"] integerValue];
	return self;

}
@end