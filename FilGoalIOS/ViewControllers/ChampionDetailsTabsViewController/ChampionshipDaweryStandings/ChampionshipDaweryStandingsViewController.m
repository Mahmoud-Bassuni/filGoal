//
//  ChampionshipDaweryStandingsViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ChampionshipDaweryStandingsViewController.h"
#import "TeamStandingsHeaderCell.h"
#import "StandingsLandscapeViewController.h"
#import "StandingsHeaderWithBtnTableViewCell.h"
@import Firebase;
@interface ChampionshipDaweryStandingsViewController ()
{
    NSMutableArray * standings;
}
@end

@implementation ChampionshipDaweryStandingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    standings = [[NSMutableArray alloc]init];
    self.tableView.scrollEnabled = YES;
    self.tableView.delegate = self;
    [self getChampionshipStandingsUsingChampionId:(int)self.championshipItem.idField];
    self.tableView.tableFooterView = [super setBannerViewFooter:@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",self.championshipItem.name]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS- Champion League Standings with ID %ld",(long)self.championshipItem.idField]];

    StandingsHeaderWithBtnTableViewCell * cell= [[[NSBundle mainBundle] loadNibNamed:@"StandingsHeaderWithBtnTableViewCell" owner:self options:nil]objectAtIndex:0];
    [cell.cellBtn addTarget:self action:@selector(landscapeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cellTitleLbl setText:[NSString stringWithFormat:@"ترتيب الفرق في %@ ",self.championshipItem.name]];
    self.tableView.tableHeaderView= cell;
    self.screenName=[NSString stringWithFormat:@"iOS- Champion League Standings with ID %ld",(long)self.championshipItem.idField];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Champion League Standings with ID %ld",(long)self.championshipItem.idField]
                                     }];
    if(self.championshipItem.idField !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.championshipItem.idField])
    {
        NSString * sponsorUrl=[AppSponsors getListingSponsorImagePathUsingChampionId:self.championshipItem.idField andContentType:@"Matches"];
        self.sponsorImgView.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.championshipItem.idField category:@"Matches"];
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgViewHeightConstraint.constant=image.size.height;

        }];
    }
    else
    {
        self.sponsorImgViewHeightConstraint.constant=0.0;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidDisappear:YES];
  //  [[NSNotificationCenter defaultCenter]removeObserver:@"EnableScroll"];
}
#pragma mark - Get Standings Data
-(void) getChampionshipStandingsUsingChampionId:(int) champId
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[
                                                                   [NSString stringWithFormat:@"ChampionshipId eq %li and Week eq %li",(long)champId,self.championshipItem.currentWeek],
                                                                    @"rank asc"]
                             
                                                         forKeys:@[@"$filter",
                                                                   @"$orderby"]];
    NSString *url = [NSString stringWithFormat:TeamStandingsAPI,[WServicesManager getSportsEngineApiBaseURL]];
    
    [WServicesManager getDataWithURLString:url andParameters:paramDic WithObjectName:@"TeamStandings" andAuthenticationType:SportesEngineAPIs success:^(TeamStandings * success)
     {
         
         if(success.data.count>0)
         {
             [standings insertObject:[[Standing alloc]init] atIndex:0]; // standings header
             [standings addObjectsFromArray:success.data];
             [self.tableView reloadData];
             self.tableView.hidden = NO;
             self.loadingLbl.hidden = YES;
         }
         else{
             self.loadingLbl.hidden = NO;
             [self.loadingLbl setText:@"لا يوجد  فرق"];
             self.tableView.hidden = YES;
         }
         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Championship Standings with champion ID = %li ",(long)champId]  ApiError:@"Success"];
         
     }failure:^(NSError *error) {
         self.loadingLbl.hidden = NO;
         [self.loadingLbl setText:@"لا يوجد  فرق"];
         IBGLog(@"Standings API Error  : %@",error);
         
         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Championship Standings with champion ID = %li ",(long)champId] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getChampionshipStandingsUsingChampionId:champId];
                                          }];
         
     }];
}

#pragma mark - UITableView Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return standings.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier ;
    
    UITableViewCell *cell ;
    Standing * item = standings[indexPath.row];
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
        [((StandingsCell*)cell) initWithTeamStandingItem:item];
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return 33;
    else
        return 67;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0)
    {
    Standing * item = standings[indexPath.row];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)item.teamId;
    teamProfile.teamName = item.teamName;
    [self.navigationController pushViewController:teamProfile animated:YES];
    }
}

- (IBAction)landscapeBtnPressed:(id)sender {
    AppDelegate * appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    StandingsLandscapeViewController * standingsView = [[StandingsLandscapeViewController alloc]init];
    standingsView.standings = standings;
    standingsView.championshipItem = self.championshipItem;
    standingsView.modalPresentationStyle = UIModalPresentationFullScreen ;
   // [appDelegate.getSelectedNavigationController pushViewController:standingsView animated:YES];
    [appDelegate.getSelectedNavigationController presentViewController:standingsView animated:YES completion:nil];
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
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
//                    withVelocity:(CGPoint)velocity
//             targetContentOffset:(inout CGPoint *)targetContentOffset{
//    
//    if (velocity.y > 0){
//        BOOL scroll= true;
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:@"scrollUpNotification"
//         object:userInfo];
//        
//    }
//    if (velocity.y < 0){
//        BOOL scroll= false;
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
//        if(scrollView.contentOffset.y<=0)
//            [[NSNotificationCenter defaultCenter]
//             postNotificationName:@"scrollDownNotification"
//             object:userInfo];
//        
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
