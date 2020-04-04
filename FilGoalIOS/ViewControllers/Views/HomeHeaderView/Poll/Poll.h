//
//  Poll.h
//  FilGoalIOS
//
//  Created by Abdelrahman Elabd on 11/11/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Poll : NSObject  <NSCoding>
@property (nonatomic, retain) NSString *pollsDescription;
@property (nonatomic, retain) NSArray *pollsSectionId;
@property (nonatomic, assign) int pollsTypeId;
@property (nonatomic, retain) NSString *pollsDate;
@property (nonatomic, assign) int editorId;
@property (nonatomic, retain) NSString *pollsTitle;
@property (nonatomic, assign) int pollsLikes;
@property (nonatomic, retain) NSString *sourceDate;
@property (nonatomic, retain) NSString *editorPicture;
@property (nonatomic, assign) int pollsId;
@property (nonatomic, retain) NSArray *relatedVideos;
@property (nonatomic, retain) NSArray *relatedAlbums;
@property (nonatomic, strong) RelatedData * relatedData;

@property (nonatomic, retain) NSArray *relatedNews;
@property (nonatomic, retain) NSArray * authorRelatedOpinions;
@property (nonatomic, retain) NSArray * authors;

@property (nonatomic, assign) int pollsDislikes;
@property (nonatomic, assign) int commentsNo;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain) NSString *editorName;
@property (nonatomic, retain) NSArray *quotes;

@property (nonatomic, retain) NSString *pollsWriter;
@property (nonatomic, retain) NSString *smallImage;
@property (nonatomic, retain) NSString * status;

//DataBase ONly Filed
@property (nonatomic, assign) BOOL isRedirect;
@property (nonatomic, strong) NSString *redirectionUrl;


@property (nonatomic, assign) int partId;
@property (nonatomic, assign) int pollsIsFavorite;
@property (nonatomic, retain) NSString *pollsLargeImageUrl;
@property (nonatomic, retain) NSString *pollsSmallImageUrl;
@property (nonatomic, retain) NSString *pollsCaption;
@property (nonatomic, retain) NSString *quotesDB;

+ (Poll *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END
