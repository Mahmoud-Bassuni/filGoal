//
//	Album.h
//
//	Create by Nada Gamal on 20/9/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Picture.h"
#import "RelatedData.h"
@interface Album : NSObject

@property (nonatomic, strong) NSString * picName;
@property (nonatomic, assign) NSInteger picsCount;
@property (nonatomic, assign) NSInteger views;
@property (nonatomic, strong) NSString * albumDate;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, assign) NSInteger sectionId;
@property (nonatomic, strong) NSString * albumSourcedate;
@property (nonatomic, strong) NSString * albumSubtitle;
@property (nonatomic, strong) NSString * albumDescription;
@property (nonatomic, strong) NSString * albumTitle;
@property (nonatomic, strong) NSString * byline;
@property (nonatomic, assign) NSInteger editorId;
@property (nonatomic, strong) NSArray * pictures;
@property (nonatomic, strong) NSArray * relatedAlbums;
@property (nonatomic, strong) NSArray * sectionIds;
@property (nonatomic, strong) RelatedData * relatedData;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
