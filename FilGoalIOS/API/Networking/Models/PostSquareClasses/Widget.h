//
//	Widget.h
//
//	Create by Nada Gamal on 10/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Widget : NSObject

@property (nonatomic, strong) NSObject * additionalData;
@property (nonatomic, strong) NSString * anad;
@property (nonatomic, strong) NSObject * backgroundColor;
@property (nonatomic, assign) NSInteger backgroundColorType;
@property (nonatomic, assign) NSInteger brandingId;
@property (nonatomic, assign) NSInteger displayRows;
@property (nonatomic, strong) NSArray * displayTags;
@property (nonatomic, strong) NSObject * esaData;
@property (nonatomic, strong) NSString * fontColor;
@property (nonatomic, strong) NSObject * fontFamily;
@property (nonatomic, strong) NSString * headerText;
@property (nonatomic, strong) NSObject * headerText2;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger isDisplayed;
@property (nonatomic, assign) BOOL isRealImpressions;
@property (nonatomic, assign) NSInteger layoutTypeId;
@property (nonatomic, assign) NSInteger platform;
@property (nonatomic, assign) NSInteger publisherId;
@property (nonatomic, assign) NSInteger slideAnimationColorReminder;
@property (nonatomic, assign) NSInteger textDirection;
@property (nonatomic, strong) NSObject * thumbnailSizeId;
@property (nonatomic, assign) NSInteger titleFontSize;
@property (nonatomic, assign) NSInteger websiteId;
@property (nonatomic, assign) NSInteger websiteLanguageId;
@property (nonatomic, strong) NSObject * widgetXPath;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end