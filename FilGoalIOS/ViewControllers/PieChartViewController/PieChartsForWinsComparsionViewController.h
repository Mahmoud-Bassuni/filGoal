//
//  PieChartsForWinsComparsionViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/16/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WinsComparison.h"
#import "UIImageView+WebCache.h"
@interface PieChartsForWinsComparsionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (weak, nonatomic) IBOutlet UIView *homeTeamWinView;
@property (weak, nonatomic) IBOutlet UIView *awayTeamWinView;
@property (weak, nonatomic) IBOutlet UIView *drawTeamsView;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamWinVsawayTeamLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamWinVshomeTeamLbl;
@property (weak, nonatomic) IBOutlet UILabel *nOfWiningMatchesLblForhomeTeam;
@property (weak, nonatomic) IBOutlet UILabel *nOfWiningMatchesLblForawayTeam;
@property (weak, nonatomic) IBOutlet UILabel *nOfDrawMatchesLbl;
@property (nonatomic,strong) NSString * homeTeamName;
@property (nonatomic,strong) NSString * awayTeamName;
@property (nonatomic,strong) WinsComparison * winComparsion;
@property(nonatomic,strong) NSString * awayTeamLogoUrl;
@property(nonatomic,strong) NSString * homeTeamLogoUrl;
@property(nonatomic,strong) MatchCenterDetails * matchItem;

@end
