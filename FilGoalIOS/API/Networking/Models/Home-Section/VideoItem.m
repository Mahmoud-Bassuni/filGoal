//
//  VideoItem.m
//
//  Created by MacBookPro  on 6/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "VideoItem.h"
#import "VideoSectionId.h"
#import "NewsItem.h"
#import "Global.h"

@interface VideoItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoItem

@synthesize videoSectionId = _videoSectionId;
@synthesize videoUrl = _videoUrl;
@synthesize videoDate = _videoDate;
@synthesize videoTitle = _videoTitle;
@synthesize videoPreviewImage = _videoPreviewImage;
@synthesize videoId = _videoId;
@synthesize sourceDate = _sourceDate;
@synthesize videoNumofviews = _videoNumofviews;
@synthesize videoDetails = _videoDetails;
@synthesize brightCoveVideoID=_brightCoveVideoID;
@synthesize embed=_embed;

NSString *const kRootClassRelatedData = @"related_data";


+ (VideoItem *)modelObjectWithDictionary:(NSDictionary *)dict
{
    VideoItem *instance = [[VideoItem alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
 //   NSLog(@"%@",[dict description]);

    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedVideoSectionId = [dict objectForKey:@"video_section_id"];
    NSMutableArray *parsedVideoSectionId = [NSMutableArray array];
    if ([receivedVideoSectionId isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedVideoSectionId) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedVideoSectionId addObject:[VideoSectionId modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedVideoSectionId isKindOfClass:[NSDictionary class]]) {
       [parsedVideoSectionId addObject:[VideoSectionId modelObjectWithDictionary:(NSDictionary *)receivedVideoSectionId]];
    }
        NSObject *receivedRelatedVideos = [dict objectForKey:@"related_videos"];
        NSMutableArray *parsedRelatedVideos = [NSMutableArray array];
        if ([receivedRelatedVideos isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRelatedVideos) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRelatedVideos addObject:[VideoItem modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedRelatedVideos isKindOfClass:[NSDictionary class]]) {
            [parsedRelatedVideos addObject:[VideoItem modelObjectWithDictionary:(NSDictionary *)receivedRelatedVideos]];
        }
        
        self.relatedVideos = [NSArray arrayWithArray:parsedRelatedVideos];
        
        NSObject *receivedRelatedNews = [dict objectForKey:@"related_news"];
        NSMutableArray *parsedRelatedNews = [NSMutableArray array];
        if ([receivedRelatedNews isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRelatedNews) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRelatedNews addObject:[NewsItem modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedRelatedNews isKindOfClass:[NSDictionary class]]) {
            [parsedRelatedNews addObject:[NewsItem modelObjectWithDictionary:(NSDictionary *)receivedRelatedNews]];
        }
        
        self.relatedNews = [NSArray arrayWithArray:parsedRelatedNews];
        
       self.videoSectionId = [NSArray arrayWithArray:parsedVideoSectionId];
            self.videoUrl = [self objectOrNilForKey:@"video_url" fromDictionary:dict];
            self.videoDate = [self objectOrNilForKey:@"video_date" fromDictionary:dict];
        self.brightCoveVideoID = [self objectOrNilForKey:@"brightCoveVideoId" fromDictionary:dict];

       /* int offset=2;
        if ([Global getInstance].appInfo) {
            offset=[[Global getInstance].appInfo.timeoff intValue];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(([self.videoDate doubleValue]+(1000*60*60*offset)) / 1000)];*/
        int offset = [[[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]intValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(([self.videoDate doubleValue]+(1000*60*60*offset)) / 1000)];
        
        NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
        [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [dtfrm setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ar"]];
        [dtfrm setDateFormat:@"EEEE dd MMMM yyyy hh:mm"];
        self.videoDate = [dtfrm stringFromDate:date];
            self.isYouTube = [[dict objectForKey:@"isYouTube"] boolValue];
            self.videoTitle = [self objectOrNilForKey:@"video_title" fromDictionary:dict];
            self.embed = [self objectOrNilForKey:@"embed" fromDictionary:dict];
            self.videoPreviewImage = [self objectOrNilForKey:@"video_preview_image" fromDictionary:dict];
            self.videoId = [[dict objectForKey:@"video_id"] intValue];
            self.sourceDate = [self objectOrNilForKey:@"source_date" fromDictionary:dict];
            self.videoNumofviews = [[dict objectForKey:@"video_numofviews"] intValue];
            self.videoDetails = [self objectOrNilForKey:@"video_details" fromDictionary:dict];
           self.nativeVideoURL = [self objectOrNilForKey:@"nativeVideoUrl" fromDictionary:dict];

    }
    if(![dict[kRootClassRelatedData] isKindOfClass:[NSNull class]]){
        self.relatedData = [[RelatedData alloc] initWithDictionary:dict[kRootClassRelatedData]];
    }
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForVideoSectionId = [NSMutableArray array];
    for (NSObject *subArrayObject in self.videoSectionId) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVideoSectionId addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVideoSectionId addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVideoSectionId] forKey:@"video_section_id"];
    [mutableDict setValue:[NSNumber numberWithBool:self.isYouTube] forKey:@"isYouTube"];

    [mutableDict setValue:self.videoUrl forKey:@"video_url"];
     [mutableDict setValue:self.brightCoveVideoID forKey:@"brightCoveVideoId"];
    [mutableDict setValue:self.videoDate forKey:@"video_date"];
    [mutableDict setValue:self.videoTitle forKey:@"video_title"];
    [mutableDict setValue:self.embed forKey:@"embed"];
    [mutableDict setValue:self.videoPreviewImage forKey:@"video_preview_image"];
    [mutableDict setValue:[NSNumber numberWithInt:self.videoId] forKey:@"video_id"];
    [mutableDict setValue:self.sourceDate forKey:@"source_date"];
    [mutableDict setValue:[NSNumber numberWithInt:self.videoNumofviews] forKey:@"video_numofviews"];
    [mutableDict setValue:self.videoDetails forKey:@"video_details"];
    NSMutableArray *tempArrayForRelatedVideos = [NSMutableArray array];
    for (NSObject *subArrayObject in self.relatedVideos) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRelatedVideos addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRelatedVideos addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRelatedVideos] forKey:@"related_videos"];
    
    NSMutableArray *tempArrayForRelatedNews = [NSMutableArray array];
    for (NSObject *subArrayObject in self.relatedNews) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRelatedNews addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRelatedNews addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRelatedNews] forKey:@"related_news"];
  //  self.brightCoveVideoID=4631051515001;
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
    self.brightCoveVideoID = [aDecoder decodeObjectForKey:@"brightCoveVideoId"];
    self.relatedVideos = [aDecoder decodeObjectForKey:@"relatedVideos"];
    self.relatedNews = [aDecoder decodeObjectForKey:@"relatedNews"];
    self.videoSectionId = [aDecoder decodeObjectForKey:@"videoSectionId"];
    self.videoUrl = [aDecoder decodeObjectForKey:@"videoUrl"];
    self.isYouTube = [aDecoder decodeBoolForKey:@"isYouTube"];

    self.videoDate = [aDecoder decodeObjectForKey:@"videoDate"];
    self.videoTitle = [aDecoder decodeObjectForKey:@"videoTitle"];
    self.embed = [aDecoder decodeObjectForKey:@"embed"];
    self.videoPreviewImage = [aDecoder decodeObjectForKey:@"videoPreviewImage"];
    self.videoId = [aDecoder decodeIntForKey:@"videoId"];
    self.sourceDate = [aDecoder decodeObjectForKey:@"sourceDate"];
    self.videoNumofviews = [aDecoder decodeIntForKey:@"videoNumofviews"];
    self.videoDetails = [aDecoder decodeObjectForKey:@"videoDetails"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_brightCoveVideoID forKey:@"brightCoveVideoId"];
    [aCoder encodeObject:_relatedVideos forKey:@"relatedVideos"];
    [aCoder encodeObject:_relatedNews forKey:@"relatedNews"];
    [aCoder encodeObject:_videoSectionId forKey:@"videoSectionId"];
    [aCoder encodeObject:_videoUrl forKey:@"videoUrl"];
    [aCoder encodeObject:_videoDate forKey:@"videoDate"];
    [aCoder encodeObject:_videoTitle forKey:@"videoTitle"];
    [aCoder encodeObject:_embed forKey:@"embed"];
    [aCoder encodeObject:_videoPreviewImage forKey:@"videoPreviewImage"];
    [aCoder encodeInt:_videoId forKey:@"videoId"];
    [aCoder encodeObject:_sourceDate forKey:@"sourceDate"];
    [aCoder encodeInt:_videoNumofviews forKey:@"videoNumofviews"];
    [aCoder encodeObject:_videoDetails forKey:@"videoDetails"];
    [aCoder encodeBool:_isYouTube forKey:@"isYouTube"];
}


@end
