//
//  PartMatches.m
//
//  Created by MacBookPro  on 5/6/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "PartMatches.h"



@interface PartMatches ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PartMatches

@synthesize today = _today;
@synthesize yesterday = _yesterday;
@synthesize tommorrow = _tommorrow;
@synthesize live = _live;


//+ (PartMatches *)modelObjectWithDictionary:(NSDictionary *)dict
//{
//    PartMatches *instance = [[PartMatches alloc] initWithDictionary:dict];
//    return instance;
//}

//- (id)initWithDictionary:(NSDictionary *)dict
//{
//    self = [super init];
//    
//    // This check serves to make sure that a non-NSDictionary object
//    // passed into the model class doesn't break the parsing.
//    if(self && [dict isKindOfClass:[NSDictionary class]]) {
//    NSObject *receivedToday = [dict objectForKey:@"today"];
//    NSMutableArray *parsedToday = [NSMutableArray array];
//    if ([receivedToday isKindOfClass:[NSArray class]]) {
//        for (NSDictionary *item in (NSArray *)receivedToday) {
//            if ([item isKindOfClass:[NSDictionary class]]) {
//                [parsedToday addObject:[MatchItem modelObjectWithDictionary:item]];
//            }
//       }
//    } else if ([receivedToday isKindOfClass:[NSDictionary class]]) {
//       [parsedToday addObject:[MatchItem modelObjectWithDictionary:(NSDictionary *)receivedToday]];
//    }
//
//    self.today = [NSArray arrayWithArray:parsedToday];
//    NSObject *receivedYesterday = [dict objectForKey:@"yesterday"];
//    NSMutableArray *parsedYesterday = [NSMutableArray array];
//    if ([receivedYesterday isKindOfClass:[NSArray class]]) {
//        for (NSDictionary *item in (NSArray *)receivedYesterday) {
//            if ([item isKindOfClass:[NSDictionary class]]) {
//                [parsedYesterday addObject:[MatchItem modelObjectWithDictionary:item]];
//            }
//       }
//    } else if ([receivedYesterday isKindOfClass:[NSDictionary class]]) {
//       [parsedYesterday addObject:[MatchItem modelObjectWithDictionary:(NSDictionary *)receivedYesterday]];
//    }
//
//    self.yesterday = [NSArray arrayWithArray:parsedYesterday];
//    NSObject *receivedTommorrow = [dict objectForKey:@"tommorrow"];
//    NSMutableArray *parsedTommorrow = [NSMutableArray array];
//    if ([receivedTommorrow isKindOfClass:[NSArray class]]) {
//        for (NSDictionary *item in (NSArray *)receivedTommorrow) {
//            if ([item isKindOfClass:[NSDictionary class]]) {
//                [parsedTommorrow addObject:[MatchItem modelObjectWithDictionary:item]];
//            }
//       }
//    } else if ([receivedTommorrow isKindOfClass:[NSDictionary class]]) {
//       [parsedTommorrow addObject:[MatchItem modelObjectWithDictionary:(NSDictionary *)receivedTommorrow]];
//    }
//
//    self.tommorrow = [NSArray arrayWithArray:parsedTommorrow];
//    NSObject *receivedLive = [dict objectForKey:@"live"];
//    NSMutableArray *parsedLive = [NSMutableArray array];
//    if ([receivedLive isKindOfClass:[NSArray class]]) {
//        for (NSDictionary *item in (NSArray *)receivedLive) {
//            if ([item isKindOfClass:[NSDictionary class]]) {
//                [parsedLive addObject:[MatchItem modelObjectWithDictionary:item]];
//            }
//       }
//    } else if ([receivedLive isKindOfClass:[NSDictionary class]]) {
//       [parsedLive addObject:[MatchItem modelObjectWithDictionary:(NSDictionary *)receivedLive]];
//    }
//
//    self.live = [NSArray arrayWithArray:parsedLive];
//
//    }
//    
//    return self;
//    
//}
//
//- (NSDictionary *)dictionaryRepresentation
//{
//    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
//NSMutableArray *tempArrayForToday = [NSMutableArray array];
//    for (NSObject *subArrayObject in self.today) {
//        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
//            // This class is a model object
//            [tempArrayForToday addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
//        } else {
//            // Generic object
//            [tempArrayForToday addObject:subArrayObject];
//        }
//    }
//    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForToday] forKey:@"today"];
//NSMutableArray *tempArrayForYesterday = [NSMutableArray array];
//    for (NSObject *subArrayObject in self.yesterday) {
//        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
//            // This class is a model object
//            [tempArrayForYesterday addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
//        } else {
//            // Generic object
//            [tempArrayForYesterday addObject:subArrayObject];
//        }
//    }
//    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForYesterday] forKey:@"yesterday"];
//NSMutableArray *tempArrayForTommorrow = [NSMutableArray array];
//    for (NSObject *subArrayObject in self.tommorrow) {
//        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
//            // This class is a model object
//            [tempArrayForTommorrow addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
//        } else {
//            // Generic object
//            [tempArrayForTommorrow addObject:subArrayObject];
//        }
//    }
//    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTommorrow] forKey:@"tommorrow"];
//NSMutableArray *tempArrayForLive = [NSMutableArray array];
//    for (NSObject *subArrayObject in self.live) {
//        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
//            // This class is a model object
//            [tempArrayForLive addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
//        } else {
//            // Generic object
//            [tempArrayForLive addObject:subArrayObject];
//        }
//    }
//    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLive] forKey:@"live"];
//
//    return [NSDictionary dictionaryWithDictionary:mutableDict];
//}
//
//- (NSString *)description 
//{
//    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
//}
//
//#pragma mark - Helper Method
//- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
//{
//    id object = [dict objectForKey:aKey];
//    return [object isEqual:[NSNull null]] ? nil : object;
//}
//
//
//#pragma mark - NSCoding Methods
//
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//
//    self.today = [aDecoder decodeObjectForKey:@"today"];
//    self.yesterday = [aDecoder decodeObjectForKey:@"yesterday"];
//    self.tommorrow = [aDecoder decodeObjectForKey:@"tommorrow"];
//    self.live = [aDecoder decodeObjectForKey:@"live"];
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//
//    [aCoder encodeObject:_today forKey:@"today"];
//    [aCoder encodeObject:_yesterday forKey:@"yesterday"];
//    [aCoder encodeObject:_tommorrow forKey:@"tommorrow"];
//    [aCoder encodeObject:_live forKey:@"live"];
//}
//

@end
