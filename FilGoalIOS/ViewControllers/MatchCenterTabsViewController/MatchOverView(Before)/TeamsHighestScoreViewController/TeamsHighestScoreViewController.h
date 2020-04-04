//
//  TeamsHighestScoreViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/17/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTeamHeighestScore.h"

@interface TeamsHighestScoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *firstChampNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *secChampNameLbl;
@property (weak, nonatomic) IBOutlet UIView *firstMatchItemView;
@property (weak, nonatomic) IBOutlet UIView *secMatchItemView;
@property (weak, nonatomic) IBOutlet UIImageView *firstHomeTeamLogoImg;
@property (weak, nonatomic) IBOutlet UIImageView *firstAwayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel * firstHomeTeamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstAwayTeamNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *secHomeTeamLogoImg;
@property (weak, nonatomic) IBOutlet UIImageView *secAwayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *secHomeTeamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *secAwayTeamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstHomeScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *firstAwayScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *secHomeScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *secAwayScoreLbl;
@property (strong,nonatomic) UIColor * firstMatchItemViewBackgrounColor;
@property (strong,nonatomic) UIColor * scoreColor;

@property (strong, nonatomic) FirstTeamHeighestScore * firstHighestScore;

@property (weak, nonatomic) IBOutlet UIButton *homeTeamBtn;
@property (weak, nonatomic) IBOutlet UIButton *awayTeamBtn;

@end
