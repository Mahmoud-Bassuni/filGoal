//
//  PreviousMatchTableViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/24/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "PreviousMatchTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation PreviousMatchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void) initWithMatchItem :(MatchCenterDetails*) item{
    [self.homeTeamNameLbl setText:item.homeTeamName];
    [self.awayTeamNameLbl setText:item.awayTeamName];
    [self.champNameLbl setText:item.championshipName];
    [self.homeTeamImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.homeTeamId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       
                                       
                                   }];
    
    [self.awayTeamImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.awayTeamId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       
                                       
                                   }];
    
    [self.dateLbl setText:item.dateStr];
    self.homeTeamBtn.titleLabel.text = item.homeTeamName;
    self.homeTeamBtn.tag = item.homeTeamId;
    
    self.awayTeamBtn.titleLabel.text = item.awayTeamName;
    self.awayTeamBtn.tag = item.awayTeamId;
    if(item.matchStatusHistory.count>0)
    {
        MatchStatusHistory * matchStatusItem=[item.matchStatusHistory objectAtIndex:0];
        if (matchStatusItem.matchStatusIndicatorId == MatchNotStartedIndicatorID||matchStatusItem.matchStatusId == KMatchPostponed)  {
            
            self.homeScoreLbl.text = @"-";
            self.awayScoreLbl.text = @"-";
            
        }
        else{
            [self.homeScoreLbl setText:[NSString stringWithFormat:@"%li",(long)item.homeScore]];
            [self.awayScoreLbl setText:[NSString stringWithFormat:@"%li",(long)item.awayScore]];
        }
    }
    
}

- (IBAction)homeTeamBtnPressed:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = [appDelegate getSelectedNavigationController];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [navigationController pushViewController:teamProfile animated:YES];
}

- (IBAction)awayTeamBtnPressed:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = [appDelegate getSelectedNavigationController];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [navigationController pushViewController:teamProfile animated:YES];
}
@end
