//
//	Albums.m
//
//	Create by Nada Gamal on 20/9/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Albums.h"

NSString *const kAlbumsAlbums = @"albums";
NSString *const kAlbumsTotalCount = @"totalCount";
NSString *const kAlbumsInfo = @"info";

@interface Albums ()
@end
@implementation Albums




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */
-(instancetype)initWithArrayList:(NSArray*)responseObject
{
    NSMutableArray * albumsItems = [NSMutableArray array];
    for(NSDictionary * albumsDictionary in responseObject){
        Album * albumsItem = [[Album alloc] initWithDictionary:albumsDictionary];
        [albumsItems addObject:albumsItem];
    }
    self.albums = albumsItems;
    return self;
}
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kAlbumsAlbums] != nil && [dictionary[kAlbumsAlbums] isKindOfClass:[NSArray class]]){
		NSArray * albumsDictionaries = dictionary[kAlbumsAlbums];
		NSMutableArray * albumsItems = [NSMutableArray array];
		for(NSDictionary * albumsDictionary in albumsDictionaries){
			Album * albumsItem = [[Album alloc] initWithDictionary:albumsDictionary];
			[albumsItems addObject:albumsItem];
		}
		self.albums = albumsItems;
	}
    if(![dictionary[kAlbumsInfo] isKindOfClass:[NSNull class]]){
        self.info = [[Album alloc] initWithDictionary:dictionary[kAlbumsInfo]];
    }
	if(![dictionary[kAlbumsTotalCount] isKindOfClass:[NSNull class]]){
		self.totalCount = [dictionary[kAlbumsTotalCount] integerValue];
	}

	return self;
}

@end
