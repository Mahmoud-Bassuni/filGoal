//
//	LandingScreen.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface LandingScreen : NSObject

@property (nonatomic, strong) NSString * backgroundImg;
@property (nonatomic, strong) NSString * buttonSectionImg;
@property (nonatomic, strong) NSString * buttonSectionName;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, strong) NSString * pageUrl;
@property (nonatomic, assign) NSInteger type;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end