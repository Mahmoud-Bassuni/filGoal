//
//  StandingsLandscapeCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/19/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandingsLandscapeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *rankLbl;
@property (strong, nonatomic) IBOutlet UIImageView *teamImgView;
@property (strong, nonatomic) IBOutlet UILabel *teamLbl;
@property (strong, nonatomic) IBOutlet UILabel *playsLbl;
@property (strong, nonatomic) IBOutlet UILabel *playedAwayLbl;
@property (strong, nonatomic) IBOutlet UILabel *playedHomeLbl;
@property (strong, nonatomic) IBOutlet UILabel *winsLbl;
@property (strong, nonatomic) IBOutlet UILabel *losesLbl;
@property (strong, nonatomic) IBOutlet UILabel *drawLbl;
@property (strong, nonatomic) IBOutlet UILabel *goalsScoredLbl;
@property (strong, nonatomic) IBOutlet UILabel *goalsConcededLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *pointsLbl;
-(void)initWithStandingCell:(Standing*)item;
@property (weak, nonatomic) IBOutlet UIImageView * rankUpImagView;


@end
