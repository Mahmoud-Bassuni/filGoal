//
//	AuthorsList.m
//
//	Create by Nada Gamal on 3/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AuthorsList.h"

NSString *const kAuthorsListFeatured = @"Featured";
NSString *const kAuthorsListFilteredOpinions = @"FilteredOpinions";
NSString *const kAuthorsListIsMoreItemsExists = @"IsMoreItemsExists";
NSString *const kAuthorsListMostViewedOpinions = @"MostViewedOpinions";

@interface AuthorsList ()
@end
@implementation AuthorsList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kAuthorsListFeatured] != nil && [dictionary[kAuthorsListFeatured] isKindOfClass:[NSArray class]]){
		NSArray * featuredDictionaries = dictionary[kAuthorsListFeatured];
		NSMutableArray * featuredItems = [NSMutableArray array];
		for(NSDictionary * featuredDictionary in featuredDictionaries){
			Author * featuredItem = [[Author alloc] initWithDictionary:featuredDictionary];
			[featuredItems addObject:featuredItem];
		}
		self.featured = featuredItems;
	}
	if(dictionary[kAuthorsListFilteredOpinions] != nil && [dictionary[kAuthorsListFilteredOpinions] isKindOfClass:[NSArray class]]){
		NSArray * filteredOpinionsDictionaries = dictionary[kAuthorsListFilteredOpinions];
		NSMutableArray * filteredOpinionsItems = [NSMutableArray array];
		for(NSDictionary * filteredOpinionsDictionary in filteredOpinionsDictionaries){
			NewsItem * filteredOpinionsItem = [[NewsItem alloc] initWithDictionary:filteredOpinionsDictionary];
			[filteredOpinionsItems addObject:filteredOpinionsItem];
		}
		self.filteredOpinions = filteredOpinionsItems;
	}
	if(![dictionary[kAuthorsListIsMoreItemsExists] isKindOfClass:[NSNull class]]){
		self.isMoreItemsExists = [dictionary[kAuthorsListIsMoreItemsExists] boolValue];
	}

	if(dictionary[kAuthorsListMostViewedOpinions] != nil && [dictionary[kAuthorsListMostViewedOpinions] isKindOfClass:[NSArray class]]){
		NSArray * mostViewedOpinionsDictionaries = dictionary[kAuthorsListMostViewedOpinions];
		NSMutableArray * mostViewedOpinionsItems = [NSMutableArray array];
		for(NSDictionary * mostViewedOpinionsDictionary in mostViewedOpinionsDictionaries){
			NewsItem * mostViewedOpinionsItem = [[NewsItem alloc] initWithDictionary:mostViewedOpinionsDictionary];
			[mostViewedOpinionsItems addObject:mostViewedOpinionsItem];
		}
		self.mostViewedOpinions = mostViewedOpinionsItems;
	}
	return self;
}
@end
