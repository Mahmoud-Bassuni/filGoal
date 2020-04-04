//
//	FeaturedSection.h
//
//	Create by Mohamed Mansour on 2/7/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface FeaturedSection : NSObject

@property (nonatomic, strong) NSString * metaDataJsonUrl;
@property (nonatomic, assign) NSInteger sectionMenuIndex;
@property (nonatomic, assign) BOOL isSpecialSection;
@property (nonatomic, assign) NSInteger sectionId;
@property (nonatomic, strong) NSString * sectionName;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * sectionBannarImgBaseUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end