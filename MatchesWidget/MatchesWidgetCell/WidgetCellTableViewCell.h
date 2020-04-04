//
//  WidgetCellTableViewCell.h
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 10/27/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WidgetCellTableViewCell : UITableViewCell


@property  (weak, nonatomic) IBOutlet UIImageView *teamImage2;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *teamActivity2;

@property (strong, nonatomic) IBOutlet UILabel *matchStatusLbl;

@property (weak, nonatomic) IBOutlet UIImageView *teamImage1;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *teamActivity1;
@property (nonatomic,strong) IBOutlet UILabel *teamscore1Label;
@property (nonatomic,strong) IBOutlet UILabel *teamscore2Label;



@property (nonatomic,strong) IBOutlet UILabel *testscore1Label;



@property (weak, nonatomic) IBOutlet UIImageView *didntStartImage;

@property (weak, nonatomic) IBOutlet UILabel *matchStatus;

@property (weak, nonatomic) IBOutlet UILabel *team1Name;
@property (weak, nonatomic) IBOutlet UILabel *matchCounter;
@property (weak, nonatomic) IBOutlet UILabel *team2Name;

@property (weak, nonatomic) IBOutlet  UILabel *timeOfTheMatch;


@end
