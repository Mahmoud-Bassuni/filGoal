//
//  ChampionshipAllmatchesViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 2/1/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import "ChampionshipAllmatchesViewController.h"
#import "UsersStatisticsViewController.h"
@interface ChampionshipAllmatchesViewController ()
{
    NSMutableArray * matches;
    int page;
    NSInteger selectedPickerIndex;
    NSMutableArray * tabs;
    NSMutableArray * groupNames;
    NSArray * groups;
    
}
@end

@implementation ChampionshipAllmatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(self.champion.championshipTypeId == ChampionshipTypeDawery)
    {
        [self.filterBtn setTitle:[NSString stringWithFormat:@"الإسبوع %li",(long)self.selectedWeek] forState:UIControlStateNormal];
        selectedPickerIndex = self.champion.currentWeek-1;
        [self getWeekNames];
    }
    else
    {
        if(self.selectedRound.roundTypeId == ROUND_GROUPS_ID)
        {
            Stage * stage = [self getCurrentRoundStage:self.selectedRound];
            if(stage != nil)
                [self getGroupNames:stage];
            if(stage.groups.count>0)
            {
                self.filterBtn.hidden=YES;
                self.filtersBtnHeightConstraint.constant=0;
                self.groupsDropdownArrow.hidden=YES;
            }
        }
        else
        {
            [self.filterBtn setTitle:[NSString stringWithFormat:@"   %@", (self.selectedRound.name!=nil?self.selectedRound.name:self.selectedRound.roundTypeName)] forState:UIControlStateNormal];
            self.filtersBtnHeightConstraint.constant=50;
            selectedPickerIndex = [self getCurrentRoundIndex];
            [self getRoundNames];
        }
    }
    page=0;
    // self.title=@"مباريات";
    [self setCoSponsor];
    [self addBottomPullToRefresh];
    [self getMatchesAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self setMainSponsor];
}
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    /// Main Sponsorship
    if([AppSponsors isChampionActiveUsingId:self.champion.idField])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSpecialChampionshipBannerImagePathUsingId:self.champion.idField]];
    }
    if((mainSponsorUrl==nil||[mainSponsorUrl isEqualToString:@""])&&[AppSponsors isMatchSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationbarChampionSponsorImagePath:self.champion.idField]];
    }
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];
    [super setNavigationBarBackgroundFromChildViewControllerImageStr:mainSponsorUrl champs_id:self.champion.idField section_id:nil activeCategory: nil];
}
#pragma mark - Get selected Round
-(NSInteger) getCurrentRoundIndex
{
    for(int i =0;i<self.champion.rounds.count;i++)
    {
        Round * item = self.champion.rounds[i];
        if(item.idField == self.champion.currentRoundId)
        {
            [self.filterBtn setTitle:[NSString stringWithFormat:@"   %@",(item.name!=nil?item.name:item.roundTypeName)] forState:UIControlStateNormal];
            return i;
        }
    }
    return 0;
}
-(Stage*)getCurrentRoundStage:(Round*)currentRound
{
    for (Stage * stageItem in self.champion.stages) {
        if(stageItem.isGroups&&stageItem.rounds.count>0)
        {
            for(Round * roundItem in stageItem.rounds)
            {
                if(currentRound.idField == roundItem.idField)
                {
                    return stageItem;
                }
            }
            
        }
    }
    return [[Stage alloc]init];
}

-(void)getGroupNames:(Stage*)stage
{
    groupNames = [[NSMutableArray alloc]init];
    for (Group * groupItem in stage.groups) {
        [groupNames addObject:groupItem.name];
    }
}
#pragma mark - Get roundNames
-(void)getRoundNames
{
    tabs = [[NSMutableArray alloc]init];
    for (Round * roundItem in self.champion.rounds) {
        [tabs addObject:(roundItem.name!=nil?roundItem.name:roundItem.roundTypeName)];
    }
}
#pragma mark - Get roundNames
#pragma mark - Group Standings
-(NSArray*) groupMatchesByGroupId:(NSArray*)matches andGroups:(NSArray*) groupsList
{
    NSMutableArray *resultArray = [NSMutableArray new];
    NSArray *groups = [matches valueForKeyPath:@"@distinctUnionOfObjects.groupId"];
    NSMutableDictionary * groupDic = [[NSMutableDictionary alloc]init];
    NSMutableArray * teams = [[NSMutableArray alloc]init];
    NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    groups = [groups sortedArrayUsingDescriptors:@[descriptor]];
    for (int i=0; i<groups.count; i++) {
        teams = [[NSMutableArray alloc]init];
        for (MatchCenterDetails * item in matches)
        {
            if(item.groupId == [groups[i] integerValue])
            {
                [teams addObject:item];
            }
        }
        if(teams.count>0)
        {
            groupDic = [[NSMutableDictionary alloc]init];
            NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"date"
                                                                        ascending: YES];
            teams = (NSMutableArray*)[teams sortedArrayUsingDescriptors:@[sortOrder]];
            [groupDic setObject:teams forKey:[NSString stringWithFormat:@"%@",groups[i]]];
        }
        [resultArray addObject:groupDic];
    }
    
    
    return [[NSArray alloc]initWithArray:resultArray];
}
-(Stage*)getStageUsingStageId:(NSInteger) currentStageId
{
    Stage * stageItem = [[Stage alloc]init];
    for (Stage * item in self.champion.stages) {
        if(item.idField == currentStageId)
        {
            stageItem = item;
            break;
        }
    }
    return stageItem;
}
-(Group*)getGroupUsingGroupId:(NSInteger) groupId
{
    Group * groupItem = [[Group alloc]init];
    for (Group * item in groups) {
        if(item.idField == groupId)
        {
            groupItem = item;
            break;
        }
    }
    return groupItem;
}
-(NSArray *) getGroupNamesFromStage:(Stage*)stage
{
    NSMutableArray * groups = [[NSMutableArray alloc]init];
    for (NSDictionary * group in stage.groups) {
        [groups addObject:[[NSDictionary alloc]initWithObjects:@[[group objectForKey:@"name"]] forKeys:@[[group objectForKey:@"id"]]]];
    }
    return groups;
}
-(void)setCoSponsor
{
    if(self.champion.idField !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.champion.idField])
    {
        NSString * sponsorUrl=[AppSponsors getListingSponsorImagePathUsingChampionId:self.champion.idField andContentType:@"Matches"];
        self.sponsorImg.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.champion.idField category:@"Matches"];
        [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgHeightConstraint.constant=image.size.height;

        }];
    }
    else
    {
        self.sponsorImgHeightConstraint.constant=0.0;
    }
}

#pragma mark - Handle Bottom refresh
-(void)addBottomPullToRefresh
{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor darkGrayColor];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14],
                                 NSForegroundColorAttributeName: [UIColor blackColor]};
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"جاري تحميل البيانات"attributes:attributes];
    refreshControl.triggerVerticalOffset = 80.;
    [refreshControl addTarget:self action:@selector(refreshBottom) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl=refreshControl;
}
-(void)refreshBottom
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        page += 10;
        [self getMatchesAPI];
    });
    
}
-(void)getMatchesAPI
{
    __weak __typeof(self) weakSelf = self;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSDictionary * paramDic;
    if(self.champion.championshipTypeId==ChampionshipTypeDawery)
    {
        paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and Week eq %li",(long)self.champion.idField,(long)self.selectedWeek],[NSString stringWithFormat:@"%i",page],@"Date desc",@"Id,HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Week",@"MatchStatusHistory($orderby=StartAt desc;)"] forKeys:@[@"$filter",@"$skip",@"$orderby",@"$select",@"$expand"]];
    }
    else  if(self.selectedRound.roundTypeId == ROUND_GROUPS_ID)
    {
        Stage * stage = [self getCurrentRoundStage:self.selectedRound];
        if(stage != nil)
            [self getGroupNames:stage];
        self.selectedRound=[self.champion.rounds objectAtIndex:selectedPickerIndex];
        paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and RoundId eq %ld",(long)self.champion.idField,(long)self.selectedRound.idField],[NSString stringWithFormat:@"%i",page],@"Date desc",@"Id,HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,RoundId,GroupId",@"MatchStatusHistory($orderby=StartAt desc;)"] forKeys:@[@"$filter",@"$skip",@"$orderby",@"$select",@"$expand"]];
    }
    else
    {
        self.selectedRound=[self.champion.rounds objectAtIndex:selectedPickerIndex];
        paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and RoundId eq %ld",(long)self.champion.idField,(long)self.selectedRound.idField],[NSString stringWithFormat:@"%i",page],@"Date desc",@"Id,HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,RoundId,GroupId",@"MatchStatusHistory($orderby=StartAt desc;)"] forKeys:@[@"$filter",@"$skip",@"$orderby",@"$select",@"$expand"]];
    }
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         MatchesList * matchesList = success;
         self.tableView.hidden = NO;
         self.loadingLbl.hidden = YES;
         
         if(matchesList.matches.count>0)
         {
             matches = [[NSMutableArray alloc]initWithArray:matchesList.matches];
             if(self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
             {
                 Stage * stage = [self getCurrentRoundStage:self.selectedRound];
                 if(stage != nil)
                     [self getGroupNames:stage];
                 if(stage.groups.count>0)
                 {
                     groups = stage.groups;
                     matches=[[NSMutableArray alloc]initWithArray:[self groupMatchesByGroupId:matches andGroups:groups]];
                 }
             }
             [self.tableView reloadData];
             
         }
         else if(matchesList.matches.count==0&&!self.tableView.bottomRefreshControl.isRefreshing)
         {
             matches=[[NSMutableArray alloc]init];
             self.loadingLbl.hidden = NO;
             [self.loadingLbl setText:@"لم يتم العثور علي مباريات"];
             self.tableView.hidden=YES;
         }
         if(self.tableView.bottomRefreshControl.isRefreshing)
         {
             [self.tableView.bottomRefreshControl endRefreshing];
         }
         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Champion Matches with  ID = %@ ",[NSString stringWithFormat:@"Champion Matches with  ID = %li ",(long)self.champion.idField]]  ApiError:@"Success"];
         
         
     }failure:^(NSError *error) {
         self.loadingLbl.hidden = NO;
         [self.loadingLbl setText:@"لا يوجد نتائج في هذه البطولة"];
         IBGLog(@"Matches API Error  : %@",error);
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Champion Matches with  ID = %@ ",[NSString stringWithFormat:@"Champion Matches with  ID = %li ",(long)self.champion.idField]] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [weakSelf getMatchesAPI];
                                          }];
         [self.tableView.bottomRefreshControl endRefreshing];
         
         [self.activityIndicator stopAnimating];
         
     }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    MatchCenterDetails * item;
    if(self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
    {
        Group * groupItem=groups[indexPath.section];
        NSArray* list= [[matches objectAtIndex:indexPath.section]objectForKey:[NSString stringWithFormat:@"%ld", (long)groupItem.idField]];
        item = [list objectAtIndex:indexPath.row];
    }
    else
        item = [matches objectAtIndex:indexPath.row];
    
    cell = [MatcheCenterCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchItem:item];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn setTag:item.awayTeamId];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn setTitle:item.awayTeamName forState:UIControlStateNormal];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn addTarget:self action:@selector(awayTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [((MatcheCenterCellLoader*)cell).champNameLbl setHidden:YES];
    
    [((MatcheCenterCellLoader*)cell).homeTeamBtn setTag:item.homeTeamId];
    [((MatcheCenterCellLoader*)cell).homeTeamBtn setTitle:item.homeTeamName forState:UIControlStateNormal];
    [((MatcheCenterCellLoader*)cell).homeTeamBtn addTarget:self action:@selector(homeTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [((MatcheCenterCellLoader*)cell).predictMatchBtn addTarget:self action:@selector(predictBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [((MatcheCenterCellLoader*)cell).statisticsBtn addTarget:self action:@selector(statisticalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];
    [headerView setBackgroundColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0  blue:68.0/255.0  alpha:1.0]];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width-10, 35)];
    [title setFont:[UIFont defaultMeduimFontOfSize:14.0]];
    [title setTextColor:[UIColor whiteColor]];
    [title setTextAlignment:NSTextAlignmentRight];
    [title setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:title];
    headerView.tag=section;
    if(matches.count>0&&self.champion.championshipTypeId == ChampionshipTypeDawery)
    {
        [title setText:[NSString stringWithFormat:@"الإسبوع %li",(long)self.selectedWeek]];
    }
    else if (self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
    {
        Group * groupItemm=groups[section];
        [title setText:groupItemm.name];
    }
    else
    {
        [title setText:[NSString stringWithFormat:@"%@",(self.selectedRound.name!=nil?self.selectedRound.name:self.selectedRound.roundTypeName)]];
    }
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate * appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    MatchCenterDetails * item;
    if(self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
    {
        Group * groupItem=groups[indexPath.section];
        NSArray* list= [[matches objectAtIndex:indexPath.section]objectForKey:[NSString stringWithFormat:@"%ld", (long)groupItem.idField]];
        item = [list objectAtIndex:indexPath.row];
    }
    else
        item = [matches objectAtIndex:indexPath.row];
    MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
    matchCenter.matchCenterDetails = item;
    if(self.navigationController != nil)
        [self.navigationController pushViewController:matchCenter animated:YES];
    else
    {
        UINavigationController * navigationContoller = [appdelegate getSelectedNavigationController];
        [navigationContoller pushViewController:matchCenter animated:YES];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
    {
        return matches.count;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
    {
        Group * groupItem=groups[section];
        NSArray* list= [[matches objectAtIndex:section]objectForKey:[NSString stringWithFormat:@"%ld", (long)groupItem.idField]];
        return list.count;
    }
    return matches.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchCenterDetails * item;
    if(self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
    {
        Group * groupItem=groups[indexPath.section];
        NSArray* list= [[matches objectAtIndex:indexPath.section]objectForKey:[NSString stringWithFormat:@"%ld", (long)groupItem.idField]];
        item = [list objectAtIndex:indexPath.row];
    }
    else
        item = [matches objectAtIndex:indexPath.row];
    
    if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]&&item.matchStatusHistory.count>0&&[[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
        return 170;
    }
    else{
        return 128;
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)getWeekNames
{
    tabs = [[NSMutableArray alloc]init];
    for (int i = 1; i<= self.champion.weeks; i++) {
        [tabs addObject:[NSString stringWithFormat:@"الإسبوع %i",i]];
    }
}
- (IBAction)filterBtnPressed:(id)sender {
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@""
                                                                                           rows:tabs
                                                                               initialSelection:selectedPickerIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          [self.activityIndicator startAnimating];
                                                                                          [self.activityIndicator setHidden:NO];
                                                                                          selectedPickerIndex = selectedIndex;
                                                                                          self.selectedWeek=selectedPickerIndex+1;
                                                                                          [self.filterBtn setTitle:[NSString stringWithFormat:@"   %@",tabs[selectedPickerIndex]] forState:UIControlStateNormal];
                                                                                          [self getMatchesAPI];
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
    if(self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
    {
        Group * groupItem=groups[indexPath.section];
        NSArray* list= [[matches objectAtIndex:indexPath.section]objectForKey:[NSString stringWithFormat:@"%ld", (long)groupItem.idField]];
        item = [list objectAtIndex:indexPath.row];
    }
    else
        item = [matches objectAtIndex:indexPath.row];
    if(item != nil){
        UsersStatisticsViewController * viewController = [[UsersStatisticsViewController alloc]init];
        viewController.matchItem = item;
        STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:viewController];
        popupController.style = STPopupStyleFormSheet;
        [popupController presentInViewController:GetAppDelegate().getSelectedNavigationController.topViewController];
        
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Predictions"
                                                              action:@"Statistics-Button"
                                                               label:[NSString stringWithFormat:@"Match ID = %i ",item.idField]
                                                               value:nil] build]];
    }
}

- (IBAction)predictBtnAction:(UIButton*)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(MatcheCenterCellLoader*)sender.superview.superview];
    MatchCenterDetails * item;
    if(self.selectedRound.roundTypeId==ROUND_GROUPS_ID)
    {
        Group * groupItem=groups[indexPath.section];
        NSArray* list= [[matches objectAtIndex:indexPath.section]objectForKey:[NSString stringWithFormat:@"%ld", (long)groupItem.idField]];
        item = [list objectAtIndex:indexPath.row];
    }
    else
        item = [matches objectAtIndex:indexPath.row];
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
                                                           label:[NSString stringWithFormat:@"Match ID = %i ",item.idField]
                                                           value:nil] build]];
    
}

@end
