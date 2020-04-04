//
//	StoriesHome.m
//
//	Create by Nada Gamal on 30/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "StoriesHome.h"

NSString *const kStoriesHomeAlbums = @"albums";
NSString *const kStoriesHomeNews = @"news";
NSString *const kStoriesHomeVideos = @"videos";

@interface StoriesHome ()
@end
@implementation StoriesHome




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kStoriesHomeAlbums] != nil && [dictionary[kStoriesHomeAlbums] isKindOfClass:[NSArray class]]){
		NSArray * albumsDictionaries = dictionary[kStoriesHomeAlbums];
		NSMutableArray * albumsItems = [NSMutableArray array];
		for(NSDictionary * albumsDictionary in albumsDictionaries){
			Album * albumsItem = [[Album alloc] initWithDictionary:albumsDictionary];
			[albumsItems addObject:albumsItem];
		}
		self.albums = albumsItems;
	}
	if(dictionary[kStoriesHomeNews] != nil && [dictionary[kStoriesHomeNews] isKindOfClass:[NSArray class]]){
		NSArray * newsDictionaries = dictionary[kStoriesHomeNews];
		NSMutableArray * newsItems = [NSMutableArray array];
		for(NSDictionary * newsDictionary in newsDictionaries){
			NewsItem * newsItem = [[NewsItem alloc] initWithDictionary:newsDictionary];
			[newsItems addObject:newsItem];
		}
		self.news = newsItems;
	}
	if(dictionary[kStoriesHomeVideos] != nil && [dictionary[kStoriesHomeVideos] isKindOfClass:[NSArray class]]){
		NSArray * videosDictionaries = dictionary[kStoriesHomeVideos];
		NSMutableArray * videosItems = [NSMutableArray array];
		for(NSDictionary * videosDictionary in videosDictionaries){
			VideoItem * videosItem = [[VideoItem alloc] initWithDictionary:videosDictionary];
			[videosItems addObject:videosItem];
		}
		self.videos = videosItems;
	}
	return self;
}
@end
