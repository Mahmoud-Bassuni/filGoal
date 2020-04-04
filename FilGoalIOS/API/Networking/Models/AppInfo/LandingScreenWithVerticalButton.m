//
//	LandingScreenWithVerticalButton.m
//
//	Create by Nada Gamal on 21/5/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LandingScreenWithVerticalButton.h"

NSString *const kLandingScreenWithVerticalButtonBackgroundImg = @"backgroundImg";
NSString *const kLandingScreenWithVerticalButtonButtonHomeImg = @"buttonHomeImg";
NSString *const kLandingScreenWithVerticalButtonButtonSectionImg = @"buttonSectionImg";
NSString *const kLandingScreenWithVerticalButtonButtonSectionName = @"buttonSectionName";
NSString *const kLandingScreenWithVerticalButtonIdField = @"id";
NSString *const kLandingScreenWithVerticalButtonIsActive = @"isActive";
NSString *const kLandingScreenWithVerticalButtonPageUrl = @"pageUrl";
NSString *const kLandingScreenWithVerticalButtonType = @"type";

@interface LandingScreenWithVerticalButton ()
@end
@implementation LandingScreenWithVerticalButton




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLandingScreenWithVerticalButtonBackgroundImg] isKindOfClass:[NSNull class]]){
		self.backgroundImg = dictionary[kLandingScreenWithVerticalButtonBackgroundImg];
	}	
	if(![dictionary[kLandingScreenWithVerticalButtonButtonHomeImg] isKindOfClass:[NSNull class]]){
		self.buttonHomeImg = dictionary[kLandingScreenWithVerticalButtonButtonHomeImg];
	}	
	if(![dictionary[kLandingScreenWithVerticalButtonButtonSectionImg] isKindOfClass:[NSNull class]]){
		self.buttonSectionImg = dictionary[kLandingScreenWithVerticalButtonButtonSectionImg];
	}	
	if(![dictionary[kLandingScreenWithVerticalButtonButtonSectionName] isKindOfClass:[NSNull class]]){
		self.buttonSectionName = dictionary[kLandingScreenWithVerticalButtonButtonSectionName];
	}	
	if(![dictionary[kLandingScreenWithVerticalButtonIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kLandingScreenWithVerticalButtonIdField] integerValue];
	}

	if(![dictionary[kLandingScreenWithVerticalButtonIsActive] isKindOfClass:[NSNull class]]){
		self.isActive = [dictionary[kLandingScreenWithVerticalButtonIsActive] boolValue];
	}

	if(![dictionary[kLandingScreenWithVerticalButtonPageUrl] isKindOfClass:[NSNull class]]){
		self.pageUrl = dictionary[kLandingScreenWithVerticalButtonPageUrl];
	}	
	if(![dictionary[kLandingScreenWithVerticalButtonType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kLandingScreenWithVerticalButtonType] integerValue];
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
		dictionary[kLandingScreenWithVerticalButtonBackgroundImg] = self.backgroundImg;
	}
	if(self.buttonHomeImg != nil){
		dictionary[kLandingScreenWithVerticalButtonButtonHomeImg] = self.buttonHomeImg;
	}
	if(self.buttonSectionImg != nil){
		dictionary[kLandingScreenWithVerticalButtonButtonSectionImg] = self.buttonSectionImg;
	}
	if(self.buttonSectionName != nil){
		dictionary[kLandingScreenWithVerticalButtonButtonSectionName] = self.buttonSectionName;
	}
	dictionary[kLandingScreenWithVerticalButtonIdField] = @(self.idField);
	dictionary[kLandingScreenWithVerticalButtonIsActive] = @(self.isActive);
	if(self.pageUrl != nil){
		dictionary[kLandingScreenWithVerticalButtonPageUrl] = self.pageUrl;
	}
	dictionary[kLandingScreenWithVerticalButtonType] = @(self.type);
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
		[aCoder encodeObject:self.backgroundImg forKey:kLandingScreenWithVerticalButtonBackgroundImg];
	}
	if(self.buttonHomeImg != nil){
		[aCoder encodeObject:self.buttonHomeImg forKey:kLandingScreenWithVerticalButtonButtonHomeImg];
	}
	if(self.buttonSectionImg != nil){
		[aCoder encodeObject:self.buttonSectionImg forKey:kLandingScreenWithVerticalButtonButtonSectionImg];
	}
	if(self.buttonSectionName != nil){
		[aCoder encodeObject:self.buttonSectionName forKey:kLandingScreenWithVerticalButtonButtonSectionName];
	}
	[aCoder encodeObject:@(self.idField) forKey:kLandingScreenWithVerticalButtonIdField];	[aCoder encodeObject:@(self.isActive) forKey:kLandingScreenWithVerticalButtonIsActive];	if(self.pageUrl != nil){
		[aCoder encodeObject:self.pageUrl forKey:kLandingScreenWithVerticalButtonPageUrl];
	}
	[aCoder encodeObject:@(self.type) forKey:kLandingScreenWithVerticalButtonType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.backgroundImg = [aDecoder decodeObjectForKey:kLandingScreenWithVerticalButtonBackgroundImg];
	self.buttonHomeImg = [aDecoder decodeObjectForKey:kLandingScreenWithVerticalButtonButtonHomeImg];
	self.buttonSectionImg = [aDecoder decodeObjectForKey:kLandingScreenWithVerticalButtonButtonSectionImg];
	self.buttonSectionName = [aDecoder decodeObjectForKey:kLandingScreenWithVerticalButtonButtonSectionName];
	self.idField = [[aDecoder decodeObjectForKey:kLandingScreenWithVerticalButtonIdField] integerValue];
	self.isActive = [[aDecoder decodeObjectForKey:kLandingScreenWithVerticalButtonIsActive] boolValue];
	self.pageUrl = [aDecoder decodeObjectForKey:kLandingScreenWithVerticalButtonPageUrl];
	self.type = [[aDecoder decodeObjectForKey:kLandingScreenWithVerticalButtonType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LandingScreenWithVerticalButton *copy = [LandingScreenWithVerticalButton new];

	copy.backgroundImg = [self.backgroundImg copy];
	copy.buttonHomeImg = [self.buttonHomeImg copy];
	copy.buttonSectionImg = [self.buttonSectionImg copy];
	copy.buttonSectionName = [self.buttonSectionName copy];
	copy.idField = self.idField;
	copy.isActive = self.isActive;
	copy.pageUrl = [self.pageUrl copy];
	copy.type = self.type;

	return copy;
}
@end