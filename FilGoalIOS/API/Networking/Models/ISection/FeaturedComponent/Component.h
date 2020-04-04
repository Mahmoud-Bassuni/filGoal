//
//	Component.h
//
//	Create by Mohamed Mansour on 4/5/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Component : NSObject

@property (nonatomic, strong) NSString * brief;
@property (nonatomic, strong) NSString * componentTitle;
@property (nonatomic, strong) NSString * fullDescription;
@property (nonatomic, strong) NSString * largeImageURL;
@property (nonatomic, strong) NSString * smallImageURL;
@property (nonatomic, strong) NSString * style;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * videoURL;
@property (nonatomic, strong) NSString * componentIconURL;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end