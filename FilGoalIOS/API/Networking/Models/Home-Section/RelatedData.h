//
//	RelatedData.h
//
//	Create by Nada Gamal on 27/5/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Championship.h"
#import "MatchCenterDetails.h"
#import "ChampionShipData.h"
#import "Team.h"
#import "Player.h"
@interface RelatedData : NSObject
@property (nonatomic, strong) NSArray * championships;
@property (nonatomic, strong) NSArray * matches;
@property (nonatomic, strong) NSArray * people;
@property (nonatomic, strong) NSArray * teams;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
