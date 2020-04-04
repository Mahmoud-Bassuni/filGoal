//
//	PostSquareClass.h
//
//	Create by Nada Gamal on 10/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Rec.h"
#import "Widget.h"

@interface PostSquareClass : NSObject

@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, strong) NSObject * guid;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, strong) NSArray * recs;
@property (nonatomic, strong) NSString * requestGeoCountry;
@property (nonatomic, strong) NSString * requestGeoRegion;
@property (nonatomic, strong) NSString * requestId;
@property (nonatomic, assign) NSInteger responseTime;
@property (nonatomic, assign) NSInteger rndid;
@property (nonatomic, assign) NSInteger srcAdminNetworkId;
@property (nonatomic, assign) NSInteger srcCategoryId;
@property (nonatomic, assign) NSInteger srcPostId;
@property (nonatomic, strong) NSString * srcSubId;
@property (nonatomic, assign) NSInteger srcWebsiteId;
@property (nonatomic, assign) NSInteger srcWidgetId;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, assign) NSInteger userLocalTimestamp;
@property (nonatomic, strong) NSString * viewPxl;
@property (nonatomic, strong) Widget * widget;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end