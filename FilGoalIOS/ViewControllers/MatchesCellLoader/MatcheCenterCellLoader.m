//
//  NewsCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "MatcheCenterCellLoader.h"
#import  "Images.h"
#import  "UIImageView+WebCache.h"
#import "TvCoverage.h"
#import "UsersStatisticsViewController.h"
@implementation MatcheCenterCellLoader
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super initWithCoder:aDecoder]) {
   
    }
    
    return self;
}

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withMatchItem:(MatchCenterDetails *)item
{
    static NSString *CellIdentifier = @"MatcheCenterCellLoader";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"MatcheCenterCellLoader";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];

    cell.contentView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    
    UIButton * homeClubBtn = (UIButton *)[cell viewWithTag:4004];
    UIButton * awayClubBtn = (UIButton *)[cell viewWithTag:4005];
    UIButton * predictBtn = (UIButton *)[cell viewWithTag:10002];
    UIButton * statisticsBtn = (UIButton *)[cell viewWithTag:90000];


    UIImageView *fClubImageView = (UIImageView *)[cell viewWithTag:3000];
    UIImageView *sClubImageView = (UIImageView *)[cell viewWithTag:3001];
    
    UIImageView *fClubView = (UIImageView *)[cell viewWithTag:7001];
    UIImageView *sClubView = (UIImageView *)[cell viewWithTag:7000];
    //fClubView.layer.cornerRadius = fClubView.frame.size.width/2;
    fClubView.clipsToBounds = YES;
    
   // sClubView.layer.cornerRadius = sClubView.frame.size.width/2;
    sClubView.clipsToBounds = YES;
  //  fClubImageView.layer.cornerRadius = fClubImageView.frame.size.height /2;
    fClubImageView.layer.masksToBounds = YES;
    fClubImageView.layer.borderWidth = 0;
    
    //sClubImageView.layer.cornerRadius = sClubImageView.frame.size.height /2;
    sClubImageView.layer.masksToBounds = YES;
    sClubImageView.layer.borderWidth = 0;
    
    UIActivityIndicatorView *ind = (UIActivityIndicatorView *)[cell viewWithTag:4000];
    [ind startAnimating];
    [ind setHidden:NO];
    //item.fClubLogo= [item.fClubLogo stringByReplacingOccurrencesOfString:@"black" withString:@"White"];
    [fClubImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.homeTeamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [ind stopAnimating];
                                 [ind setHidden:YES];
                                 
                             }];
    
    
    UIActivityIndicatorView *ind1 = (UIActivityIndicatorView *)[cell viewWithTag:4001];
    [ind1 startAnimating];
    [ind1 setHidden:NO];
    //  item.sClubLogo= [item.sClubLogo stringByReplacingOccurrencesOfString:@"black" withString:@"White"];
    [sClubImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.awayTeamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [ind1 stopAnimating];
                                 [ind1 setHidden:YES];
                                 
                             }];
    
    
    
    
    UILabel *champNameLbl = (UILabel *)[cell viewWithTag:10000];

    UILabel *fClubTitleLabel = (UILabel *)[cell viewWithTag:1000];
    UILabel *sClubTitleLabel = (UILabel *)[cell viewWithTag:1001];
    
    UILabel *fClubScoreLabel = (UILabel *)[cell viewWithTag:1002];
    UILabel *sClubScoreLabel = (UILabel *)[cell viewWithTag:1003];
    
    UILabel *fClubPensLabel = (UILabel *)[cell viewWithTag:1006];
    UILabel *sClubPensLabel = (UILabel *)[cell viewWithTag:1007];
    
    UILabel *matchStatusIndicator = (UILabel *)[cell viewWithTag:1004];
    UILabel *matchDateLabel = (UILabel *)[cell viewWithTag:20000];
    UILabel *matchStatusLbl = (UILabel *)[cell viewWithTag:3002];
    
    UILabel *matchFDateLabel = (UILabel *)[cell viewWithTag:1008];
    UILabel *matchShowLabel = (UILabel *)[cell viewWithTag:1009];

    matchStatusLbl.layer.cornerRadius = 12;
    matchStatusLbl.clipsToBounds = YES;
    [matchFDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:fClubTitleLabel.font.pointSize]];
    [matchShowLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:fClubTitleLabel.font.pointSize]];
    
    matchFDateLabel.text=item.longDateStr;
    if (item.tvCoverage.count>0) {
        TvCoverage * channelItem = [item.tvCoverage objectAtIndex:0];
        matchShowLabel.text=[NSString stringWithFormat:@"يعرض علي : %@",channelItem.tvChannelName];
    }
    else{
        matchShowLabel.hidden=YES;
        UIImageView *tvi = (UIImageView *)[cell viewWithTag:9000];
        tvi.hidden=YES;
    }
    champNameLbl.text=item.championshipName;
    [fClubTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:fClubTitleLabel.font.pointSize]];
    [sClubTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:sClubTitleLabel.font.pointSize]];
    [fClubScoreLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:fClubScoreLabel.font.pointSize]];
    [sClubScoreLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:sClubScoreLabel.font.pointSize]];
    [matchStatusIndicator setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:matchStatusIndicator.font.pointSize]];
    [matchDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:matchDateLabel.font.pointSize]];
    [fClubPensLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:matchDateLabel.font.pointSize]];
    [sClubPensLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:matchDateLabel.font.pointSize]];
    
    fClubTitleLabel.text=item.homeTeamName;
    sClubTitleLabel.text=item.awayTeamName;
    if(item.matchStatusHistory.count>0)
    {
        MatchStatusHistory * matchStatusItem=[item.matchStatusHistory objectAtIndex:0];
        matchStatusLbl.text=matchStatusItem.matchStatusName;
       // [matchStatusLbl setBackgroundColor:matchStatusItem.matchStatusColor];
        
        if (matchStatusItem.matchStatusIndicatorId == MatchNotStartedIndicatorID||matchStatusItem.matchStatusId == KMatchPostponed)  {
            
            fClubScoreLabel.text = @"-";
            sClubScoreLabel.text = @"-";
            [matchStatusLbl setBackgroundColor:[UIColor fa_whiteFourColor]];
            [matchStatusLbl setTextColor:[UIColor blackColor]];
        }
        else{
            fClubScoreLabel.text= [NSString stringWithFormat:@"%li",(long)item.homeScore];
            sClubScoreLabel.text= [NSString stringWithFormat:@"%li",(long)item.awayScore];
            [matchStatusLbl setBackgroundColor:[UIColor mainAppDarkGrayColor]];
            [matchStatusLbl setTextColor:[UIColor mainAppYellowColor]];
            
        }
        if(matchStatusItem.matchStatusIndicatorId == MatchLiveIndicatorID)
        {
            [matchStatusLbl setText:@"مباشر"];
            [matchStatusIndicator setHidden:NO];
            [matchStatusIndicator setText:matchStatusItem.matchStatusName];
            [matchStatusLbl setBackgroundColor:[UIColor redColor]];
            [matchStatusLbl setTextColor:[UIColor whiteColor]];
        }
        else
        {
            [matchStatusIndicator setHidden:YES];
            
        }
        
        if(item.homePenaltyScore !=0 || item.awayPenaltyScore != 0)
        {
            fClubScoreLabel.text= [fClubScoreLabel.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",item.homePenaltyScore==-1?@"":[NSString stringWithFormat:@"(%li)",(long)item.homePenaltyScore ]]];
            
            sClubScoreLabel.text= [sClubScoreLabel.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",item.awayPenaltyScore==-1?@"":[NSString stringWithFormat:@"(%li)",(long)item.awayPenaltyScore ]]];
        }
        
        
        
        
    }
    
    matchDateLabel.text=item.time;
    //statisticsBtn.tag = item.idField;
    homeClubBtn.titleLabel.text = item.homeTeamName;
    homeClubBtn.tag = item.homeTeamId;
    
    awayClubBtn.titleLabel.text = item.awayTeamName;
    awayClubBtn.tag = item.awayTeamId;
    predictBtn.layer.cornerRadius = 15;
    predictBtn.clipsToBounds = YES;
    predictBtn.layer.borderColor = [[UIColor mainAppYellowColor]CGColor];
    predictBtn.layer.borderWidth = 1.0;
    statisticsBtn.hidden = YES;
    predictBtn.hidden = YES;
    if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]){
        [statisticsBtn setHidden:NO];
    }
   if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]&&item.matchStatusHistory.count>0&&[[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
        [predictBtn setHidden:NO];
    }
    else{
        [predictBtn setHidden:YES];

    }
    return cell;
    
}

- (IBAction)homeTeamBtnPressed:(UIButton*)sender {
//    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    UINavigationController * navigationController = [appDelegate getSelectedNavigationController];
//    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
//    teamProfile.teamId = (int)sender.tag;
//    teamProfile.teamName = sender.titleLabel.text;
//    [navigationController pushViewController:teamProfile animated:YES];
}

- (IBAction)awayTeamBtnPressed:(UIButton*)sender {
//    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
//    UINavigationController * navigationController = [appDelegate getSelectedNavigationController];
//    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
//    teamProfile.teamId = (int)sender.tag;
//    teamProfile.teamName = sender.titleLabel.text;
//    [navigationController pushViewController:teamProfile animated:YES];
}

\
@end
