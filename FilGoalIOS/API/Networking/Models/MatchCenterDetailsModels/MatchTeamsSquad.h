//
//	MatchTeamsSquad.h
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface MatchTeamsSquad : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) BOOL isSpare;
@property (nonatomic, assign) NSInteger matchId;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) NSInteger personId;
@property (nonatomic, strong) NSString * personLogoUrl;
@property (nonatomic, strong) NSString * personName;
@property (nonatomic, assign) NSInteger playerPositionId;
@property (nonatomic, strong) NSString * playerPositionName;
@property (nonatomic, assign) NSInteger shirtNumber;
@property (nonatomic, assign) NSInteger teamId;
@property (nonatomic,strong) NSMutableArray * playerMatchEvents;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end