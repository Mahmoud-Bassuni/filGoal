//
//	StoriesHome.h
//
//	Create by Nada Gamal on 30/7/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Album.h"
#import "NewsItem.h"
#import "VideoItem.h"

@interface StoriesHome : NSObject

@property (nonatomic, strong) NSArray * albums;
@property (nonatomic, strong) NSArray * news;
@property (nonatomic, strong) NSArray * videos;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
