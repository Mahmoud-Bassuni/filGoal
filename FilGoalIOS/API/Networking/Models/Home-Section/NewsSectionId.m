//
//  NewsSectionId.m
//
//  Created by MacBookPro  on 2/23/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NewsSectionId.h"


@interface NewsSectionId ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NewsSectionId

@synthesize sectionId = _sectionId;


+ (NewsSectionId *)modelObjectWithDictionary:(NSDictionary *)dict
{
    NewsSectionId *instance = [[NewsSectionId alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.sectionId = [[dict objectForKey:@"section_id"] intValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithInt:self.sectionId] forKey:@"section_id"];

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

    self.sectionId = [aDecoder decodeIntForKey:@"sectionId"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeInt:_sectionId forKey:@"sectionId"];
}


@end
