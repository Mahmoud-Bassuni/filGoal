//
//  TeamsHighestScoreViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/17/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "TeamsHighestScoreViewController.h"
#import "UIImageView+WebCache.h"

@interface TeamsHighestScoreViewController ()

@end

@implementation TeamsHighestScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.firstMatchItemView.layer.cornerRadius = 30;
    self.firstMatchItemView.layer.masksToBounds = YES;
    [self updateUI];
}
-(void)updateUI
{
    [self.firstMatchItemView setBackgroundColor:self.firstMatchItemViewBackgrounColor];
    [self.firstChampNameLbl setText:self.firstHighestScore.championshipName];
    [self.firstAwayTeamNameLbl setText:self.firstHighestScore.awayTeamName];
    [self.firstHomeTeamNameLbl setText:self.firstHighestScore.homeTeamName];
    [self.firstAwayScoreLbl setText:[NSString stringWithFormat:@"%ld",(long)self.firstHighestScore.awayScore]];
    [self.firstHomeScoreLbl setText:[NSString stringWithFormat:@"%ld",(long)self.firstHighestScore.homeScore]];
    [self.firstAwayTeamLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)self.firstHighestScore.awayTeamId]]];
    [self.firstHomeTeamLogoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)self.firstHighestScore.homeTeamId]]];
    [self.firstHomeScoreLbl setTextColor:self.scoreColor];
    [self.firstAwayScoreLbl setTextColor:self.scoreColor];
    self.homeTeamBtn.titleLabel.text = self.firstHighestScore.homeTeamName;
    self.homeTeamBtn.tag = self.firstHighestScore.homeTeamId;
    self.awayTeamBtn.titleLabel.text = self.firstHighestScore.awayTeamName;
    self.awayTeamBtn.tag = self.firstHighestScore.awayTeamId;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)homeTeamBtnAction:(UIButton*)sender {
//    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    UINavigationController * navigationController = [appDelegate getSelectedNavigationController];
//    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
//    teamProfile.teamId = (int)sender.tag;
//    teamProfile.teamName = sender.titleLabel.text;
//    [navigationController pushViewController:teamProfile animated:YES];
}

- (IBAction)awayTeamBtnAction:(UIButton*)sender {
//    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    UINavigationController * navigationController = [appDelegate getSelectedNavigationController];
//    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
//    teamProfile.teamId = (int)sender.tag;
//    teamProfile.teamName = sender.titleLabel.text;
//    [navigationController pushViewController:teamProfile animated:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
