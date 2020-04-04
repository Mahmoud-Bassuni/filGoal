//
//	PostSquareClass.m
//
//	Create by Nada Gamal on 10/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "PostSquareClass.h"

NSString *const kPostSquareClassCreateTime = @"createTime";
NSString *const kPostSquareClassDate = @"date";
NSString *const kPostSquareClassGuid = @"guid";
NSString *const kPostSquareClassHour = @"hour";
NSString *const kPostSquareClassRecs = @"recs";
NSString *const kPostSquareClassRequestGeoCountry = @"requestGeoCountry";
NSString *const kPostSquareClassRequestGeoRegion = @"requestGeoRegion";
NSString *const kPostSquareClassRequestId = @"requestId";
NSString *const kPostSquareClassResponseTime = @"responseTime";
NSString *const kPostSquareClassRndid = @"rndid";
NSString *const kPostSquareClassSrcAdminNetworkId = @"srcAdminNetworkId";
NSString *const kPostSquareClassSrcCategoryId = @"srcCategoryId";
NSString *const kPostSquareClassSrcPostId = @"srcPostId";
NSString *const kPostSquareClassSrcSubId = @"srcSubId";
NSString *const kPostSquareClassSrcWebsiteId = @"srcWebsiteId";
NSString *const kPostSquareClassSrcWidgetId = @"srcWidgetId";
NSString *const kPostSquareClassStatus = @"status";
NSString *const kPostSquareClassUserLocalTimestamp = @"userLocalTimestamp";
NSString *const kPostSquareClassViewPxl = @"viewPxl";
NSString *const kPostSquareClassWidget = @"widget";

@interface PostSquareClass ()
@end
@implementation PostSquareClass




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kPostSquareClassCreateTime] isKindOfClass:[NSNull class]]){
		self.createTime = [dictionary[kPostSquareClassCreateTime] integerValue];
	}

	if(![dictionary[kPostSquareClassDate] isKindOfClass:[NSNull class]]){
		self.date = dictionary[kPostSquareClassDate];
	}	
	if(![dictionary[kPostSquareClassGuid] isKindOfClass:[NSNull class]]){
		self.guid = dictionary[kPostSquareClassGuid];
	}	
	if(![dictionary[kPostSquareClassHour] isKindOfClass:[NSNull class]]){
		self.hour = [dictionary[kPostSquareClassHour] integerValue];
	}

	if(dictionary[kPostSquareClassRecs] != nil && [dictionary[kPostSquareClassRecs] isKindOfClass:[NSArray class]]){
		NSArray * recsDictionaries = dictionary[kPostSquareClassRecs];
		NSMutableArray * recsItems = [NSMutableArray array];
		for(NSDictionary * recsDictionary in recsDictionaries){
			Rec * recsItem = [[Rec alloc] initWithDictionary:recsDictionary];
			[recsItems addObject:recsItem];
		}
		self.recs = recsItems;
	}
	if(![dictionary[kPostSquareClassRequestGeoCountry] isKindOfClass:[NSNull class]]){
		self.requestGeoCountry = dictionary[kPostSquareClassRequestGeoCountry];
	}	
	if(![dictionary[kPostSquareClassRequestGeoRegion] isKindOfClass:[NSNull class]]){
		self.requestGeoRegion = dictionary[kPostSquareClassRequestGeoRegion];
	}	
	if(![dictionary[kPostSquareClassRequestId] isKindOfClass:[NSNull class]]){
		self.requestId = dictionary[kPostSquareClassRequestId];
	}	
	if(![dictionary[kPostSquareClassResponseTime] isKindOfClass:[NSNull class]]){
		self.responseTime = [dictionary[kPostSquareClassResponseTime] integerValue];
	}

	if(![dictionary[kPostSquareClassRndid] isKindOfClass:[NSNull class]]){
		self.rndid = [dictionary[kPostSquareClassRndid] integerValue];
	}

	if(![dictionary[kPostSquareClassSrcAdminNetworkId] isKindOfClass:[NSNull class]]){
		self.srcAdminNetworkId = [dictionary[kPostSquareClassSrcAdminNetworkId] integerValue];
	}

	if(![dictionary[kPostSquareClassSrcCategoryId] isKindOfClass:[NSNull class]]){
		self.srcCategoryId = [dictionary[kPostSquareClassSrcCategoryId] integerValue];
	}

	if(![dictionary[kPostSquareClassSrcPostId] isKindOfClass:[NSNull class]]){
		self.srcPostId = [dictionary[kPostSquareClassSrcPostId] integerValue];
	}

	if(![dictionary[kPostSquareClassSrcSubId] isKindOfClass:[NSNull class]]){
		self.srcSubId = dictionary[kPostSquareClassSrcSubId];
	}	
	if(![dictionary[kPostSquareClassSrcWebsiteId] isKindOfClass:[NSNull class]]){
		self.srcWebsiteId = [dictionary[kPostSquareClassSrcWebsiteId] integerValue];
	}

	if(![dictionary[kPostSquareClassSrcWidgetId] isKindOfClass:[NSNull class]]){
		self.srcWidgetId = [dictionary[kPostSquareClassSrcWidgetId] integerValue];
	}

	if(![dictionary[kPostSquareClassStatus] isKindOfClass:[NSNull class]]){
		self.status = dictionary[kPostSquareClassStatus];
	}	
	if(![dictionary[kPostSquareClassUserLocalTimestamp] isKindOfClass:[NSNull class]]){
		self.userLocalTimestamp = [dictionary[kPostSquareClassUserLocalTimestamp] integerValue];
	}

	if(![dictionary[kPostSquareClassViewPxl] isKindOfClass:[NSNull class]]){
		self.viewPxl = dictionary[kPostSquareClassViewPxl];
	}	
	if(![dictionary[kPostSquareClassWidget] isKindOfClass:[NSNull class]]){
		self.widget = [[Widget alloc] initWithDictionary:dictionary[kPostSquareClassWidget]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kPostSquareClassCreateTime] = @(self.createTime);
	if(self.date != nil){
		dictionary[kPostSquareClassDate] = self.date;
	}
	if(self.guid != nil){
		dictionary[kPostSquareClassGuid] = self.guid;
	}
	dictionary[kPostSquareClassHour] = @(self.hour);
	if(self.recs != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Rec * recsElement in self.recs){
			[dictionaryElements addObject:[recsElement toDictionary]];
		}
		dictionary[kPostSquareClassRecs] = dictionaryElements;
	}
	if(self.requestGeoCountry != nil){
		dictionary[kPostSquareClassRequestGeoCountry] = self.requestGeoCountry;
	}
	if(self.requestGeoRegion != nil){
		dictionary[kPostSquareClassRequestGeoRegion] = self.requestGeoRegion;
	}
	if(self.requestId != nil){
		dictionary[kPostSquareClassRequestId] = self.requestId;
	}
	dictionary[kPostSquareClassResponseTime] = @(self.responseTime);
	dictionary[kPostSquareClassRndid] = @(self.rndid);
	dictionary[kPostSquareClassSrcAdminNetworkId] = @(self.srcAdminNetworkId);
	dictionary[kPostSquareClassSrcCategoryId] = @(self.srcCategoryId);
	dictionary[kPostSquareClassSrcPostId] = @(self.srcPostId);
	if(self.srcSubId != nil){
		dictionary[kPostSquareClassSrcSubId] = self.srcSubId;
	}
	dictionary[kPostSquareClassSrcWebsiteId] = @(self.srcWebsiteId);
	dictionary[kPostSquareClassSrcWidgetId] = @(self.srcWidgetId);
	if(self.status != nil){
		dictionary[kPostSquareClassStatus] = self.status;
	}
	dictionary[kPostSquareClassUserLocalTimestamp] = @(self.userLocalTimestamp);
	if(self.viewPxl != nil){
		dictionary[kPostSquareClassViewPxl] = self.viewPxl;
	}
	if(self.widget != nil){
		dictionary[kPostSquareClassWidget] = [self.widget toDictionary];
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
	[aCoder encodeObject:@(self.createTime) forKey:kPostSquareClassCreateTime];	if(self.date != nil){
		[aCoder encodeObject:self.date forKey:kPostSquareClassDate];
	}
	if(self.guid != nil){
		[aCoder encodeObject:self.guid forKey:kPostSquareClassGuid];
	}
	[aCoder encodeObject:@(self.hour) forKey:kPostSquareClassHour];	if(self.recs != nil){
		[aCoder encodeObject:self.recs forKey:kPostSquareClassRecs];
	}
	if(self.requestGeoCountry != nil){
		[aCoder encodeObject:self.requestGeoCountry forKey:kPostSquareClassRequestGeoCountry];
	}
	if(self.requestGeoRegion != nil){
		[aCoder encodeObject:self.requestGeoRegion forKey:kPostSquareClassRequestGeoRegion];
	}
	if(self.requestId != nil){
		[aCoder encodeObject:self.requestId forKey:kPostSquareClassRequestId];
	}
	[aCoder encodeObject:@(self.responseTime) forKey:kPostSquareClassResponseTime];	[aCoder encodeObject:@(self.rndid) forKey:kPostSquareClassRndid];	[aCoder encodeObject:@(self.srcAdminNetworkId) forKey:kPostSquareClassSrcAdminNetworkId];	[aCoder encodeObject:@(self.srcCategoryId) forKey:kPostSquareClassSrcCategoryId];	[aCoder encodeObject:@(self.srcPostId) forKey:kPostSquareClassSrcPostId];	if(self.srcSubId != nil){
		[aCoder encodeObject:self.srcSubId forKey:kPostSquareClassSrcSubId];
	}
	[aCoder encodeObject:@(self.srcWebsiteId) forKey:kPostSquareClassSrcWebsiteId];	[aCoder encodeObject:@(self.srcWidgetId) forKey:kPostSquareClassSrcWidgetId];	if(self.status != nil){
		[aCoder encodeObject:self.status forKey:kPostSquareClassStatus];
	}
	[aCoder encodeObject:@(self.userLocalTimestamp) forKey:kPostSquareClassUserLocalTimestamp];	if(self.viewPxl != nil){
		[aCoder encodeObject:self.viewPxl forKey:kPostSquareClassViewPxl];
	}
	if(self.widget != nil){
		[aCoder encodeObject:self.widget forKey:kPostSquareClassWidget];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.createTime = [[aDecoder decodeObjectForKey:kPostSquareClassCreateTime] integerValue];
	self.date = [aDecoder decodeObjectForKey:kPostSquareClassDate];
	self.guid = [aDecoder decodeObjectForKey:kPostSquareClassGuid];
	self.hour = [[aDecoder decodeObjectForKey:kPostSquareClassHour] integerValue];
	self.recs = [aDecoder decodeObjectForKey:kPostSquareClassRecs];
	self.requestGeoCountry = [aDecoder decodeObjectForKey:kPostSquareClassRequestGeoCountry];
	self.requestGeoRegion = [aDecoder decodeObjectForKey:kPostSquareClassRequestGeoRegion];
	self.requestId = [aDecoder decodeObjectForKey:kPostSquareClassRequestId];
	self.responseTime = [[aDecoder decodeObjectForKey:kPostSquareClassResponseTime] integerValue];
	self.rndid = [[aDecoder decodeObjectForKey:kPostSquareClassRndid] integerValue];
	self.srcAdminNetworkId = [[aDecoder decodeObjectForKey:kPostSquareClassSrcAdminNetworkId] integerValue];
	self.srcCategoryId = [[aDecoder decodeObjectForKey:kPostSquareClassSrcCategoryId] integerValue];
	self.srcPostId = [[aDecoder decodeObjectForKey:kPostSquareClassSrcPostId] integerValue];
	self.srcSubId = [aDecoder decodeObjectForKey:kPostSquareClassSrcSubId];
	self.srcWebsiteId = [[aDecoder decodeObjectForKey:kPostSquareClassSrcWebsiteId] integerValue];
	self.srcWidgetId = [[aDecoder decodeObjectForKey:kPostSquareClassSrcWidgetId] integerValue];
	self.status = [aDecoder decodeObjectForKey:kPostSquareClassStatus];
	self.userLocalTimestamp = [[aDecoder decodeObjectForKey:kPostSquareClassUserLocalTimestamp] integerValue];
	self.viewPxl = [aDecoder decodeObjectForKey:kPostSquareClassViewPxl];
	self.widget = [aDecoder decodeObjectForKey:kPostSquareClassWidget];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	PostSquareClass *copy = [PostSquareClass new];

	copy.createTime = self.createTime;
	copy.date = [self.date copy];
	copy.guid = [self.guid copy];
	copy.hour = self.hour;
	copy.recs = [self.recs copy];
	copy.requestGeoCountry = [self.requestGeoCountry copy];
	copy.requestGeoRegion = [self.requestGeoRegion copy];
	copy.requestId = [self.requestId copy];
	copy.responseTime = self.responseTime;
	copy.rndid = self.rndid;
	copy.srcAdminNetworkId = self.srcAdminNetworkId;
	copy.srcCategoryId = self.srcCategoryId;
	copy.srcPostId = self.srcPostId;
	copy.srcSubId = [self.srcSubId copy];
	copy.srcWebsiteId = self.srcWebsiteId;
	copy.srcWidgetId = self.srcWidgetId;
	copy.status = [self.status copy];
	copy.userLocalTimestamp = self.userLocalTimestamp;
	copy.viewPxl = [self.viewPxl copy];
	copy.widget = [self.widget copy];

	return copy;
}
@end