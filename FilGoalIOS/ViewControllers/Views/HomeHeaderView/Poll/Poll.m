//
//  Poll.m
//  FilGoalIOS
//
//  Created by Abdelrahman Elabd on 11/11/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

#import "Poll.h"
#import "NewsSectionId.h"
#import "VideoItem.h"
#import "Images.h"
#import "Global.h"
#import "Album.h"
@interface Poll ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end  

@implementation Poll

@synthesize pollsDescription = _newsDescription;
@synthesize pollsSectionId = _newsSectionId;
@synthesize pollsTypeId = _newsTypeId;
@synthesize pollsDate = _newsDate;
@synthesize editorId = _editorId;
@synthesize pollsTitle = _newsTitle;
@synthesize pollsLikes = _newsLikes;
@synthesize sourceDate = _sourceDate;
@synthesize editorPicture = _editorPicture;
@synthesize pollsId = _newsId;
@synthesize relatedVideos = _relatedVideos;
@synthesize pollsDislikes = _newsDislikes;
@synthesize commentsNo = _commentsNo;
@synthesize images = _images;
@synthesize editorName = _editorName;
@synthesize quotes = _quotes;
@synthesize relatedNews = _relatedNews;
@synthesize pollsWriter = _newsWriter;
NSString *const kNewsRootClassRelatedData = @"related_data";



- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.smallImage = [self objectOrNilForKey:@"ImageName" fromDictionary:dict];
        self.pollsDescription = [self objectOrNilForKey:@"Description" fromDictionary:dict];
        self.status = [self objectOrNilForKey:@"status" fromDictionary:dict];
        NSObject *receivedNewsSectionId = [dict objectForKey:@"Id"];
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
        
        self.pollsSectionId = [NSArray arrayWithArray:parsedNewsSectionId];
        if(![[dict objectForKey:@"news_type_id"] isKindOfClass:[NSNull class]])
            self.pollsTypeId = [[dict objectForKey:@"news_type_id"] intValue];
        self.pollsDate = [self objectOrNilForKey:@"news_date" fromDictionary:dict];
        int offset = [[[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]intValue];
        /* if ([Global getInstance].appInfo) {
         offset=[[Global getInstance].appInfo.timeoff intValue];
         }*/
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(([self.pollsDate doubleValue]+(1000*60*60*offset)) / 1000)];
        NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
        [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [dtfrm setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"ar"]];
        [dtfrm setDateFormat:@"EEEE dd MMMM yyyy hh:mm"];
       // [dtfrm setDateStyle:NSDateFormatterLongStyle];
        self.pollsDate = [dtfrm stringFromDate:date];
        self.editorId = [[dict objectForKey:@"editor_id"] intValue];
        self.pollsTitle = [self objectOrNilForKey:@"news_title" fromDictionary:dict];
        self.pollsLikes = [[dict objectForKey:@"news_likes"] intValue];
        self.sourceDate = [self objectOrNilForKey:@"source_date" fromDictionary:dict];
        self.editorPicture = [self objectOrNilForKey:@"editor_picture" fromDictionary:dict];
        self.pollsId = [[dict objectForKey:@"news_id"] intValue];
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
        self.pollsDislikes = [[dict objectForKey:@"news_dislikes"] intValue];
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
        self.pollsWriter = [self objectOrNilForKey:@"news_writer" fromDictionary:dict];
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



#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}







@end
