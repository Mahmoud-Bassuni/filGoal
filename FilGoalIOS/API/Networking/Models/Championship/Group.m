//
//	Group.m
//
//	Create by Nada Gamal on 29/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Group.h"

NSString *const kGroupChampionshipStageId = @"championshipStageId";
NSString *const kGroupCultureData = @"cultureData";
NSString *const kGroupIdField = @"id";
NSString *const kGroupName = @"name";
NSString *const kGroupTeams = @"teams";

@interface Group ()
@end
@implementation Group




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kGroupChampionshipStageId] isKindOfClass:[NSNull class]]){
		self.championshipStageId = [dictionary[kGroupChampionshipStageId] integerValue];
	}

	if(![dictionary[kGroupCultureData] isKindOfClass:[NSNull class]]){
		self.cultureData = dictionary[kGroupCultureData];
	}	
	if(![dictionary[kGroupIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kGroupIdField] integerValue];
	}

	if(![dictionary[kGroupName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kGroupName];
	}	
	if(dictionary[kGroupTeams] != nil && [dictionary[kGroupTeams] isKindOfClass:[NSArray class]]){
		NSArray * teamsDictionaries = dictionary[kGroupTeams];
		NSMutableArray * teamsItems = [NSMutableArray array];
		for(NSDictionary * teamsDictionary in teamsDictionaries){
			Team * teamsItem = [[Team alloc] initWithDictionary:teamsDictionary];
			[teamsItems addObject:teamsItem];
		}
		self.teams = teamsItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(self.championshipStageId) forKey:kGroupChampionshipStageId];	if(self.cultureData != nil){
		[aCoder encodeObject:self.cultureData forKey:kGroupCultureData];
	}
	[aCoder encodeObject:@(self.idField) forKey:kGroupIdField];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kGroupName];
	}
	if(self.teams != nil){
		[aCoder encodeObject:self.teams forKey:kGroupTeams];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.championshipStageId = [[aDecoder decodeObjectForKey:kGroupChampionshipStageId] integerValue];
	self.cultureData = [aDecoder decodeObjectForKey:kGroupCultureData];
	self.idField = [[aDecoder decodeObjectForKey:kGroupIdField] integerValue];
	self.name = [aDecoder decodeObjectForKey:kGroupName];
	self.teams = [aDecoder decodeObjectForKey:kGroupTeams];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Group *copy = [Group new];

	copy.championshipStageId = self.championshipStageId;
	copy.cultureData = [self.cultureData copy];
	copy.idField = self.idField;
	copy.name = [self.name copy];
	copy.teams = [self.teams copy];

	return copy;
}
@end
