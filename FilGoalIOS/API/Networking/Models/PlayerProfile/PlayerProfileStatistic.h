//
//	PlayerProfileStatistic.h
//
//	Create by Nada Gamal on 26/7/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface PlayerProfileStatistic : NSObject

@property (nonatomic, assign) NSInteger championshipId;
@property (nonatomic, strong) NSString * championshipName;
@property (nonatomic, strong) NSString * championshipSlug;
@property (nonatomic, assign) NSInteger goals;
@property (nonatomic, assign) NSInteger played;
@property (nonatomic, assign) NSInteger redCards;
@property (nonatomic, assign) NSInteger teamId;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSString * teamSlug;
@property (nonatomic, assign) NSInteger yellowCards;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end