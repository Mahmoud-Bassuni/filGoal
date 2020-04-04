//
//  pagerItems.m
//  Reyada
//
//  Created by Ahmed Kotb on 5/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "pagerItems.h"

@implementation pagerItems

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"title"] isKindOfClass:[NSNull class]]){
        self.title = dictionary[@"title"];
    }
    if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
        self.type = [dictionary[@"type"] integerValue];
    }    if(![dictionary[@"src"] isKindOfClass:[NSNull class]]){
        self.source = dictionary[@"src"];
    }
    if(![dictionary[@"date"] isKindOfClass:[NSNull class]]){
        self.date = dictionary[@"date"];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.title != nil){
        dictionary[@"title"] = self.title;
    }
    dictionary[@"type"] = @(self.type);
    if(self.source != nil){
        dictionary[@"src"] = self.source;
    }
    if(self.date != nil){
        dictionary[@"date"] = self.date;
    }
    
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(self.title != nil){
        [aCoder encodeObject:self.title forKey:@"title"];
    }
    [aCoder encodeObject:@(self.type) forKey:@"type"];
    if(self.source != nil){
        [aCoder encodeObject:self.source forKey:@"src"];
    }
    if(self.date != nil){
        [aCoder encodeObject:self.date forKey:@"date"];
    }
    
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];
    self.source = [aDecoder decodeObjectForKey:@"src"];
    self.date = [aDecoder decodeObjectForKey:@"date"];
    
    return self;
    
}

@end
