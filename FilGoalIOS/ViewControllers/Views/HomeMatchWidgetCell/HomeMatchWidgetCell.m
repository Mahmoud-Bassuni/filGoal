//
//  HomeMatchWidgetCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "HomeMatchWidgetCell.h"
#import "UIImageView+WebCache.h"
#import "TvCoverage.h"
@implementation HomeMatchWidgetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.matchstatusLbl.layer.cornerRadius = 10.2;
    self.matchstatusLbl.clipsToBounds = YES;
   // self.matchstatusLbl.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initCellWithMatchItem:(MatchCenterDetails*)item
{
    self.predictBtn.layer.cornerRadius = 18;
    self.predictBtn.clipsToBounds = YES;
    self.predictBtn.layer.borderColor = [[UIColor mainAppYellowColor]CGColor];
    self.predictBtn.layer.borderWidth = 1.0;
    self.homeLogoView.layer.cornerRadius = self.homeLogoView.frame.size.width/2;
    self.homeLogoView.clipsToBounds = YES;
    self.awayLogoView.layer.cornerRadius = self.awayLogoView.frame.size.width/2;
    self.awayLogoView.clipsToBounds = YES;
    
    self.homeLogoView.layer.cornerRadius = self.homeLogoView.frame.size.height /2;
    self.homeLogoView.layer.masksToBounds = YES;
    self.homeLogoView.layer.borderWidth = 1;
    self.homeLogoView.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]CGColor];

    self.awayLogoView.layer.cornerRadius = self.awayLogoView.frame.size.height /2;
    self.awayLogoView.layer.masksToBounds = YES;
    self.awayLogoView.layer.borderWidth =1;
    self.awayLogoView.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]CGColor];
    
    [self.homeTeamNameLbl setText:item.homeTeamName];
    [self.awayTeamNameLbl setText:item.awayTeamName];
    [self.homeScoreLbl setText:[NSString stringWithFormat:@"%li",(long)item.homeScore]];
    [self.awayScoreLbl setText:[NSString stringWithFormat:@"%li",(long)item.awayScore]];
    [self.championshipNameBtn setTitle:item.championshipName forState:UIControlStateNormal];
    [self.homeTeamImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.homeTeamId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       [self.homeActivityIndicator stopAnimating];
 
                                       
                                   }];
    
    [self.awayTeamImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.awayTeamId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       
                                       [self.awayActivityIndicator stopAnimating];
                                   }];
    
    [self.timeLbl setText:item.time];
    self.homeTeamBtn.titleLabel.text = item.homeTeamName;
    self.homeTeamBtn.tag = item.homeTeamId;
    
    self.awayTeamBtn.titleLabel.text = item.awayTeamName;
    self.awayTeamBtn.tag = item.awayTeamId;
//    if (item.tvCoverage.count>0) {
//        [self.channelsLbl setTitle:[NSString stringWithFormat:@"يعرض علي : %@",[[item.tvCoverage objectAtIndex:0]objectForKey:@"tvChannelName"]]forState:UIControlStateNormal];
//    }
    NSString * channels=[[NSString alloc]init];
    for(TvCoverage * channelItem in item.tvCoverage)
    {
        channels=[channels stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@,",channelItem.tvChannelName]];
        
    }
    if ([channels length] > 0) {
        [self.channelsLbl setTitle:[channels substringToIndex:[channels length] - 1] forState:UIControlStateNormal];
    } else {
        [self.channelsLbl setTitle:@"غير متوفر حاليا" forState:UIControlStateNormal];

    }
    // check predict Button
    if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId] &&
        item.matchStatusHistory.count>0 &&
        [[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
        
        [self.predictBtn setHidden:NO];
        [self.statisticsBtn setHidden:NO];
    }
    else{
        [self.predictBtn setHidden:YES];
        if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]){
            self.statisticsBtn.hidden = NO;
            
        }
        else{
        [self.statisticsBtn setHidden:YES];
        }
    }
        if(item.matchStatusHistory.count>0)
        {
            MatchStatusHistory * matchStatusItem=[item.matchStatusHistory objectAtIndex:0];
            self.matchstatusLbl.text=matchStatusItem.matchStatusName;
           // [self.matchstatusLbl setBackgroundColor:matchStatusItem.matchStatusColor];
            
            if (matchStatusItem.matchStatusIndicatorId == MatchNotStartedIndicatorID||matchStatusItem.matchStatusId == KMatchPostponed)  {
                
                self.homeScoreLbl.text = @"-";
                self.awayScoreLbl.text = @"-";
                [self.matchstatusLbl setBackgroundColor:[UIColor whiteColor]];
                [self.matchstatusLbl setTextColor:[UIColor blackColor]];

            }
            else{
                self.homeScoreLbl.text= [NSString stringWithFormat:@"%li",(long)item.homeScore];
                self.awayScoreLbl.text= [NSString stringWithFormat:@"%li",(long)item.awayScore];
                [self.matchstatusLbl setBackgroundColor:[UIColor mainAppDarkGrayColor]];
                [self.matchstatusLbl setTextColor:[UIColor mainAppYellowColor]];
                
            }
            if(matchStatusItem.matchStatusIndicatorId == MatchLiveIndicatorID)
            {
                [self.matchstatusLbl setText:@"مباشر"];
                [self.matchStatusIndicator setHidden:NO];
                [self.matchStatusIndicator setText:matchStatusItem.matchStatusName];
                [self.matchstatusLbl setBackgroundColor:[UIColor redColor]];
                [self.matchstatusLbl setTextColor:[UIColor whiteColor]];
            }
            else
            {
                [self.matchStatusIndicator setHidden:YES];
                
            }
            
            if(item.homePenaltyScore !=0 || item.awayPenaltyScore != 0)
            {
                self.homeScoreLbl.text= [self.homeScoreLbl.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",item.homePenaltyScore==-1?@"":[NSString stringWithFormat:@"(%li)",(long)item.homePenaltyScore ]]];
                
                self.awayScoreLbl.text= [self.awayScoreLbl.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",item.awayPenaltyScore==-1?@"":[NSString stringWithFormat:@"(%li)",(long)item.awayPenaltyScore ]]];
            }
            
        }
   // }
        
    [self.homeTeamBtn setTitle:item.homeTeamName forState:UIControlStateNormal];;
    self.homeTeamBtn.tag = item.homeTeamId;
    
    [self.awayTeamBtn setTitle:item.awayTeamName forState:UIControlStateNormal];
    self.awayTeamBtn.tag = item.awayTeamId;
    
    self.championshipNameBtn.titleLabel.text = item.championshipName;
    self.championshipNameBtn.tag = item.championshipId;
}





- (IBAction)homeTeamBtnPressed:(UIButton*)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    UINavigationController * navigationController = delegate.getSelectedNavigationController;
    [navigationController pushViewController:teamProfile animated:NO];
}

- (IBAction)awayTeamBtnPressed:(UIButton*)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    UINavigationController * navigationController = delegate.getSelectedNavigationController;
    [navigationController pushViewController:teamProfile animated:NO];
}

- (IBAction)championshipBtnPressed:(UIButton*)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    Champion * champ = [[Global getInstance]getChampById:(int)sender.tag];
    ChampionShipData * champion = [[ChampionShipData alloc]init];
    champion.idField = champ.champId;
    champion.name = champ.champName;
    
    
    if(champ != nil)
    {
        UINavigationController * navigationController = delegate.getSelectedNavigationController;
        ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
        detailsScreen.champion = champion;
        [navigationController pushViewController:detailsScreen animated:YES];
    }
}

@end
