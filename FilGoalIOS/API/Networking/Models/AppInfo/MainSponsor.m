//
//    MainSponsor.m
//
//    Create by Nada Gamal on 21/5/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MainSponsor.h"

NSString *const kMainSponsorAppSponsor = @"app_sponsor";
NSString *const kMainSponsorPerContentTypeSponsor = @"per_content_type_sponsor";
NSString *const kMainSponsorPredictSponsor = @"predict_sponsor";
NSString *const kMainSponsorSpecialSponsor = @"special_sponsor";

@interface MainSponsor ()
@end
@implementation MainSponsor




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kMainSponsorAppSponsor] isKindOfClass:[NSNull class]]){
        self.appSponsor = [[AppSponsor alloc] initWithDictionary:dictionary[kMainSponsorAppSponsor]];
    }
    
    if(![dictionary[kMainSponsorPerContentTypeSponsor] isKindOfClass:[NSNull class]]){
        self.perContentTypeSponsor = [[PerContentTypeSponsor alloc] initWithDictionary:dictionary[kMainSponsorPerContentTypeSponsor]];
    }
    
    if(![dictionary[kMainSponsorPredictSponsor] isKindOfClass:[NSNull class]]){
        self.predictSponsor = [[PredictSponsor alloc] initWithDictionary:dictionary[kMainSponsorPredictSponsor]];
    }
    
    if(![dictionary[kMainSponsorSpecialSponsor] isKindOfClass:[NSNull class]]){
        self.specialSponsor = [[CoSponsor alloc] initWithDictionary:dictionary[kMainSponsorSpecialSponsor]];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.appSponsor != nil){
        dictionary[kMainSponsorAppSponsor] = [self.appSponsor toDictionary];
    }
    if(self.perContentTypeSponsor != nil){
        dictionary[kMainSponsorPerContentTypeSponsor] = [self.perContentTypeSponsor toDictionary];
    }
    if(self.predictSponsor != nil){
        dictionary[kMainSponsorPredictSponsor] = [self.predictSponsor toDictionary];
    }
    if(self.specialSponsor != nil){
        dictionary[kMainSponsorSpecialSponsor] = [self.specialSponsor toDictionary];
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
    if(self.appSponsor != nil){
        [aCoder encodeObject:self.appSponsor forKey:kMainSponsorAppSponsor];
    }
    if(self.perContentTypeSponsor != nil){
        [aCoder encodeObject:self.perContentTypeSponsor forKey:kMainSponsorPerContentTypeSponsor];
    }
    if(self.predictSponsor != nil){
        [aCoder encodeObject:self.predictSponsor forKey:kMainSponsorPredictSponsor];
    }
    if(self.specialSponsor != nil){
        [aCoder encodeObject:self.specialSponsor forKey:kMainSponsorSpecialSponsor];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.appSponsor = [aDecoder decodeObjectForKey:kMainSponsorAppSponsor];
    self.perContentTypeSponsor = [aDecoder decodeObjectForKey:kMainSponsorPerContentTypeSponsor];
    self.predictSponsor = [aDecoder decodeObjectForKey:kMainSponsorPredictSponsor];
    self.specialSponsor = [aDecoder decodeObjectForKey:kMainSponsorSpecialSponsor];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    MainSponsor *copy = [MainSponsor new];
    
    copy.appSponsor = [self.appSponsor copy];
    copy.perContentTypeSponsor = [self.perContentTypeSponsor copy];
    copy.predictSponsor = [self.predictSponsor copy];
    copy.specialSponsor = [self.specialSponsor copy];
    
    return copy;
}
@end
