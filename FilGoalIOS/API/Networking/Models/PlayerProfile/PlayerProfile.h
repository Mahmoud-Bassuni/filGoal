//
//	PlayerProfile.h
//
//	Create by Nada Gamal on 16/8/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Album.h"
#import "NewsItem.h"
#import "VideoItem.h"

@interface PlayerProfile : NSObject

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSArray * albums;
@property (nonatomic, strong) NSString * birthDate;
@property (nonatomic, assign) NSInteger goals;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSArray * news;
@property (nonatomic, strong) NSString * playerPic;
@property (nonatomic, assign) NSInteger rCards;
@property (nonatomic, assign) NSInteger tShirtNo;
@property (nonatomic, strong) NSArray * videos;
@property (nonatomic, assign) NSInteger yCards;
@property (nonatomic, strong) NSString * club;
@property (nonatomic, strong) NSString * country;
@property (nonatomic, assign) NSInteger countryId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * position;
@property (nonatomic, strong) NSString * profile;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
