//
//  VideoSectionId.m
//
//  Created by MacBookPro  on 6/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "VideoSectionId.h"


@interface VideoSectionId ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoSectionId

@synthesize sectionId = _sectionId;


+ (VideoSectionId *)modelObjectWithDictionary:(NSDictionary *)dict
{
    VideoSectionId *instance = [[VideoSectionId alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.sectionId = [[dict objectForKey:@"section_id"] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sectionId] forKey:@"section_id"];

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

    self.sectionId = [aDecoder decodeDoubleForKey:@"sectionId"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sectionId forKey:@"sectionId"];
}


@end
