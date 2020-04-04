//
//	Standing.h
//
//	Create by Nada Gamal on 18/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Standing : NSObject

@property (nonatomic, assign) NSInteger championshipId;
@property (nonatomic, strong) NSString * championshipName;
@property (nonatomic, assign) NSInteger draws;
@property (nonatomic, assign) NSInteger goalsConceded;
@property (nonatomic, assign) NSInteger goalsScored;
@property (nonatomic, assign) NSInteger groupId;
@property (nonatomic, strong) NSString * groupName;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger loses;
@property (nonatomic, strong) NSObject * orderInGroup;
@property (nonatomic, assign) NSInteger playedAway;
@property (nonatomic, assign) NSInteger playedHome;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger roundId;
@property (nonatomic, strong) NSString * roundName;
@property (nonatomic, assign) NSInteger roundOrder;
@property (nonatomic, strong) NSString * roundTypeName;
@property (nonatomic, assign) NSInteger teamId;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSObject * week;
@property (nonatomic, assign) NSInteger wins;
@property (nonatomic, strong) NSString *isRankUp;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
