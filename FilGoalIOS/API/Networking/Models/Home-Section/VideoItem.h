//
//  VideoItem.h
//
//  Created by MacBookPro  on 6/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RelatedData.h"


@interface VideoItem : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *videoSectionId;
@property (nonatomic, retain) NSString *videoUrl;
@property (nonatomic, retain) NSString *videoDate;
@property (nonatomic, retain) NSString *videoTitle;
@property (nonatomic, retain) NSString *videoPreviewImage;
@property (nonatomic, assign) int videoId;
@property (nonatomic, retain) NSString *sourceDate;
@property (nonatomic, assign) int videoNumofviews;
@property (nonatomic, retain) NSString *videoDetails;
@property (nonatomic, retain) NSArray *relatedVideos;
@property (nonatomic, retain) NSArray *relatedNews;
@property (nonatomic, strong) NSString * brightCoveVideoID;
@property (nonatomic, strong) NSString * nativeVideoURL;
@property (nonatomic, assign) bool isYouTube;
@property (nonatomic, strong) NSString *embed;
@property (nonatomic, strong) RelatedData * relatedData;

+ (VideoItem *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
