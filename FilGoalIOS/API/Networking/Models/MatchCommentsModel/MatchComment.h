//
//	MatchComment.h
//
//	Create by Mohamed Mansour on 11/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "MatchEvent.h"

@interface MatchComment : NSObject
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * contentUrl;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger languageId;
@property (nonatomic, strong) NSString * languageName;
@property (nonatomic, assign) NSInteger  matchEventId;
@property (nonatomic, assign) NSInteger matchId;
@property (nonatomic, assign) NSInteger matchStatusId;
@property (nonatomic, assign) NSInteger  matchStatusMaxTime;
@property (nonatomic, strong) NSString * matchStatusName;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) MatchEvent * matchEvent;
@property (nonatomic, assign) NSInteger matchStatusestime;
@property (nonatomic, assign) NSInteger order;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
