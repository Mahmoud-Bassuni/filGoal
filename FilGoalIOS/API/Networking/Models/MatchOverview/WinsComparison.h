//
//	WinsComparison.h
//
//	Create by Mohamed Mansour on 16/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface WinsComparison : NSObject

@property (nonatomic, assign) NSInteger draws;
@property (nonatomic, assign) NSInteger firstTeamWins;
@property (nonatomic, assign) NSInteger secondTeamWins;
@property (nonatomic, assign) NSInteger totalMatches;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end