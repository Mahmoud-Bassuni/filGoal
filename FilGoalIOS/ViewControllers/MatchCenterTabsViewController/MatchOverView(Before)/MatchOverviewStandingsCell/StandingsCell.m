//
//  StandingsCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/21/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "StandingsCell.h"
#import "UIImageView+WebCache.h"
@implementation StandingsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithTeamStandingItem:(Standing *)item
{
    [self.activityIndicator startAnimating];
    [self.teamLogoImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.teamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                     [self.activityIndicator stopAnimating];
                                                     [self.activityIndicator setHidden:YES];
                                                     
                                                 }];
    
    [self.playedLbl setText:[NSString stringWithFormat:@"%li",(item.playedAway+item.playedHome)]];
    [self.teamRankLbl setText:[NSString stringWithFormat:@"%li",item.rank]];
    [self.winLbl setText:[NSString stringWithFormat:@"%li",item.goalsScored]];
    [self.lossLbl setText:[NSString stringWithFormat:@"%li",item.goalsConceded]];
    [self.pointsLbl setText:[NSString stringWithFormat:@"%li",item.points]];
    [self.teamNameLbl setText:item.teamName];
    
    self.homeTeamBtn.titleLabel.text = item.teamName;
    self.homeTeamBtn.tag = item.teamId;
    if(item.isRankUp==nil)
    {
        [self.rankUpImagView setHidden:YES];
    }
    else if([[NSString stringWithFormat:@"%@",item.isRankUp] isEqualToString:@"1"])
    {
        [self.rankUpImagView setHidden:NO];
        [self.rankUpImagView setImage:[UIImage imageNamed:@"player_in"]];
    }
    else
    {
        [self.rankUpImagView setHidden:NO];
        [self.rankUpImagView setImage:[UIImage imageNamed:@"player_out"]];
    }

}
- (IBAction)homeTeamBtnPressed:(UIButton*)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController * navigationController = delegate.getSelectedNavigationController;
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [navigationController pushViewController:teamProfile animated:YES];
}
@end
