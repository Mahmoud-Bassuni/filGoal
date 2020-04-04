//
//  StandingsLandscapeCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/19/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "StandingsLandscapeCell.h"

@implementation StandingsLandscapeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithStandingCell:(Standing *)item
{
    [self.rankLbl setText:[NSString stringWithFormat:@"%li",(long)item.rank]];
    [self.teamLbl setText:item.teamName];
    [self.playsLbl setText:[NSString stringWithFormat:@"%li",(item.playedHome+item.playedAway)]];
    [self.playedHomeLbl setText:[NSString stringWithFormat:@"%li",(long)item.playedHome]];
    [self.playedAwayLbl setText:[NSString stringWithFormat:@"%li",(long)item.playedAway]];
    [self.winsLbl setText:[NSString stringWithFormat:@"%li",(long)item.wins]];
    [self.losesLbl setText:[NSString stringWithFormat:@"%li",(long)item.loses]];
    [self.drawLbl setText:[NSString stringWithFormat:@"%li",(long)item.draws]];
    [self.goalsScoredLbl setText:[NSString stringWithFormat:@"%li",(long)item.goalsScored]];
    [self.goalsConcededLbl setText:[NSString stringWithFormat:@"%li",(long)item.goalsConceded]];
    [self.pointsLbl setText:[NSString stringWithFormat:@"%li",(long)item.points]];
    [self.teamImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.teamId]] placeholderImage:[UIImage imageNamed:@"Team-Image-Placeholder"]
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                   [self.activityIndicator stopAnimating];
                                   
                               }];
    
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

@end
