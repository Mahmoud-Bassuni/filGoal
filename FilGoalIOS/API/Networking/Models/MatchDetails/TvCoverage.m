//
//	TvCoverage.m
//
//	Create by Nada Gamal on 13/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TvCoverage.h"

NSString *const kTvCoverageCommenterId = @"commenterId";
NSString *const kTvCoverageCommenterName = @"commenterName";
NSString *const kTvCoverageIdField = @"id";
NSString *const kTvCoverageMatchId = @"matchId";
NSString *const kTvCoverageSatelliteName = @"satelliteName";
NSString *const kTvCoverageTvChannelId = @"tvChannelId";
NSString *const kTvCoverageTvChannelName = @"tvChannelName";

@interface TvCoverage ()
@end
@implementation TvCoverage




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTvCoverageCommenterId] isKindOfClass:[NSNull class]]){
		self.commenterId = [dictionary[kTvCoverageCommenterId] integerValue];
	}

	if(![dictionary[kTvCoverageCommenterName] isKindOfClass:[NSNull class]]){
		self.commenterName = dictionary[kTvCoverageCommenterName];
	}	
	if(![dictionary[kTvCoverageIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kTvCoverageIdField] integerValue];
	}

	if(![dictionary[kTvCoverageMatchId] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kTvCoverageMatchId] integerValue];
	}

	if(![dictionary[kTvCoverageSatelliteName] isKindOfClass:[NSNull class]]){
		self.satelliteName = dictionary[kTvCoverageSatelliteName];
	}	
	if(![dictionary[kTvCoverageTvChannelId] isKindOfClass:[NSNull class]]){
		self.tvChannelId = [dictionary[kTvCoverageTvChannelId] integerValue];
	}

	if(![dictionary[kTvCoverageTvChannelName] isKindOfClass:[NSNull class]]){
		self.tvChannelName = dictionary[kTvCoverageTvChannelName];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kTvCoverageCommenterId] = @(self.commenterId);
	if(self.commenterName != nil){
		dictionary[kTvCoverageCommenterName] = self.commenterName;
	}
	dictionary[kTvCoverageIdField] = @(self.idField);
	dictionary[kTvCoverageMatchId] = @(self.matchId);
	if(self.satelliteName != nil){
		dictionary[kTvCoverageSatelliteName] = self.satelliteName;
	}
	dictionary[kTvCoverageTvChannelId] = @(self.tvChannelId);
	if(self.tvChannelName != nil){
		dictionary[kTvCoverageTvChannelName] = self.tvChannelName;
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
	[aCoder encodeObject:@(self.commenterId) forKey:kTvCoverageCommenterId];	if(self.commenterName != nil){
		[aCoder encodeObject:self.commenterName forKey:kTvCoverageCommenterName];
	}
	[aCoder encodeObject:@(self.idField) forKey:kTvCoverageIdField];	[aCoder encodeObject:@(self.matchId) forKey:kTvCoverageMatchId];	if(self.satelliteName != nil){
		[aCoder encodeObject:self.satelliteName forKey:kTvCoverageSatelliteName];
	}
	[aCoder encodeObject:@(self.tvChannelId) forKey:kTvCoverageTvChannelId];	if(self.tvChannelName != nil){
		[aCoder encodeObject:self.tvChannelName forKey:kTvCoverageTvChannelName];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.commenterId = [[aDecoder decodeObjectForKey:kTvCoverageCommenterId] integerValue];
	self.commenterName = [aDecoder decodeObjectForKey:kTvCoverageCommenterName];
	self.idField = [[aDecoder decodeObjectForKey:kTvCoverageIdField] integerValue];
	self.matchId = [[aDecoder decodeObjectForKey:kTvCoverageMatchId] integerValue];
	self.satelliteName = [aDecoder decodeObjectForKey:kTvCoverageSatelliteName];
	self.tvChannelId = [[aDecoder decodeObjectForKey:kTvCoverageTvChannelId] integerValue];
	self.tvChannelName = [aDecoder decodeObjectForKey:kTvCoverageTvChannelName];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	TvCoverage *copy = [TvCoverage new];

	copy.commenterId = self.commenterId;
	copy.commenterName = [self.commenterName copy];
	copy.idField = self.idField;
	copy.matchId = self.matchId;
	copy.satelliteName = [self.satelliteName copy];
	copy.tvChannelId = self.tvChannelId;
	copy.tvChannelName = [self.tvChannelName copy];

	return copy;
}
@end
