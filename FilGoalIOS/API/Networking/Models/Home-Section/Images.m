//
//  Images.m
//
//  Created by MacBookPro  on 2/23/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Images.h"


@interface Images ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Images

@synthesize small = _small;
@synthesize large = _large;
@synthesize caption = _caption;


+ (Images *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Images *instance = [[Images alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.small = [self objectOrNilForKey:@"small" fromDictionary:dict];
            self.large = [self objectOrNilForKey:@"large" fromDictionary:dict];
            self.caption = [self objectOrNilForKey:@"caption" fromDictionary:dict];
    }
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.small forKey:@"small"];
    [mutableDict setValue:self.large forKey:@"large"];
    [mutableDict setValue:self.caption forKey:@"caption"];

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

    self.small = [aDecoder decodeObjectForKey:@"small"];
    self.large = [aDecoder decodeObjectForKey:@"large"];
    self.caption = [aDecoder decodeObjectForKey:@"caption"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_small forKey:@"small"];
    [aCoder encodeObject:_large forKey:@"large"];
    [aCoder encodeObject:_caption forKey:@"caption"];
}


@end
