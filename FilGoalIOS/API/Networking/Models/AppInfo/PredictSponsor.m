//
//	PredictSponsor.m
//
//	Create by Nada Gamal on 21/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PredictSponsor.h"

NSString *const kPredictSponsorChampsIds = @"champs_ids";

@interface PredictSponsor ()
@end
@implementation PredictSponsor




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPredictSponsorChampsIds] isKindOfClass:[NSNull class]]){
		self.champsIds = dictionary[kPredictSponsorChampsIds];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.champsIds != nil){
		dictionary[kPredictSponsorChampsIds] = self.champsIds;
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
	if(self.champsIds != nil){
		[aCoder encodeObject:self.champsIds forKey:kPredictSponsorChampsIds];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.champsIds = [aDecoder decodeObjectForKey:kPredictSponsorChampsIds];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	PredictSponsor *copy = [PredictSponsor new];

	copy.champsIds = [self.champsIds copy];

	return copy;
}
@end
