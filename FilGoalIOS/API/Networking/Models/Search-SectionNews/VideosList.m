//
//  SearchVideos.m
//
//  Created by MacBookPro  on 2/23/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "VideosList.h"
#import "VideoItem.h"


@interface VideosList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideosList

@synthesize videos = _videos;
-(instancetype)initWithArrayList:(NSArray*)responseObject
{
    NSMutableArray *parsedVideos = [NSMutableArray array];

    for (NSDictionary *item in responseObject) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            [parsedVideos addObject:[VideoItem modelObjectWithDictionary:item]];
        }
    }
    self.videos = [NSArray arrayWithArray:parsedVideos];
    return self;
}

+ (VideosList *)modelObjectWithDictionary:(NSDictionary *)dict
{
    VideosList *instance = [[VideosList alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedVideos = [dict objectForKey:@"videos"];
    NSMutableArray *parsedVideos = [NSMutableArray array];
    if ([receivedVideos isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedVideos) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedVideos addObject:[VideoItem modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedVideos isKindOfClass:[NSDictionary class]]) {
       [parsedVideos addObject:[VideoItem modelObjectWithDictionary:(NSDictionary *)receivedVideos]];
    }

    self.videos = [NSArray arrayWithArray:parsedVideos];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForVideos = [NSMutableArray array];
    for (NSObject *subArrayObject in self.videos) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVideos addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVideos addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVideos] forKey:@"videos"];

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

    self.videos = [aDecoder decodeObjectForKey:@"videos"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_videos forKey:@"videos"];
}


@end
