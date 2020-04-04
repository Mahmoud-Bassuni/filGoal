//
//  MatchFormulationTabViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/7/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//
@import Firebase;
#import "MatchFormulationTabViewController.h"
#import "MatchSquadWithEvents.h"
#import "LineUpCellLoader.h"
#import "MatchTeamsSquad.h"
#import "PlaygroundWithPlayersViewController.h"
#import "UIImageView+WebCache.h"
#define Padding  285
#define PlayerWidth  20
#define PlayerHeight  25


@interface MatchFormulationTabViewController ()
{
    JDFTooltipView *tooltip ;
    JDFTooltipView * teamBTooltip ;
    JDFTooltipView * firstGoalTooltip ;
    JDFTooltipView * secGoalTooltip ;
    JDFTooltipView * firstSpearTooltip ;
    JDFTooltipView * secSpearTooltip ;
    
    
}
@end

@implementation MatchFormulationTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = [NSString stringWithFormat:@"iOS-Match center-Formation with match ID = %li",(long)self.matchDetails.idField];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-Match center-Formation with match ID = %li",(long)self.matchDetails.idField]
                                     }];
    self.awayTeamSquad=[[NSMutableArray alloc]init];
    self.homeTeamSquad=[[NSMutableArray alloc]init];
    self.awaySpareTeamSquad=[[NSMutableArray alloc]init];
    self.homeSpareTeamSquad=[[NSMutableArray alloc]init];
    
    if(self.matchEvents!=nil)
    {
        MatchSquadWithEvents* matchTeamsSquads=[[MatchSquadWithEvents alloc]initwithMatchSquad:self.matchTeamsSquads andMatchEvents:self.matchEvents andHomeTeamID:self.matchDetails.homeTeamId andAwayTeamID:self.matchDetails.awayTeamId];
        self.homeTeamSquad=matchTeamsSquads.homeTeamSquad;
        self.awayTeamSquad=matchTeamsSquads.awayTeamSquad;
        self.homeSpareTeamSquad=matchTeamsSquads.homeSpareTeamSquad;
        self.awaySpareTeamSquad=matchTeamsSquads.awaySpareTeamSquad;
        //  self.matchTeamsSquads=matchTeamsSquads.matchSquadsWithEvents;
        self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner",@"Match",[NSString stringWithFormat:@"فريق %@",self.matchDetails.homeTeamName],[NSString stringWithFormat:@"فريق %@",self.matchDetails.awayTeamName],[NSString stringWithFormat:@"بطولة %@",self.matchDetails.championshipName],[NSString stringWithFormat:@"مباراة %@ و%@",self.matchDetails.homeTeamName,self.matchDetails.awayTeamName]] andPosition:@[@"Pos1"] andScreenName:[NSString stringWithFormat:@"iOS-Match center-Formation with match ID = %li",(long)self.matchDetails.idField]];

        
        if(self.awayTeamSquad.count==0&&self.homeTeamSquad.count==0)
        {
            [self.loadingLbl setHidden:NO];
            //self.tableView.tableFooterView= [super setBannerViewFooter:@[@"Inner"] andPosition:@[@"Pos1"]];
//            UIView * bannerAdView=[[UIView alloc]initWithFrame:CGRectMake(0, self.loadingLbl.frame.origin.y+self.loadingLbl.frame.size.height,Screenwidth,400 )];
//            [bannerAdView addSubview:[super setBannerViewFooter]];
//            [self.view addSubview:bannerAdView];
        }
        else
        {
            [self.loadingLbl setHidden:YES];
           // self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner"] andPosition:@[@"Pos1"]];


        [self.tableView reloadData];
        }
        
        
    }
    // set formulation header
    [self.homeTeamLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)_matchDetails.homeTeamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    [self.awayTeamLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)_matchDetails.awayTeamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    // NSLog(@"%@",self.matchDetails.awayTeamFormationName);
    [self.awayTeamFormlutionTypeLbl setText:self.matchDetails.awayTeamFormationName];
    [self.homeTeamFormlutionTypeLbl setText:self.matchDetails.homeTeamFormationName];

    
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.frame=CGRectMake(0, 40, Screenwidth, self.tableView.frame.size.height);
    [self.loadingLbl setFrame: CGRectMake(40, 0, Screenwidth-80, self.loadingLbl.frame.size.height)];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.homeSpareTeamSquad.count>0&&self.homeTeamSquad.count>1)
        return 3;
    else if(self.homeSpareTeamSquad.count==0&&self.homeTeamSquad.count>1)
        return 2;
    else
        return 0;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 1;
    else if(section==1)
        return self.homeTeamSquad.count;
    else if(section==2)
    {
        if(self.awaySpareTeamSquad.count<self.homeSpareTeamSquad.count)
            return self.homeSpareTeamSquad.count;
        else if(self.awaySpareTeamSquad.count>self.homeSpareTeamSquad.count)
            return self.awaySpareTeamSquad.count;
        else if(self.awaySpareTeamSquad.count==self.homeSpareTeamSquad.count)
            return self.homeSpareTeamSquad.count;
        
        if(self.awayTeamSquad.count<self.homeTeamSquad.count)
            return self.homeTeamSquad.count;
        else if(self.awayTeamSquad.count>self.homeTeamSquad.count)
            return self.awayTeamSquad.count;
        else
            return self.homeTeamSquad.count;
        
    }
    else
        return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier ;
    MatchTeamsSquad * homePlayerItem;
    MatchTeamsSquad * awayPlayerItem;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    if(indexPath.section==0)
    {
        cellIdentifier=@"PlaygroundCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        PlaygroundWithPlayersViewController * plagroundView=[[PlaygroundWithPlayersViewController alloc]init];
        
        
        if(self.matchDetails.awayTeamFormationName!=nil)
        {
            plagroundView.matchDetails=self.matchDetails;
            plagroundView.homeTeamSquad=self.homeTeamSquad;
            plagroundView.awayTeamSquad=self.awayTeamSquad;
        }
        [plagroundView.view setFrame:CGRectMake(0, 0, plagroundView.view.frame.size.width-10, 150)];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
            // [cell.contentView addSubview:plagroundView.view];
            // [plagroundView.view setUserInteractionEnabled:YES];
            // [cell.contentView setUserInteractionEnabled:NO];
            [cell addSubview:plagroundView.view];
            [plagroundView didMoveToParentViewController:self];
           // [plagroundView.firstTeamGoalBtn addTarget:self action:@selector(firstTeamGoalBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
           // [plagroundView.secTeamGoalBtn addTarget:self action:@selector(secTeamGoalBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            if(self.matchDetails.homeTeamFormationName!=nil)
            {
                [self setTeamAFormulation:self.matchDetails.homeTeamFormationName andPlayground:plagroundView];
            }
            if(self.matchDetails.awayTeamFormationName!=nil)
            {
                [self setTeamBFormulation:self.matchDetails.awayTeamFormationName andPlayground:plagroundView];
            }
            
            
            
        }
        
        //[plagroundView.view setUserInteractionEnabled:YES];
        // [cell setUserInteractionEnabled:false];
        //[cell.contentView setUserInteractionEnabled:false];
        
        return cell;
        
    }
    if(indexPath.section==1)
    {    if(indexPath.row<_homeTeamSquad.count)
        homePlayerItem=[self.homeTeamSquad objectAtIndex:indexPath.row];
        if(indexPath.row<_awayTeamSquad.count)
        awayPlayerItem=[self.awayTeamSquad objectAtIndex:indexPath.row];
    }
    else if (indexPath.section==2)
    {
        if(indexPath.row<_homeSpareTeamSquad.count)
            homePlayerItem=[self.homeSpareTeamSquad objectAtIndex:indexPath.row];
        if(indexPath.row<_awaySpareTeamSquad.count)
            awayPlayerItem=[self.awaySpareTeamSquad objectAtIndex:indexPath.row];
    }
    return   [LineUpCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withline1:homePlayerItem withline2:awayPlayerItem];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
        return self.formulationHeaderView.frame.size.height+10;
    else
        return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return 170;
    
    return 60;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]init];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(8, 0, Screenwidth-15, 25)];
    [title setBackgroundColor:[UIColor clearColor]];
    UIImageView *img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matche_event_title"]];
    [img setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:10]];
    [title setTextColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
    if(section==0)
    {
        if(IS_IPHONE_6_PLUS||IS_IPHONE_6)
         self.formulationHeaderView.frame=CGRectMake(80,5, 215, 29);
        else
            self.formulationHeaderView.frame=CGRectMake(60,5, 215, 29);

        [headerView setBackgroundColor:[UIColor whiteColor]];
        [headerView addSubview:self.formulationHeaderView];
        // [headerView addSubview:self.formulationHeaderView];
      //  return _formulationHeaderView;
    }
    else if(section==1)
    {
        title.text=@"التشكيل الأساسي";
        [headerView addSubview:img];
        [headerView addSubview:title];
    }
    else
    {
        title.text=@"البدلاء";
        [headerView addSubview:img];
        [headerView addSubview:title];
    }
    
    return headerView;
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}
-(void)setTeamAFormulation:(NSString*)formulationType andPlayground:(PlaygroundWithPlayersViewController*)playgroundView
{
    NSArray * list=[formulationType componentsSeparatedByString:@"-"];
    NSInteger attackPlayersFormulationNumber=[[list objectAtIndex:2]integerValue];
    NSInteger centerPlayersFormulationNumber=[[list objectAtIndex:1]integerValue];
    NSInteger defenderPlayersFormulationNumber=[[list objectAtIndex:0]integerValue];
    NSInteger  attackPlayer=0;
    if(list.count==4)
    {
    attackPlayer =[[list objectAtIndex:3]integerValue];
        [playgroundView.firstTeamSpearHeadView setHidden:NO];
        MatchTeamsSquad * item;
        if(centerPlayersFormulationNumber+defenderPlayersFormulationNumber+attackPlayersFormulationNumber+attackPlayer<self.homeTeamSquad.count)
            item=[self.homeTeamSquad objectAtIndex:centerPlayersFormulationNumber+defenderPlayersFormulationNumber+attackPlayersFormulationNumber+attackPlayer];
        [playgroundView.firstSpearBtn setTag:centerPlayersFormulationNumber+defenderPlayersFormulationNumber+attackPlayersFormulationNumber ];
        [playgroundView.firstSpearBtn setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        attackPlayer=1;
        
    }
    int x=0;
    int y=0;
    int x1=0;
    int y1=0;
    int x3=0;
    int y3=0;
    if(centerPlayersFormulationNumber<4)
    {
        y1=15;
    }
    if(defenderPlayersFormulationNumber<4)
    {
        y=15;
    }
    if (attackPlayersFormulationNumber<4)
    {
        y3=15;
    }
    if(self.homeTeamSquad.count>0)

    [playgroundView.firstTeamGoalBtn setTitle:[NSString stringWithFormat:@"%li",(long)[(MatchTeamsSquad*)[self.homeTeamSquad objectAtIndex:0]shirtNumber]] forState:UIControlStateNormal];
    for(int i=1;i<=defenderPlayersFormulationNumber;i++)
    {
        MatchTeamsSquad * item;
        if(i<self.homeTeamSquad.count)
            item=[self.homeTeamSquad objectAtIndex:i];
        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x, y, PlayerWidth, PlayerHeight)];
        [teamAGoalPlayer setTag:i];
        //[teamAGoalPlayer addTarget:self action:@selector(showPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:10.0];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-l"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [teamAGoalPlayer setUserInteractionEnabled:YES];
        [playgroundView.firstTeamDefenderView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer bringSubviewToFront:playgroundView.firstTeamDefenderView];

        x=x+3;
        y=y+22;
    }
    
    for(int i=defenderPlayersFormulationNumber+1;i<=centerPlayersFormulationNumber+defenderPlayersFormulationNumber;i++)
    {
        MatchTeamsSquad * item;
        if(i<self.homeTeamSquad.count)
        item=[self.homeTeamSquad objectAtIndex:i];
        
        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x1, y1, PlayerWidth, PlayerHeight)];
        [teamAGoalPlayer setTag:i];
      //  [teamAGoalPlayer addTarget:self action:@selector(showPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-l"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [playgroundView.firstTeamCenterView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer setUserInteractionEnabled:YES];
        [teamAGoalPlayer bringSubviewToFront:playgroundView.firstTeamCenterView];

        
        x1=x1+2;
        y1=y1+22;
    }
    if(attackPlayersFormulationNumber==1)
    {
        [playgroundView.firstTeamSpearHeadView setHidden:NO];
        MatchTeamsSquad * item;
        if(centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1<self.homeTeamSquad.count)
       item=[self.homeTeamSquad objectAtIndex:centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1];
        [playgroundView.firstSpearBtn setTag:centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1 ];
        [playgroundView.firstSpearBtn setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
       // [playgroundView.firstSpearBtn addTarget:self action:@selector(firstSpearBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        for(int i=centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1;i<self.homeTeamSquad.count-attackPlayer;i++)
        {
            MatchTeamsSquad * item;
            if(i<self.homeTeamSquad.count)
                item=[self.homeTeamSquad objectAtIndex:i];
            
            UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x3, y3, PlayerWidth, PlayerHeight)];
            [teamAGoalPlayer setTag:i];
           // [teamAGoalPlayer addTarget:self action:@selector(showPopUp:) forControlEvents:UIControlEventTouchUpInside];
            [teamAGoalPlayer setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:10.0];
            [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
            // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
            [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-l"] forState:UIControlStateNormal];
            [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
            [playgroundView.firstTeamAttackView addSubview:teamAGoalPlayer];
            [teamAGoalPlayer setUserInteractionEnabled:YES];
            [teamAGoalPlayer bringSubviewToFront:playgroundView.firstTeamAttackView];

            
            x3=x3+1;
            y3=y3+22;
        }
    }
    
    
    
    
}


-(void)setTeamBFormulation:(NSString*)formulationType andPlayground:(PlaygroundWithPlayersViewController*)playgroundView
{
    NSArray * list=[formulationType componentsSeparatedByString:@"-"];
    NSInteger attackPlayersFormulationNumber=[[list objectAtIndex:2]integerValue];
    NSInteger centerPlayersFormulationNumber=[[list objectAtIndex:1]integerValue];
    NSInteger defenderPlayersFormulationNumber=[[list objectAtIndex:0]integerValue];
    int x=0;
    int y=0;
    int x1=0;
    int y1=0;
    int x3=0;
    int y3=0;
    if(self.awayTeamSquad.count>0)
    [playgroundView.secTeamGoalBtn setTitle:[NSString stringWithFormat:@"%li",(long)[(MatchTeamsSquad*)[self.awayTeamSquad objectAtIndex:0]shirtNumber]] forState:UIControlStateNormal];
    if(defenderPlayersFormulationNumber<4)
    {
        y=15;
    }
    
    if(centerPlayersFormulationNumber<4)
    {
        y1=15;

    }

    if (attackPlayersFormulationNumber<4)
    {
        y3=15;

    }
    NSInteger  attackPlayer=0;
    if(list.count==4)
    {
        attackPlayer =[[list objectAtIndex:3]integerValue];
        [playgroundView.secTeamSpearHeadView setHidden:NO];
        MatchTeamsSquad * item;
        if(self.awayTeamSquad.count>0)
            item=[self.awayTeamSquad lastObject];
        [playgroundView.secSpearBtn setTag:self.awayTeamSquad.count-1];
        [playgroundView.secSpearBtn setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        attackPlayer=1;
        
    }
    
    for(int i=defenderPlayersFormulationNumber;i>=1;i--)
    {
        MatchTeamsSquad * item;
        if(i<self.awayTeamSquad.count)
        item=[self.awayTeamSquad objectAtIndex:i];
        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x, y, PlayerWidth, PlayerHeight)];
        [teamAGoalPlayer setTag:i];
       // [teamAGoalPlayer addTarget:self action:@selector(showTeamBPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:10.0];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-r"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [teamAGoalPlayer setUserInteractionEnabled:YES];
        [playgroundView.secTeamDefenderView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer bringSubviewToFront:playgroundView.secTeamDefenderView];

        x=x-3;
        y=y+21;
    }
    
    for(int i= centerPlayersFormulationNumber+defenderPlayersFormulationNumber ;i>=defenderPlayersFormulationNumber+1;i--)
    {
        MatchTeamsSquad * item;
        if(i<self.awayTeamSquad.count)
            item=[self.awayTeamSquad objectAtIndex:i];
        UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x1, y1, PlayerWidth, PlayerHeight)];
        [teamAGoalPlayer setTag:i];
       // [teamAGoalPlayer addTarget:self action:@selector(showTeamBPopUp:) forControlEvents:UIControlEventTouchUpInside];
        [teamAGoalPlayer setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:10.0];
        [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-r"] forState:UIControlStateNormal];
        [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
        [playgroundView.secTeamCenterView addSubview:teamAGoalPlayer];
        [teamAGoalPlayer setUserInteractionEnabled:YES];
        [teamAGoalPlayer bringSubviewToFront:playgroundView.secTeamCenterView];

        
        x1=x1-2;
        y1=y1+21;
    }
    if(attackPlayersFormulationNumber==1)
    {
        [playgroundView.secTeamSpearHeadView setHidden:NO];
        MatchTeamsSquad * item;
        if(centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1<self.awayTeamSquad.count)
            item=[self.awayTeamSquad objectAtIndex:centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1];
        
        [playgroundView.secSpearBtn setTag:centerPlayersFormulationNumber+defenderPlayersFormulationNumber+1 ];
        [playgroundView.secSpearBtn setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
        
       // [playgroundView.secSpearBtn addTarget:self action:@selector(secSpearBtnPressed:) forControlEvents:UIControlEventTouchUpInside];

    }
    else
    {
        
        
        for(int i=self.awayTeamSquad.count-attackPlayer-1 ;i>centerPlayersFormulationNumber+defenderPlayersFormulationNumber;i--)
        {
            MatchTeamsSquad * item;
            if(i<self.awayTeamSquad.count)
                item=[self.awayTeamSquad objectAtIndex:i];
            UIButton * teamAGoalPlayer=[[UIButton alloc]initWithFrame:CGRectMake(x3, y3, PlayerWidth, PlayerHeight)];
            [teamAGoalPlayer setTag:i];
           // [teamAGoalPlayer addTarget:self action:@selector(showTeamBPopUp:) forControlEvents:UIControlEventTouchUpInside];
            [teamAGoalPlayer setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            teamAGoalPlayer.titleLabel.font=[UIFont systemFontOfSize:10.0];
            [teamAGoalPlayer setTitle:[NSString stringWithFormat:@"%li",(long)item.shirtNumber] forState:UIControlStateNormal];
            // [teamAGoalPlayer setImage:[UIImage imageNamed:@"shirt"] forState:UIControlStateNormal];
            [teamAGoalPlayer setBackgroundImage:[UIImage imageNamed:@"player-r"] forState:UIControlStateNormal];
            [teamAGoalPlayer setBackgroundColor:[UIColor clearColor]];
            [playgroundView.secTeamAttackView addSubview:teamAGoalPlayer];
            [teamAGoalPlayer bringSubviewToFront:playgroundView.secTeamAttackView];
            [teamAGoalPlayer setUserInteractionEnabled:YES];
            
            x3=x3-1.5;
            y3=y3+21;
            [teamAGoalPlayer bringSubviewToFront:playgroundView.secTeamAttackView];

        }
    }
    
    
    
}


-(void)showPopUp:(UIButton*)sender
{
    NSLog(@"%@",sender);
   // CGFloat tooltipWidth = 100.0f;
    //NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    CGRect windowRect = [sender convertRect:sender.bounds toView:nil];
    UIView * view=[[UIView alloc]initWithFrame:windowRect];
    if(tooltip.tag==0)
    {
        [teamBTooltip hideAnimated:YES];
        [secGoalTooltip hideAnimated:YES];
        [firstGoalTooltip hideAnimated:YES];
        [firstSpearTooltip hideAnimated:YES];
        [secSpearTooltip hideAnimated:YES];
        teamBTooltip.tag=0;
        tooltip = [[JDFTooltipView alloc] initWithTargetView:view hostView:sender.superview tooltipText:[(MatchTeamsSquad*)[self.homeTeamSquad objectAtIndex:sender.tag]personName] arrowDirection:JDFTooltipViewArrowDirectionDown width:100.0f];
        tooltip.tag=sender.tag;
        [tooltip setDismissOnTouch:YES];
        tooltip. tooltipBackgroundColour=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.97];
        [tooltip show];
      //  [tooltip bringSubviewToFront:sender];
    }
    else
    {
        [tooltip hideAnimated:YES];
        tooltip.tag=0;

        tooltip = [[JDFTooltipView alloc]init];
    }
}
-(void)showTeamBPopUp:(UIButton*)sender
{
    CGRect windowRect = [sender convertRect:sender.bounds toView:nil];
    UIView * view=[[UIView alloc]initWithFrame:windowRect];
    if(teamBTooltip.tag==0)
    {
        [tooltip hideAnimated:YES];
        [secGoalTooltip hideAnimated:YES];
        [firstGoalTooltip hideAnimated:YES];
        [firstSpearTooltip hideAnimated:YES];
        [secSpearTooltip hideAnimated:YES];
        tooltip = [[JDFTooltipView alloc]init];
        teamBTooltip = [[JDFTooltipView alloc] initWithTargetView:view hostView:sender tooltipText:[(MatchTeamsSquad*)[self.awayTeamSquad objectAtIndex:sender.tag]personName] arrowDirection:JDFTooltipViewArrowDirectionDown width:130.0f];
        teamBTooltip.tag=sender.tag;
        [teamBTooltip setDismissOnTouch:YES];
        teamBTooltip. tooltipBackgroundColour=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [teamBTooltip show];
    }
    else
    {
        [teamBTooltip hideAnimated:YES];
        teamBTooltip.tag=0;
        //teamBTooltip = [[JDFTooltipView alloc]init];
    }
}

//Scrolling
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y > 0){
        BOOL scroll= true;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"scrollUpNotification"
         object:userInfo];
        self.formulationHeaderView.frame=CGRectMake(self.tableView.frame.origin.x, 5, Screenwidth, 48);
        self.tableView.frame= CGRectMake(0, 20, Screenwidth,self.tableView.frame.size.height);
        
    }
    if (velocity.y < 0){
        BOOL scroll= false;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
        if(scrollView.contentOffset.y<=0)
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"scrollDownNotification"
         object:userInfo];
        self.tableView.frame= CGRectMake(0, 20, Screenwidth,self.tableView.frame.size.height);
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        [teamBTooltip hideAnimated:YES];
        [tooltip hideAnimated:YES];
        [secGoalTooltip hideAnimated:YES];
        [firstGoalTooltip hideAnimated:YES];
        [firstSpearTooltip hideAnimated:YES];
        [secSpearTooltip hideAnimated:YES];
        
        
        
    }
}
- (IBAction)firstTeamGoalBtnPressed:(UIButton*)sender
{
    CGRect windowRect = [sender convertRect:sender.bounds toView:nil];
    UIView * view=[[UIView alloc]initWithFrame:windowRect];
    if(firstGoalTooltip.tag==0)
    {
        [teamBTooltip hideAnimated:YES];
        [tooltip hideAnimated:YES];
        [secGoalTooltip hideAnimated:YES];
        [firstSpearTooltip hideAnimated:YES];
        [secSpearTooltip hideAnimated:YES];
        
        MatchTeamsSquad* homeGoalPlayerItem=[self.homeTeamSquad objectAtIndex:0];
        
        firstGoalTooltip = [[JDFTooltipView alloc] initWithTargetView:view hostView:sender tooltipText: homeGoalPlayerItem.personName arrowDirection:JDFTooltipViewArrowDirectionDown width:130.0f];
        firstGoalTooltip.tag=sender.tag;
        [firstGoalTooltip setDismissOnTouch:YES];
        firstGoalTooltip. tooltipBackgroundColour=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [firstGoalTooltip show];
    }
    else
    {
        [firstGoalTooltip hideAnimated:YES];
        firstGoalTooltip.tag=0;
        //teamBTooltip = [[JDFTooltipView alloc]init];
    }
    
}
- (IBAction)secTeamGoalBtnPressed:(UIButton*)sender
{
    CGRect windowRect = [sender convertRect:sender.bounds toView:nil];
    UIView * view=[[UIView alloc]initWithFrame:windowRect];
    if(secGoalTooltip.tag==0)
    {
        [teamBTooltip hideAnimated:YES];
        [tooltip hideAnimated:YES];
        [firstGoalTooltip hideAnimated:YES];
        [firstSpearTooltip hideAnimated:YES];
        [secSpearTooltip hideAnimated:YES];
        MatchTeamsSquad* awayGoalPlayerItem=[self.awayTeamSquad objectAtIndex:0];
        
        secGoalTooltip = [[JDFTooltipView alloc] initWithTargetView:view hostView:sender tooltipText: awayGoalPlayerItem.personName arrowDirection:JDFTooltipViewArrowDirectionDown width:130.0f];
        secGoalTooltip.tag=sender.tag;
        [secGoalTooltip setDismissOnTouch:YES];
        secGoalTooltip. tooltipBackgroundColour=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [secGoalTooltip show];
    }
    else
    {
        [secGoalTooltip hideAnimated:YES];
        secGoalTooltip.tag=0;
        //teamBTooltip = [[JDFTooltipView alloc]init];
    }
}
-(IBAction)firstSpearBtnPressed:(UIButton*)sender
{
    CGRect windowRect = [sender convertRect:sender.bounds toView:nil];
    UIView * view=[[UIView alloc]initWithFrame:windowRect];
    if(firstSpearTooltip.tag==0&&sender.tag<self.homeTeamSquad.count)
    {
        [teamBTooltip hideAnimated:YES];
        [tooltip hideAnimated:YES];
        [secGoalTooltip hideAnimated:YES];
        [firstGoalTooltip hideAnimated:YES];
        [secSpearTooltip hideAnimated:YES];
        
        MatchTeamsSquad* homeSpearPlayerItem=[self.homeTeamSquad objectAtIndex:sender.tag];
        
        firstSpearTooltip = [[JDFTooltipView alloc] initWithTargetView:view hostView:sender tooltipText: homeSpearPlayerItem.personName arrowDirection:JDFTooltipViewArrowDirectionDown width:130.0f];
        firstSpearTooltip.tag=sender.tag;
        [firstSpearTooltip setDismissOnTouch:YES];
        firstSpearTooltip. tooltipBackgroundColour=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [firstSpearTooltip show];
    }
    else
    {
        [firstSpearTooltip hideAnimated:YES];
        firstSpearTooltip.tag=0;
        //teamBTooltip = [[JDFTooltipView alloc]init];
    }
}

-(IBAction)secSpearBtnPressed:(UIButton*)sender
{
    CGRect windowRect = [sender convertRect:sender.bounds toView:nil];
    UIView * view=[[UIView alloc]initWithFrame:windowRect];
    if(secSpearTooltip.tag==0&&sender.tag<self.awayTeamSquad.count)
    {
        [teamBTooltip hideAnimated:YES];
        [tooltip hideAnimated:YES];
        [secGoalTooltip hideAnimated:YES];
        [firstGoalTooltip hideAnimated:YES];
        [firstSpearTooltip hideAnimated:YES];
        
        MatchTeamsSquad* homeSpearPlayerItem=[self.awayTeamSquad objectAtIndex:sender.tag];
        
        secSpearTooltip = [[JDFTooltipView alloc] initWithTargetView:view hostView:sender tooltipText: homeSpearPlayerItem.personName arrowDirection:JDFTooltipViewArrowDirectionDown width:130.0f];
        secSpearTooltip.tag=sender.tag;
        [secSpearTooltip setDismissOnTouch:YES];
        secSpearTooltip. tooltipBackgroundColour=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [secSpearTooltip show];
    }
    else
    {
        [secSpearTooltip hideAnimated:YES];
        secSpearTooltip.tag=0;
        //teamBTooltip = [[JDFTooltipView alloc]init];
    }
}


#pragma mark GADBanner Delegate implementation
- (void)adView:(DFPBannerView *)banner didFailToReceiveAdWithError:(GADRequestError *)error
{
    //  [self.errorLbl setText:[NSString stringWithFormat:@"%@",error]];
    
}
- (void)adViewDidReceiveAd:(DFPBannerView *)bannerView
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
