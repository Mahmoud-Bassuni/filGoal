//
//  Items.m
//
//  Created by MacBookPro  on 5/6/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HomeItems.h"
#import "VideoItem.h"
#import "PartMatches.h"
#import "NewsItem.h"
#import "Album.h"
#import "PollsCell.h"
#import "Poll.h"
#import "FilGoalIOS-Swift.h"

@interface HomeItems ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HomeItems

@synthesize partVideos = _partVideos;
//@synthesize partMatches = _partMatches;
@synthesize partNews = _partNews;
@synthesize partAlbums = _partAlbums;
@synthesize partPolls = _partPolls;



+ (HomeItems *)modelObjectWithDictionary:(NSDictionary *)dict
{
    HomeItems *instance = [[HomeItems alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        NSObject *receivedPartVideos = [dict objectForKey:@"part_videos"];
        NSMutableArray *parsedPartVideos = [NSMutableArray array];
        if ([receivedPartVideos isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedPartVideos) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedPartVideos addObject:[VideoItem modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedPartVideos isKindOfClass:[NSDictionary class]]) {
            [parsedPartVideos addObject:[VideoItem modelObjectWithDictionary:(NSDictionary *)receivedPartVideos]];
        }
        
        self.partVideos = [NSArray arrayWithArray:parsedPartVideos];
//        NSObject *receivedPartMatches = [dict objectForKey:@"part_matches"];
//        NSMutableArray *parsedPartMatches = [NSMutableArray array];
//        if ([receivedPartMatches isKindOfClass:[NSArray class]]) {
//            for (NSDictionary *item in (NSArray *)receivedPartMatches) {
//                if ([item isKindOfClass:[NSDictionary class]]) {
//                    [parsedPartMatches addObject:[PartMatches modelObjectWithDictionary:item]];
//                }
//            }
//        } else if ([receivedPartMatches isKindOfClass:[NSDictionary class]]) {
//            [parsedPartMatches addObject:[PartMatches modelObjectWithDictionary:(NSDictionary *)receivedPartMatches]];
//        }
//        
//        self.partMatches = [NSArray arrayWithArray:parsedPartMatches];
        NSObject *receivedPartNews = [dict objectForKey:@"part_news"];
        NSMutableArray *parsedPartNews = [NSMutableArray array];
        if ([receivedPartNews isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedPartNews) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedPartNews addObject:[NewsItem modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedPartNews isKindOfClass:[NSDictionary class]]) {
            [parsedPartNews addObject:[NewsItem modelObjectWithDictionary:(NSDictionary *)receivedPartNews]];
        }
        
        self.partNews = [NSArray arrayWithArray:parsedPartNews];
        
        
        NSObject *receivedPartAlbums = [dict objectForKey:@"part_albums"];
        NSMutableArray *parsedPartAlbums = [NSMutableArray array];
        if ([receivedPartAlbums isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedPartAlbums) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedPartAlbums addObject:[[Album alloc]initWithDictionary:item]];
                }
            }
        } else if ([receivedPartAlbums isKindOfClass:[NSDictionary class]]) {
            [parsedPartAlbums addObject:[[Album alloc]initWithDictionary:(NSDictionary *)receivedPartAlbums]];
            
        }
        
        self.partAlbums = [NSArray arrayWithArray:parsedPartAlbums];
        
        NSObject *receivedPartPolls = [dict objectForKey:@"part_polls"];
        NSMutableArray *parsedPartPolls = [NSMutableArray array];
        if ([receivedPartPolls isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedPartPolls) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                  //  [parsedPartPolls addObject:[[Poll alloc]initWithDictionary:(NSDictionary *)receivedPartPolls]];
                    NSDictionary *dict = [(NSArray*)receivedPartPolls firstObject];
                    [parsedPartPolls addObject:[[Polld alloc]initWithDic: dict]];
                  //  [parsedPartPolls addObject:[Polld alloc]initDic:(NSDictionary *)receivedPartPolls];
                }
            }
        } else if ([receivedPartPolls isKindOfClass:[NSDictionary class]]) {
           NSDictionary *dict = [(NSArray*)receivedPartPolls firstObject];
            [parsedPartPolls addObject:[[Polld alloc]initWithDic: dict]];
            
        }
        
        self.partPolls = [NSArray arrayWithArray:parsedPartPolls];
        
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForPartVideos = [NSMutableArray array];
    for (NSObject *subArrayObject in self.partVideos) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPartVideos addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPartVideos addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPartVideos] forKey:@"part_videos"];
//    NSMutableArray *tempArrayForPartMatches = [NSMutableArray array];
//    for (NSObject *subArrayObject in self.partMatches) {
//        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
//            // This class is a model object
//            [tempArrayForPartMatches addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
//        } else {
//            // Generic object
//            [tempArrayForPartMatches addObject:subArrayObject];
//        }
//    }
//    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPartMatches] forKey:@"part_matches"];
    NSMutableArray *tempArrayForPartNews = [NSMutableArray array];
    for (NSObject *subArrayObject in self.partNews) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPartNews addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPartNews addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPartNews] forKey:@"part_news"];
    
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
    
    self.partVideos = [aDecoder decodeObjectForKey:@"partVideos"];
  //  self.partMatches = [aDecoder decodeObjectForKey:@"partMatches"];
    self.partNews = [aDecoder decodeObjectForKey:@"partNews"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_partVideos forKey:@"partVideos"];
  //  [aCoder encodeObject:_partMatches forKey:@"partMatches"];
    [aCoder encodeObject:_partNews forKey:@"partNews"];
}


@end
