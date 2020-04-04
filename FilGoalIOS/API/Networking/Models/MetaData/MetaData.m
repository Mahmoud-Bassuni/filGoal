//
//  MetaData.m
//
//  Created by MacBookPro  on 5/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MetaData.h"
#import "Section.h"
#import "Type.h"
#import "Champion.h"


@interface MetaData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MetaData

@synthesize sections = _sections;
@synthesize types = _types;
@synthesize champions = _champions;


+ (MetaData *)modelObjectWithDictionary:(NSDictionary *)dict
{
    MetaData *instance = [[MetaData alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedSections = [dict objectForKey:@"Sections"];
    NSMutableArray *parsedSections = [NSMutableArray array];
    if ([receivedSections isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSections) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSections addObject:[[Section alloc]initWithDictionary:item]];
            }
       }
    } else if ([receivedSections isKindOfClass:[NSDictionary class]]) {
       [parsedSections addObject:[[Section alloc]initWithDictionary:(NSDictionary *)receivedSections]];
    }

    self.sections = [NSArray arrayWithArray:parsedSections];
    NSObject *receivedTypes = [dict objectForKey:@"Types"];
    NSMutableArray *parsedTypes = [NSMutableArray array];
    if ([receivedTypes isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTypes) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTypes addObject:[Type modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTypes isKindOfClass:[NSDictionary class]]) {
       [parsedTypes addObject:[Type modelObjectWithDictionary:(NSDictionary *)receivedTypes]];
    }

    self.types = [NSArray arrayWithArray:parsedTypes];
    NSObject *receivedChampions = [dict objectForKey:@"Champions"];
    NSMutableArray *parsedChampions = [NSMutableArray array];
    if ([receivedChampions isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedChampions) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedChampions addObject:[Champion modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedChampions isKindOfClass:[NSDictionary class]]) {
       [parsedChampions addObject:[Champion modelObjectWithDictionary:(NSDictionary *)receivedChampions]];
    }

    self.champions = [NSArray arrayWithArray:parsedChampions];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForSections = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sections) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSections addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSections addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSections] forKey:@"Sections"];
NSMutableArray *tempArrayForTypes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.types) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTypes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTypes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTypes] forKey:@"Types"];
NSMutableArray *tempArrayForChampions = [NSMutableArray array];
    for (NSObject *subArrayObject in self.champions) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForChampions addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForChampions addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChampions] forKey:@"Champions"];

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

    self.sections = [aDecoder decodeObjectForKey:@"sections"];
    self.types = [aDecoder decodeObjectForKey:@"types"];
    self.champions = [aDecoder decodeObjectForKey:@"champions"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sections forKey:@"sections"];
    [aCoder encodeObject:_types forKey:@"types"];
    [aCoder encodeObject:_champions forKey:@"champions"];
}


@end
