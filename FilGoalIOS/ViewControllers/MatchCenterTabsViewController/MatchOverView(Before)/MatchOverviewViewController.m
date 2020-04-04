//
//  MatchOverviewViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchOverviewViewController.h"
#import "WServicesManager.h"
#import "MatchOverview.h"
#import "FirstTeamHeighestScore.h"
#import "PlayersStatistic.h"
#import "FirstTeamHeighestScore.h"
#import "WinsComparison.h"
#import "PieChartsForWinsComparsionViewController.h"
#import "TeamsHighestScoreViewController.h"
#import "FirstTeamHeighestScore.h"
#import "PlayerStatisticsCell.h"
#import "PlayersStatistic.h"
#import "UIImageView+WebCache.h"
#import "MatchesList.h"
#import "Standing.h"
#import "StandingsCell.h"
#import "MatchCenterDetails.h"
#import "PreviousMatchTableViewCell.h"
#import "MatchStatistic.h"
#import "TeamStatisticsBarChartCell.h"
#import "ChampionshipTeamsMatchesStatistic.h"
#import "MatchCenterTabsViewController.h"
#import "MatchEventTabViewController.h"
@import Firebase;
@interface MatchOverviewViewController ()
{
    NSArray * championshipTeamsMatchesStatistics;
    NSMutableArray * playersStatistics;
    NSMutableArray * sections;
    NSArray * headerTitles;
    NSMutableArray * highestScoresList;
    NSMutableArray * teamStandings;
    MatchOverview * matchOverviewObj;
    NSArray * previousMatches;
    NSMutableArray * otherPlayerStatisticList;
    
}
@end

@implementation MatchOverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = [NSString stringWithFormat:@"iOS-Match center-Overview with match ID = %li",(long)self.matchItem.idField ];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-Match center-Overview with match ID = %li",(long)self.matchItem.idField ]
                                     }];
    // Do any additional setup after loading the view from its nib.
    sections=[[NSMutableArray alloc]init];
    headerTitles=[[NSArray alloc]initWithObjects:@"نسبة الفوز بين الفريقين",@"أعلى نتيجة في مواجهات الفريقين",@"ترتيب الفرقتين",@"احصائيات الفريقين في البطولة",@"اللقاءات السابقة بين الفريقين",@"احصاىيات اللاعبين", nil];

    self.loadingLbl.hidden=NO;
    [self.activityIndicator startAnimating];
    [self loadMatchOverviewDetails];
    
    self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner",@"Match",[NSString stringWithFormat:@"فريق %@",self.matchItem.homeTeamName],[NSString stringWithFormat:@"فريق %@",self.matchItem.awayTeamName],[NSString stringWithFormat:@"بطولة %@",self.matchItem.championshipName],[NSString stringWithFormat:@"مباراة %@ و%@",self.matchItem.homeTeamName,self.matchItem.awayTeamName]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS-Match center-Overview with match ID = %li",(long)self.matchItem.idField ]];
    // [self.tableView.tableFooterView addSubview:[self setBannerViewFooter]];
    [self setscreenSponsor];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tableView.frame=CGRectMake(0, 10, Screenwidth, self.tableView.frame.size.height);
    [self.activityIndicator setFrame: CGRectMake((Screenwidth/2)-20, 10, _activityIndicator.frame.size.width, _activityIndicator.frame.size.height)];
    [self.loadingLbl setFrame: CGRectMake(40, 20, Screenwidth-80, self.loadingLbl.frame.size.height)];
    
    
}
-(void)setscreenSponsor{
    if(self.matchItem.championshipId !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.matchItem.championshipId])
    {
        NSString * sponsorUrl=[AppSponsors getMatchDetailsTabsSponsorImagePathUsingChampionId:self.matchItem.championshipId];
        self.sponsorImgView.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.matchItem.championshipId category:@"Matches"];
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgViewHeightConstraint.constant=image.size.height;
            
        }];
    }
    else
    {
        self.sponsorImgViewHeightConstraint.constant=0;
    }
}
-(void) updateArray :(UIRefreshControl *)sender {
    sections=[[NSMutableArray alloc]init];
    [self loadMatchOverviewDetails];
    
}


-(void)loadMatchOverviewDetails
{
    highestScoresList=[[NSMutableArray alloc]init];
    sections=[[NSMutableArray alloc]init];
    playersStatistics=[[NSMutableArray alloc]init];
    previousMatches=[[NSArray alloc]init];
    teamStandings=[[NSMutableArray alloc]init];
    otherPlayerStatisticList=[[NSMutableArray alloc]init];
    matchOverviewObj=[[MatchOverview alloc]init];
    championshipTeamsMatchesStatistics=[[NSArray alloc]init];
    [self getCompareMatchesAPI];
    
    
}
-(void)getMatchesAPI
{
    NSString * secURL = [NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[formatter dateFromString:self.matchItem.dateStr]];
    [components setDay:[components day]];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSDate *newDate = [gregorian dateFromComponents:components];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * date=[outputFormatter stringFromDate:newDate];
    NSDictionary * secParameters=[[NSDictionary alloc]initWithObjects:@[@"MatchStatusHistory($orderby=StartAt desc)",[NSString stringWithFormat:@"((HomeTeamId eq %ld and AwayTeamId eq %ld)or(HomeTeamId eq %d and AwayTeamId eq %d)) and Date le %@&$top=4",(long)self.matchItem.homeTeamId,(long)self.matchItem.awayTeamId,self.matchItem.awayTeamId,self.matchItem.homeTeamId, date],@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id"] forKeys:@[@"$expand",@"$filter",@"$select"]];
    
    [WServicesManager getDataWithURLString:secURL andParameters:secParameters WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(MatchesList * matches) {
        previousMatches=matches.matches;
        championshipTeamsMatchesStatistics=  matchOverviewObj.championshipTeamsMatchesStatistics;
        //championshipTeamsMatchesStatistics=self.matchStatistics;
        [teamStandings insertObject:[[Standing alloc]init] atIndex:0];
        [teamStandings addObjectsFromArray:matchOverviewObj.standings];
        playersStatistics = (NSMutableArray*) matchOverviewObj.playersStatistics;
        if(teamStandings.count>0)
            [sections addObject:teamStandings];
        if(playersStatistics.count>0)
            [sections addObject:playersStatistics];
        if(previousMatches.count>0)
            [sections addObject:previousMatches];
//        if(matchOverviewObj.winsComparison !=NULL)
//            [sections addObject:matchOverviewObj.winsComparison];
//        if(matchOverviewObj.firstTeamHeighestScore!=NULL)
//            [highestScoresList addObject:matchOverviewObj.firstTeamHeighestScore];
//        if(matchOverviewObj.secondTeamHeighestScore!=NULL)
//            [highestScoresList addObject:matchOverviewObj.secondTeamHeighestScore];
//        if(highestScoresList.count>0)
//            [sections addObject:highestScoresList];
        
        if(championshipTeamsMatchesStatistics.count>0)
            [sections addObject:championshipTeamsMatchesStatistics];
        
        // To remove analy player statistics record from array Incase of any player iD =0
        for(int i=0;i<playersStatistics.count;i++)
        {
            PlayersStatistic * player=[playersStatistics objectAtIndex:i];
            if(player.firstPersonId!=0&&player.firstPersonId!=0)
            {
                [otherPlayerStatisticList addObject:player];
            }
        }
        self.loadingLbl.hidden=YES;
        [self.activityIndicator stopAnimating];
        [self.tableView reloadData];
        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Overview with ID = %li ",(long)self.matchItem.idField]  ApiError:@"Success"];
        
    } failure:^(NSError *error) {
        [self.activityIndicator stopAnimating];
        IBGLog(@"Matches Error  : %@",error);
        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Overview with ID = %li ",(long)self.matchItem.idField] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
        [self showDefaultNetworkingErrorMessageForError:error
                                         refreshHandler:^{
                                             [self getMatchesAPI];
                                         }];
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
    }];

}
-(void)getCompareMatchesAPI
{
    NSString * firstURL =[NSString stringWithFormat:CompareMatchesAPI,[WServicesManager getSportsEngineApiBaseURL],[NSString stringWithFormat:@"%li" ,(long)self.matchItem.idField] ];
    NSDictionary * firstParameters=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%li" ,(long)self.matchItem.idField]] forKeys:@[@"matchId"]];

    [WServicesManager getDataWithURLString:firstURL andParameters:firstParameters WithObjectName:@"MatchOverview" andAuthenticationType:SportesEngineAPIs success:^(MatchOverview * matchOverview) {
        matchOverviewObj=matchOverview;
        [self getMatchesAPI];
    } failure:^(NSError *error) {
        [self.activityIndicator stopAnimating];
        IBGLog(@"Match Overview Error  : %@",error);
        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Overview with ID = %li ",(long)self.matchItem.idField] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
        
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark XLPagerTabStripChildItem
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}
#pragma mark - UITableView DataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, Screenwidth, 40)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
    UILabel * headerTitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, headerView.frame.size.width-20, headerView.frame.size.height)];
    [headerTitleLbl setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:13.0]];
    if([[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[Standing class]]&&[(NSArray*)[sections objectAtIndex:section]count]>1)
    {
        Standing * item=[(NSArray*)[sections objectAtIndex:section]objectAtIndex:1];
        if(item.groupName!=nil&&![item.groupName isEqualToString:@""])
            [headerTitleLbl setText:[NSString stringWithFormat:@"%@ %@ %@ ",@"ترتيب الفريقين",@"في",item.groupName]];
        else  if(item.roundName!=nil&&![item.roundName isEqualToString:@""])
            
            [headerTitleLbl setText:[NSString stringWithFormat:@"%@ %@ %@ ",@"ترتيب الفريقين",@"في",item.roundName]];
        else
            [headerTitleLbl setText:@"ترتيب الفريقين"];
        
        
        
    }
    
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[MatchCenterDetails class]])
    {
        [headerTitleLbl setText:@"اللقاءات السابقة بين الفريقين"];
        
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[ChampionshipTeamsMatchesStatistic class]])
    {
        [headerTitleLbl setText:@"احصائيات الفريقين في البطولة"];
        
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[PlayersStatistic class]])
    {
        [headerTitleLbl setText:@"احصائيات اللاعبين"];
        
    }
    else
        [headerTitleLbl setText:[headerTitles objectAtIndex:section]];
    [headerTitleLbl setTextAlignment:NSTextAlignmentRight];
    [headerView addSubview:headerTitleLbl];

    return headerView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier ;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    if([[sections objectAtIndex:indexPath.section]isKindOfClass:[WinsComparison class]])
    {
        cellIdentifier=@"WinComparsionCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
        PieChartsForWinsComparsionViewController * circleChartsView=[[PieChartsForWinsComparsionViewController alloc]init];
        circleChartsView.matchItem=self.matchItem;
        circleChartsView.winComparsion=[sections objectAtIndex:indexPath.section];
        [circleChartsView.view setFrame:CGRectMake(0, 0, Screenwidth, 760)];
        [cell.contentView addSubview:circleChartsView.view];
        
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[FirstTeamHeighestScore class]])
    {
        cellIdentifier=@"HighestScoreCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
            
        }
        
        TeamsHighestScoreViewController * highestScoreView=[[TeamsHighestScoreViewController alloc]init];
        FirstTeamHeighestScore * firstHighestScore= [highestScoresList objectAtIndex:indexPath.row];
        if(indexPath.row==0)
        {
            highestScoreView.firstMatchItemViewBackgrounColor=[UIColor colorWithRed:0.32 green:0.60 blue:0.42 alpha:1.0];
            highestScoreView.scoreColor=[UIColor orangeColor];
            
        }
        else
        {
            highestScoreView.firstMatchItemViewBackgrounColor=[UIColor colorWithRed:0.95 green:0.65 blue:0.00 alpha:1.0];;
            highestScoreView.scoreColor=[UIColor whiteColor];
            
        }
        [highestScoreView.homeTeamBtn addTarget:self action:@selector(homeTeamBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [highestScoreView.awayTeamBtn addTarget:self action:@selector(awayTeamBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        highestScoreView.firstHighestScore=firstHighestScore;
        [highestScoreView.view setFrame:CGRectMake(5, 0, self.tableView.frame.size.width-10, 100)];
        [cell.contentView addSubview:highestScoreView.view];
        
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[PlayersStatistic class]])
    {
        cellIdentifier=@"PlayerStatisticsCell";
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PlayerStatisticsCell" owner:self options:nil]objectAtIndex:0];
        PlayersStatistic * playerStatistic=[otherPlayerStatisticList objectAtIndex:indexPath.row];
        [((PlayerStatisticsCell*)cell) initWithPlayerStatistics:playerStatistic andMatchItem:self.matchItem];
        
        
        
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[Standing class]])
    {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
        if(indexPath.row==0)
        {
            cellIdentifier=@"StandingsHeaderCell";
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StandingsHeaderCell" owner:self options:nil]objectAtIndex:0];
            
        }
        else
        {
            
            cellIdentifier=@"StandingsCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StandingsCell" owner:self options:nil]objectAtIndex:0];
            Standing * item=[teamStandings objectAtIndex:indexPath.row];
            [((StandingsCell*)cell) initWithTeamStandingItem:item];
            
        }
    }
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[MatchCenterDetails class]])
    {
        cellIdentifier=@"PreviousMatchTableViewCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PreviousMatchTableViewCell" owner:self options:nil]objectAtIndex:0];
        MatchCenterDetails * item=[previousMatches objectAtIndex:indexPath.row];
        [((PreviousMatchTableViewCell*)cell) initWithMatchItem:item];
        
    }
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[ChampionshipTeamsMatchesStatistic  class]])
    {
        cellIdentifier=@"StatisticsEventCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TeamStatisticsBarChartCell" owner:self options:nil]objectAtIndex:0];
        ChampionshipTeamsMatchesStatistic * item=[championshipTeamsMatchesStatistics objectAtIndex:indexPath.row];
        [((TeamStatisticsBarChartCell*)cell).eventTypeLbl setText:item.matchStatisticsTypeName];
        if(!item.isPercentage)
        {
            [((TeamStatisticsBarChartCell*)cell).homeTeamValueLbl setText:[NSString stringWithFormat:@"%li",(long)item.homeTeamValue]];
            
            [((TeamStatisticsBarChartCell*)cell).awayTeamValueLbl setText:[NSString stringWithFormat:@"%li",(long)item.awayTeamValue]];
        }
        else
        {
            [((TeamStatisticsBarChartCell*)cell).homeTeamValueLbl setText:[NSString stringWithFormat:@"%li %%",(long)item.homeTeamValue]];
            
            [((TeamStatisticsBarChartCell*)cell).awayTeamValueLbl setText:[NSString stringWithFormat:@"%li %%",(long)item.awayTeamValue]];
        }
        
        [((TeamStatisticsBarChartCell*)cell).homeProgressView setProgress:(CGFloat)item.homeTeamValue/10];
        [((TeamStatisticsBarChartCell*)cell).awayProgressView setProgress:(CGFloat)item.awayTeamValue/10];
        
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[sections objectAtIndex:indexPath.section]isKindOfClass:[WinsComparison class]])
    {
        return 760;
    }
    else if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[FirstTeamHeighestScore class]])
    {
        return 100;
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[PlayersStatistic class]])
    {
        return 150;
    }
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[Standing class]])
    {
        if(indexPath.row==0)
            return 33;
        else
            return 67;
    }
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[MatchCenterDetails class]])
    {
        return 112;
    }
    else
        return 48;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[FirstTeamHeighestScore class]])
    {
        return highestScoresList.count;
    }
    else  if( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[PlayersStatistic class]])
    {
        return otherPlayerStatisticList.count;
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[Standing class]])
    {
        // new row for standings header
        return teamStandings.count;
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[MatchCenterDetails class]])
    {
        return previousMatches.count;
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[ChampionshipTeamsMatchesStatistic class]])
    {
        return championshipTeamsMatchesStatistics.count;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[MatchCenterDetails class]])
    {
        MatchCenterDetails * item=[previousMatches objectAtIndex:indexPath.row];
        MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
        matchCenter.matchCenterDetails=item;
        [appDelegate.getSelectedNavigationController pushViewController:matchCenter animated:NO];
        
    }
    if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[Standing class]])
    
    {
        Standing * item=[teamStandings objectAtIndex:indexPath.row];
        TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
        teamProfile.teamId = (int)item.teamId;
        teamProfile.teamName = item.teamName;
        [appDelegate.getSelectedNavigationController pushViewController:teamProfile animated:YES];
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[FirstTeamHeighestScore class]])
    {
        FirstTeamHeighestScore * item=[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        MatchCenterDetails * matchItem=[[MatchCenterDetails alloc]init];
        matchItem.idField=item.matchId;
        matchItem.championshipId=item.championshipId;
        matchItem.championshipName=item.championshipName;
        matchItem.awayTeamId=item.awayTeamId;
        matchItem.homeTeamId=item.homeTeamId;
        // matchItem.date=item.
        MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
        matchCenter.matchCenterDetails=matchItem;
        [appDelegate.getSelectedNavigationController pushViewController:matchCenter animated:NO];
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
        self.tableView.frame= CGRectMake(0, 0, Screenwidth,self.tableView.frame.size.height);
        
    }
    if (velocity.y < 0){
        BOOL scroll= false;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
        if(scrollView.contentOffset.y<=0)
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"scrollDownNotification"
             object:userInfo];
        self.tableView.frame= CGRectMake(0, 0, Screenwidth,self.tableView.frame.size.height);
        
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

- (IBAction)homeTeamBtnAction:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = [appDelegate getSelectedNavigationController];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [navigationController pushViewController:teamProfile animated:YES];
}

- (IBAction)awayTeamBtnAction:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = [appDelegate getSelectedNavigationController];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [navigationController pushViewController:teamProfile animated:YES];
}


@end
