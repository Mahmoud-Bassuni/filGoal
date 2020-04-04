//
//	AdsEnabledPerVersion.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface AdsEnabledPerVersion : NSObject

@property (nonatomic, assign) NSInteger isAdsEnabled;
@property (nonatomic, assign) NSInteger isPagerAdsEnabled;
@property (nonatomic, assign) NSInteger isSponsorEnabled;
@property (nonatomic, strong) NSString * versionCode;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end