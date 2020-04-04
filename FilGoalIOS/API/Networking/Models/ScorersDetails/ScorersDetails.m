//
//  ScorersDetails.m
//
//  Created by MacBookPro  on 5/29/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "ScorersDetails.h"
#import "Player.h"


@interface ScorersDetails ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ScorersDetails

@synthesize scorers = _scorers;
@synthesize totalcount = _totalcount;


+ (ScorersDetails *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ScorersDetails *instance = [[ScorersDetails alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedScorers = [dict objectForKey:@"Scorers"];
    NSMutableArray *parsedScorers = [NSMutableArray array];
    if ([receivedScorers isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedScorers) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                Player * player = [[Player alloc]initWithDictionary:item];
                [parsedScorers addObject:player];
            }
       }
    } else if ([receivedScorers isKindOfClass:[NSDictionary class]]) {
        Player * player = [[Player alloc]initWithDictionary:receivedScorers];
       [parsedScorers addObject:player];
    }

    self.scorers = [NSArray arrayWithArray:parsedScorers];
            self.totalcount = [[dict objectForKey:@"totalcount"] intValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForScorers = [NSMutableArray array];
    for (NSObject *subArrayObject in self.scorers) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForScorers addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForScorers addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForScorers] forKey:@"Scorers"];
    [mutableDict setValue:[NSNumber numberWithInt:self.totalcount] forKey:@"totalcount"];

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

    self.scorers = [aDecoder decodeObjectForKey:@"scorers"];
    self.totalcount = [aDecoder decodeIntForKey:@"totalcount"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_scorers forKey:@"scorers"];
    [aCoder encodeInt:_totalcount forKey:@"totalcount"];
}


@end
