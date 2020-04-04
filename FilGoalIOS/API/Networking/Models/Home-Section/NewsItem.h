//
//  NewsItem.h
//
//  Created by MacBookPro  on 4/15/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Author.h"
#import "RelatedData.h"
@interface NewsItem : NSObject <NSCoding>

@property (nonatomic, retain) NSString *newsDescription;
@property (nonatomic, retain) NSArray *newsSectionId;
@property (nonatomic, assign) int newsTypeId;
@property (nonatomic, retain) NSString *newsDate;
@property (nonatomic, assign) int editorId;
@property (nonatomic, retain) NSString *newsTitle;
@property (nonatomic, assign) int newsLikes;
@property (nonatomic, retain) NSString *sourceDate;
@property (nonatomic, retain) NSString *editorPicture;
@property (nonatomic, assign) int newsId;
@property (nonatomic, retain) NSArray *relatedVideos;
@property (nonatomic, retain) NSArray *relatedAlbums;
@property (nonatomic, strong) RelatedData * relatedData;

@property (nonatomic, retain) NSArray *relatedNews;
@property (nonatomic, retain) NSArray * authorRelatedOpinions;
@property (nonatomic, retain) NSArray * authors;

@property (nonatomic, assign) int newsDislikes;
@property (nonatomic, assign) int commentsNo;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain) NSString *editorName;
@property (nonatomic, retain) NSArray *quotes;

@property (nonatomic, retain) NSString *newsWriter;
@property (nonatomic, retain) NSString *smallImage;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString *status_id;

//DataBase ONly Filed
@property (nonatomic, assign) BOOL isRedirect;
@property (nonatomic, strong) NSString *redirectionUrl;


@property (nonatomic, assign) int partId;
@property (nonatomic, assign) int newsIsFavorite;
@property (nonatomic, retain) NSString *newsLargeImageUrl;
@property (nonatomic, retain) NSString *newsSmallImageUrl;
@property (nonatomic, retain) NSString *newsCaption;
@property (nonatomic, retain) NSString *quotesDB;

+ (NewsItem *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
