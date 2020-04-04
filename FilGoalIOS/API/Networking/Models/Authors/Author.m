

//
//    Author.m
//
//    Create by Nada Gamal on 5/12/2017
//    Copyright © 2017. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Author.h"

NSString *const kAuthorIdField = @"Id";
NSString *const kAuthorImage = @"Image";
NSString *const kAuthorIsMoreItemsExists = @"IsMoreItemsExists";
NSString *const kAuthorMostViewedOpinions = @"MostViewedOpinions";
NSString *const kAuthorName = @"Name";
NSString *const kAuthorNumberOfOpinions = @"NumberOfOpinions";
NSString *const kAuthorNumberOfViews = @"NumberOfViews";
NSString *const kAuthorOpinions = @"Opinions";
NSString *const kFeaturedLatestOpinionTitle = @"LatestOpinionTitle";
NSString *const kFeaturedLatestOpinionID = @"LatestOpinionId";

@interface Author ()
@end
@implementation Author




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kAuthorIdField] isKindOfClass:[NSNull class]]){
        self.idField = [dictionary[kAuthorIdField] integerValue];
    }
    if(![dictionary[kFeaturedLatestOpinionID] isKindOfClass:[NSNull class]]){
        self.latestOpinionID = [dictionary[kFeaturedLatestOpinionID] integerValue];
    }
    
    if(![dictionary[kAuthorImage] isKindOfClass:[NSNull class]]){
        self.image = dictionary[kAuthorImage];
    }
    if(![dictionary[kAuthorIsMoreItemsExists] isKindOfClass:[NSNull class]]){
        self.isMoreItemsExists = [dictionary[kAuthorIsMoreItemsExists] boolValue];
    }
    if(![dictionary[kFeaturedLatestOpinionTitle] isKindOfClass:[NSNull class]]){
        self.latestOpinionTitle = dictionary[kFeaturedLatestOpinionTitle];
    }
    if(dictionary[kAuthorMostViewedOpinions] != nil && [dictionary[kAuthorMostViewedOpinions] isKindOfClass:[NSArray class]]){
        NSArray * mostViewedOpinionsDictionaries = dictionary[kAuthorMostViewedOpinions];
        NSMutableArray * mostViewedOpinionsItems = [NSMutableArray array];
        for(NSDictionary * mostViewedOpinionsDictionary in mostViewedOpinionsDictionaries){
            NewsItem * mostViewedOpinionsItem = [[NewsItem alloc] initWithDictionary:mostViewedOpinionsDictionary];
            [mostViewedOpinionsItems addObject:mostViewedOpinionsItem];
        }
        self.mostViewedOpinions = mostViewedOpinionsItems;
    }
    if(![dictionary[kAuthorName] isKindOfClass:[NSNull class]]){
        self.name = dictionary[kAuthorName];
    }
    if(![dictionary[kAuthorNumberOfOpinions] isKindOfClass:[NSNull class]]){
        self.numberOfOpinions = [dictionary[kAuthorNumberOfOpinions] integerValue];
    }
    
    if(![dictionary[kAuthorNumberOfViews] isKindOfClass:[NSNull class]]){
        self.numberOfViews = [dictionary[kAuthorNumberOfViews] integerValue];
    }
    
    if(dictionary[kAuthorOpinions] != nil && [dictionary[kAuthorOpinions] isKindOfClass:[NSArray class]]){
        NSArray * opinionsDictionaries = dictionary[kAuthorOpinions];
        NSMutableArray * opinionsItems = [NSMutableArray array];
        for(NSDictionary * opinionsDictionary in opinionsDictionaries){
            NewsItem * opinionsItem = [[NewsItem alloc] initWithDictionary:opinionsDictionary];
            [opinionsItems addObject:opinionsItem];
        }
        self.opinions = opinionsItems;
    }
    return self;
}
@end


