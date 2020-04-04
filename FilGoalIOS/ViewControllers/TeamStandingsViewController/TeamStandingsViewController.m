//
//  TeamStandingsViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/8/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamStandingsViewController.h"
#import "ChampionshipHeaderViewCellTableViewCell.h"
#import "TeamStandingsHeaderCell.h"
@import Firebase;
@interface TeamStandingsViewController ()
{
     NSInteger selectedPickerIndex;
}
@end

@implementation TeamStandingsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName = @"iOS - Team Standings";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS - Team Standings"
                                     }];
    [self getTeamStandings];

    self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner",@"Team",[NSString stringWithFormat:@"فريق %@",self.teamName]] andPosition:@[@"Pos1"] andScreenName:@"iOS - Team Standings"];
}
-(NSArray*) getChampionshipTitles
{
    NSMutableArray * titles = [[NSMutableArray alloc]init];
    
    for(ChampionShipData * item in self.championships)
    {
        [titles addObject:item.name];
    }
    return [[NSArray alloc]initWithArray:titles];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Get Standings Data
-(void) getTeamStandings
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"TeamId eq %i and %@",self.teamId,[self getChampionshipIdsString]],@"RoundOrder desc,Week desc"] forKeys:@[@"$filter",@"$orderby"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:TeamStandingsAPI,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"TeamStandings" andAuthenticationType:SportesEngineAPIs success:^(TeamStandings * success)
     {
         
         if(success.data.count>0)
         {
             self.loadingLbl.hidden = YES;
             self.standings = [[NSMutableArray alloc]initWithArray: success.data];
             self.standings= [self filterStandingsListByChampId:self.standings withSections:[[NSMutableArray alloc]init] ];
             [self.tableView reloadData];
             self.tableView.hidden = NO;
         }
         else{
             self.loadingLbl.hidden = NO;
             [self.loadingLbl setText:@"لا يوجد  فرق"];
             self.tableView.hidden = YES;
         }
         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Standings"]  ApiError:@"Success"];

     }failure:^(NSError *error) {
         self.loadingLbl.hidden = NO;
         [self.loadingLbl setText:@"لا يوجد  فرق"];
         IBGLog(@"Standings API Error  : %@",error);
         
         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Standings"]ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getTeamStandings];
                                          }];

     }];
}
-(NSString*) getChampionshipIdsString
{
    NSString* championIds = [[NSString alloc]init];
    championIds =  [championIds stringByAppendingString:@"("];
    
    for(int i=0 ; i< self.championships.count ; i++)
    {
        // Concatnate request parameters
        ChampionShipData * champIdItem = self.championships[i];
        championIds = [championIds stringByAppendingString:[NSString stringWithFormat:@"(championshipId = %li)",(long)champIdItem.idField]];
        if(i<self.championships.count-1)
        {
            championIds = [championIds stringByAppendingString:@" or "];
        }
        else
        {
            championIds =  [championIds stringByAppendingString:@")"];
        }
    }
    return championIds;
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
        else {
            [subMatches addObject:item];
        }
    }
    [sections addObject:subMatches];

    return sections;
    
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

#pragma mark - UITableView Datasource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
   // UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
    Standing * item=[[self.standings objectAtIndex:section]objectAtIndex:0];
    if(item.groupName != nil)
    ((MoreHeaderCell*)view).headerTitle.text = [NSString stringWithFormat:@"ترتيب الفريق في %@ في %@",item.championshipName,item.groupName];
     else
    ((MoreHeaderCell*)view).headerTitle.text = [NSString stringWithFormat:@"ترتيب الفريق في %@",item.championshipName];
    ((MoreHeaderCell*)view).headerTitle.textColor=[UIColor lightGrayColor];
    ((MoreHeaderCell*)view).backgroundColor = [UIColor clearColor];
    ((MoreHeaderCell*)view).moreBtn.hidden = YES;
    
    return view;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.standings.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Standing * item = [[self.standings objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StandingsCell"];
    cell = [tableView dequeueReusableCellWithIdentifier:@"StandingsCell"];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"TeamStandingsHeaderCell" owner:self options:nil]objectAtIndex:0];
    [((TeamStandingsHeaderCell*)cell) initWithTeamStandingItem:item];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Standing * item = self.standings[indexPath.row];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)item.teamId;
    teamProfile.teamName = item.teamName;
    [self.navigationController pushViewController:teamProfile animated:YES];
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(self.teamId !=0)
    {
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
}


@end
