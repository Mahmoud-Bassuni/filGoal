//
//	CareerData.m
//
//	Create by Nada Gamal on 25/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CareerData.h"

NSString *const kCareerDataFrom = @"from";
NSString *const kCareerDataIdField = @"id";
NSString *const kCareerDataIsLoaned = @"isLoaned";
NSString *const kCareerDataPersonId = @"personId";
NSString *const kCareerDataPersonLogoUrl = @"personLogoUrl";
NSString *const kCareerDataPersonName = @"personName";
NSString *const kCareerDataPersonTypeId = @"personTypeId";
NSString *const kCareerDataPersonTypeName = @"personTypeName";
NSString *const kCareerDataPlayerNumber = @"playerNumber";
NSString *const kCareerDataPlayerPositionId = @"playerPositionId";
NSString *const kCareerDataPlayerPositionName = @"playerPositionName";
NSString *const kCareerDataTeamId = @"teamId";
NSString *const kCareerDataTeamLogoUrl = @"teamLogoUrl";
NSString *const kCareerDataTeamName = @"teamName";
NSString *const kCareerDataTo = @"to";

@interface CareerData ()
@end
@implementation CareerData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCareerDataFrom] isKindOfClass:[NSNull class]]){
		self.from = dictionary[kCareerDataFrom];
	}	
	if(![dictionary[kCareerDataIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kCareerDataIdField] integerValue];
	}

	if(![dictionary[kCareerDataIsLoaned] isKindOfClass:[NSNull class]]){
		self.isLoaned = [dictionary[kCareerDataIsLoaned] boolValue];
	}

	if(![dictionary[kCareerDataPersonId] isKindOfClass:[NSNull class]]){
		self.personId = [dictionary[kCareerDataPersonId] integerValue];
	}

	if(![dictionary[kCareerDataPersonLogoUrl] isKindOfClass:[NSNull class]]){
		self.personLogoUrl = dictionary[kCareerDataPersonLogoUrl];
	}	
	if(![dictionary[kCareerDataPersonName] isKindOfClass:[NSNull class]]){
		self.personName = dictionary[kCareerDataPersonName];
	}	
	if(![dictionary[kCareerDataPersonTypeId] isKindOfClass:[NSNull class]]){
		self.personTypeId = [dictionary[kCareerDataPersonTypeId] integerValue];
	}

	if(![dictionary[kCareerDataPersonTypeName] isKindOfClass:[NSNull class]]){
		self.personTypeName = dictionary[kCareerDataPersonTypeName];
	}	
	if(![dictionary[kCareerDataPlayerNumber] isKindOfClass:[NSNull class]]){
		self.playerNumber = [dictionary[kCareerDataPlayerNumber] integerValue];
	}

	if(![dictionary[kCareerDataPlayerPositionId] isKindOfClass:[NSNull class]]){
		self.playerPositionId = [dictionary[kCareerDataPlayerPositionId] integerValue];
	}

	if(![dictionary[kCareerDataPlayerPositionName] isKindOfClass:[NSNull class]]){
		self.playerPositionName = dictionary[kCareerDataPlayerPositionName];
	}	
	if(![dictionary[kCareerDataTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kCareerDataTeamId] integerValue];
	}

	if(![dictionary[kCareerDataTeamLogoUrl] isKindOfClass:[NSNull class]]){
		self.teamLogoUrl = dictionary[kCareerDataTeamLogoUrl];
	}	
	if(![dictionary[kCareerDataTeamName] isKindOfClass:[NSNull class]]){
		self.teamName = dictionary[kCareerDataTeamName];
	}	
	if(![dictionary[kCareerDataTo] isKindOfClass:[NSNull class]]){
		self.to = dictionary[kCareerDataTo];
	}	
	return self;
}
@end