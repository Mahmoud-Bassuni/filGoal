//
//  SearchNews.m
//
//  Created by MacBookPro  on 2/23/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NewsList.h"
#import "NewsItem.h"


@interface NewsList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NewsList

@synthesize news = _news;


+ (NewsList *)modelObjectWithDictionary:(NSDictionary *)dict
{
    NewsList *instance = [[NewsList alloc] initWithDictionary:dict];
    return instance;
}
#pragma mark set news list response as array
-(instancetype)initWithArrayList:(NSArray*)responseObject
{
    NSMutableArray *parsedNews = [NSMutableArray array];

    for (NSDictionary *item in responseObject) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            [parsedNews addObject:[NewsItem modelObjectWithDictionary:item]];
        }
    }
    self.news = [NSArray arrayWithArray:parsedNews];
    return self;
}
- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedNews = [dict objectForKey:@"news"];
    NSMutableArray *parsedNews = [NSMutableArray array];
    if ([receivedNews isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNews) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNews addObject:[NewsItem modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNews isKindOfClass:[NSDictionary class]]) {
       [parsedNews addObject:[NewsItem modelObjectWithDictionary:(NSDictionary *)receivedNews]];
    }

    self.news = [NSArray arrayWithArray:parsedNews];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForNews = [NSMutableArray array];
    for (NSObject *subArrayObject in self.news) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNews addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNews addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNews] forKey:@"news"];

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

    self.news = [aDecoder decodeObjectForKey:@"news"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_news forKey:@"news"];
}


@end
