//
//	SpecialSection.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Banner.h"

@interface SpecialSection : NSObject

@property (nonatomic, strong) NSString * bannerArtWorkImg;
@property (nonatomic, strong) NSArray * banners;
@property (nonatomic, assign) NSInteger champID;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, assign) BOOL isHomeSectionBannersActive;
@property (nonatomic, assign) BOOL isMainHomeBannersActive;
@property (nonatomic, assign) BOOL isNewsDetailsBannersActive;
@property (nonatomic, assign) BOOL isTabActive;
@property (nonatomic, assign) NSInteger sectionID;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end