//
//	AppSponsor.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface AppSponsor : NSObject

@property (nonatomic, assign) BOOL isAppBarActive;
@property (nonatomic, assign) BOOL isSplashActive;
@property (nonatomic) NSString *appBarUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
