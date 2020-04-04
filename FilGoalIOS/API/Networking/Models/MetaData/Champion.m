//
//  Champion.m
//
//  Created by MacBookPro  on 6/4/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Champion.h"


@interface Champion ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Champion

@synthesize displayorder = _displayorder;
@synthesize champId = _champId;
@synthesize numRounds = _numRounds;
@synthesize champLogo = _champLogo;
@synthesize champName = _champName;
@synthesize champType = _champType;
@synthesize hasGroups = _hasGroups;


+ (Champion *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Champion *instance = [[Champion alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.displayorder = [[self objectOrNilForKey:@"displayorder" fromDictionary:dict] intValue];
            self.champId = [[self objectOrNilForKey:@"champ_id" fromDictionary:dict] intValue];
            self.sectionid = [[self objectOrNilForKey:@"sectionid" fromDictionary:dict] intValue];
            self.numRounds = [[self objectOrNilForKey:@"NumRounds" fromDictionary:dict] intValue];
            self.champLogo = [self objectOrNilForKey:@"champ_logo" fromDictionary:dict];
            self.champName = [self objectOrNilForKey:@"champ_name" fromDictionary:dict];
            self.champType = [[self objectOrNilForKey:@"champ_type" fromDictionary:dict] intValue];
            self.hasGroups = [[self objectOrNilForKey:@"HasGroups"fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithInt:self.displayorder] forKey:@"displayorder"];
    [mutableDict setValue:[NSNumber numberWithInt:self.champId] forKey:@"champ_id"];
    [mutableDict setValue:[NSNumber numberWithInt:self.sectionid] forKey:@"sectionid"];
    [mutableDict setValue:[NSNumber numberWithInt:self.numRounds] forKey:@"NumRounds"];
    [mutableDict setValue:self.champLogo forKey:@"champ_logo"];
    [mutableDict setValue:self.champName forKey:@"champ_name"];
    [mutableDict setValue:[NSNumber numberWithInt:self.champType] forKey:@"champ_type"];
    [mutableDict setValue:[NSNumber numberWithBool:self.hasGroups] forKey:@"HasGroups"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.displayorder = [aDecoder decodeIntForKey:@"displayorder"];
    self.champId = [aDecoder decodeIntForKey:@"champId"];
    self.sectionid = [aDecoder decodeIntForKey:@"sectionid"];
    self.numRounds = [aDecoder decodeIntForKey:@"numRounds"];
    self.champLogo = [aDecoder decodeObjectForKey:@"champLogo"];
    self.champName = [aDecoder decodeObjectForKey:@"champName"];
    self.champType = [aDecoder decodeIntForKey:@"champType"];
    self.hasGroups = [aDecoder decodeBoolForKey:@"hasGroups"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeInt:_displayorder forKey:@"displayorder"];
    [aCoder encodeInt:_champId forKey:@"champId"];
     [aCoder encodeInt:_sectionid forKey:@"sectionid"];
    [aCoder encodeInt:_numRounds forKey:@"numRounds"];
    [aCoder encodeObject:_champLogo forKey:@"champLogo"];
    [aCoder encodeObject:_champName forKey:@"champName"];
    [aCoder encodeInt:_champType forKey:@"champType"];
    [aCoder encodeBool:_hasGroups forKey:@"hasGroups"];
}


@end
