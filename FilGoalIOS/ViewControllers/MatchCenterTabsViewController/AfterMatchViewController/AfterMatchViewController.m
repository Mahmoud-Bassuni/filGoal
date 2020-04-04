//
//  AfterMatchViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "AfterMatchViewController.h"
@import Firebase;
@interface AfterMatchViewController ()
{
    NSArray * championshipTeamsMatchesStatistics;
    NSMutableArray * sections;
    NSArray * headerTitles;
    NSMutableArray * highestScoresList;
    NSMutableArray * teamStandings;
    MatchOverview * matchOverviewObj;
    NSArray * upcommingMatches;
    Album * selectedAlbum ;
}
@end

@implementation AfterMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = [NSString stringWithFormat:@"iOS-Match center-After Match with match ID = %li",(long)self.matchItem.idField ];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-Match center-After Match with match ID = %li",(long)self.matchItem.idField ]
                                     }];
    //    // Do any additional setup after loading the view from its nib.
    upcommingMatches=[[NSArray alloc]init];
    sections=[[NSMutableArray alloc]init];
    highestScoresList=[[NSMutableArray alloc]init];
    self.photos=[[NSMutableArray alloc]init];
    teamStandings=[[NSMutableArray alloc]init];
    matchOverviewObj=[[MatchOverview alloc]init];
    sections=[[NSMutableArray alloc]init];
    self.newsList=[[NSArray alloc]init];
    self.videosList=[[NSArray alloc]init];
    self.albumsList=[[NSArray alloc]init];
    self.loadingLbl.hidden=NO;
    [self.activityIndicator startAnimating];
    // self.matchEventsList=self.matchEvents;
    // self.matchEvents=[[NSArray alloc]init];


    if(self.matchStatusHistory.count>0)
    {
    if([[self.matchStatusHistory objectAtIndex:0]matchStatusId]!=9) // Match not started so we should to hide data
    {
        self.loadingLbl.hidden=NO;
        self.activityIndicator.hidden=YES;
        [self.activityIndicator stopAnimating];
        [self.loadingLbl setText:@"لا يوجد محتوي لهذه المباراة"];
        self.tableView.tableHeaderView = self.loadingLbl;

    }
    else
    {
        [self getEventsWithMatchStatusHistory];  // matchEvents
        [self getNewsAndVideosAndAlbum];
        [self loadAfterMatchDetails];

    }
    }

    self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner",@"Match",[NSString stringWithFormat:@"فريق %@",self.matchItem.homeTeamName],[NSString stringWithFormat:@"فريق %@",self.matchItem.awayTeamName],[NSString stringWithFormat:@"بطولة %@",self.matchItem.championshipName],[NSString stringWithFormat:@"مباراة %@ و%@",self.matchItem.homeTeamName,self.matchItem.awayTeamName]] andPosition:@[@"Pos1"] andScreenName:[NSString stringWithFormat:@"iOS-Match center-After Match with match ID = %li",(long)self.matchItem.idField ]];

    [self setscreenSponsor];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
   // self.tableView.frame=CGRectMake(0, 20, Screenwidth, self.tableView.frame.size.height);
    [self.activityIndicator setFrame: CGRectMake((Screenwidth/2)-20, 10, _activityIndicator.frame.size.width, _activityIndicator.frame.size.height)];
    self.tableView.frame=CGRectMake(0, 0, Screenwidth, self.tableView.frame.size.height);
    [self.loadingLbl setFrame: CGRectMake(40, 0, Screenwidth-80, self.loadingLbl.frame.size.height)];
    [super viewWillAppear:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Set Screen sponsers
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
    
    [self getNewsAndVideosAndAlbum];
    // [self getEventsWithMatchStatusHistory];  // matchEvents
    [self loadAfterMatchDetails];
    [self loadViewSections];
    
    
}

-(void)getNewsListAPI
{
    id parameter=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%li",(long)self.matchItem.idField]] forKeys:@[@"id"]];

    [WServicesManager getDataWithURLString:[NSString stringWithFormat:AfterNewsMatchesAPI,[WServicesManager getApiBaseURL]] andParameters:parameter WithObjectName:@"NewsList" andAuthenticationType:CMSAPIs success:^(NewsList * newsList) {
        if(newsList.news.count>0)
        {
            self.newsList=newsList.news;
            [sections addObject:newsList.news];
        }
    } failure:^(NSError *error) {
        IBGLog(@" After Match APIs Error  : %@",error);
        [self.activityIndicator stopAnimating];
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
    }];
}

-(void)getAlbumsListAPI
{
    id parameter=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%li",(long)self.matchItem.idField]] forKeys:@[@"id"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:AfterAlbumsMatchesAPI,[WServicesManager getApiBaseURL]] andParameters:parameter WithObjectName:@"Albums" andAuthenticationType:CMSAPIs success:^(Albums * albumsList) {
        if(albumsList.albums.count>0)
        {
            self.albumsList=albumsList.albums;
            [sections addObject:albumsList.albums];
        }
        
    } failure:^(NSError *error) {
        IBGLog(@" After Matches Albums APIs Error  : %@",error);
        [self.activityIndicator stopAnimating];
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
    }];
}

-(void)getVideosListAPI
{
    id parameter=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%li",(long)self.matchItem.idField]] forKeys:@[@"id"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:AfterVideosMatchesAPI,[WServicesManager getApiBaseURL]] andParameters:parameter WithObjectName:@"VideosList" andAuthenticationType:CMSAPIs success:^(VideosList * videosList) {
        if(videosList.videos.count>0)
        {
            self.videosList=videosList.videos;
            [sections addObject:videosList.videos];
        }
    } failure:^(NSError *error) {
        IBGLog(@" After Matches Videos APIs Error  : %@",error);
        [self.activityIndicator stopAnimating];
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
    }];
}


-(void)getNewsAndVideosAndAlbum
{
    sections=[[NSMutableArray alloc]init];
    self.newsList=[[NSArray alloc]init];
    self.videosList=[[NSArray alloc]init];
    self.albumsList=[[NSArray alloc]init];

    [self getNewsListAPI];
    [self getAlbumsListAPI];
    [self getVideosListAPI];

    
}


-(void)loadAfterMatchDetails
{
    highestScoresList=[[NSMutableArray alloc]init];
    teamStandings=[[NSMutableArray alloc]init];
    matchOverviewObj=[[MatchOverview alloc]init];
    championshipTeamsMatchesStatistics=[[NSArray alloc]init];
    upcommingMatches=[[NSArray alloc]init];
    NSDictionary * firstParameters=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%li" ,(long)self.matchItem.idField]] forKeys:@[@"matchId"]];

    NSString * firstURL =[NSString stringWithFormat:CompareMatchesAPI,[WServicesManager getSportsEngineApiBaseURL],[NSString stringWithFormat:@"%li" ,(long)self.matchItem.idField] ];


    [WServicesManager getDataWithURLString:firstURL andParameters:firstParameters WithObjectName:@"MatchOverview" andAuthenticationType:SportesEngineAPIs success:^(MatchOverview * matchOverview) {
        matchOverviewObj=matchOverview;
        [teamStandings insertObject:[[Standing alloc]init] atIndex:0]; // standings header
        [teamStandings addObjectsFromArray:matchOverview.standings];
        
    } failure:^(NSError *error) {
        IBGLog(@" Standings Error  : %@",error);
        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Overview with ID = %li ",(long)self.matchItem.idField]  ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
        
        [self.activityIndicator stopAnimating];
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
    }];
    [self getMatchesListAPI];
  
    
}
-(void)getMatchesListAPI
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[formatter dateFromString:self.matchItem.dateStr]];
    [components setDay:[components day]+1];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSDate *newDate = [gregorian dateFromComponents:components];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * date=[outputFormatter stringFromDate:newDate];
    
    NSDictionary * secParameters=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"((HomeTeamId eq %d and AwayTeamId eq %d) or(HomeTeamId eq %d and AwayTeamId eq %d)) and Date ge %@&$top=4",self.matchItem.homeTeamId,self.matchItem.awayTeamId,self.matchItem.awayTeamId,self.matchItem.homeTeamId, date],@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id"] forKeys:@[@"$filter",@"$select"]];
    
    NSString * secURL = [NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]];
    
    [WServicesManager getDataWithURLString:secURL andParameters:secParameters WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(MatchesList * matches) {
        upcommingMatches=matches.matches;
        [self loadViewSections];
        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Overview with ID = %li ",(long)self.matchItem.idField]  ApiError:@"Success"];
        
    } failure:^(NSError *error) {
        IBGLog(@" Standings Error  : %@",error);
        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Overview with ID = %li ",(long)self.matchItem.idField]  ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
        
        [self.activityIndicator stopAnimating];
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
    }];
}
#pragma mark - Constrcut after view sections
-(void)loadViewSections
{
    [self.refreshControl endRefreshing];
    championshipTeamsMatchesStatistics=self.matchStatistics;
    // championshipTeamsMatchesStatistics=  matchOverviewObj.championshipTeamsMatchesStatistics;
    if(teamStandings.count>0)
        [sections addObject:teamStandings];
//    if(matchOverviewObj.winsComparison !=NULL)
//        [sections addObject:matchOverviewObj.winsComparison];
//    if(matchOverviewObj.firstTeamHeighestScore!=NULL)
//        [highestScoresList addObject:matchOverviewObj.firstTeamHeighestScore];
//    if(matchOverviewObj.secondTeamHeighestScore!=NULL)
//        [highestScoresList addObject:matchOverviewObj.secondTeamHeighestScore];
//    if(highestScoresList.count>0)
//        [sections addObject:highestScoresList];
    if(championshipTeamsMatchesStatistics.count>0)
        [sections addObject:championshipTeamsMatchesStatistics];
    if(upcommingMatches.count>0)
        [sections addObject:upcommingMatches];
    if(_matchEventsGroupedByStatuesList.count>0)
    {
        for(NSDictionary * eventSection in self.matchEventsGroupedByStatuesList)
        {
            [sections addObject:eventSection];
        }
    }
    
    
    self.loadingLbl.hidden=YES;
    [self.activityIndicator stopAnimating];
    [self.tableView reloadData];
    
}
#pragma mark - UITableView DataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(10, 0, Screenwidth, 40)];
    [headerView setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
    UILabel * headerTitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, headerView.frame.size.width-40, headerView.frame.size.height)];
    [headerTitleLbl setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:13.0]];
    [headerTitleLbl setTextAlignment:NSTextAlignmentRight];
    
    if([[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[Standing class]]&&[(NSArray*)[sections objectAtIndex:section]count]>1)
    {
      //  Standing * item=[(NSArray*)[sections objectAtIndex:section]objectAtIndex:1];
     //   [headerTitleLbl setText:[NSString stringWithFormat:@"%@ %@",@" ترتيب الفرقتين في",item.groupName]];
        Standing * item=[(NSArray*)[sections objectAtIndex:section]objectAtIndex:1];
        if(item.groupName!=nil&&![item.groupName isEqualToString:@""])
            [headerTitleLbl setText:[NSString stringWithFormat:@"%@ %@ %@",@"ترتيب الفريقين",@"في",item.groupName]];
        else  if(item.roundName!=nil&&![item.roundName isEqualToString:@""])
            
            [headerTitleLbl setText:[NSString stringWithFormat:@"%@ %@ %@",@"ترتيب الفريقين",@"في",item.roundName]];
        else
            [headerTitleLbl setText:@"ترتيب الفريقين"];
        
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[MatchCenterDetails class]])
    {
        [headerTitleLbl setText:@"اللقاءات القادمة بين الفريقين"];
        
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[MatchStatistic class]])
    {
        [headerTitleLbl setText:@"آحصائيات الفريقين"];
        
    }
    else if([[sections objectAtIndex:section]isKindOfClass:[WinsComparison class]])
    {
        [headerTitleLbl setText:@"نسبة الفوز بين الفريقين"];
        
    }
    else  if( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[FirstTeamHeighestScore class]])
    {
        [headerTitleLbl setText:@"أعلى نتيجة في مواجهات الفريقين"];
        
    }
    else  if( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[NewsItem class]])
    {
        
    }
    else  if( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[VideoItem class]])
    {
        
    }
    else  if( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[Album class]])
    {
    }
    else if(_matchEventsGroupedByStatuesList.count>0&&[[sections objectAtIndex:section]isKindOfClass:[NSDictionary class]])
    {
      //  [headerTitleLbl setText:@"أهم أحداث المباراة"];
        UIView *headerView=[[UIView alloc]init];
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(8, 0, Screenwidth-15, 25)];
        [title setBackgroundColor:[UIColor clearColor]];
        UIImageView *img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matche_event_title"]];
        [img setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
        [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:10]];
        [title setTextColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0  blue:19.0/255.0  alpha:1.0]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
        [title setText:[[(NSDictionary*)[sections objectAtIndex:section]allKeys]objectAtIndex:0]];
        if(self.matchEventsGroupedByStatuesList.count==0){
            // title.text=@"لا يوجد احداث للمباراة";
            title.textAlignment=NSTextAlignmentCenter;
            [title setFrame:CGRectMake(0, 5, Screenwidth, 20)];
            [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:15]];
            return nil;
        }
        else{
            [headerView addSubview:img];
            [headerView addSubview:title];
            return headerView;
            
        }
        // [headerView addSubview:img];
        
        
    }
    [headerView addSubview:headerTitleLbl];
    return headerView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier ;
    
    UITableViewCell *cell ;
    if(_matchEventsGroupedByStatuesList.count>0&&[[sections objectAtIndex:indexPath.section]isKindOfClass:[NSDictionary class]])
    {
        MatchEvent * matchEvent=[[[(NSDictionary*)[sections objectAtIndex:indexPath.section]allValues]objectAtIndex:0] objectAtIndex:indexPath.row];
        return   [MatchActionCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchAction:matchEvent clubone:(int)self.matchItem.homeTeamId clubtwo:(int)self.matchItem.awayTeamId];
        
    }
    
    else if([[sections objectAtIndex:indexPath.section]isKindOfClass:[WinsComparison class]])
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
        
        highestScoreView.firstHighestScore=[highestScoresList objectAtIndex:indexPath.row];
        [highestScoreView.view setFrame:CGRectMake(5, 0, self.tableView.frame.size.width-10, 100)];
        [cell.contentView addSubview:highestScoreView.view];
        
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
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[MatchStatistic  class]])
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
        MatchStatistic * item=[championshipTeamsMatchesStatistics objectAtIndex:indexPath.row];
        [((TeamStatisticsBarChartCell*)cell) initWithMatchStatistics:item];
        
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
        MatchCenterDetails * item=[upcommingMatches objectAtIndex:indexPath.row];
        [((PreviousMatchTableViewCell*)cell) initWithMatchItem:item];

        
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[NewsItem class]])
    {
        NewsItem *item=[self.newsList objectAtIndex:indexPath.row ];
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
        
        [((StoryCell*)cell)initWithNewsItem:item];
        return cell;
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[VideoItem class]])
    {
        VideoItem *item=[self.videosList objectAtIndex:indexPath.row ];
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
        
        [((StoryCell*)cell)initWithVideoItem:item];
        return cell;
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[Album class]])
    {
        Album * item=[self.albumsList objectAtIndex:indexPath.row];
 
        cellIdentifier=@"AlbumCustomCellTableViewCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]init];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
        }
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AlbumCustomCellTableViewCell" owner:self options:nil]objectAtIndex:0];
        [((AlbumCustomCellTableViewCell*)cell) initWithAlbumItem:item];
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_matchEventsGroupedByStatuesList.count>0&&[[sections objectAtIndex:indexPath.section]isKindOfClass:[NSDictionary class]])
    {
        MatchEvent * matchEvent=[[[(NSDictionary*)[sections objectAtIndex:indexPath.section]allValues]objectAtIndex:0] objectAtIndex:indexPath.row];
        
        return   [self getHeightForMatchRow:matchEvent];
    }
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[MatchCenterDetails class]])
    {
        return 112;
    }
    else if([[sections objectAtIndex:indexPath.section]isKindOfClass:[WinsComparison class]])
    {
        return 760;
    }
    else if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[FirstTeamHeighestScore class]])
    {
        return 100;
    }
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[Standing class]])
    {
        if(indexPath.row==0)
            return 33;
        else
            return 67;
    }
    else  if( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&(([[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[NewsItem class]])||([[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[VideoItem class]])))
    {
        if (IS_IPHONE_6_PLUS) {
            return IPHONE_6Plus_Cell_Hieght;
        }
        else if (IS_IPHONE_6)
        {
            return IPHONE_6_Cell_Hieght;
        }
        else
        {
            return IPHONE_4_5_Cell_Hieght;
        }
    }
    
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[Album class]])
    {
        return 244;
    }
    else
        return 48;
}

-(int)getHeightForMatchRow:(MatchEvent*)item{
    int leftHeight=30;
    int rigthHeight=30;
    //for(MatchEvent *action in item){
    if(item.playerAId&&item.playerBId!=0&&item.teamId==_matchItem.homeTeamId)
    {
        leftHeight+=44;
    }
    else  if(item.playerAId&&item.playerBId!=0&&item.teamId==_matchItem.awayTeamId)
    {
        rigthHeight+=44;
    }
    else if (item.teamId==_matchItem.homeTeamId) {
        leftHeight+=22;
    }
    else if (item.teamId== _matchItem.awayTeamId) {
        rigthHeight+=22;
    }
    // }
    return leftHeight>rigthHeight?leftHeight:rigthHeight;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_matchEventsGroupedByStatuesList.count>0&&[[sections objectAtIndex:section]isKindOfClass:[NSDictionary class]])
    {
        return [(NSArray*)[[(NSDictionary*)[sections objectAtIndex:section]allValues]objectAtIndex:0] count];
    }
    
    else if( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[FirstTeamHeighestScore class]])
    {
        return highestScoresList.count;
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[MatchCenterDetails class]])
    {
        return upcommingMatches.count;
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[Standing class]])
    {
        // new row for standings header
        return teamStandings.count;
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[MatchStatistic class]])
    {
        return championshipTeamsMatchesStatistics.count;
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[NewsItem class]])
    {
        return self.newsList.count;
    }
    else if ( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[VideoItem class]])
    {
        return self.videosList.count;
    }
    else if( [[sections objectAtIndex:section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:section]objectAtIndex:0]isKindOfClass:[Album class]])
    {
        return self.albumsList.count;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections.count;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[Album class]])
    {
       selectedAlbum=[self.albumsList objectAtIndex:indexPath.row];
        GalleryDetailsViewController * viewController = [[GalleryDetailsViewController alloc]init];
        viewController.albumItem = selectedAlbum;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[NewsItem class]])
    {
        NewsItem * item=[self.newsList objectAtIndex:indexPath.row ];
        NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc]initWithNewsItem:item];
        NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc]initWithNewsItem:item];
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
        [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
        else
        [self.navigationController pushViewController:newsDetailsScreen animated:YES];
    }
    if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[Standing class]])
        
    {
        Standing * item=[teamStandings objectAtIndex:indexPath.row];
        TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
        teamProfile.teamId = (int)item.teamId;
        teamProfile.teamName = item.teamName;
        [self.navigationController pushViewController:teamProfile animated:YES];
    }
    else  if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]isKindOfClass:[MatchCenterDetails class]])
    {
        MatchCenterDetails * item=[upcommingMatches objectAtIndex:indexPath.row];
        MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
        matchCenter.matchCenterDetails=item;
        [self.navigationController pushViewController:matchCenter animated:YES];
        
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
        [self.navigationController pushViewController:matchCenter animated:NO];
    }
    else if ( [[sections objectAtIndex:indexPath.section]isKindOfClass:[NSArray class]]&&[[(NSArray*)[sections objectAtIndex:indexPath.section]objectAtIndex:0]isKindOfClass:[VideoItem class]])
    {
        VideoItem * item=[self.videosList objectAtIndex:indexPath.row ];
        VideoDetailsViewController * newsDetailsScreen=[[VideoDetailsViewController alloc]initWithVideo:item];
        [self.navigationController pushViewController:newsDetailsScreen animated:YES];
    }
    
}
//#pragma mark - Photo Gallery
-(void)showImageController
{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.autoPlayOnAppear = NO;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];

}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index
{
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}
#pragma mark - Load Events
-(void)getEventsWithMatchStatusHistory
{
    self.matchEventsList=nil;
    self.matchEventsGroupedByStatuesList=self.matchEventsWithStatusHistory.mainMatchEventsGroupedByStatuesList;
}

//Scrolling
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y > 0){
     //   [self.loadingLbl setFrame: CGRectMake(60, 20, Screenwidth-120, self.loadingLbl.frame.size.height)];

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
#pragma - mark XLPagerTabStripChildItem
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}

#pragma mark - MWPhotoBrowser Delegates
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}
#pragma mark GADBanner Delegate implementation
- (void)adView:(DFPBannerView *)banner didFailToReceiveAdWithError:(GADRequestError *)error
{
    //  [self.errorLbl setText:[NSString stringWithFormat:@"%@",error]];
    
}
- (void)adViewDidReceiveAd:(DFPBannerView *)bannerView
{
    
}
@end
