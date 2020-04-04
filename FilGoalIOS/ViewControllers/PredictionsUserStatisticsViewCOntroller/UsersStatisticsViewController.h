//
//  UsersStatisticsViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 5/12/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <STPopup/STPopup.h>
@interface UsersStatisticsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIProgressView *homeProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *awayProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *drawProgressView;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamPercentageLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamPercentageLbl;
@property (weak, nonatomic) IBOutlet UILabel *drawTeamPercentageLbl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *drawTeamLbl;
@property (weak, nonatomic) IBOutlet UIImageView *sponsorImgView;
@property (strong, nonatomic) MatchCenterDetails * matchItem;
@end
