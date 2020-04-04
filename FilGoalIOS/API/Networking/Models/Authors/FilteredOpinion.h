//
//	FilteredOpinion.h
//
//	Create by Nada Gamal on 3/12/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Image.h"
#import "NewsSectionId.h"

@interface FilteredOpinion : NSObject

@property (nonatomic, assign) NSInteger commentsNo;
@property (nonatomic, assign) NSInteger editorId;
@property (nonatomic, strong) NSString * editorName;
@property (nonatomic, strong) NSString * editorPicture;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSString * newsDate;
@property (nonatomic, strong) NSString * newsDescription;
@property (nonatomic, assign) NSInteger newsDislikes;
@property (nonatomic, assign) NSInteger newsId;
@property (nonatomic, assign) NSInteger newsLikes;
@property (nonatomic, strong) NSArray * newsSectionId;
@property (nonatomic, strong) NSString * newsTitle;
@property (nonatomic, assign) NSInteger newsTypeId;
@property (nonatomic, strong) NSString * newsWriter;
@property (nonatomic, strong) NSArray * quotes;
@property (nonatomic, strong) NSString * sourceDate;
@property (nonatomic, strong) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end