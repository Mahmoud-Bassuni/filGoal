//
//  Home.m
//
//  Created by MacBookPro  on 5/6/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Home.h"
#import "HomeParts.h"


@interface Home ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Home

@synthesize homeParts = _homeParts;


+ (Home *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Home *instance = [[Home alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedHomeParts = [dict objectForKey:@"HomeParts"];
    NSMutableArray *parsedHomeParts = [NSMutableArray array];
    if ([receivedHomeParts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHomeParts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHomeParts addObject:[HomeParts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHomeParts isKindOfClass:[NSDictionary class]]) {
       [parsedHomeParts addObject:[HomeParts modelObjectWithDictionary:(NSDictionary *)receivedHomeParts]];
    }

    self.homeParts = [NSArray arrayWithArray:parsedHomeParts];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForHomeParts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.homeParts) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHomeParts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHomeParts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHomeParts] forKey:@"HomeParts"];

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

    self.homeParts = [aDecoder decodeObjectForKey:@"homeParts"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_homeParts forKey:@"homeParts"];
}


@end
