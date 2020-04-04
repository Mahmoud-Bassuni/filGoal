//
//	FeaturedSection.m
//
//	Create by Mohamed Mansour on 2/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FeaturedSection.h"

@interface FeaturedSection ()
@end
@implementation FeaturedSection




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"MetaDataJsonUrl"] isKindOfClass:[NSNull class]]){
		self.metaDataJsonUrl = dictionary[@"MetaDataJsonUrl"];
	}
    if(![dictionary[@"sectionBannarImgBaseUrl"] isKindOfClass:[NSNull class]]){
        self.sectionBannarImgBaseUrl = dictionary[@"sectionBannarImgBaseUrl"];
    }
	if(![dictionary[@"SectionMenuIndex"] isKindOfClass:[NSNull class]]){
		self.sectionMenuIndex = [dictionary[@"SectionMenuIndex"] integerValue];
	}

	if(![dictionary[@"isSpecialSection"] isKindOfClass:[NSNull class]]){
		self.isSpecialSection = [dictionary[@"isSpecialSection"] boolValue];
	}

	if(![dictionary[@"section_id"] isKindOfClass:[NSNull class]]){
		self.sectionId = [dictionary[@"section_id"] integerValue];
	}

	if(![dictionary[@"section_name"] isKindOfClass:[NSNull class]]){
		self.sectionName = dictionary[@"section_name"];
	}	
	if(![dictionary[@"url"] isKindOfClass:[NSNull class]]){
		self.url = dictionary[@"url"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.metaDataJsonUrl != nil){
		dictionary[@"MetaDataJsonUrl"] = self.metaDataJsonUrl;
	}
    if(self.sectionBannarImgBaseUrl != nil){
        dictionary[@"sectionBannarImgBaseUrl"] = self.sectionBannarImgBaseUrl;
    }
	dictionary[@"SectionMenuIndex"] = @(self.sectionMenuIndex);
	dictionary[@"isSpecialSection"] = @(self.isSpecialSection);
	dictionary[@"section_id"] = @(self.sectionId);
	if(self.sectionName != nil){
		dictionary[@"section_name"] = self.sectionName;
	}
	if(self.url != nil){
		dictionary[@"url"] = self.url;
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
	if(self.metaDataJsonUrl != nil){
		[aCoder encodeObject:self.metaDataJsonUrl forKey:@"MetaDataJsonUrl"];
	}
    if(self.sectionBannarImgBaseUrl != nil){
        [aCoder encodeObject:self.sectionBannarImgBaseUrl forKey:@"sectionBannarImgBaseUrl"];
    }
	[aCoder encodeObject:@(self.sectionMenuIndex) forKey:@"SectionMenuIndex"];	[aCoder encodeObject:@(self.isSpecialSection) forKey:@"isSpecialSection"];	[aCoder encodeObject:@(self.sectionId) forKey:@"section_id"];	if(self.sectionName != nil){
		[aCoder encodeObject:self.sectionName forKey:@"section_name"];
	}
	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:@"url"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
    self.sectionBannarImgBaseUrl= [aDecoder decodeObjectForKey:@"sectionBannarImgBaseUrl"];
	self.metaDataJsonUrl = [aDecoder decodeObjectForKey:@"MetaDataJsonUrl"];
	self.sectionMenuIndex = [[aDecoder decodeObjectForKey:@"SectionMenuIndex"] integerValue];
	self.isSpecialSection = [[aDecoder decodeObjectForKey:@"isSpecialSection"] boolValue];
	self.sectionId = [[aDecoder decodeObjectForKey:@"section_id"] integerValue];
	self.sectionName = [aDecoder decodeObjectForKey:@"section_name"];
	self.url = [aDecoder decodeObjectForKey:@"url"];
	return self;

}
@end