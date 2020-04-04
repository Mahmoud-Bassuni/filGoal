//
//	Player.h
//
//	Create by Nada Gamal on 25/7/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "CareerData.h"

@interface Player : NSObject

@property (nonatomic, strong) NSString * bio;
@property (nonatomic, strong) NSArray * careerData;
@property (nonatomic, assign) NSInteger countryId;
@property (nonatomic, strong) NSString * countryName;
@property (nonatomic, strong) NSString * dateOfBirth;
@property (nonatomic, strong) NSString * facebook;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger shirtNumber;

@property (nonatomic, strong) NSString * instagram;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * playerName;

@property (nonatomic, strong) NSObject * nationalities;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * shortName;
@property (nonatomic, strong) NSString * slug;
@property (nonatomic, strong) NSString * snapChat;
@property (nonatomic, strong) NSString * twitter;
@property (nonatomic, strong) NSString * positionName;

//Old ScorersObject from api.filgoal API
@property (nonatomic, assign) int playerId;
@property (nonatomic, assign) int playerIdd;

@property (nonatomic, assign) int clubId;
@property (nonatomic, retain) NSString *playerPicture;
@property (nonatomic, assign) int champID;
@property (nonatomic, retain) NSString *aClubName;
@property (nonatomic, retain) NSString *champname;
@property (nonatomic, retain) NSString *clubLogo;
@property (nonatomic, retain) NSString *aName;
@property (nonatomic, assign) int goals;
@property (nonatomic, assign) NSInteger playerPositionId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
