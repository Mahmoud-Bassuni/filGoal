//
//	Result.m
//
//	Create by Nada Gamal on 10/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ActiveChampion.h"

NSString *const kActiveChampionChampId = @"champId";
NSString *const kActiveChampionRoundIds = @"roundIds";

@interface ActiveChampion ()
@end
@implementation ActiveChampion




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kActiveChampionChampId] isKindOfClass:[NSNull class]]){
		self.champId = [dictionary[kActiveChampionChampId] integerValue];
	}

	if(![dictionary[kActiveChampionRoundIds] isKindOfClass:[NSNull class]]){
		self.roundIds = dictionary[kActiveChampionRoundIds];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kActiveChampionChampId] = @(self.champId);
	if(self.roundIds != nil){
		dictionary[kActiveChampionRoundIds] = self.roundIds;
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
	[aCoder encodeObject:@(self.champId) forKey:kActiveChampionChampId];	if(self.roundIds != nil){
		[aCoder encodeObject:self.roundIds forKey:kActiveChampionRoundIds];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.champId = [[aDecoder decodeObjectForKey:kActiveChampionChampId] integerValue];
	self.roundIds = [aDecoder decodeObjectForKey:kActiveChampionRoundIds];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	ActiveChampion *copy = [ActiveChampion new];
	copy.champId = self.champId;
	copy.roundIds = [self.roundIds copy];

	return copy;
}
@end
