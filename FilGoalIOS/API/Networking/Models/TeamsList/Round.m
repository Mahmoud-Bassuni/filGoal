//
//    Round.m
//
//    Create by Nada Gamal on 25/10/2017
//    Copyright © 2017. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Round.h"

NSString *const kRoundChampionshipId = @"championshipId";
NSString *const kRoundIdField = @"id";
NSString *const kRoundIsActive = @"isActive";
NSString *const kRoundIsHomeAway = @"isHomeAway";
NSString *const kRoundName = @"name";
NSString *const kRoundOrder = @"order";
NSString *const kRoundRoundTypeId = @"roundTypeId";
NSString *const kRoundRoundTypeName = @"roundTypeName";
NSString *const kRoundRoundNumber = @"roundNumber";
NSString *const kRoundStageId = @"stageId";
NSString *const kRoundUniqueStamp = @"uniqueStamp";

@interface Round ()
@end
@implementation Round




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kRoundChampionshipId] isKindOfClass:[NSNull class]]){
        self.championshipId = [dictionary[kRoundChampionshipId] integerValue];
    }
    
    if(![dictionary[kRoundIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kRoundIdField] integerValue];
    }
    
    if(![dictionary[kRoundIsActive] isKindOfClass:[NSNull class]]){
        self.isActive = [dictionary[kRoundIsActive] boolValue];
    }
    
    if(![dictionary[kRoundIsHomeAway] isKindOfClass:[NSNull class]]){
        self.isHomeAway = [dictionary[kRoundIsHomeAway] boolValue];
    }
    
    if(![dictionary[kRoundName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kRoundName];
    }
    if(![dictionary[kRoundOrder] isKindOfClass:[NSNull class]]){
        self.order = [dictionary[kRoundOrder] integerValue];
    }
    
    if(![dictionary[kRoundRoundTypeId] isKindOfClass:[NSNull class]]){
        self.roundTypeId = [dictionary[kRoundRoundTypeId] integerValue];
    }
    
    if(![dictionary[kRoundRoundTypeName] isKindOfClass:[NSNull class]]){
        self.roundTypeName = dictionary[kRoundRoundTypeName];
    }
    if(![dictionary[kRoundName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kRoundName];
    }
    if(![dictionary[kRoundRoundNumber] isKindOfClass:[NSNull class]]){
        self.roundNumber = dictionary[kRoundRoundNumber];
    }
    if(![dictionary[kRoundStageId] isKindOfClass:[NSNull class]]){
        self.stageId = [dictionary[kRoundStageId] integerValue];
    }
    
    if(![dictionary[kRoundUniqueStamp] isKindOfClass:[NSNull class]]){
        self.uniqueStamp = dictionary[kRoundUniqueStamp];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kRoundChampionshipId] = @(self.championshipId);
    dictionary[kRoundIdField] = @(self.idField);
    dictionary[kRoundIsActive] = @(self.isActive);
    dictionary[kRoundIsHomeAway] = @(self.isHomeAway);
    if(self.name != nil){
        dictionary[kRoundName] = self.name;
    }
    dictionary[kRoundOrder] = @(self.order);
    dictionary[kRoundRoundTypeId] = @(self.roundTypeId);
    if(self.roundTypeName != nil){
        dictionary[kRoundRoundTypeName] = self.roundTypeName;
    }
    if(self.name != nil){
        dictionary[kRoundName] = self.name;
    }
    if(self.roundNumber != nil){
        dictionary[kRoundRoundNumber] = self.roundNumber;
    }
    dictionary[kRoundStageId] = @(self.stageId);
    if(self.uniqueStamp != nil){
        dictionary[kRoundUniqueStamp] = self.uniqueStamp;
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
    [aCoder encodeObject:@(self.championshipId) forKey:kRoundChampionshipId];
    [aCoder encodeObject:@(self.idField) forKey:kRoundIdField];
    [aCoder encodeObject:@(self.isActive) forKey:kRoundIsActive];
    [aCoder encodeObject:@(self.isHomeAway) forKey:kRoundIsHomeAway];
    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:kRoundName];
    }
    [aCoder encodeObject:@(self.order) forKey:kRoundOrder];
    [aCoder encodeObject:@(self.roundTypeId) forKey:kRoundRoundTypeId];
    if(self.roundTypeName != nil){
        [aCoder encodeObject:self.roundTypeName forKey:kRoundRoundTypeName];
    }
    if(self.name != nil){
        [aCoder encodeObject:self.name forKey:kRoundName];
    }
    if(self.roundNumber != nil){
        [aCoder encodeObject:self.roundNumber forKey:kRoundRoundNumber];
    }
    [aCoder encodeObject:@(self.stageId) forKey:kRoundStageId];    if(self.uniqueStamp != nil){
        [aCoder encodeObject:self.uniqueStamp forKey:kRoundUniqueStamp];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.championshipId = [[aDecoder decodeObjectForKey:kRoundChampionshipId] integerValue];
    self.idField = [[aDecoder decodeObjectForKey:kRoundIdField] integerValue];
    self.isActive = [[aDecoder decodeObjectForKey:kRoundIsActive] boolValue];
    self.isHomeAway = [[aDecoder decodeObjectForKey:kRoundIsHomeAway] boolValue];
    self.name = [aDecoder decodeObjectForKey:kRoundName];
    self.order = [[aDecoder decodeObjectForKey:kRoundOrder] integerValue];
    self.roundTypeId = [[aDecoder decodeObjectForKey:kRoundRoundTypeId] integerValue];
    self.roundTypeName = [aDecoder decodeObjectForKey:kRoundRoundTypeName];
    self.name = [aDecoder decodeObjectForKey:kRoundName];
    self.roundNumber = [aDecoder decodeObjectForKey:kRoundRoundNumber];
    self.stageId = [[aDecoder decodeObjectForKey:kRoundStageId] integerValue];
    self.uniqueStamp = [aDecoder decodeObjectForKey:kRoundUniqueStamp];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    Round *copy = [Round new];
    
    copy.championshipId = self.championshipId;
    copy.idField = self.idField;
    copy.isActive = self.isActive;
    copy.isHomeAway = self.isHomeAway;
    copy.name = [self.name copy];
    copy.order = self.order;
    copy.roundTypeId = self.roundTypeId;
    copy.roundTypeName = [self.roundTypeName copy];
    copy.name = [self.name copy];
    copy.roundNumber = [self.roundNumber copy];
    copy.stageId = self.stageId;
    copy.uniqueStamp = [self.uniqueStamp copy];
    
    return copy;
}
@end
