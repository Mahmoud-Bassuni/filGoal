//
//  NewsItem.m
//
//  Created by MacBookPro  on 4/15/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "NewsItem.h"
#import "NewsSectionId.h"
#import "VideoItem.h"
#import "Images.h"
#import "NewsItem.h"
#import "Global.h"
#import "Album.h"
@interface NewsItem ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NewsItem

@synthesize newsDescription = _newsDescription;
@synthesize newsSectionId = _newsSectionId;
@synthesize newsTypeId = _newsTypeId;
@synthesize newsDate = _newsDate;
@synthesize editorId = _editorId;
@synthesize newsTitle = _newsTitle;
@synthesize newsLikes = _newsLikes;
@synthesize sourceDate = _sourceDate;
@synthesize editorPicture = _editorPicture;
@synthesize newsId = _newsId;
@synthesize relatedVideos = _relatedVideos;
@synthesize newsDislikes = _newsDislikes;
@synthesize status_id = _status_id;
@synthesize commentsNo = _commentsNo;
@synthesize images = _images;
@synthesize editorName = _editorName;
@synthesize quotes = _quotes;
@synthesize relatedNews = _relatedNews;
@synthesize newsWriter = _newsWriter;
NSString *const kNewsRootClassRelatedData = @"related_data";


+ (NewsItem *)modelObjectWithDictionary:(NSDictionary *)dict
{
    NewsItem *instance = [[NewsItem alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.smallImage = [self objectOrNilForKey:@"small_Image" fromDictionary:dict];
        self.newsDescription = [self objectOrNilForKey:@"news_description" fromDictionary:dict];
        self.status = [self objectOrNilForKey:@"status" fromDictionary:dict];
        self.status_id  =  [self objectOrNilForKey:@"status_id" fromDictionary:dict] ; // fromDictionary:dict]; [dict objectForKey:@"status_id"];
        
        
        NSObject *receivedNewsSectionId = [dict objectForKey:@"news_section_id"];
        NSMutableArray *parsedNewsSectionId = [NSMutableArray array];
        if ([receivedNewsSectionId isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedNewsSectionId) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedNewsSectionId addObject:[NewsSectionId modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedNewsSectionId isKindOfClass:[NSDictionary class]]) {
            [parsedNewsSectionId addObject:[NewsSectionId modelObjectWithDictionary:(NSDictionary *)receivedNewsSectionId]];
        }
        
        self.newsSectionId = [NSArray arrayWithArray:parsedNewsSectionId];
        if(![[dict objectForKey:@"news_type_id"] isKindOfClass:[NSNull class]])
            self.newsTypeId = [[dict objectForKey:@"news_type_id"] intValue];
        self.newsDate = [self objectOrNilForKey:@"news_date" fromDictionary:dict];
        int offset = [[[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]intValue];
        /* if ([Global getInstance].appInfo) {
         offset=[[Global getInstance].appInfo.timeoff intValue];
         }*/
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(([self.newsDate doubleValue]+(1000*60*60*offset)) / 1000)];
        NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
        [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [dtfrm setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ar"]];
        [dtfrm setDateFormat:@"EEEE dd MMMM yyyy hh:mm"];
       // [dtfrm setDateStyle:NSDateFormatterLongStyle];
        self.newsDate = [dtfrm stringFromDate:date];
        self.editorId = [[dict objectForKey:@"editor_id"] intValue];
        self.newsTitle = [self objectOrNilForKey:@"news_title" fromDictionary:dict];
        self.newsLikes = [[dict objectForKey:@"news_likes"] intValue];
        self.sourceDate = [self objectOrNilForKey:@"source_date" fromDictionary:dict];
        self.editorPicture = [self objectOrNilForKey:@"editor_picture" fromDictionary:dict];
        self.newsId = [[dict objectForKey:@"news_id"] intValue];
        self.isRedirect= [[dict objectForKey:@"IsRedirect"] boolValue];
        self.redirectionUrl= [dict objectForKey:@"RedirectUrl"];
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
        self.newsDislikes = [[dict objectForKey:@"news_dislikes"] intValue];
        self.commentsNo = [[dict objectForKey:@"comments_no"] intValue];
        NSArray *receivedImages = [dict objectForKey:@"images"];
        NSMutableArray *parsedImages = [NSMutableArray array];
        if ([receivedImages isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedImages) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedImages addObject:[Images modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedImages isKindOfClass:[NSDictionary class]]) {
            [parsedImages addObject:[Images modelObjectWithDictionary:(NSDictionary *)receivedImages]];
        }
        
        self.images = [NSArray arrayWithArray:parsedImages];
        self.editorName = [self objectOrNilForKey:@"editor_name" fromDictionary:dict];
        self.quotes = [self objectOrNilForKey:@"quotes" fromDictionary:dict];
        ///////
        //Related opinions
        NSObject *receivedRelatedOpinions = [dict objectForKey:@"authorRelatedOpinions"];
        NSMutableArray *parsedRelatedOpinions = [NSMutableArray array];
        if ([receivedRelatedOpinions isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRelatedOpinions) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRelatedOpinions addObject:[NewsItem modelObjectWithDictionary:item]];
                }
            }
        }
        self.authorRelatedOpinions = [NSArray arrayWithArray:parsedRelatedOpinions];

        
        ////////
        
        
        
        NSObject * authors = [dict objectForKey:@"authors"];
        NSMutableArray *parsedAuthors = [NSMutableArray array];
        if ([authors isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)authors) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedAuthors addObject:[[Author alloc]initWithDictionary:item]];
                }
            }
        }
        self.authors = [NSArray arrayWithArray:parsedAuthors];
        
        
        ////////
        
        
    ////////
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
        self.newsWriter = [self objectOrNilForKey:@"news_writer" fromDictionary:dict];
        /// Related Albums
        
        NSObject *receivedRelatedAlbums = [dict objectForKey:@"related_albums"];
        NSMutableArray *parsedRelatedAlbums = [NSMutableArray array];
        if ([receivedRelatedAlbums isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRelatedAlbums) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRelatedAlbums addObject:[[Album alloc]initWithDictionary:item]];
                }
            }
        } else if ([receivedRelatedAlbums isKindOfClass:[NSDictionary class]]) {
            [parsedRelatedAlbums addObject:[[Album alloc]initWithDictionary:(NSDictionary *)receivedRelatedAlbums]];
        }
        
        self.relatedAlbums = [NSArray arrayWithArray:parsedRelatedAlbums];
        
    }
    if(![dict[kNewsRootClassRelatedData] isKindOfClass:[NSNull class]]){
        self.relatedData = [[RelatedData alloc] initWithDictionary:dict[kNewsRootClassRelatedData]];
    }
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.smallImage forKey:@"small_Image"];
    [mutableDict setValue:self.newsDescription forKey:@"news_description"];
    [mutableDict setValue:self.status forKey:@"status"];
    [mutableDict setValue:[NSNumber numberWithInt:self.status_id] forKey:@"status_id"];
    NSMutableArray *tempArrayForNewsSectionId = [NSMutableArray array];
    for (NSObject *subArrayObject in self.newsSectionId) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNewsSectionId addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNewsSectionId addObject:subArrayObject];
        }
    }
    
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNewsSectionId] forKey:@"news_section_id"];
    [mutableDict setValue:[NSNumber numberWithInt:self.newsTypeId] forKey:@"news_type_id"];
    [mutableDict setValue:self.newsDate forKey:@"news_date"];
    [mutableDict setValue:[NSNumber numberWithInt:self.editorId] forKey:@"editor_id"];
    [mutableDict setValue:self.newsTitle forKey:@"news_title"];
    [mutableDict setValue:[NSNumber numberWithInt:self.newsLikes] forKey:@"news_likes"];
    [mutableDict setValue:self.sourceDate forKey:@"source_date"];
    [mutableDict setValue:self.editorPicture forKey:@"editor_picture"];
    [mutableDict setValue:[NSNumber numberWithInt:self.newsId] forKey:@"news_id"];
    [mutableDict setValue:[NSNumber numberWithBool:self.isRedirect] forKey:@"IsRedirect"];
    [mutableDict setValue:self.redirectionUrl forKey:@"RedirectUrl"];
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
    [mutableDict setValue:[NSNumber numberWithInt:self.newsDislikes] forKey:@"news_dislikes"];
    [mutableDict setValue:[NSNumber numberWithInt:self.commentsNo] forKey:@"comments_no"];
    NSMutableArray *tempArrayForImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.images) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:@"images"];
    [mutableDict setValue:self.editorName forKey:@"editor_name"];
    NSMutableArray *tempArrayForQuotes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.quotes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForQuotes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForQuotes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForQuotes] forKey:@"quotes"];
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
    [mutableDict setValue:self.newsWriter forKey:@"news_writer"];
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
    self.smallImage = [aDecoder decodeObjectForKey:@"smallImage"];
    self.status = [aDecoder decodeObjectForKey:@"type"];
    //self.status_id = [aDecoder decodeObjectForKey:@"status_id"];
    self.newsDescription = [aDecoder decodeObjectForKey:@"newsDescription"];
    self.newsSectionId = [aDecoder decodeObjectForKey:@"newsSectionId"];
    self.newsTypeId = [aDecoder decodeIntForKey:@"newsTypeId"];
    self.newsDate = [aDecoder decodeObjectForKey:@"newsDate"];
    self.editorId = [aDecoder decodeIntForKey:@"editorId"];
    self.newsTitle = [aDecoder decodeObjectForKey:@"newsTitle"];
    self.newsLikes = [aDecoder decodeIntForKey:@"newsLikes"];
    self.sourceDate = [aDecoder decodeObjectForKey:@"sourceDate"];
    self.editorPicture = [aDecoder decodeObjectForKey:@"editorPicture"];
    self.newsId = [aDecoder decodeIntForKey:@"newsId"];
    self.relatedVideos = [aDecoder decodeObjectForKey:@"relatedVideos"];
    self.newsDislikes = [aDecoder decodeIntForKey:@"newsDislikes"];
    self.commentsNo = [aDecoder decodeIntForKey:@"commentsNo"];
    self.images = [aDecoder decodeObjectForKey:@"images"];
    self.editorName = [aDecoder decodeObjectForKey:@"editorName"];
    self.quotes = [aDecoder decodeObjectForKey:@"quotes"];
    self.relatedNews = [aDecoder decodeObjectForKey:@"relatedNews"];
    self.authorRelatedOpinions = [aDecoder decodeObjectForKey:@"authorRelatedOpinions"];
    self.authors = [aDecoder decodeObjectForKey:@"authors"];
    self.newsWriter = [aDecoder decodeObjectForKey:@"newsWriter"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_smallImage forKey:@"smallImage"];
    [aCoder encodeObject:_status forKey:@"type"];
    //[aCoder encodeObject:_status_id forKey:@"status_id"];
    [aCoder encodeObject:_newsDescription forKey:@"newsDescription"];
    [aCoder encodeObject:_newsSectionId forKey:@"newsSectionId"];
    [aCoder encodeInt:_newsTypeId forKey:@"newsTypeId"];
    [aCoder encodeObject:_newsDate forKey:@"newsDate"];
    [aCoder encodeInt:_editorId forKey:@"editorId"];
    [aCoder encodeObject:_newsTitle forKey:@"newsTitle"];
    [aCoder encodeInt:_newsLikes forKey:@"newsLikes"];
    [aCoder encodeObject:_sourceDate forKey:@"sourceDate"];
    [aCoder encodeObject:_editorPicture forKey:@"editorPicture"];
    [aCoder encodeInt:_newsId forKey:@"newsId"];
    [aCoder encodeObject:_relatedVideos forKey:@"relatedVideos"];
    [aCoder encodeInt:_newsDislikes forKey:@"newsDislikes"];
    [aCoder encodeInt:_commentsNo forKey:@"commentsNo"];
    [aCoder encodeObject:_images forKey:@"images"];
    [aCoder encodeObject:_editorName forKey:@"editorName"];
    [aCoder encodeObject:_quotes forKey:@"quotes"];
    [aCoder encodeObject:_relatedNews forKey:@"relatedNews"];
    [aCoder encodeObject:_authorRelatedOpinions forKey:@"authorRelatedOpinions"];
    [aCoder encodeObject:_authors forKey:@"authors"];

    [aCoder encodeObject:_newsWriter forKey:@"newsWriter"];
}


@end
