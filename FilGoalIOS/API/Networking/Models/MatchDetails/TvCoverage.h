//
//	TvCoverage.h
//
//	Create by Nada Gamal on 13/5/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface TvCoverage : NSObject

@property (nonatomic, assign) NSInteger commenterId;
@property (nonatomic, strong) NSString * commenterName;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger matchId;
@property (nonatomic, strong) NSString * satelliteName;
@property (nonatomic, assign) NSInteger tvChannelId;
@property (nonatomic, strong) NSString * tvChannelName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end