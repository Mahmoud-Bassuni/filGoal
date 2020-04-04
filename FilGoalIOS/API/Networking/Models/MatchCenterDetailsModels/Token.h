//
//	Token.h
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Token : NSObject

@property (nonatomic, strong) NSString * accessToken;
@property (nonatomic, assign) NSInteger expiresIn;
@property (nonatomic, strong) NSString * refreshToken;
@property (nonatomic, strong) NSString * rights;
@property (nonatomic, strong) NSString * tokenType;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * views;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end