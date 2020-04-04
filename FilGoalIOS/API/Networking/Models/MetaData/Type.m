//
//  Types.m
//
//  Created by MacBookPro  on 5/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Type.h"


@interface Type ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Type

@synthesize typeId = _typeId;
@synthesize typeName = _typeName;


+ (Type *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Type *instance = [[Type alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.typeId = [[dict objectForKey:@"type_id"] intValue];
            self.typeName = [self objectOrNilForKey:@"type_name" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithInt:self.typeId] forKey:@"type_id"];
    [mutableDict setValue:self.typeName forKey:@"type_name"];

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

    self.typeId = [aDecoder decodeIntForKey:@"typeId"];
    self.typeName = [aDecoder decodeObjectForKey:@"typeName"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeInt:_typeId forKey:@"typeId"];
    [aCoder encodeObject:_typeName forKey:@"typeName"];
}


@end
