//
//	Rec.m
//
//	Create by Nada Gamal on 10/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Rec.h"

NSString *const kRecAjx = @"ajx";
NSString *const kRecCategoryId = @"category_id";
NSString *const kRecClickUrl = @"clickUrl";
NSString *const kRecDescriptionField = @"description";
NSString *const kRecDisplayName = @"displayName";
NSString *const kRecGeoTags = @"geo_tags";
NSString *const kRecImpressionUrls = @"impressionUrls";
NSString *const kRecMetatagLabels = @"metatagLabels";
NSString *const kRecMetatags = @"metatags";
NSString *const kRecPartnerId = @"partner_id";
NSString *const kRecPostId = @"postId";
NSString *const kRecPostType = @"postType";
NSString *const kRecRecType = @"recType";
NSString *const kRecRecTypeDB = @"recTypeDB";
NSString *const kRecTargetClickUrl = @"targetClickUrl";
NSString *const kRecThumbnailPath = @"thumbnail_path";
NSString *const kRecTitle = @"title";
NSString *const kRecUrl = @"url";

@interface Rec ()
@end
@implementation Rec




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kRecAjx] isKindOfClass:[NSNull class]]){
		self.ajx = [dictionary[kRecAjx] boolValue];
	}

	if(![dictionary[kRecCategoryId] isKindOfClass:[NSNull class]]){
		self.categoryId = [dictionary[kRecCategoryId] integerValue];
	}

	if(![dictionary[kRecClickUrl] isKindOfClass:[NSNull class]]){
		self.clickUrl = dictionary[kRecClickUrl];
	}	
	if(![dictionary[kRecDescriptionField] isKindOfClass:[NSNull class]]){
		self.descriptionField = dictionary[kRecDescriptionField];
	}	
	if(![dictionary[kRecDisplayName] isKindOfClass:[NSNull class]]){
		self.displayName = dictionary[kRecDisplayName];
	}	
	if(![dictionary[kRecGeoTags] isKindOfClass:[NSNull class]]){
		self.geoTags = dictionary[kRecGeoTags];
	}	
	if(![dictionary[kRecImpressionUrls] isKindOfClass:[NSNull class]]){
		self.impressionUrls = dictionary[kRecImpressionUrls];
	}	
	if(![dictionary[kRecMetatagLabels] isKindOfClass:[NSNull class]]){
		self.metatagLabels = dictionary[kRecMetatagLabels];
	}	
	if(![dictionary[kRecMetatags] isKindOfClass:[NSNull class]]){
		self.metatags = dictionary[kRecMetatags];
	}	
	if(![dictionary[kRecPartnerId] isKindOfClass:[NSNull class]]){
		self.partnerId = [dictionary[kRecPartnerId] integerValue];
	}

	if(![dictionary[kRecPostId] isKindOfClass:[NSNull class]]){
		self.postId = [dictionary[kRecPostId] integerValue];
	}

	if(![dictionary[kRecPostType] isKindOfClass:[NSNull class]]){
		self.postType = [dictionary[kRecPostType] integerValue];
	}

	if(![dictionary[kRecRecType] isKindOfClass:[NSNull class]]){
		self.recType = dictionary[kRecRecType];
	}	
	if(![dictionary[kRecRecTypeDB] isKindOfClass:[NSNull class]]){
		self.recTypeDB = [dictionary[kRecRecTypeDB] integerValue];
	}

	if(![dictionary[kRecTargetClickUrl] isKindOfClass:[NSNull class]]){
		self.targetClickUrl = dictionary[kRecTargetClickUrl];
	}	
	if(![dictionary[kRecThumbnailPath] isKindOfClass:[NSNull class]]){
		self.thumbnailPath = dictionary[kRecThumbnailPath];
	}	
	if(![dictionary[kRecTitle] isKindOfClass:[NSNull class]]){
		self.title = dictionary[kRecTitle];
	}	
	if(![dictionary[kRecUrl] isKindOfClass:[NSNull class]]){
		self.url = dictionary[kRecUrl];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kRecAjx] = @(self.ajx);
	dictionary[kRecCategoryId] = @(self.categoryId);
	if(self.clickUrl != nil){
		dictionary[kRecClickUrl] = self.clickUrl;
	}
	if(self.descriptionField != nil){
		dictionary[kRecDescriptionField] = self.descriptionField;
	}
	if(self.displayName != nil){
		dictionary[kRecDisplayName] = self.displayName;
	}
	if(self.geoTags != nil){
		dictionary[kRecGeoTags] = self.geoTags;
	}
	if(self.impressionUrls != nil){
		dictionary[kRecImpressionUrls] = self.impressionUrls;
	}
	if(self.metatagLabels != nil){
		dictionary[kRecMetatagLabels] = self.metatagLabels;
	}
	if(self.metatags != nil){
		dictionary[kRecMetatags] = self.metatags;
	}
	dictionary[kRecPartnerId] = @(self.partnerId);
	dictionary[kRecPostId] = @(self.postId);
	dictionary[kRecPostType] = @(self.postType);
	if(self.recType != nil){
		dictionary[kRecRecType] = self.recType;
	}
	dictionary[kRecRecTypeDB] = @(self.recTypeDB);
	if(self.targetClickUrl != nil){
		dictionary[kRecTargetClickUrl] = self.targetClickUrl;
	}
	if(self.thumbnailPath != nil){
		dictionary[kRecThumbnailPath] = self.thumbnailPath;
	}
	if(self.title != nil){
		dictionary[kRecTitle] = self.title;
	}
	if(self.url != nil){
		dictionary[kRecUrl] = self.url;
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
	[aCoder encodeObject:@(self.ajx) forKey:kRecAjx];	[aCoder encodeObject:@(self.categoryId) forKey:kRecCategoryId];	if(self.clickUrl != nil){
		[aCoder encodeObject:self.clickUrl forKey:kRecClickUrl];
	}
	if(self.descriptionField != nil){
		[aCoder encodeObject:self.descriptionField forKey:kRecDescriptionField];
	}
	if(self.displayName != nil){
		[aCoder encodeObject:self.displayName forKey:kRecDisplayName];
	}
	if(self.geoTags != nil){
		[aCoder encodeObject:self.geoTags forKey:kRecGeoTags];
	}
	if(self.impressionUrls != nil){
		[aCoder encodeObject:self.impressionUrls forKey:kRecImpressionUrls];
	}
	if(self.metatagLabels != nil){
		[aCoder encodeObject:self.metatagLabels forKey:kRecMetatagLabels];
	}
	if(self.metatags != nil){
		[aCoder encodeObject:self.metatags forKey:kRecMetatags];
	}
	[aCoder encodeObject:@(self.partnerId) forKey:kRecPartnerId];	[aCoder encodeObject:@(self.postId) forKey:kRecPostId];	[aCoder encodeObject:@(self.postType) forKey:kRecPostType];	if(self.recType != nil){
		[aCoder encodeObject:self.recType forKey:kRecRecType];
	}
	[aCoder encodeObject:@(self.recTypeDB) forKey:kRecRecTypeDB];	if(self.targetClickUrl != nil){
		[aCoder encodeObject:self.targetClickUrl forKey:kRecTargetClickUrl];
	}
	if(self.thumbnailPath != nil){
		[aCoder encodeObject:self.thumbnailPath forKey:kRecThumbnailPath];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:kRecTitle];
	}
	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:kRecUrl];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.ajx = [[aDecoder decodeObjectForKey:kRecAjx] boolValue];
	self.categoryId = [[aDecoder decodeObjectForKey:kRecCategoryId] integerValue];
	self.clickUrl = [aDecoder decodeObjectForKey:kRecClickUrl];
	self.descriptionField = [aDecoder decodeObjectForKey:kRecDescriptionField];
	self.displayName = [aDecoder decodeObjectForKey:kRecDisplayName];
	self.geoTags = [aDecoder decodeObjectForKey:kRecGeoTags];
	self.impressionUrls = [aDecoder decodeObjectForKey:kRecImpressionUrls];
	self.metatagLabels = [aDecoder decodeObjectForKey:kRecMetatagLabels];
	self.metatags = [aDecoder decodeObjectForKey:kRecMetatags];
	self.partnerId = [[aDecoder decodeObjectForKey:kRecPartnerId] integerValue];
	self.postId = [[aDecoder decodeObjectForKey:kRecPostId] integerValue];
	self.postType = [[aDecoder decodeObjectForKey:kRecPostType] integerValue];
	self.recType = [aDecoder decodeObjectForKey:kRecRecType];
	self.recTypeDB = [[aDecoder decodeObjectForKey:kRecRecTypeDB] integerValue];
	self.targetClickUrl = [aDecoder decodeObjectForKey:kRecTargetClickUrl];
	self.thumbnailPath = [aDecoder decodeObjectForKey:kRecThumbnailPath];
	self.title = [aDecoder decodeObjectForKey:kRecTitle];
	self.url = [aDecoder decodeObjectForKey:kRecUrl];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Rec *copy = [Rec new];

	copy.ajx = self.ajx;
	copy.categoryId = self.categoryId;
	copy.clickUrl = [self.clickUrl copy];
	copy.descriptionField = [self.descriptionField copy];
	copy.displayName = [self.displayName copy];
	copy.geoTags = [self.geoTags copy];
	copy.impressionUrls = [self.impressionUrls copy];
	copy.metatagLabels = [self.metatagLabels copy];
	copy.metatags = [self.metatags copy];
	copy.partnerId = self.partnerId;
	copy.postId = self.postId;
	copy.postType = self.postType;
	copy.recType = [self.recType copy];
	copy.recTypeDB = self.recTypeDB;
	copy.targetClickUrl = [self.targetClickUrl copy];
	copy.thumbnailPath = [self.thumbnailPath copy];
	copy.title = [self.title copy];
	copy.url = [self.url copy];

	return copy;
}
@end