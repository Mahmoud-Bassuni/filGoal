//
//  PlaygroundWithPlayersViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/0/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "PlaygroundWithPlayersViewController.h"

@interface PlaygroundWithPlayersViewController ()

@end

@implementation PlaygroundWithPlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(CGSizeMake(Screenwidth, 190));
    [[UIImage imageNamed:@"staduim.png"] drawInRect:CGRectMake(0, 0, Screenwidth, 190)];
    UIGraphicsEndImageContext();

    if(self.matchDetails.awayTeamFormationName!=nil)
    {
    }
    if(self.matchDetails.homeTeamFormationName!=nil)
    {

    }
    
    [self setscreenSponsor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Set Screen sponsers
-(void)setscreenSponsor{
    if(self.matchDetails.championshipId !=0 && [AppSponsors isChampionCoSponsorActiveUsingId:self.matchDetails.championshipId])
    {
        NSString * sponsorUrl=[AppSponsors getMatchDetailsPlaygroundSponsorImagePathUsingChampionId:self.matchDetails.championshipId];
        self.sponsorImgView.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.matchDetails.championshipId category:@"Matches"];
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
          //  self.sponsorImgViewHeightConstraint.constant=image.size.height;
            self.sponsorImgView.hidden=NO;
          //  self.sponsorImgView.frame.size.height = image.size.height;

        }];
    }
    else
    {
        self.sponsorImgView.hidden=YES;
    }
}
-(void)setTeamAFormulation:(NSString*)formulationType
{
    NSArray * list=[formulationType componentsSeparatedByString:@"-"];
    NSInteger centerPlayersFormulationNumber=[[list objectAtIndex:1]integerValue];
    NSInteger defenderPlayersFormulationNumber=[[list objectAtIndex:0]integerValue];
    int x=0;
    int y=0;
    int x1=0;
    int y1=0;
    int x3=0;
    int y3=0;
    [self.firstTeamGoalBtn setTitle:[NSString stringWithFormat:@"%li",(long)[(MatchTeamsSquad*)[self.homeTeamSquad objectAtIndex:0]shirtNumber]] forState:UIControlStateNormal];
    for(int i=1;i<=defenderPlayersFormulationNumber;i++)
    {
        MatchTeamsSquad * item=[self.homeTeamSquad objectAtIndex:i];
        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x, y, 18, 20)];
        [teamAGoalPlayer setTag:item.shirtNumber];
        [teamAGoalPlayer addTarget:self action:@selector(showPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:11.0];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-l"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [teamAGoalPlayer setUserInteractionEnabled:YES];
        [self.firstTeamDefenderView addSubview:teamAGoalPlayer];
        x=x+1;
        y=y+22;
    }
    
    for(int i=defenderPlayersFormulationNumber+1;i<=centerPlayersFormulationNumber+defenderPlayersFormulationNumber;i++)
    {
        MatchTeamsSquad * item=[self.homeTeamSquad objectAtIndex:i];

        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x1, y1, 18, 20)];
        [teamAGoalPlayer setTag:item.shirtNumber];
        [teamAGoalPlayer addTarget:self action:@selector(showPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:11.0];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-l"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [self.firstTeamCenterView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer setUserInteractionEnabled:YES];

         x1=x1+1;
        y1=y1+22;
    }
    for(int i=centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1;i<self.homeTeamSquad.count;i++)
    {
        MatchTeamsSquad * item=[self.homeTeamSquad objectAtIndex:i];

        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x3, y3, 18, 20)];
        [teamAGoalPlayer setTag:item.shirtNumber];
        [teamAGoalPlayer addTarget:self action:@selector(showPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:11.0];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-l"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [self.firstTeamAttackView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer setUserInteractionEnabled:YES];

        x3=x3+1;
        y3=y3+22;
    }
    
    
    
}


-(void)setTeamBFormulation:(NSString*)formulationType
{
    NSArray * list=[formulationType componentsSeparatedByString:@"-"];
    NSInteger centerPlayersFormulationNumber=[[list objectAtIndex:1]integerValue];
    NSInteger defenderPlayersFormulationNumber=[[list objectAtIndex:0]integerValue];
    int x=0;
    int y=0;
    int x1=0;
    int y1=0;
    int x3=0;
    int y3=0;
    [self.secTeamGoalBtn setTitle:[NSString stringWithFormat:@"%li",(long)[(MatchTeamsSquad*)[self.awayTeamSquad objectAtIndex:0]shirtNumber]] forState:UIControlStateNormal];

    for(int i=1;i<=defenderPlayersFormulationNumber;i++)
    {
        MatchTeamsSquad * item=[self.awayTeamSquad objectAtIndex:i];
        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x, y, 18, 20)];
        [teamAGoalPlayer setTag:i];
        [teamAGoalPlayer addTarget:self action:@selector(showTeamBPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:11.0];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-r"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [self.secTeamDefenderView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer setUserInteractionEnabled:YES];

         x=x-5;
        y=y+22;
    }
    
    for(int i=defenderPlayersFormulationNumber+1;i<=centerPlayersFormulationNumber+defenderPlayersFormulationNumber;i++)
    {
        MatchTeamsSquad * item=[self.awayTeamSquad objectAtIndex:i];

        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x1, y1, 18, 20)];
        [teamAGoalPlayer setTag:i];
        [teamAGoalPlayer addTarget:self action:@selector(showTeamBPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:11.0];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-r"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [self.secTeamCenterView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer setUserInteractionEnabled:YES];

         x1=x1-5;
        y1=y1+22;
    }
    for(int i=centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1;i<self.awayTeamSquad.count;i++)
    {
        MatchTeamsSquad * item=[self.awayTeamSquad objectAtIndex:i];
        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x3, y3, 18, 20)];
        [teamAGoalPlayer setTag:i];
        [teamAGoalPlayer addTarget:self action:@selector(showTeamBPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:11.0];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-r"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [self.secTeamAttackView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer setUserInteractionEnabled:YES];

       x3=x3-5;
        y3=y3+22;
    }
    
    
    
    
}
-(void)showTeamBPopUp:(UIButton*)sender
{
  
}
- (IBAction)firstTeamGoalBtnPressed:(id)sender
{
    
}
- (IBAction)secTeamGoalBtnPressed:(id)sender
{
    
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
