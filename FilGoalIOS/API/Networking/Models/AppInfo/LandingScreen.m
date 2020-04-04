//
//	LandingScreen.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LandingScreen.h"

NSString *const kLandingScreenBackgroundImg = @"backgroundImg";
NSString *const kLandingScreenButtonSectionImg = @"buttonSectionImg";
NSString *const kLandingScreenButtonSectionName = @"buttonSectionName";
NSString *const kLandingScreenIdField = @"id";
NSString *const kLandingScreenIsActive = @"isActive";
NSString *const kLandingScreenPageUrl = @"pageUrl";
NSString *const kLandingScreenType = @"type";

@interface LandingScreen ()
@end
@implementation LandingScreen




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLandingScreenBackgroundImg] isKindOfClass:[NSNull class]]){
		self.backgroundImg = dictionary[kLandingScreenBackgroundImg];
	}	
	if(![dictionary[kLandingScreenButtonSectionImg] isKindOfClass:[NSNull class]]){
		self.buttonSectionImg = dictionary[kLandingScreenButtonSectionImg];
	}	
	if(![dictionary[kLandingScreenButtonSectionName] isKindOfClass:[NSNull class]]){
		self.buttonSectionName = dictionary[kLandingScreenButtonSectionName];
	}	
	if(![dictionary[kLandingScreenIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kLandingScreenIdField] integerValue];
	}

	if(![dictionary[kLandingScreenIsActive] isKindOfClass:[NSNull class]]){
		self.isActive = [dictionary[kLandingScreenIsActive] boolValue];
	}

	if(![dictionary[kLandingScreenPageUrl] isKindOfClass:[NSNull class]]){
		self.pageUrl = dictionary[kLandingScreenPageUrl];
	}	
	if(![dictionary[kLandingScreenType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kLandingScreenType] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.backgroundImg != nil){
		dictionary[kLandingScreenBackgroundImg] = self.backgroundImg;
	}
	if(self.buttonSectionImg != nil){
		dictionary[kLandingScreenButtonSectionImg] = self.buttonSectionImg;
	}
	if(self.buttonSectionName != nil){
		dictionary[kLandingScreenButtonSectionName] = self.buttonSectionName;
	}
	dictionary[kLandingScreenIdField] = @(self.idField);
	dictionary[kLandingScreenIsActive] = @(self.isActive);
	if(self.pageUrl != nil){
		dictionary[kLandingScreenPageUrl] = self.pageUrl;
	}
	dictionary[kLandingScreenType] = @(self.type);
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
	if(self.backgroundImg != nil){
		[aCoder encodeObject:self.backgroundImg forKey:kLandingScreenBackgroundImg];
	}
	if(self.buttonSectionImg != nil){
		[aCoder encodeObject:self.buttonSectionImg forKey:kLandingScreenButtonSectionImg];
	}
	if(self.buttonSectionName != nil){
		[aCoder encodeObject:self.buttonSectionName forKey:kLandingScreenButtonSectionName];
	}
	[aCoder encodeObject:@(self.idField) forKey:kLandingScreenIdField];	[aCoder encodeObject:@(self.isActive) forKey:kLandingScreenIsActive];	if(self.pageUrl != nil){
		[aCoder encodeObject:self.pageUrl forKey:kLandingScreenPageUrl];
	}
	[aCoder encodeObject:@(self.type) forKey:kLandingScreenType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.backgroundImg = [aDecoder decodeObjectForKey:kLandingScreenBackgroundImg];
	self.buttonSectionImg = [aDecoder decodeObjectForKey:kLandingScreenButtonSectionImg];
	self.buttonSectionName = [aDecoder decodeObjectForKey:kLandingScreenButtonSectionName];
	self.idField = [[aDecoder decodeObjectForKey:kLandingScreenIdField] integerValue];
	self.isActive = [[aDecoder decodeObjectForKey:kLandingScreenIsActive] boolValue];
	self.pageUrl = [aDecoder decodeObjectForKey:kLandingScreenPageUrl];
	self.type = [[aDecoder decodeObjectForKey:kLandingScreenType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LandingScreen *copy = [LandingScreen new];

	copy.backgroundImg = [self.backgroundImg copy];
	copy.buttonSectionImg = [self.buttonSectionImg copy];
	copy.buttonSectionName = [self.buttonSectionName copy];
	copy.idField = self.idField;
	copy.isActive = self.isActive;
	copy.pageUrl = [self.pageUrl copy];
	copy.type = self.type;

	return copy;
}
@end