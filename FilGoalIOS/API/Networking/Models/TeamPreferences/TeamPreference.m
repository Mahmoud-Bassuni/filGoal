//
//	TeamPreference.m
//
//	Create by Nada Gamal on 6/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "TeamPreference.h"

NSString *const kTeamPreferenceEventIds = @"EventIds";
NSString *const kTeamPreferenceTeamId = @"TeamId";
NSString *const kTeamPreferenceUserId = @"UserId";
NSString *const kTeamPreferenceTeamName = @"TeamName";


@interface TeamPreference ()
@end
@implementation TeamPreference




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTeamPreferenceEventIds] isKindOfClass:[NSNull class]]){
		self.eventIds = dictionary[kTeamPreferenceEventIds];
	}	
	if(![dictionary[kTeamPreferenceTeamId] isKindOfClass:[NSNull class]]){
		self.teamId = [dictionary[kTeamPreferenceTeamId] integerValue];
	}
    if(![dictionary[kTeamPreferenceTeamName] isKindOfClass:[NSNull class]]){
        self.teamName = dictionary[kTeamPreferenceTeamName] ;
    }

	if(![dictionary[kTeamPreferenceUserId] isKindOfClass:[NSNull class]]){
		self.userId = [dictionary[kTeamPreferenceUserId] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.eventIds != nil){
		dictionary[kTeamPreferenceEventIds] = self.eventIds;
	}
	dictionary[kTeamPreferenceTeamId] = @(self.teamId);
    dictionary[kTeamPreferenceTeamName] = self.teamName;
	dictionary[kTeamPreferenceUserId] = @(self.userId);
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
	if(self.eventIds != nil){
		[aCoder encodeObject:self.eventIds forKey:kTeamPreferenceEventIds];
	}
    if(self.teamName != nil){
        [aCoder encodeObject:self.teamName forKey:kTeamPreferenceTeamName];
    }
	[aCoder encodeObject:@(self.teamId) forKey:kTeamPreferenceTeamId];
    [aCoder encodeObject:@(self.userId) forKey:kTeamPreferenceUserId];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.eventIds = [aDecoder decodeObjectForKey:kTeamPreferenceEventIds];
	self.teamId = [[aDecoder decodeObjectForKey:kTeamPreferenceTeamId] integerValue];
	self.userId = [[aDecoder decodeObjectForKey:kTeamPreferenceUserId] integerValue];
    self.teamName = [aDecoder decodeObjectForKey:kTeamPreferenceTeamName];

	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	TeamPreference *copy = [TeamPreference new];

	copy.eventIds = [self.eventIds copy];
	copy.teamId = self.teamId;
	copy.userId = self.userId;
    copy.teamName = self.teamName;
	return copy;
}
@end
