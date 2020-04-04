//
//	SpecialSection.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "SpecialSection.h"

NSString *const kSpecialSectionBannerArtWorkImg = @"bannerArtWorkImg";
NSString *const kSpecialSectionBanners = @"banners";
NSString *const kSpecialSectionChampID = @"champID";
NSString *const kSpecialSectionIsActive = @"isActive";
NSString *const kSpecialSectionIsHomeSectionBannersActive = @"isHomeSectionBannersActive";
NSString *const kSpecialSectionIsMainHomeBannersActive = @"isMainHomeBannersActive";
NSString *const kSpecialSectionIsNewsDetailsBannersActive = @"isNewsDetailsBannersActive";
NSString *const kSpecialSectionIsTabActive = @"isTabActive";
NSString *const kSpecialSectionSectionID = @"sectionID";

@interface SpecialSection ()
@end
@implementation SpecialSection




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kSpecialSectionBannerArtWorkImg] isKindOfClass:[NSNull class]]){
		self.bannerArtWorkImg = dictionary[kSpecialSectionBannerArtWorkImg];
	}	
	if(dictionary[kSpecialSectionBanners] != nil && [dictionary[kSpecialSectionBanners] isKindOfClass:[NSArray class]]){
		NSArray * bannersDictionaries = dictionary[kSpecialSectionBanners];
		NSMutableArray * bannersItems = [NSMutableArray array];
		for(NSDictionary * bannersDictionary in bannersDictionaries){
			Banner * bannersItem = [[Banner alloc] initWithDictionary:bannersDictionary];
			[bannersItems addObject:bannersItem];
		}
		self.banners = bannersItems;
	}
	if(![dictionary[kSpecialSectionChampID] isKindOfClass:[NSNull class]]){
		self.champID = [dictionary[kSpecialSectionChampID] integerValue];
	}

	if(![dictionary[kSpecialSectionIsActive] isKindOfClass:[NSNull class]]){
		self.isActive = [dictionary[kSpecialSectionIsActive] boolValue];
	}

	if(![dictionary[kSpecialSectionIsHomeSectionBannersActive] isKindOfClass:[NSNull class]]){
		self.isHomeSectionBannersActive = [dictionary[kSpecialSectionIsHomeSectionBannersActive] boolValue];
	}

	if(![dictionary[kSpecialSectionIsMainHomeBannersActive] isKindOfClass:[NSNull class]]){
		self.isMainHomeBannersActive = [dictionary[kSpecialSectionIsMainHomeBannersActive] boolValue];
	}

	if(![dictionary[kSpecialSectionIsNewsDetailsBannersActive] isKindOfClass:[NSNull class]]){
		self.isNewsDetailsBannersActive = [dictionary[kSpecialSectionIsNewsDetailsBannersActive] boolValue];
	}

	if(![dictionary[kSpecialSectionIsTabActive] isKindOfClass:[NSNull class]]){
		self.isTabActive = [dictionary[kSpecialSectionIsTabActive] boolValue];
	}

	if(![dictionary[kSpecialSectionSectionID] isKindOfClass:[NSNull class]]){
		self.sectionID = [dictionary[kSpecialSectionSectionID] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.bannerArtWorkImg != nil){
		dictionary[kSpecialSectionBannerArtWorkImg] = self.bannerArtWorkImg;
	}
	if(self.banners != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Banner * bannersElement in self.banners){
			[dictionaryElements addObject:[bannersElement toDictionary]];
		}
		dictionary[kSpecialSectionBanners] = dictionaryElements;
	}
	dictionary[kSpecialSectionChampID] = @(self.champID);
	dictionary[kSpecialSectionIsActive] = @(self.isActive);
	dictionary[kSpecialSectionIsHomeSectionBannersActive] = @(self.isHomeSectionBannersActive);
	dictionary[kSpecialSectionIsMainHomeBannersActive] = @(self.isMainHomeBannersActive);
	dictionary[kSpecialSectionIsNewsDetailsBannersActive] = @(self.isNewsDetailsBannersActive);
	dictionary[kSpecialSectionIsTabActive] = @(self.isTabActive);
	dictionary[kSpecialSectionSectionID] = @(self.sectionID);
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
	if(self.bannerArtWorkImg != nil){
		[aCoder encodeObject:self.bannerArtWorkImg forKey:kSpecialSectionBannerArtWorkImg];
	}
	if(self.banners != nil){
		[aCoder encodeObject:self.banners forKey:kSpecialSectionBanners];
	}
	[aCoder encodeObject:@(self.champID) forKey:kSpecialSectionChampID];	[aCoder encodeObject:@(self.isActive) forKey:kSpecialSectionIsActive];	[aCoder encodeObject:@(self.isHomeSectionBannersActive) forKey:kSpecialSectionIsHomeSectionBannersActive];	[aCoder encodeObject:@(self.isMainHomeBannersActive) forKey:kSpecialSectionIsMainHomeBannersActive];	[aCoder encodeObject:@(self.isNewsDetailsBannersActive) forKey:kSpecialSectionIsNewsDetailsBannersActive];	[aCoder encodeObject:@(self.isTabActive) forKey:kSpecialSectionIsTabActive];	[aCoder encodeObject:@(self.sectionID) forKey:kSpecialSectionSectionID];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.bannerArtWorkImg = [aDecoder decodeObjectForKey:kSpecialSectionBannerArtWorkImg];
	self.banners = [aDecoder decodeObjectForKey:kSpecialSectionBanners];
	self.champID = [[aDecoder decodeObjectForKey:kSpecialSectionChampID] integerValue];
	self.isActive = [[aDecoder decodeObjectForKey:kSpecialSectionIsActive] boolValue];
	self.isHomeSectionBannersActive = [[aDecoder decodeObjectForKey:kSpecialSectionIsHomeSectionBannersActive] boolValue];
	self.isMainHomeBannersActive = [[aDecoder decodeObjectForKey:kSpecialSectionIsMainHomeBannersActive] boolValue];
	self.isNewsDetailsBannersActive = [[aDecoder decodeObjectForKey:kSpecialSectionIsNewsDetailsBannersActive] boolValue];
	self.isTabActive = [[aDecoder decodeObjectForKey:kSpecialSectionIsTabActive] boolValue];
	self.sectionID = [[aDecoder decodeObjectForKey:kSpecialSectionSectionID] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	SpecialSection *copy = [SpecialSection new];

	copy.bannerArtWorkImg = [self.bannerArtWorkImg copy];
	copy.banners = [self.banners copy];
	copy.champID = self.champID;
	copy.isActive = self.isActive;
	copy.isHomeSectionBannersActive = self.isHomeSectionBannersActive;
	copy.isMainHomeBannersActive = self.isMainHomeBannersActive;
	copy.isNewsDetailsBannersActive = self.isNewsDetailsBannersActive;
	copy.isTabActive = self.isTabActive;
	copy.sectionID = self.sectionID;

	return copy;
}
@end