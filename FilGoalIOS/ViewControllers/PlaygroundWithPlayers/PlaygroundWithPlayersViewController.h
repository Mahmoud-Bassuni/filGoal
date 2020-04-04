//
//  PlaygroundWithPlayersViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/8/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDFTooltips.h"
#import "TappableSponsorImageView.h"


@interface PlaygroundWithPlayersViewController : UIViewController

@property (nonatomic, strong) JDFSequentialTooltipManager *tooltipManager;

@property (weak, nonatomic) IBOutlet UIImageView *groundImgView;
@property (weak, nonatomic) IBOutlet UIView *secTeamGoalView;
@property (nonatomic,strong) MatchCenterDetails* matchDetails;
@property (weak, nonatomic) IBOutlet UIView *firstTeamGoalView;
@property (weak, nonatomic) IBOutlet UIView *secTeamDefenderView;
@property (weak, nonatomic) IBOutlet UIView *secTeamCenterView;
@property (weak, nonatomic) IBOutlet UIView *secTeamAttackView;
@property (weak, nonatomic) IBOutlet UIView *secTeamSpearHeadView; // ras 7arba
@property (weak, nonatomic) IBOutlet UIView *firstTeamDefenderView;
@property (weak, nonatomic) IBOutlet UIView *firstTeamCenterView;
@property (weak, nonatomic) IBOutlet UIView *firstTeamAttackView;
@property (weak, nonatomic) IBOutlet UIView *firstTeamSpearHeadView; // ras 7arba
@property(nonatomic,strong) NSMutableArray * homeTeamSquad;
@property(nonatomic,strong) NSMutableArray * awayTeamSquad;
- (IBAction)firstTeamGoalBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *firstTeamGoalBtn;
@property (strong, nonatomic) IBOutlet UIButton *firstSpearBtn;
@property (strong, nonatomic) IBOutlet UIButton *secSpearBtn;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
- (IBAction)secTeamGoalBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton * secTeamGoalBtn;
@end
