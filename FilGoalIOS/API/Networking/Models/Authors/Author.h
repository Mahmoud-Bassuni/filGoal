//
//	Featured.h
//
//	Create by Nada Gamal on 3/12/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Author : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) BOOL isMoreItemsExists;
@property (nonatomic, strong) NSArray * mostViewedOpinions;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger numberOfOpinions;
@property (nonatomic, assign) NSInteger numberOfViews;
@property (nonatomic, strong) NSArray * opinions;
@property (nonatomic, strong) NSString * latestOpinionTitle;
@property (nonatomic, assign) NSInteger latestOpinionID;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end



