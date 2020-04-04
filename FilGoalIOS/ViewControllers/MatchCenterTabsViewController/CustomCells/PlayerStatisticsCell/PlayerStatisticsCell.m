//
//  PlayerStatisticsCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/18/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "PlayerStatisticsCell.h"
#import "UIImageView+WebCache.h"
#import "PlayerProfileViewController.h"
@implementation PlayerStatisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.firstPlayerLogoImg.layer.cornerRadius = self.firstPlayerLogoImg.frame.size.width/2;
    self.firstPlayerLogoImg.clipsToBounds = YES;
    self.firstPlayerLogoImg.layer.borderWidth = 1.0f;
    self.firstPlayerLogoImg.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    self.secPlayerLogoImg.layer.cornerRadius = self.secPlayerLogoImg.frame.size.width/2;
    self.secPlayerLogoImg.clipsToBounds = YES;
    self.secPlayerLogoImg.layer.borderWidth = 1.0f;
    self.secPlayerLogoImg.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)secPlayerBtnPressed:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];

    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

- (IBAction)firstPlayerBtnPressed:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

-(void)initWithPlayerStatistics:(PlayersStatistic *)item andMatchItem:(MatchCenterDetails*) matchItem
{
    [self.firstPlayerNameLbl setText:item.firstPersonName];
    [self.secPlayerNameLbl setText:item.secondPersonName];
    [self.firstPlayerLogoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)item.firstPersonId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    [self.secPlayerLogoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)item.secondPersonId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    [self.eventTypeLbl setText:item.eventTypeName];
    [self.nOfFirstPlayerGoalsLbl setText:[NSString stringWithFormat:@"%ld",(long)item.firstValue]];
    [self.nOfSecPlayerGoalsLbl setText:[NSString stringWithFormat:@"%ld",(long)item.secondValue]];
    [self.awayTeamLogoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)matchItem.awayTeamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    [self.homeTeamLogoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)matchItem.homeTeamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    self.firstPlayerBtn.tag = item.firstPersonId;
    self.secPlayerBtn.tag = item.secondPersonId;

}

@end
