//
//  ChampionshipGroupStandingsViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ChampionshipGroupStandingsViewController.h"
#import "StandingsLandscapeViewController.h"
#import "StandingsHeaderWithBtnTableViewCell.h"
@import Firebase;
@interface ChampionshipGroupStandingsViewController ()
{
    NSInteger selectedPickerIndex;
    NSMutableArray * standings;
    Round * selectedRound;
    NSArray * rounds;
}
@end

@implementation ChampionshipGroupStandingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    rounds = [self getGroupsRounds];
    self.screenName=[NSString stringWithFormat:@"iOS- Champion Group Standings with ID %ld",(long)self.championshipItem.idField];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Champion Group Standings with ID %ld",(long)self.championshipItem.idField]
                                     }];
    if(rounds.count>0)
    {
        self.selectRoundBtn.hidden = NO;
        Round * round = [[Round alloc]init];
        round.name = self.championshipItem.currentRoundName;
        if(rounds.count>0)
        round=rounds[0];
        
        [self.selectRoundBtn setTitle:[NSString stringWithFormat:@"   %@", (round.name!=nil?round.name:round.roundTypeName)] forState:UIControlStateNormal];
        selectedRound=round;
        [self getChampionshipStandingsByRounID:round];
        self.tableView.tableFooterView = [super setBannerViewFooter:@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",self.championshipItem.name]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS- Champion Group Standings with ID %ld",(long)self.championshipItem.idField]];
        StandingsHeaderWithBtnTableViewCell * cell= [[[NSBundle mainBundle] loadNibNamed:@"StandingsHeaderWithBtnTableViewCell" owner:self options:nil]objectAtIndex:0];
        [cell.cellBtn addTarget:self action:@selector(landscapeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cellTitleLbl setText:[NSString stringWithFormat:@"ترتيب الفرق في %@ ",self.championshipItem.name]];
        self.tableView.tableHeaderView= cell;
    }
    else
    {
        self.selectRoundBtn.hidden = YES;
        self.loadingLbl.hidden=YES;
        self.dropdownBtn.hidden=YES;
        [self.activityIndicator stopAnimating];
        self.loadingLbl.hidden = NO;
        [self.loadingLbl setText:@"لا يوجد  فرق"];
        self.tableView.hidden = YES;
        
    }
    if(rounds.count==1)
    {
        [self.selectRoundBtn setHidden:YES];
        [self.dropdownBtn setHidden:YES];
        self.dropDownHeightConstraint.constant=0.0;
    }
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

-(NSArray*)getGroupsRounds
{
    NSMutableArray * list =[[NSMutableArray alloc]init];
    for (Round * item in self.championshipItem.rounds) {
        if(item.roundTypeId == 10)
        {
            [list addObject:item];
        }
    }
    return list;
}
-(void)setSelectedRound
{
    selectedRound = [[Round alloc]init];
    selectedRound.idField = self.championshipItem.currentRoundId;
    selectedRound.name = self.championshipItem.currentRoundName;
    for(Round * item in rounds)
    {
        if(item.idField == self.championshipItem.currentRoundId)
        {
            selectedRound.roundTypeId = item.roundTypeId;
            break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Group Standings
-(NSArray*) groupStandingsByGroupId:(NSArray*)standings
{
    NSMutableArray *resultArray = [NSMutableArray new];
    NSArray *groups = [standings valueForKeyPath:@"@distinctUnionOfObjects.groupId"];
    NSMutableDictionary * groupDic = [[NSMutableDictionary alloc]init];
    NSMutableArray * teams = [[NSMutableArray alloc]init];
    NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    groups = [groups sortedArrayUsingDescriptors:@[descriptor]];
    for (int i=0; i<groups.count; i++) {
        teams = [[NSMutableArray alloc]init];
        for (Standing * item in standings)
        {
            if(item.groupId == [groups[i] integerValue])
            {
                [teams addObject:item];
            }
        }
        if(teams.count>0)
        {
            groupDic = [[NSMutableDictionary alloc]init];
            [teams insertObject:[[Standing alloc]init] atIndex:0]; // standings header
            [groupDic setObject:teams forKey:[NSString stringWithFormat:@"%@",groups[i]]];
        }
        [resultArray addObject:groupDic];
    }
    
    
    return [[NSArray alloc]initWithArray:resultArray];
}
#pragma mark - Get Standings Data
-(void) getChampionshipStandingsByRounID:(Round*) round
{
    int champId = (int)self.championshipItem.idField;
    NSDictionary * paramDic;
    standings = [[NSMutableArray alloc]init];
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    // Groups
    paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"ChampionshipId eq %i and (RoundId in (%li))",champId,round.idField],@"groupId asc,rank asc"] forKeys:@[@"$filter",@"$orderby"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:TeamStandingsAPI,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"TeamStandings" andAuthenticationType:SportesEngineAPIs success:^(TeamStandings * success)
     {
         
         if(success.data.count>0)
         {
             if(selectedRound.roundTypeId == 10)
                 [standings addObjectsFromArray:[self groupStandingsByGroupId:success.data]];
             else
             {
                 [standings insertObject:[[Standing alloc]init] atIndex:0]; // standings header
                 [standings addObjectsFromArray:success.data];
             }
             
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
                                              [self getChampionshipStandingsByRounID:round];
                                          }];
         
     }];
}

-(NSArray*) getRoundsTitles
{
    NSMutableArray * titles = [[NSMutableArray alloc]init];
    
    for(Round * item in rounds)
    {
        [titles addObject:(item.name!=nil?item.name:item.roundTypeName)];
    }
    return [[NSArray alloc]initWithArray:titles];
}
- (IBAction)selectRoundBtnPressed:(id)sender {
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@"أختر المجموعة"
                                                                                           rows:[self getRoundsTitles]
                                                                               initialSelection:selectedPickerIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          Round * item = [rounds objectAtIndex:selectedIndex];
                                                                                          selectedPickerIndex = selectedIndex;
                                                                                          [self.selectRoundBtn setTitle:[NSString stringWithFormat:@"   %@",(item.name!=nil?item.name:item.roundTypeName)] forState:UIControlStateNormal];
                                                                                          selectedRound = item;
                                                                                          [self getChampionshipStandingsByRounID:item];
                                                                                          
                                                                                          
                                                                                      }
                                                                                    cancelBlock:^(ActionSheetStringPicker *picker) {
                                                                                        NSLog(@"Block Picker Canceled");
                                                                                    }
                                                                                         origin:sender];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"تم" style:UIBarButtonItemStyleDone target:self action:nil];
    [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    UIBarButtonItem * cancelButton=[[UIBarButtonItem alloc]initWithTitle:@"الغاء" style:UIBarButtonItemStyleDone target:self action:nil];
    [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [doneButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [actionsheetPicker setCancelButton:cancelButton];
    [actionsheetPicker setDoneButton:doneButton];
    [[UIToolbar appearance]setTintColor:[UIColor whiteColor]];
    actionsheetPicker.pickerBackgroundColor = [UIColor whiteColor];
    actionsheetPicker.toolbarBackgroundColor = [UIColor darkGrayColor];
    actionsheetPicker.toolbarButtonsColor = [UIColor whiteColor];
    [actionsheetPicker showActionSheetPicker];
    
}

#pragma mark - UITableView Datasource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary * dic;
    NSArray * list;
    if( [[standings objectAtIndex:section] isKindOfClass:[NSDictionary class]])
    {
        dic = [standings objectAtIndex:section];
        list = dic.allValues[0] ;
        if(list.count>1)
        {
            Standing * item = list[1];
            UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
            // UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
            ((MoreHeaderCell*)view).headerTitle.text = item.groupName;
            ((MoreHeaderCell*)view).headerTitle.textColor = [UIColor blackColor];
            ((MoreHeaderCell*)view).backgroundColor = [UIColor whiteColor];
            ((MoreHeaderCell*)view).moreBtn.hidden = YES;
            return view;
        }
        else
            return [[UIView alloc]init];
    }
    
    return [[UIView alloc]init];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(selectedRound.roundTypeId == 10)
        return standings.count;
    else
        return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(selectedRound.roundTypeId == 10)
    {
        NSDictionary * dic;
        NSArray * list;
        if( [[standings objectAtIndex:section] isKindOfClass:[NSDictionary class]])
        {
            dic = [standings objectAtIndex:section];
            list = dic.allValues[0] ;
            if(list.count>0)
            {
                return list.count;
            }
            return 0;
            
        }
        else
            return 0;
    }
    else
        return standings.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier ;
    
    UITableViewCell *cell ;
    NSDictionary * dic;
    NSArray * list;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
    }
    cellIdentifier=@"StandingsCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"StandingsCell" owner:self options:nil]objectAtIndex:0];
    if(selectedRound.roundTypeId == 10)
    {
            if( [[standings objectAtIndex:indexPath.section] isKindOfClass:[NSDictionary class]])
            {
                dic = [standings objectAtIndex:indexPath.section];
                list = dic.allValues[0] ;
                if(list.count>0)
                {
                    Standing * item = [list objectAtIndex:indexPath.row];
                    if(indexPath.row==0)
                    {
                        cellIdentifier=@"StandingsHeaderCell";
                        
                        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                        
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"StandingsHeaderCell" owner:self options:nil]objectAtIndex:0];
                        
                    }
                    else
                    [((StandingsCell*)cell) initWithTeamStandingItem:item];
                }
            }
    }
    else
    {
        if(indexPath.row==0)
        {
            cellIdentifier=@"StandingsHeaderCell";
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StandingsHeaderCell" owner:self options:nil]objectAtIndex:0];
            
        }
        else
        {
            Standing * item = [standings objectAtIndex:indexPath.row];
            [((StandingsCell*)cell) initWithTeamStandingItem:item];
        }
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return 33;
    else
        return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(selectedRound.roundTypeId == 10)
        return 40;
    else
        return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0)
    {
        if(selectedRound.roundTypeId == 10)
        {
            if( [[standings objectAtIndex:indexPath.section] isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * dic;
                NSArray * list;
                dic = [standings objectAtIndex:indexPath.section];
                list = dic.allValues[0] ;
                if(list.count>0)
                {
                    Standing * item = [list objectAtIndex:indexPath.row];
                    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
                    teamProfile.teamId = (int)item.teamId;
                    teamProfile.teamName = item.teamName;
                    [self.navigationController pushViewController:teamProfile animated:YES];
                }
                
            }
        }
        else
        {
            Standing * item = standings[indexPath.row];
            TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
            teamProfile.teamId = (int)item.teamId;
            teamProfile.teamName = item.teamName;
            [self.navigationController pushViewController:teamProfile animated:YES];
            
        }
    }
    
}
- (IBAction)landscapeBtnPressed:(id)sender {
    AppDelegate * appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    StandingsLandscapeViewController * standingsView = [[StandingsLandscapeViewController alloc]init];
    standingsView.standings = standings;
    standingsView.selectedRound = selectedRound;
    standingsView.modalPresentationStyle = UIModalPresentationFullScreen ;
    //[appDelegate.getSelectedNavigationController pushViewController:standingsView animated:YES];
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


@end
