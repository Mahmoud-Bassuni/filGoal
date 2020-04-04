//
//	Rec.h
//
//	Create by Nada Gamal on 10/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Rec : NSObject

@property (nonatomic, assign) BOOL ajx;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSString * clickUrl;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) NSString * displayName;
@property (nonatomic, strong) NSString * geoTags;
@property (nonatomic, strong) NSObject * impressionUrls;
@property (nonatomic, strong) NSObject * metatagLabels;
@property (nonatomic, strong) NSObject * metatags;
@property (nonatomic, assign) NSInteger partnerId;
@property (nonatomic, assign) NSInteger postId;
@property (nonatomic, assign) NSInteger postType;
@property (nonatomic, strong) NSString * recType;
@property (nonatomic, assign) NSInteger recTypeDB;
@property (nonatomic, strong) NSObject * targetClickUrl;
@property (nonatomic, strong) NSString * thumbnailPath;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * url;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
