//
//	PredictionStatistics.h
//
//	Create by Nada Gamal on 13/5/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface PredictionStatistics : NSObject

@property (nonatomic, assign) NSInteger awayTeamWin;
@property (nonatomic, assign) NSInteger awayTeamWinPercentage;
@property (nonatomic, assign) NSInteger homeTeamWin;
@property (nonatomic, assign) NSInteger homeTeamWinPercentage;
@property (nonatomic, assign) NSInteger matchDraw;
@property (nonatomic, assign) NSInteger matchDrawPercentage;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end