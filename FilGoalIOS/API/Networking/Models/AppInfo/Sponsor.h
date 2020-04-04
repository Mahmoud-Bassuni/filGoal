//
//	Sponsor.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Sponsor : NSObject

@property (nonatomic, strong) NSArray * champSponsor;
@property (nonatomic, strong) NSString * imgsBaseUrl;
@property (nonatomic, assign) NSInteger isActive;
@property (nonatomic, strong) NSArray * sectionSponsor;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end