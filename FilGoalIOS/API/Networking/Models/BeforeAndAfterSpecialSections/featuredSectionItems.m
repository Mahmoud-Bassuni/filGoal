//
//  FeaturedSectionItems.m
//  Reyada
//
//  Created by Ahmed Kotb on 5/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "FeaturedSectionItems.h"
#import "pagerItems.h"

@implementation FeaturedSectionItems
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[@"afterSection"] isKindOfClass:[NSNull class]]){
        self.afterSection = [[AfterSection alloc] initWithDictionary:dictionary[@"afterSection"]];
    }
    
    if(![dictionary[@"baseUrl"] isKindOfClass:[NSNull class]]){
        self.baseUrl = dictionary[@"baseUrl"];
    }
    if(![dictionary[@"beforeSection"] isKindOfClass:[NSNull class]]){
        self.beforeSection = [[AfterSection alloc] initWithDictionary:dictionary[@"beforeSection"]];
    }
    
    if(dictionary[@"section"] != nil && [dictionary[@"section"] isKindOfClass:[NSArray class]]){
        NSArray * componentDictionaries = dictionary[@"section"];
        NSMutableArray * componentItems = [NSMutableArray array];
        for(NSDictionary * componentDictionary in componentDictionaries){
            pagerItems * componentItem = [[pagerItems alloc] initWithDictionary:componentDictionary];
            [componentItems addObject:componentItem];
        }
        self.section = componentItems;
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.afterSection != nil){
        dictionary[@"afterSection"] = [self.afterSection toDictionary];
    }
    if(self.baseUrl != nil){
        dictionary[@"baseUrl"] = self.baseUrl;
    }
    if(self.beforeSection != nil){
        dictionary[@"beforeSection"] = [self.beforeSection toDictionary];
    }
    if(self.section != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(pagerItems * componentElement in self.section){
            [dictionaryElements addObject:[componentElement toDictionary]];
        }
        dictionary[@"section"] = dictionaryElements;
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
    if(self.afterSection != nil){
        [aCoder encodeObject:self.afterSection forKey:@"afterSection"];
    }
    if(self.baseUrl != nil){
        [aCoder encodeObject:self.baseUrl forKey:@"baseUrl"];
    }
    if(self.beforeSection != nil){
        [aCoder encodeObject:self.beforeSection forKey:@"beforeSection"];
    }
    if(self.section != nil){
        [aCoder encodeObject:self.section forKey:@"section"];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
   	self = [super init];
    self.afterSection = [aDecoder decodeObjectForKey:@"afterSection"];
    self.baseUrl = [aDecoder decodeObjectForKey:@"baseUrl"];
    self.beforeSection = [aDecoder decodeObjectForKey:@"beforeSection"];
    self.section = [aDecoder decodeObjectForKey:@"section"];
    return self;
    
}
@end
