//
//	PreviousMatches.h
//
//	Create by Mohamed Mansour on 18/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "MatchCenterDetails.h"

@interface MatchesList : NSObject

//@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSArray * matches;
@property (nonatomic, strong) NSMutableArray * dates;
@property (nonatomic, strong) NSMutableArray * matchItems;
@property (nonatomic, strong) NSObject * nextPageUri;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary*)getMatchesWidget:(NSArray*) matches andYestardayDate:(NSString*)yesterdayDate andTomorrowDate:(NSString*)tomorrowDate;
-(NSArray*)getMatchesListByDate:(NSString*)selectedDate andMatches:(NSArray*) matches;
@end
