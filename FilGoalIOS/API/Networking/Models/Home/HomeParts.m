//
//  HomeParts.m
//
//  Created by MacBookPro  on 5/6/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HomeParts.h"
#import "HomeItems.h"


@interface HomeParts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeParts

@synthesize items = _items;
@synthesize partName = _partName;
@synthesize partType = _partType;


+ (HomeParts *)modelObjectWithDictionary:(NSDictionary *)dict
{
    HomeParts *instance = [[HomeParts alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.items = [HomeItems modelObjectWithDictionary:[dict objectForKey:@"items"]];
            self.partName = [self objectOrNilForKey:@"part_name" fromDictionary:dict];
            self.partType = [[dict objectForKey:@"part_type"] intValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.items dictionaryRepresentation] forKey:@"items"];
    [mutableDict setValue:self.partName forKey:@"part_name"];
    [mutableDict setValue:[NSNumber numberWithInt:self.partType] forKey:@"part_type"];

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

    self.items = [aDecoder decodeObjectForKey:@"items"];
    self.partName = [aDecoder decodeObjectForKey:@"partName"];
    self.partType = [aDecoder decodeIntForKey:@"partType"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_items forKey:@"items"];
    [aCoder encodeObject:_partName forKey:@"partName"];
    [aCoder encodeInt:_partType forKey:@"partType"];
}


@end
