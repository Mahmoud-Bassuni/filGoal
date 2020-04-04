//
//	Sponsor.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Sponsor.h"

NSString *const kSponsorChampSponsor = @"champ_sponsor";
NSString *const kSponsorImgsBaseUrl = @"imgs_base_url";
NSString *const kSponsorIsActive = @"is_active";
NSString *const kSponsorSectionSponsor = @"section_sponsor";

@interface Sponsor ()
@end
@implementation Sponsor




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kSponsorChampSponsor] isKindOfClass:[NSNull class]]){
		self.champSponsor = dictionary[kSponsorChampSponsor];
	}	
	if(![dictionary[kSponsorImgsBaseUrl] isKindOfClass:[NSNull class]]){
		self.imgsBaseUrl = dictionary[kSponsorImgsBaseUrl];
	}	
	if(![dictionary[kSponsorIsActive] isKindOfClass:[NSNull class]]){
		self.isActive = [dictionary[kSponsorIsActive] integerValue];
	}

	if(![dictionary[kSponsorSectionSponsor] isKindOfClass:[NSNull class]]){
		self.sectionSponsor = dictionary[kSponsorSectionSponsor];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.champSponsor != nil){
		dictionary[kSponsorChampSponsor] = self.champSponsor;
	}
	if(self.imgsBaseUrl != nil){
		dictionary[kSponsorImgsBaseUrl] = self.imgsBaseUrl;
	}
	dictionary[kSponsorIsActive] = @(self.isActive);
	if(self.sectionSponsor != nil){
		dictionary[kSponsorSectionSponsor] = self.sectionSponsor;
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
	if(self.champSponsor != nil){
		[aCoder encodeObject:self.champSponsor forKey:kSponsorChampSponsor];
	}
	if(self.imgsBaseUrl != nil){
		[aCoder encodeObject:self.imgsBaseUrl forKey:kSponsorImgsBaseUrl];
	}
	[aCoder encodeObject:@(self.isActive) forKey:kSponsorIsActive];	if(self.sectionSponsor != nil){
		[aCoder encodeObject:self.sectionSponsor forKey:kSponsorSectionSponsor];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.champSponsor = [aDecoder decodeObjectForKey:kSponsorChampSponsor];
	self.imgsBaseUrl = [aDecoder decodeObjectForKey:kSponsorImgsBaseUrl];
	self.isActive = [[aDecoder decodeObjectForKey:kSponsorIsActive] integerValue];
	self.sectionSponsor = [aDecoder decodeObjectForKey:kSponsorSectionSponsor];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Sponsor *copy = [Sponsor new];

	copy.champSponsor = [self.champSponsor copy];
	copy.imgsBaseUrl = [self.imgsBaseUrl copy];
	copy.isActive = self.isActive;
	copy.sectionSponsor = [self.sectionSponsor copy];

	return copy;
}
@end