//
//  TeamStandingsHeaderCell.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamStandingsHeaderCell.h"

@implementation TeamStandingsHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.teamRankLbl.layer.cornerRadius = self.teamRankLbl.frame.size.width/2;
    self.teamRankLbl.clipsToBounds = YES;
    self.teamRankLbl.layer.borderWidth = 1.0;
    self.teamRankLbl.layer.borderColor = [[UIColor lightGrayColor]CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithTeamStandingItem:(Standing *)item
{
    [self.activityIndicator startAnimating];
    self.champNameLbl.text = item.championshipName;
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
