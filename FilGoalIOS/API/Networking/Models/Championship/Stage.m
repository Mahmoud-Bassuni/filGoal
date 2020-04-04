//
//    Stage.m
//
//    Create by Nada Gamal on 25/10/2017
//    Copyright © 2017. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Stage.h"

NSString *const kStageChampionshipId = @"championshipId";
NSString *const kStageGroups = @"groups";
NSString *const kStageIdField = @"id";
NSString *const kStageIsCustomGroupOrdering = @"isCustomGroupOrdering";
NSString *const kStageIsGroups = @"isGroups";
NSString *const kStageIsPlayOffs = @"isPlayOffs";
NSString *const kStageIsShowResult = @"isShowResult";
NSString *const kStageNumberOfGroups = @"numberOfGroups";
NSString *const kStageNumberOfTeams = @"numberOfTeams";
NSString *const kStageRounds = @"rounds";

@interface Stage ()
@end
@implementation Stage




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kStageChampionshipId] isKindOfClass:[NSNull class]]){
        self.championshipId = [dictionary[kStageChampionshipId] integerValue];
    }
    
    if(dictionary[kStageGroups] != nil && [dictionary[kStageGroups] isKindOfClass:[NSArray class]]){
        NSArray * groupsDictionaries = dictionary[kStageGroups];
        NSMutableArray * groupsItems = [NSMutableArray array];
        for(NSDictionary * groupsDictionary in groupsDictionaries){
            Group * groupsItem = [[Group alloc] initWithDictionary:groupsDictionary];
            [groupsItems addObject:groupsItem];
        }
        self.groups = groupsItems;
    }
    if(![dictionary[kStageIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kStageIdField] integerValue];
    }
    
    if(![dictionary[kStageIsCustomGroupOrdering] isKindOfClass:[NSNull class]]){
        self.isCustomGroupOrdering = [dictionary[kStageIsCustomGroupOrdering] boolValue];
    }
    
    if(![dictionary[kStageIsGroups] isKindOfClass:[NSNull class]]){
        self.isGroups = [dictionary[kStageIsGroups] boolValue];
    }
    
    if(![dictionary[kStageIsPlayOffs] isKindOfClass:[NSNull class]]){
        self.isPlayOffs = [dictionary[kStageIsPlayOffs] boolValue];
    }
    
    if(![dictionary[kStageIsShowResult] isKindOfClass:[NSNull class]]){
        self.isShowResult = [dictionary[kStageIsShowResult] boolValue];
    }
    
    if(![dictionary[kStageNumberOfGroups] isKindOfClass:[NSNull class]]){
        self.numberOfGroups = dictionary[kStageNumberOfGroups];
    }
    if(![dictionary[kStageNumberOfTeams] isKindOfClass:[NSNull class]]){
        self.numberOfTeams = dictionary[kStageNumberOfTeams];
    }
    if(dictionary[kStageRounds] != nil && [dictionary[kStageRounds] isKindOfClass:[NSArray class]]){
        NSArray * roundsDictionaries = dictionary[kStageRounds];
        NSMutableArray * roundsItems = [NSMutableArray array];
        for(NSDictionary * roundsDictionary in roundsDictionaries){
            Round * roundsItem = [[Round alloc] initWithDictionary:roundsDictionary];
            [roundsItems addObject:roundsItem];
        }
        self.rounds = roundsItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kStageChampionshipId] = @(self.championshipId);
    if(self.groups != nil){
        dictionary[kStageGroups] = self.groups;
    }
    dictionary[kStageIdField] = @(self.idField);
    dictionary[kStageIsCustomGroupOrdering] = @(self.isCustomGroupOrdering);
    dictionary[kStageIsGroups] = @(self.isGroups);
    dictionary[kStageIsPlayOffs] = @(self.isPlayOffs);
    dictionary[kStageIsShowResult] = @(self.isShowResult);
    if(self.numberOfGroups != nil){
        dictionary[kStageNumberOfGroups] = self.numberOfGroups;
    }
    if(self.numberOfTeams != nil){
        dictionary[kStageNumberOfTeams] = self.numberOfTeams;
    }
    if(self.rounds != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(Round * roundsElement in self.rounds){
            [dictionaryElements addObject:[roundsElement toDictionary]];
        }
        dictionary[kStageRounds] = dictionaryElements;
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
    [aCoder encodeObject:@(self.championshipId) forKey:kStageChampionshipId];    if(self.groups != nil){
        [aCoder encodeObject:self.groups forKey:kStageGroups];
    }
    [aCoder encodeObject:@(self.idField) forKey:kStageIdField];    [aCoder encodeObject:@(self.isCustomGroupOrdering) forKey:kStageIsCustomGroupOrdering];    [aCoder encodeObject:@(self.isGroups) forKey:kStageIsGroups];    [aCoder encodeObject:@(self.isPlayOffs) forKey:kStageIsPlayOffs];    [aCoder encodeObject:@(self.isShowResult) forKey:kStageIsShowResult];    if(self.numberOfGroups != nil){
        [aCoder encodeObject:self.numberOfGroups forKey:kStageNumberOfGroups];
    }
    if(self.numberOfTeams != nil){
        [aCoder encodeObject:self.numberOfTeams forKey:kStageNumberOfTeams];
    }
    if(self.rounds != nil){
        [aCoder encodeObject:self.rounds forKey:kStageRounds];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.championshipId = [[aDecoder decodeObjectForKey:kStageChampionshipId] integerValue];
    self.groups = [aDecoder decodeObjectForKey:kStageGroups];
    self.idField = [[aDecoder decodeObjectForKey:kStageIdField] integerValue];
    self.isCustomGroupOrdering = [[aDecoder decodeObjectForKey:kStageIsCustomGroupOrdering] boolValue];
    self.isGroups = [[aDecoder decodeObjectForKey:kStageIsGroups] boolValue];
    self.isPlayOffs = [[aDecoder decodeObjectForKey:kStageIsPlayOffs] boolValue];
    self.isShowResult = [[aDecoder decodeObjectForKey:kStageIsShowResult] boolValue];
    self.numberOfGroups = [aDecoder decodeObjectForKey:kStageNumberOfGroups];
    self.numberOfTeams = [aDecoder decodeObjectForKey:kStageNumberOfTeams];
    self.rounds = [aDecoder decodeObjectForKey:kStageRounds];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    Stage *copy = [Stage new];
    
    copy.championshipId = self.championshipId;
    copy.groups = [self.groups copy];
    copy.idField = self.idField;
    copy.isCustomGroupOrdering = self.isCustomGroupOrdering;
    copy.isGroups = self.isGroups;
    copy.isPlayOffs = self.isPlayOffs;
    copy.isShowResult = self.isShowResult;
    copy.numberOfGroups = [self.numberOfGroups copy];
    copy.numberOfTeams = [self.numberOfTeams copy];
    copy.rounds = [self.rounds copy];
    
    return copy;
}
@end
