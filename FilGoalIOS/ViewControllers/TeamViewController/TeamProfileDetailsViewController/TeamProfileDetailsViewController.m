//
//  TeamProfileDetailsViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 7/27/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamProfileDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "TeamStandingsHeaderCell.h"
#import "SVModalWebViewController.h"
#import "UsersStatisticsViewController.h"
@import Firebase;
@interface TeamProfileDetailsViewController ()
{
    NSString * websiteUrl;
    NSMutableDictionary * sectionsDic;
    NSMutableArray * sections;
    NSString * championIds;
}
@end

@implementation TeamProfileDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    sectionsDic = [[NSMutableDictionary alloc]init];
    sections = [[NSMutableArray alloc]init];
    [self.activityIndicator startAnimating];
    self.championshipsTitles = [[NSArray alloc]initWithArray:[self getChampionshipData]];

    [self getPreviousMatchesAPI];
    self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner",@"Team",[NSString stringWithFormat:@"فريق %@",self.teamName]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS- Team Overview with ID %ld",(long)self.teamId]];
    self.screenName=[NSString stringWithFormat:@"iOS- Team Overview with ID %ld",(long)self.teamId];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Team Overview with ID %ld",(long)self.teamId]
                                     }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

#pragma mark - Get Standings Data
-(void) getStandingsData
{
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%@ and (TeamId eq %i)",championIds,self.teamId],@"RoundOrder desc,Week desc"] forKeys:@[@"$filter",@"$orderby"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:TeamStandingsAPI,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"TeamStandings" andAuthenticationType:SportesEngineAPIs success:^(TeamStandings * success)
     {
         [self.activityIndicator stopAnimating];
         if(success.data.count>0)
         {
             self.standings = [[NSMutableArray alloc]initWithArray: success.data];
             self.standings =[self filterStandingsListByChampId:self.standings withSections:[[NSMutableArray alloc]init]];
             NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
             if(self.standings.count>2)
             self.standings = (NSMutableArray*) [self.standings subarrayWithRange:NSMakeRange(0, 3)];
             [dic setObject:self.standings forKey:@"Standings"];
             [sections addObject:dic];
             [self reloadTableView];

         }
         else{
             
         }
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Profile with Team ID = %li ",(long)self.teamId]  ApiError:@"Success"];

         
     }failure:^(NSError *error) {
         
         IBGLog(@"Team Profile API Error  : %@",error);
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Profile with Team ID = %li ",(long)self.teamId]  ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];

         
     }];
}
-(NSMutableArray*)filterStandingsListByChampId:(NSArray*)standingsList withSections:(NSMutableArray*)sections{
    //  NSMutableArray *sectiondMatches=[[NSMutableArray alloc] init];
    NSMutableArray *subMatches=[[NSMutableArray alloc] init];
    NSInteger current=-1;
    for (Standing * item  in standingsList ) {
        
        if (current==-1) {
            current=item.championshipId;
            [subMatches addObject:item];
        }
        else if (current!=item.championshipId) {
            current=item.championshipId;
            [sections addObject:subMatches];
            subMatches=[[NSMutableArray alloc] init];
            [subMatches addObject:item];
        }
//        else {
//            [subMatches addObject:item];
//        }
    }
    [sections addObject:subMatches];
    
    return sections;
}
-(NSMutableArray*)getChampionStandings:(NSArray*)standings withSections:(NSMutableArray*)sectionsList{
    //  NSMutableArray *sectiondMatches=[[NSMutableArray alloc] init];
    NSMutableArray *subMatches=[[NSMutableArray alloc] init];
    NSInteger current=-1;
    for (Standing * match  in standings ) {
        
        if (current==-1) {
            current=match.championshipId;
            if(subMatches.count<2)
            {
                [subMatches addObject:match];
                [subMatches insertObject:[[Standing alloc]init] atIndex:0];
            }
            
        }
        else if (current!=match.championshipId) {
            current=match.championshipId;
            [sectionsList addObject:subMatches];
            subMatches=[[NSMutableArray alloc] init];
            if(subMatches.count<2)
            {
                [subMatches addObject:match];
                [subMatches insertObject:[[Standing alloc]init] atIndex:0];
            }
            
        }
        else {
            if(subMatches.count<2)
            {
                [subMatches addObject:match];
            }
            
        }
    }
    [sectionsList addObject:subMatches];
    return sectionsList;
    
    
}

#pragma mark - Get Champion Titles
-(NSArray*) getChampionshipData
{
    NSMutableArray * titles = [[NSMutableArray alloc]init];
    championIds = [[NSString alloc]init];
    championIds =  [championIds stringByAppendingString:@"("];
    
    for(int i=0 ; i< self.championships.count ; i++)
    {
        ChampionShipData * item = self.championships[i];
        [titles addObject:item.name];
        // Concatnate request parameters
        championIds = [championIds stringByAppendingString:[NSString stringWithFormat:@"(championshipId eq %li)",(long)item.idField]];
        if(i<self.championships.count-1)
        {
            championIds = [championIds stringByAppendingString:@" or "];
        }
        else
        {
            championIds =  [championIds stringByAppendingString:@")"];
        }
    }
    return [[NSArray alloc]initWithArray:titles];
}

#pragma mark - Get Stories Data
-(void)getStoriesData
{
    [WServicesManager getDataWithURLString:HomeStoriesAPI andParameters:nil WithObjectName:@"StoriesHome" andAuthenticationType:CMSAPIs success:^(id success)
     {
         
         StoriesHome * homeData = success;
         
         if(homeData.news.count>0)
         {
             NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
             [dic setObject:homeData.news forKey:@"NewsList"];
             [sections addObject:dic];
         }
         if(homeData.videos.count>0)
         {
             NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
             [dic setObject:homeData.videos forKey:@"VideosList"];
             [sections addObject:dic];
         }
         if(homeData.albums.count>0)
         {
             NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
             [dic setObject:homeData.albums forKey:@"AlbumsList"];
             [sections addObject:dic];
         }
         
         [self reloadTableView];
         
     }failure:^(NSError *error) {
         
         IBGLog(@"Team Profile API Error  : %@",error);
         
         
     }];
}
#pragma mar - Get Previous and Next Matches
-(void) getMatchesData
{

    


    
    
}
-(void) getPreviousMatchesAPI
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * firstURL = [NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]];
    
    NSDictionary * firstParameters=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"(HomeTeamId eq %i or AwayTeamId eq %i) and Date le %@",self.teamId,self.teamId,[formatter stringFromDate:[NSDate date]]] ,@"Date desc",@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id",@"1",@"MatchStatusHistory($orderby=StartAt desc;)"] forKeys:@[@"$filter",@"$orderby",@"$select",@"$top",@"$expand"]];
    [WServicesManager getDataWithURLString:firstURL andParameters:firstParameters WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(MatchesList * matches) {
        
        if(matches.matches.count>0)
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            [dic setObject:matches.matches forKey:@"PreviousMatches"];
            [sections insertObject:dic atIndex:0];
        }
        [self getUpcommingMatchesAPI];
    } failure:^(NSError *error) {
        IBGLog(@"Matches Error  : %@",error);
    }];
}

-(void)getUpcommingMatchesAPI
{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * secURL = [NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]];
    
    NSDictionary * secParameters=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"(HomeTeamId eq %i or AwayTeamId eq %i) and Date gt %@",self.teamId,self.teamId,[formatter stringFromDate:[NSDate date]]] ,@"Date asc",@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id",@"2",@"MatchStatusHistory($orderby=StartAt desc;)"] forKeys:@[@"$filter",@"$orderby",@"$select",@"$top",@"$expand"]];
    [WServicesManager getDataWithURLString:secURL andParameters:secParameters WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(MatchesList * matches) {
        NSMutableArray * nextlist = [[NSMutableArray alloc]init];
        NSMutableArray * todaylist = [[NSMutableArray alloc]init];
        for(int i =0;i<matches.matches.count;i++)
        {
            MatchCenterDetails * item = [matches.matches objectAtIndex:i];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [formatter setLocale:usLocale];
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[formatter dateFromString:item.date]];
            NSDateComponents * todaycomponents = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[NSDate date]];
            
            if(components.day == todaycomponents.day)
            {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                [todaylist addObject:item];
                [dic setObject:todaylist forKey:@"TodayMatches"];
                if(sections.count>1)
                    [sections insertObject:dic atIndex:0];
                else
                    [sections addObject:dic];
                
            }
            else
            {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                [nextlist addObject:item];
                [dic setObject:nextlist forKey:@"NextMatches"];
                if(sections.count>2)
                    [sections insertObject:dic atIndex:1];
                else
                    [sections addObject:dic];
                
                break;
                
            }
            
        }
        NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[@[[[DFPBannerView alloc]init]]] forKeys:@[@"AdsView"]];
        if(sections.count>3)
        {
            [sections insertObject:dic atIndex:3];
        }
        else
        {
            [sections addObject:dic];
        }
        
        [self reloadTableView];
        if(self.championshipsTitles.count>0)
        {
            [self getStandingsData];
        }
    } failure:^(NSError *error) {
        IBGLog(@"Matches Error  : %@",error);
        [self showDefaultNetworkingErrorMessageForError:error
                                         refreshHandler:^{
                                             [self getUpcommingMatchesAPI];
                                         }];
    }];
}

#pragma mark - tableView DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [sections objectAtIndex:indexPath.section];
    NSArray * list;
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    
    NSString * cellIdentifier = @"Cell";
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
    }
    if([[list objectAtIndex:indexPath.row]isKindOfClass:[DFPBannerView class]])
   {
       UIView * adsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 250)];
       adsView.backgroundColor = [UIColor clearColor];
       cell.backgroundColor = [UIColor clearColor];
       cell.contentView.backgroundColor = [UIColor clearColor];
       [adsView addSubview:[super setBannerViewFooter:@[@"Inner"] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS- Team Overview with ID %ld",(long)self.teamId]]];
       [cell.contentView addSubview:adsView];
   }
   else if(indexPath.row < list.count && [list[indexPath.row]  isKindOfClass:[MatchCenterDetails class]])
    {
        MatchCenterDetails * item = list[indexPath.row];
        cell = [MatcheCenterCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchItem:item];
        [((MatcheCenterCellLoader*)cell).awayTeamBtn setTag:item.awayTeamId];
        [((MatcheCenterCellLoader*)cell).awayTeamBtn setTitle:item.awayTeamName forState:UIControlStateNormal];
        [((MatcheCenterCellLoader*)cell).awayTeamBtn addTarget:self action:@selector(awayTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [((MatcheCenterCellLoader*)cell).homeTeamBtn setTag:item.homeTeamId];
        [((MatcheCenterCellLoader*)cell).homeTeamBtn setTitle:item.homeTeamName forState:UIControlStateNormal];
        [((MatcheCenterCellLoader*)cell).homeTeamBtn addTarget:self action:@selector(homeTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [((MatcheCenterCellLoader*)cell).predictMatchBtn addTarget:self action:@selector(predictBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [((MatcheCenterCellLoader*)cell).statisticsBtn addTarget:self action:@selector(statisticalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if([self checkIfMatchDateIsToday:item])
        {
            cell.contentView.backgroundColor = [UIColor colorWithRed:255.0f / 255.0f green:240.0f / 255.0f blue:210.0f / 255.0f alpha:1.0f];
        }
        else
        {
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
        }
        
      return cell;
    }
    else if([list[indexPath.row]  isKindOfClass:[NewsItem class]])
    {
        NewsCustomCell *cell;
        if (cell == nil)
        {
            cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
            cell.hideDeleteBtn = YES;
            cell.playImg.hidden= YES;
            
        }
        NewsItem * item = list[indexPath.row];
        Images *imageItem =[item.images objectAtIndex:0];
        
        [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:imageItem.large]placeholderImage:[UIImage imageNamed:@"place_holder"]];
        
        [((NewsCustomCell*)cell).itemLbl setText:item.newsTitle];
        ((NewsCustomCell*)cell).dateLabel.hidden = YES;
        
        return cell;
    }
    else if([list[indexPath.row] isKindOfClass:[VideoItem class]])
    {
        NewsCustomCell *cell;
        if (cell == nil)
        {
            cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
            cell.hideDeleteBtn = YES;
            cell.playImg.image = [UIImage imageNamed:@"play_button"];
            cell.playImg.hidden=NO;
            
        }
        VideoItem * item = list[indexPath.row];
        
        [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:item.videoPreviewImage]placeholderImage:[UIImage imageNamed:@"place_holder"]];
        [((NewsCustomCell*)cell).itemLbl setText:item.videoTitle];
        ((NewsCustomCell*)cell).dateLabel.hidden = YES;
        
        return cell;
        
    }
    else if([list[indexPath.row] isKindOfClass:[Album class]])
    {
        NewsCustomCell *cell;
        if (cell == nil)
        {
            cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
            cell.hideDeleteBtn = YES;
            cell.playImg.image = [UIImage imageNamed:@"ic_album"];
            cell.playImg.hidden=NO;
            
        }
        Album * item = list[indexPath.row];
        Picture * firstPictureItem;
        if(item.pictures.count>0)
            firstPictureItem=[item.pictures objectAtIndex:0];
        
        [((NewsCustomCell*)cell).itemLbl setText:item.albumTitle];
        ((NewsCustomCell*)cell).dateLabel.hidden = YES;
        
        [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:firstPictureItem.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
        
        return cell;
        
    }
    else if([list[indexPath.row] isKindOfClass:[NSArray class]]&&[list[indexPath.row][0] isKindOfClass:[Standing class]])
    {
        Standing * item = list[indexPath.row][0];
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StandingsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"StandingsCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TeamStandingsHeaderCell" owner:self options:nil]objectAtIndex:0];
        [((TeamStandingsHeaderCell*)cell) initWithTeamStandingItem:item];

        return cell;
        
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [sections objectAtIndex:indexPath.section];
    NSArray * list;
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    
    if([[list objectAtIndex:indexPath.row] isKindOfClass:[MatchCenterDetails class]])
    {
        MatchCenterDetails * item = list[indexPath.row];
        if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]&&item.matchStatusHistory.count>0&&[[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
            return 170;
        }
        else{
            return 128;
        }
    }
    else if([[list objectAtIndex:indexPath.row] isKindOfClass:[Standing class]])
    {
        return 98;

    }
    else if([[list objectAtIndex:indexPath.row]isKindOfClass:[DFPBannerView class]])
    {
        return  270;
    }
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([sections[section] objectForKey:@"AdsView"] != nil)
    {
        return 1;
    }
    else
    {
    NSDictionary * dic = [sections objectAtIndex:section];
    NSArray * list;
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    
    return list.count;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary * dic = [sections objectAtIndex:section];
    NSArray * list;
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    
    
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
    
    if([[list objectAtIndex:0] isKindOfClass:[MatchCenterDetails class]])
    {
        
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
        
        if([dic objectForKey:@"NextMatches"] != nil)
            ((MoreHeaderCell*)view).headerTitle.text = @"المباراة التالية";
        else   if([dic objectForKey:@"TodayMatches"] != nil)
            ((MoreHeaderCell*)view).headerTitle.text = @"مباريات اليوم";
        else
            ((MoreHeaderCell*)view).headerTitle.text = @"المباراة السابقة";
        
        ((MoreHeaderCell*)view).backgroundColor = [UIColor clearColor];
        ((MoreHeaderCell*)view).moreBtn.hidden = YES;
        view.frame = headerView.frame;
        [headerView addSubview:view];
    }
    else if([[list objectAtIndex:0] isKindOfClass:[NewsItem class]])
    {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
        ((MoreHeaderCell*)view).headerTitle.text = @"آخر أخبار الفريق";
        ((MoreHeaderCell*)view).moreBtn.layer.cornerRadius = ((MoreHeaderCell*)view).moreBtn.frame.size.width/2;
        ((MoreHeaderCell*)view).moreBtn.clipsToBounds = YES;
        ((MoreHeaderCell*)view).moreBtn.tag = section;
        [((MoreHeaderCell*)view).moreBtn addTarget:self action:@selector(moreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        view.frame = headerView.frame;
        [headerView addSubview:view];
        
    }
    else if([[list objectAtIndex:0] isKindOfClass:[VideoItem class]])
    {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
        ((MoreHeaderCell*)view).headerTitle.text = @"فيديوهات الفريق";
        ((MoreHeaderCell*)view).moreBtn.layer.cornerRadius = ((MoreHeaderCell*)view).moreBtn.frame.size.width/2;
        ((MoreHeaderCell*)view).moreBtn.clipsToBounds = YES;
        ((MoreHeaderCell*)view).moreBtn.tag = section;
        [((MoreHeaderCell*)view).moreBtn addTarget:self action:@selector(moreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        view.frame = headerView.frame;
        [headerView addSubview:view];
        
      //  return view;
        
    }
    else if([[list objectAtIndex:0] isKindOfClass:[Album class]])
    {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
        ((MoreHeaderCell*)view).headerTitle.text = @"صورالفريق";
        ((MoreHeaderCell*)view).moreBtn.layer.cornerRadius = ((MoreHeaderCell*)view).moreBtn.frame.size.width/2;
        ((MoreHeaderCell*)view).moreBtn.clipsToBounds = YES;
        ((MoreHeaderCell*)view).moreBtn.tag = section;
        [((MoreHeaderCell*)view).moreBtn addTarget:self action:@selector(moreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        view.frame = headerView.frame;
        [headerView addSubview:view];
        
       // return view;
        
    }
    else if([[list objectAtIndex:0] isKindOfClass:[Standing class]])
    {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
        ((MoreHeaderCell*)view).headerTitle.text = @"ترتيب الفريق";
        ((MoreHeaderCell*)view).backgroundColor = [UIColor clearColor];
        ((MoreHeaderCell*)view).moreBtn.hidden = YES;
        view.frame = headerView.frame;
        [headerView addSubview:view];
        //return view;
        
        
    }
    return headerView;
    
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


-(void)reloadTableView
{
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}

- (IBAction)moreBtnPressed:(UIButton*)sender
{
    // More for News listing
    if([[(NSArray*)(sectionsDic.allValues[sender.tag])objectAtIndex:0] isKindOfClass:[NewsItem class]])
    {
        NewsHomeViewController * newsListVC = [[NewsHomeViewController alloc]initWithSectionId:0 TypeId:1];
        newsListVC.teamId = self.teamId;
        [self.navigationController pushViewController:newsListVC animated:YES];
        
    }
    // More for Videos listing
    
    else if([[(NSArray*)(sectionsDic.allValues[sender.tag])objectAtIndex:0] isKindOfClass:[VideoItem class]])
    {
        VideosViewController* videosViewController=[[VideosViewController alloc]initWithSectionId:0];
        videosViewController.teamId = self.teamId;
        
        [self.navigationController pushViewController:videosViewController animated:YES];
    }
    else if([[(NSArray*)(sectionsDic.allValues[sender.tag])objectAtIndex:0] isKindOfClass:[Album class]])
    {
        GalleriesViewController * galleriesViewController=[[GalleriesViewController alloc]init];
        galleriesViewController.teamId = self.teamId;
        
        [self.navigationController pushViewController:galleriesViewController animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [sections objectAtIndex:indexPath.section];
    NSArray * list;
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    if([list[indexPath.row]  isKindOfClass:[MatchCenterDetails class]])
    {
        MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
        matchCenter.matchCenterDetails = list[indexPath.row];
        [appDelegate.getSelectedNavigationController pushViewController:matchCenter animated:YES];
    }
   
}

-(BOOL)checkIfMatchDateIsToday:(MatchCenterDetails*) item
{
    NSDateFormatter * formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[formatter dateFromString:item.date]];
    NSDateComponents * todaycomponents = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[NSDate date]];
    
    if(components.day == todaycomponents.day)
    {
        return true;
    }
    return false;
}

#pragma mark - UIScrollview delegates
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (velocity.y > 0){
            //NSLog(@"up");
            BOOL scroll= true;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"TeamScrollUpNotification"
             object:userInfo];
            
        }
        if (velocity.y < 0){
            //NSLog(@"down");
            BOOL scroll= false;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
            if(scrollView.contentOffset.y<=0)
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"TeamScrollDownNotification"
                 object:userInfo];
            
        }
}

- (IBAction)homeTeamBtnPressed:(UIButton*)sender {
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [GetAppDelegate().getSelectedNavigationController pushViewController:teamProfile animated:YES];
}

- (IBAction)awayTeamBtnPressed:(UIButton*)sender {
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [GetAppDelegate().getSelectedNavigationController pushViewController:teamProfile animated:YES];
}
#pragma mark - Handle Prediction Action
- (IBAction)statisticalBtnAction:(UIButton*)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(MatcheCenterCellLoader*)sender.superview.superview];
    MatchCenterDetails * item;
    NSDictionary * dic = [sections objectAtIndex:indexPath.section];
    NSArray * list;
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    
    item = [list objectAtIndex:indexPath.row];

    if(item != nil){
        UsersStatisticsViewController * viewController = [[UsersStatisticsViewController alloc]init];
        viewController.matchItem = item;
        STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:viewController];
        popupController.style = STPopupStyleFormSheet;
        [popupController presentInViewController:GetAppDelegate().getSelectedNavigationController.topViewController];
        
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Predictions"
                                                              action:@"Statistics-Button"
                                                               label:[NSString stringWithFormat:@"Match ID = %li ",(long)item.idField]
                                                               value:nil] build]];
    }
}

- (IBAction)predictBtnAction:(UIButton*)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(MatcheCenterCellLoader*)sender.superview.superview];
    MatchCenterDetails * item;
    NSDictionary * dic = [sections objectAtIndex:indexPath.section];
    NSArray * list;
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    
    item = [list objectAtIndex:indexPath.row];

    if(item != nil){
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"FilGoalPredictions://"]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"FilGoalPredictions://https://predictnwin.filgoal.com/prediction/Predict?champId=%li&MatchId=%li",(long)item.championshipId,(long)item.idField]]];
        }
        else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://predictnwin.filgoal.com/prediction/Predict?champId=%li&MatchId=%li",(long)item.championshipId,(long)item.idField]]];
        }
    }
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Predictions"
                                                          action:@"Predict-Button"
                                                           label:[NSString stringWithFormat:@"Match ID = %li ",(long)item.idField]
                                                           value:nil] build]];
    
}

@end
