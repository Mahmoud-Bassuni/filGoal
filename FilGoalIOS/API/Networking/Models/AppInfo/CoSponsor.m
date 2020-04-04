//
//	CoSponsor.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CoSponsor.h"
#import "SpecialSponsorUrl.h"
//Old
NSString *const kCoSponsorChampsIds = @"champs_ids";
NSString *const kCoSponsorSectionIds = @"section_ids";
//New
NSString *const kCoSponsorChampsUrl = @"champs_url";
NSString *const kCoSponsorSectionsUrl = @"sections_url";
@interface CoSponsor ()
@end
@implementation CoSponsor




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    //Old
	if(![dictionary[kCoSponsorChampsIds] isKindOfClass:[NSNull class]]){
		self.champsIds = dictionary[kCoSponsorChampsIds];
	}	
	if(![dictionary[kCoSponsorSectionIds] isKindOfClass:[NSNull class]]){
		self.sectionIds = dictionary[kCoSponsorSectionIds];
	}
    //New
    if(![dictionary[kCoSponsorChampsUrl] isKindOfClass:[NSNull class]]){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary* dict in dictionary[kCoSponsorChampsUrl]) {
            SpecialSponsorUrl *obj = [[SpecialSponsorUrl alloc] initWithDictionary:dict];
            [array addObject:obj];
        }
        self.champsUrl = array;
    }
    if(![dictionary[kCoSponsorSectionsUrl] isKindOfClass:[NSNull class]]){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary* dict in dictionary[kCoSponsorSectionsUrl]) {
            SpecialSponsorUrl *obj = [[SpecialSponsorUrl alloc] initWithDictionary:dict];
            [array addObject:obj];
        }
        self.sectionUrl = array;
    }
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.champsIds != nil){
		dictionary[kCoSponsorChampsIds] = self.champsIds;
	}
	if(self.sectionIds != nil){
		dictionary[kCoSponsorSectionIds] = self.sectionIds;
	}
    if(self.champsUrl != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (SpecialSponsorUrl *specialSponsorUrl in self.champsUrl) {
            [array addObject: [specialSponsorUrl toDictionary]];
        }
        dictionary[kCoSponsorChampsUrl] = array;
    }
    if(self.sectionUrl != nil){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (SpecialSponsorUrl *specialSponsorUrl in self.sectionUrl) {
            [array addObject: [specialSponsorUrl toDictionary]];
        }
        dictionary[kCoSponsorSectionsUrl] = array;
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
	if(self.champsIds != nil){
		[aCoder encodeObject:self.champsIds forKey:kCoSponsorChampsIds];
	}
	if(self.sectionIds != nil){
		[aCoder encodeObject:self.sectionIds forKey:kCoSponsorSectionIds];
	}
    
    if(self.champsUrl != nil){
        [aCoder encodeObject:self.champsUrl forKey:kCoSponsorChampsUrl];
    }
    if(self.sectionUrl != nil){
        [aCoder encodeObject:self.sectionUrl forKey:kCoSponsorSectionsUrl];
    }
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.champsIds = [aDecoder decodeObjectForKey:kCoSponsorChampsIds];
	self.sectionIds = [aDecoder decodeObjectForKey:kCoSponsorSectionIds];
    self.champsUrl = [aDecoder decodeObjectForKey:kCoSponsorChampsUrl];
    self.sectionUrl = [aDecoder decodeObjectForKey:kCoSponsorSectionsUrl];
	return self;
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CoSponsor *copy = [CoSponsor new];

	copy.champsIds = [self.champsIds copy];
	copy.sectionIds = [self.sectionIds copy];
    copy.champsUrl = [self.champsUrl copy];
    copy.sectionUrl = [self.sectionUrl copy];
    
	return copy;
}
@end
