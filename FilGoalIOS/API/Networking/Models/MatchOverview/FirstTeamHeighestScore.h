//
//	FirstTeamHeighestScore.h
//
//	Create by Mohamed Mansour on 16/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface FirstTeamHeighestScore : NSObject

@property (nonatomic, assign) NSInteger awayScore;
@property (nonatomic, assign) NSInteger awayTeamId;
@property (nonatomic, strong) NSString * awayTeamLogoUrl;
@property (nonatomic, strong) NSString * awayTeamName;
@property (nonatomic, assign) NSInteger championshipId;
@property (nonatomic, strong) NSString * championshipName;
@property (nonatomic, assign) NSInteger homeScore;
@property (nonatomic, assign) NSInteger homeTeamId;
@property (nonatomic, strong) NSString * homeTeamLogoUrl;
@property (nonatomic, strong) NSString * homeTeamName;
@property (nonatomic, assign) NSInteger matchId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end