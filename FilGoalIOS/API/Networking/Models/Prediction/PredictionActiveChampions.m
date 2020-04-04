//
//	PredictionActiveChampions.m
//
//	Create by Nada Gamal on 10/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PredictionActiveChampions.h"
#import "ActiveChampion.h"
NSString *const kPredictionActiveChampionsIsValid = @"isValid";
NSString *const kPredictionActiveChampionsResult = @"result";
NSString *const kPredictionActiveChampionsStatus = @"status";
NSString *const kPredictionActiveChampionsTotalCount = @"totalCount";

@interface PredictionActiveChampions ()
@end
@implementation PredictionActiveChampions




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPredictionActiveChampionsIsValid] isKindOfClass:[NSNull class]]){
		self.isValid = [dictionary[kPredictionActiveChampionsIsValid] boolValue];
	}

	if(dictionary[kPredictionActiveChampionsResult] != nil && [dictionary[kPredictionActiveChampionsResult] isKindOfClass:[NSArray class]]){
		NSArray * resultDictionaries = dictionary[kPredictionActiveChampionsResult];
		NSMutableArray * resultItems = [NSMutableArray array];
		for(NSDictionary * resultDictionary in resultDictionaries){
			ActiveChampion * resultItem = [[ActiveChampion alloc] initWithDictionary:resultDictionary];
			[resultItems addObject:resultItem];
		}
		self.result = resultItems;
	}
	if(![dictionary[kPredictionActiveChampionsStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kPredictionActiveChampionsStatus] integerValue];
	}

	if(![dictionary[kPredictionActiveChampionsTotalCount] isKindOfClass:[NSNull class]]){
		self.totalCount = [dictionary[kPredictionActiveChampionsTotalCount] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kPredictionActiveChampionsIsValid] = @(self.isValid);
	if(self.result != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(ActiveChampion * resultElement in self.result){
			[dictionaryElements addObject:[resultElement toDictionary]];
		}
		dictionary[kPredictionActiveChampionsResult] = dictionaryElements;
	}
	dictionary[kPredictionActiveChampionsStatus] = @(self.status);
	dictionary[kPredictionActiveChampionsTotalCount] = @(self.totalCount);
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
	[aCoder encodeObject:@(self.isValid) forKey:kPredictionActiveChampionsIsValid];	if(self.result != nil){
		[aCoder encodeObject:self.result forKey:kPredictionActiveChampionsResult];
	}
	[aCoder encodeObject:@(self.status) forKey:kPredictionActiveChampionsStatus];	[aCoder encodeObject:@(self.totalCount) forKey:kPredictionActiveChampionsTotalCount];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.isValid = [[aDecoder decodeObjectForKey:kPredictionActiveChampionsIsValid] boolValue];
	self.result = [aDecoder decodeObjectForKey:kPredictionActiveChampionsResult];
	self.status = [[aDecoder decodeObjectForKey:kPredictionActiveChampionsStatus] integerValue];
	self.totalCount = [[aDecoder decodeObjectForKey:kPredictionActiveChampionsTotalCount] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	PredictionActiveChampions *copy = [PredictionActiveChampions new];

	copy.isValid = self.isValid;
	copy.result = [self.result copy];
	copy.status = self.status;
	copy.totalCount = self.totalCount;

	return copy;
}
@end
