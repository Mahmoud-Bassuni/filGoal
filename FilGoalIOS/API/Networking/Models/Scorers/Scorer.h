//
//	Data.h
//
//	Create by Nada Gamal on 7/8/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Scorer : NSObject

@property (nonatomic, assign) NSInteger goals;
@property (nonatomic, assign) CGFloat goalscoringPercentage;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger played;
@property (nonatomic, strong) NSString * slug;
@property (nonatomic, assign) NSInteger teamId;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSString * teamSlug;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
