//
//  TodayViewController.h
//  MatchesWidget
//
//  Created by Yomna Ahmed on 10/23/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"


@interface TodayViewController : GAITrackedViewController <UITableViewDelegate,UITableViewDataSource>{

    int whichButtonIsTapped;
    NSString *hi;
    BOOL isFail;
    BOOL isMore;


}

@property (strong, nonatomic) IBOutlet UILabel *matchStatusLbl;


@property (strong, nonatomic) NSMutableArray *yesterdayMatches;

@property (strong, nonatomic) NSMutableArray *todayMatches;

@property (strong, nonatomic)  NSMutableArray *tomorrowMatches;
@property (strong,nonatomic) NSDictionary * matchesDic;

@property (strong, nonatomic)  NSArray *widgetAllMatches;
@property (strong, nonatomic)  NSArray * matches;

@property (strong, nonatomic)  UILabel *noMatchesView;

//@property (strong, nonatomic)  UIButton *moreButton;

@property (strong, nonatomic) IBOutlet UIButton *moreButton;


@end
