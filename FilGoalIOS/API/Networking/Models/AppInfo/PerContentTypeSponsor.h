//
//	PerContentTypeSponsor.h
//
//	Create by Nada Gamal on 27/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface PerContentTypeSponsor : NSObject

@property (nonatomic, assign) BOOL isAlbumsActive;
@property (nonatomic, assign) BOOL isFreeOpinionsActive;
@property (nonatomic, assign) BOOL isMatchesActive;
@property (nonatomic, assign) BOOL isNewsActive;
@property (nonatomic, assign) BOOL isVideosActive;

@property (nonatomic, strong) NSString *albumsUrl;
@property (nonatomic, strong) NSString *freeOpinionsUrl;
@property (nonatomic, strong) NSString *matchesUrl;
@property (nonatomic, strong) NSString *newsUrl;
@property (nonatomic, strong) NSString *videosUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
