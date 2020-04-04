//
//  SpecialSponsorUrl.m
//  FilGoalIOS
//
//  Created by Sarmady on 4/1/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

#import "SpecialSponsorUrl.h"

NSString *const kSpecialSponsorUrlIdField = @"id";
NSString *const kSpecialSponsorUrlUrl = @"url";
NSString *const kSpecialSponsorUrlCategory = @"category";


@interface SpecialSponsorUrl ()
@end
@implementation SpecialSponsorUrl




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kSpecialSponsorUrlIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kSpecialSponsorUrlIdField] integerValue];
    }
    
    if(![dictionary[kSpecialSponsorUrlUrl] isKindOfClass:[NSNull class]]){
        self.url = dictionary[kSpecialSponsorUrlUrl];
    }
    
    if(![dictionary[kSpecialSponsorUrlCategory] isKindOfClass:[NSNull class]]){
        self.category = dictionary[kSpecialSponsorUrlCategory];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if (self.idField != nil) {
        dictionary[kSpecialSponsorUrlIdField] = @(self.idField);
    }
    if(self.url != nil){
        dictionary[kSpecialSponsorUrlUrl] = self.url;
    }
    if (self.category != nil) {
        dictionary[kSpecialSponsorUrlCategory] = self.category;
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
    [aCoder encodeObject:@(self.idField) forKey:kSpecialSponsorUrlIdField];
    if(self.url != nil){
        [aCoder encodeObject:self.url forKey:kSpecialSponsorUrlUrl];
    }
    if(self.url != nil){
        [aCoder encodeObject:self.category forKey:kSpecialSponsorUrlCategory];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.idField = [[aDecoder decodeObjectForKey:kSpecialSponsorUrlIdField] integerValue];
    self.url = [aDecoder decodeObjectForKey:kSpecialSponsorUrlUrl];
    self.category = [aDecoder decodeObjectForKey:kSpecialSponsorUrlCategory];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    SpecialSponsorUrl *copy = [SpecialSponsorUrl new];
    
    copy.idField = self.idField;
    copy.url = [self.url copy];
    copy.category = [self.category copy];
    return copy;
}
@end
