//
//    Picture.h
//
//    Create by Nada Gamal on 19/2/2018
//    Copyright © 2018. All rights reserved.
//

//    Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Url.h"

@interface Picture : NSObject

@property (nonatomic, strong) NSString * addedDate;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, strong) NSString * picCaption;
@property (nonatomic, strong) NSString * picDesc;
@property (nonatomic, assign) NSInteger picId;
@property (nonatomic, strong) NSString * picName;
@property (nonatomic, assign) NSInteger picOrder;
@property (nonatomic, strong) Url * urls;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
