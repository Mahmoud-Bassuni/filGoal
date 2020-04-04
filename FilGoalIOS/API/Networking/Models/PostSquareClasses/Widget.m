//
//	Widget.m
//
//	Create by Nada Gamal on 10/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Widget.h"

NSString *const kWidgetAdditionalData = @"additionalData";
NSString *const kWidgetAnad = @"anad";
NSString *const kWidgetBackgroundColor = @"backgroundColor";
NSString *const kWidgetBackgroundColorType = @"backgroundColorType";
NSString *const kWidgetBrandingId = @"brandingId";
NSString *const kWidgetDisplayRows = @"displayRows";
NSString *const kWidgetDisplayTags = @"displayTags";
NSString *const kWidgetEsaData = @"esaData";
NSString *const kWidgetFontColor = @"fontColor";
NSString *const kWidgetFontFamily = @"fontFamily";
NSString *const kWidgetHeaderText = @"headerText";
NSString *const kWidgetHeaderText2 = @"headerText2";
NSString *const kWidgetIdField = @"id";
NSString *const kWidgetIsDisplayed = @"isDisplayed";
NSString *const kWidgetIsRealImpressions = @"isRealImpressions";
NSString *const kWidgetLayoutTypeId = @"layoutTypeId";
NSString *const kWidgetPlatform = @"platform";
NSString *const kWidgetPublisherId = @"publisherId";
NSString *const kWidgetSlideAnimationColorReminder = @"slideAnimationColorReminder";
NSString *const kWidgetTextDirection = @"textDirection";
NSString *const kWidgetThumbnailSizeId = @"thumbnailSizeId";
NSString *const kWidgetTitleFontSize = @"titleFontSize";
NSString *const kWidgetWebsiteId = @"websiteId";
NSString *const kWidgetWebsiteLanguageId = @"websiteLanguageId";
NSString *const kWidgetWidgetXPath = @"widgetXPath";

@interface Widget ()
@end
@implementation Widget




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kWidgetAdditionalData] isKindOfClass:[NSNull class]]){
		self.additionalData = dictionary[kWidgetAdditionalData];
	}	
	if(![dictionary[kWidgetAnad] isKindOfClass:[NSNull class]]){
		self.anad = dictionary[kWidgetAnad];
	}	
	if(![dictionary[kWidgetBackgroundColor] isKindOfClass:[NSNull class]]){
		self.backgroundColor = dictionary[kWidgetBackgroundColor];
	}	
	if(![dictionary[kWidgetBackgroundColorType] isKindOfClass:[NSNull class]]){
		self.backgroundColorType = [dictionary[kWidgetBackgroundColorType] integerValue];
	}

	if(![dictionary[kWidgetBrandingId] isKindOfClass:[NSNull class]]){
		self.brandingId = [dictionary[kWidgetBrandingId] integerValue];
	}

	if(![dictionary[kWidgetDisplayRows] isKindOfClass:[NSNull class]]){
		self.displayRows = [dictionary[kWidgetDisplayRows] integerValue];
	}

	if(![dictionary[kWidgetDisplayTags] isKindOfClass:[NSNull class]]){
		self.displayTags = dictionary[kWidgetDisplayTags];
	}	
	if(![dictionary[kWidgetEsaData] isKindOfClass:[NSNull class]]){
		self.esaData = dictionary[kWidgetEsaData];
	}	
	if(![dictionary[kWidgetFontColor] isKindOfClass:[NSNull class]]){
		self.fontColor = dictionary[kWidgetFontColor];
	}	
	if(![dictionary[kWidgetFontFamily] isKindOfClass:[NSNull class]]){
		self.fontFamily = dictionary[kWidgetFontFamily];
	}	
	if(![dictionary[kWidgetHeaderText] isKindOfClass:[NSNull class]]){
		self.headerText = dictionary[kWidgetHeaderText];
	}	
	if(![dictionary[kWidgetHeaderText2] isKindOfClass:[NSNull class]]){
		self.headerText2 = dictionary[kWidgetHeaderText2];
	}	
	if(![dictionary[kWidgetIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kWidgetIdField] integerValue];
	}

	if(![dictionary[kWidgetIsDisplayed] isKindOfClass:[NSNull class]]){
		self.isDisplayed = [dictionary[kWidgetIsDisplayed] integerValue];
	}

	if(![dictionary[kWidgetIsRealImpressions] isKindOfClass:[NSNull class]]){
		self.isRealImpressions = [dictionary[kWidgetIsRealImpressions] boolValue];
	}

	if(![dictionary[kWidgetLayoutTypeId] isKindOfClass:[NSNull class]]){
		self.layoutTypeId = [dictionary[kWidgetLayoutTypeId] integerValue];
	}

	if(![dictionary[kWidgetPlatform] isKindOfClass:[NSNull class]]){
		self.platform = [dictionary[kWidgetPlatform] integerValue];
	}

	if(![dictionary[kWidgetPublisherId] isKindOfClass:[NSNull class]]){
		self.publisherId = [dictionary[kWidgetPublisherId] integerValue];
	}

	if(![dictionary[kWidgetSlideAnimationColorReminder] isKindOfClass:[NSNull class]]){
		self.slideAnimationColorReminder = [dictionary[kWidgetSlideAnimationColorReminder] integerValue];
	}

	if(![dictionary[kWidgetTextDirection] isKindOfClass:[NSNull class]]){
		self.textDirection = [dictionary[kWidgetTextDirection] integerValue];
	}

	if(![dictionary[kWidgetThumbnailSizeId] isKindOfClass:[NSNull class]]){
		self.thumbnailSizeId = dictionary[kWidgetThumbnailSizeId];
	}	
	if(![dictionary[kWidgetTitleFontSize] isKindOfClass:[NSNull class]]){
		self.titleFontSize = [dictionary[kWidgetTitleFontSize] integerValue];
	}

	if(![dictionary[kWidgetWebsiteId] isKindOfClass:[NSNull class]]){
		self.websiteId = [dictionary[kWidgetWebsiteId] integerValue];
	}

	if(![dictionary[kWidgetWebsiteLanguageId] isKindOfClass:[NSNull class]]){
		self.websiteLanguageId = [dictionary[kWidgetWebsiteLanguageId] integerValue];
	}

	if(![dictionary[kWidgetWidgetXPath] isKindOfClass:[NSNull class]]){
		self.widgetXPath = dictionary[kWidgetWidgetXPath];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.additionalData != nil){
		dictionary[kWidgetAdditionalData] = self.additionalData;
	}
	if(self.anad != nil){
		dictionary[kWidgetAnad] = self.anad;
	}
	if(self.backgroundColor != nil){
		dictionary[kWidgetBackgroundColor] = self.backgroundColor;
	}
	dictionary[kWidgetBackgroundColorType] = @(self.backgroundColorType);
	dictionary[kWidgetBrandingId] = @(self.brandingId);
	dictionary[kWidgetDisplayRows] = @(self.displayRows);
	if(self.displayTags != nil){
		dictionary[kWidgetDisplayTags] = self.displayTags;
	}
	if(self.esaData != nil){
		dictionary[kWidgetEsaData] = self.esaData;
	}
	if(self.fontColor != nil){
		dictionary[kWidgetFontColor] = self.fontColor;
	}
	if(self.fontFamily != nil){
		dictionary[kWidgetFontFamily] = self.fontFamily;
	}
	if(self.headerText != nil){
		dictionary[kWidgetHeaderText] = self.headerText;
	}
	if(self.headerText2 != nil){
		dictionary[kWidgetHeaderText2] = self.headerText2;
	}
	dictionary[kWidgetIdField] = @(self.idField);
	dictionary[kWidgetIsDisplayed] = @(self.isDisplayed);
	dictionary[kWidgetIsRealImpressions] = @(self.isRealImpressions);
	dictionary[kWidgetLayoutTypeId] = @(self.layoutTypeId);
	dictionary[kWidgetPlatform] = @(self.platform);
	dictionary[kWidgetPublisherId] = @(self.publisherId);
	dictionary[kWidgetSlideAnimationColorReminder] = @(self.slideAnimationColorReminder);
	dictionary[kWidgetTextDirection] = @(self.textDirection);
	if(self.thumbnailSizeId != nil){
		dictionary[kWidgetThumbnailSizeId] = self.thumbnailSizeId;
	}
	dictionary[kWidgetTitleFontSize] = @(self.titleFontSize);
	dictionary[kWidgetWebsiteId] = @(self.websiteId);
	dictionary[kWidgetWebsiteLanguageId] = @(self.websiteLanguageId);
	if(self.widgetXPath != nil){
		dictionary[kWidgetWidgetXPath] = self.widgetXPath;
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
	if(self.additionalData != nil){
		[aCoder encodeObject:self.additionalData forKey:kWidgetAdditionalData];
	}
	if(self.anad != nil){
		[aCoder encodeObject:self.anad forKey:kWidgetAnad];
	}
	if(self.backgroundColor != nil){
		[aCoder encodeObject:self.backgroundColor forKey:kWidgetBackgroundColor];
	}
	[aCoder encodeObject:@(self.backgroundColorType) forKey:kWidgetBackgroundColorType];	[aCoder encodeObject:@(self.brandingId) forKey:kWidgetBrandingId];	[aCoder encodeObject:@(self.displayRows) forKey:kWidgetDisplayRows];	if(self.displayTags != nil){
		[aCoder encodeObject:self.displayTags forKey:kWidgetDisplayTags];
	}
	if(self.esaData != nil){
		[aCoder encodeObject:self.esaData forKey:kWidgetEsaData];
	}
	if(self.fontColor != nil){
		[aCoder encodeObject:self.fontColor forKey:kWidgetFontColor];
	}
	if(self.fontFamily != nil){
		[aCoder encodeObject:self.fontFamily forKey:kWidgetFontFamily];
	}
	if(self.headerText != nil){
		[aCoder encodeObject:self.headerText forKey:kWidgetHeaderText];
	}
	if(self.headerText2 != nil){
		[aCoder encodeObject:self.headerText2 forKey:kWidgetHeaderText2];
	}
	[aCoder encodeObject:@(self.idField) forKey:kWidgetIdField];	[aCoder encodeObject:@(self.isDisplayed) forKey:kWidgetIsDisplayed];	[aCoder encodeObject:@(self.isRealImpressions) forKey:kWidgetIsRealImpressions];	[aCoder encodeObject:@(self.layoutTypeId) forKey:kWidgetLayoutTypeId];	[aCoder encodeObject:@(self.platform) forKey:kWidgetPlatform];	[aCoder encodeObject:@(self.publisherId) forKey:kWidgetPublisherId];	[aCoder encodeObject:@(self.slideAnimationColorReminder) forKey:kWidgetSlideAnimationColorReminder];	[aCoder encodeObject:@(self.textDirection) forKey:kWidgetTextDirection];	if(self.thumbnailSizeId != nil){
		[aCoder encodeObject:self.thumbnailSizeId forKey:kWidgetThumbnailSizeId];
	}
	[aCoder encodeObject:@(self.titleFontSize) forKey:kWidgetTitleFontSize];	[aCoder encodeObject:@(self.websiteId) forKey:kWidgetWebsiteId];	[aCoder encodeObject:@(self.websiteLanguageId) forKey:kWidgetWebsiteLanguageId];	if(self.widgetXPath != nil){
		[aCoder encodeObject:self.widgetXPath forKey:kWidgetWidgetXPath];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.additionalData = [aDecoder decodeObjectForKey:kWidgetAdditionalData];
	self.anad = [aDecoder decodeObjectForKey:kWidgetAnad];
	self.backgroundColor = [aDecoder decodeObjectForKey:kWidgetBackgroundColor];
	self.backgroundColorType = [[aDecoder decodeObjectForKey:kWidgetBackgroundColorType] integerValue];
	self.brandingId = [[aDecoder decodeObjectForKey:kWidgetBrandingId] integerValue];
	self.displayRows = [[aDecoder decodeObjectForKey:kWidgetDisplayRows] integerValue];
	self.displayTags = [aDecoder decodeObjectForKey:kWidgetDisplayTags];
	self.esaData = [aDecoder decodeObjectForKey:kWidgetEsaData];
	self.fontColor = [aDecoder decodeObjectForKey:kWidgetFontColor];
	self.fontFamily = [aDecoder decodeObjectForKey:kWidgetFontFamily];
	self.headerText = [aDecoder decodeObjectForKey:kWidgetHeaderText];
	self.headerText2 = [aDecoder decodeObjectForKey:kWidgetHeaderText2];
	self.idField = [[aDecoder decodeObjectForKey:kWidgetIdField] integerValue];
	self.isDisplayed = [[aDecoder decodeObjectForKey:kWidgetIsDisplayed] integerValue];
	self.isRealImpressions = [[aDecoder decodeObjectForKey:kWidgetIsRealImpressions] boolValue];
	self.layoutTypeId = [[aDecoder decodeObjectForKey:kWidgetLayoutTypeId] integerValue];
	self.platform = [[aDecoder decodeObjectForKey:kWidgetPlatform] integerValue];
	self.publisherId = [[aDecoder decodeObjectForKey:kWidgetPublisherId] integerValue];
	self.slideAnimationColorReminder = [[aDecoder decodeObjectForKey:kWidgetSlideAnimationColorReminder] integerValue];
	self.textDirection = [[aDecoder decodeObjectForKey:kWidgetTextDirection] integerValue];
	self.thumbnailSizeId = [aDecoder decodeObjectForKey:kWidgetThumbnailSizeId];
	self.titleFontSize = [[aDecoder decodeObjectForKey:kWidgetTitleFontSize] integerValue];
	self.websiteId = [[aDecoder decodeObjectForKey:kWidgetWebsiteId] integerValue];
	self.websiteLanguageId = [[aDecoder decodeObjectForKey:kWidgetWebsiteLanguageId] integerValue];
	self.widgetXPath = [aDecoder decodeObjectForKey:kWidgetWidgetXPath];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Widget *copy = [Widget new];

	copy.additionalData = [self.additionalData copy];
	copy.anad = [self.anad copy];
	copy.backgroundColor = [self.backgroundColor copy];
	copy.backgroundColorType = self.backgroundColorType;
	copy.brandingId = self.brandingId;
	copy.displayRows = self.displayRows;
	copy.displayTags = [self.displayTags copy];
	copy.esaData = [self.esaData copy];
	copy.fontColor = [self.fontColor copy];
	copy.fontFamily = [self.fontFamily copy];
	copy.headerText = [self.headerText copy];
	copy.headerText2 = [self.headerText2 copy];
	copy.idField = self.idField;
	copy.isDisplayed = self.isDisplayed;
	copy.isRealImpressions = self.isRealImpressions;
	copy.layoutTypeId = self.layoutTypeId;
	copy.platform = self.platform;
	copy.publisherId = self.publisherId;
	copy.slideAnimationColorReminder = self.slideAnimationColorReminder;
	copy.textDirection = self.textDirection;
	copy.thumbnailSizeId = [self.thumbnailSizeId copy];
	copy.titleFontSize = self.titleFontSize;
	copy.websiteId = self.websiteId;
	copy.websiteLanguageId = self.websiteLanguageId;
	copy.widgetXPath = [self.widgetXPath copy];

	return copy;
}
@end