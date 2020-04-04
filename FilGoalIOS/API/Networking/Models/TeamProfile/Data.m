//
//	Data.m
//
//	Create by Nada Gamal on 27/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Data.h"

NSString *const kDataAchievements = @"achievements";
NSString *const kDataCareerData = @"careerData";
NSString *const kDataCityId = @"cityId";
NSString *const kDataCityName = @"cityName";
NSString *const kDataCountryId = @"countryId";
NSString *const kDataCountryName = @"countryName";
NSString *const kDataFounded = @"founded";
NSString *const kDataIdField = @"id";
NSString *const kDataName = @"name";
NSString *const kDataSlug = @"slug";
NSString *const kDataTeamTypeId = @"teamTypeId";
NSString *const kDataTeamTypeName = @"teamTypeName";
NSString *const kDataWebsite = @"website";

@interface Data ()
@end
@implementation Data




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kDataAchievements] isKindOfClass:[NSNull class]]){
		self.achievements = dictionary[kDataAchievements];
	}	
	if(dictionary[kDataCareerData] != nil && [dictionary[kDataCareerData] isKindOfClass:[NSArray class]]){
		NSArray * careerDataDictionaries = dictionary[kDataCareerData];
		NSMutableArray * careerDataItems = [NSMutableArray array];
		for(NSDictionary * careerDataDictionary in careerDataDictionaries){
			CareerData * careerDataItem = [[CareerData alloc] initWithDictionary:careerDataDictionary];
			[careerDataItems addObject:careerDataItem];
		}
		self.careerData = careerDataItems;
	}
	if(![dictionary[kDataCityId] isKindOfClass:[NSNull class]]){
		self.cityId = [dictionary[kDataCityId] integerValue];
	}

	if(![dictionary[kDataCityName] isKindOfClass:[NSNull class]]){
		self.cityName = dictionary[kDataCityName];
	}	
	if(![dictionary[kDataCountryId] isKindOfClass:[NSNull class]]){
		self.countryId = [dictionary[kDataCountryId] integerValue];
	}

	if(![dictionary[kDataCountryName] isKindOfClass:[NSNull class]]){
		self.countryName = dictionary[kDataCountryName];
	}	
	if(![dictionary[kDataFounded] isKindOfClass:[NSNull class]]){
		self.founded = [dictionary[kDataFounded] integerValue];
	}

	if(![dictionary[kDataIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kDataIdField] integerValue];
	}

	if(![dictionary[kDataName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kDataName];
	}	
	if(![dictionary[kDataSlug] isKindOfClass:[NSNull class]]){
		self.slug = dictionary[kDataSlug];
	}	
	if(![dictionary[kDataTeamTypeId] isKindOfClass:[NSNull class]]){
		self.teamTypeId = [dictionary[kDataTeamTypeId] integerValue];
	}

	if(![dictionary[kDataTeamTypeName] isKindOfClass:[NSNull class]]){
		self.teamTypeName = dictionary[kDataTeamTypeName];
	}	
	if(![dictionary[kDataWebsite] isKindOfClass:[NSNull class]]){
		self.website = dictionary[kDataWebsite];
	}	
	return self;
}




@end
