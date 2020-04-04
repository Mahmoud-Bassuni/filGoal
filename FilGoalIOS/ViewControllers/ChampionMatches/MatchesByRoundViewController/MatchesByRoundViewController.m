//
//  MatchesByRoundViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/26/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "MatchesByRoundViewController.h"
#import "UsersStatisticsViewController.h"
@import Firebase;
@interface MatchesByRoundViewController ()
{
    NSMutableArray * matches;
    NSMutableArray * tabs;
    NSInteger selectedGroupIndex;
    NSInteger selectedPickerIndex;
    NSMutableArray * groupNames;
     int page;
}
@end

@implementation MatchesByRoundViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName=[NSString stringWithFormat:@"iOS- Champion Rounds with ID %ld",(long)self.champion.idField];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Champion Rounds with ID %ld",(long)self.champion.idField]
                                     }];
    matches = [[NSMutableArray alloc]init];
    page = 0;
    selectedGroupIndex = 0;
    self.dropdownMenuBtn.layer.cornerRadius = 20;
    self.dropdownMenuBtn.clipsToBounds = YES;
    self.groupsDropDownBtn.layer.cornerRadius = 20;
    self.groupsDropDownBtn.clipsToBounds = YES;
    if(self.champion.currentRoundName != nil)
        [self.dropdownMenuBtn setTitle:[NSString stringWithFormat:@"   %@", self.champion.currentRoundName] forState:UIControlStateNormal];
    else
    {
        Round * item=[self.champion.rounds objectAtIndex:0];
        [self.dropdownMenuBtn setTitle:[NSString stringWithFormat:@"   %@", (item.name!=nil?item.name:item.roundTypeName)] forState:UIControlStateNormal];

    }
    selectedPickerIndex = [self getCurrentRoundIndex];

    //[self addBottomPullToRefresh];
    [self getRoundNames];
    [self getMatchesAPI];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.title=@"مباريات";
    [self loadSponsor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSponsor
{
    NSString * sponsorUrl;
    AppInfo *appInfo= [Global getInstance].appInfo;
    if (([Global getInstance].appInfo.specialSection.champID==self.champion.idField)) {
        sponsorUrl=[NSString stringWithFormat:@"%@",[Global getInstance].appInfo.specialSection.bannerArtWorkImg];
        [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(!error&&image!=nil)
            {
                self.sponsorImgHeightConstraint.constant=67;
            }
        }];
    }
    else
    {
        if (appInfo.sponsor.isActive==1) {
            
            sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
            if (IS_IPHONE_6_PLUS) {
                sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header6plus@3x.png",appInfo.sponsor.imgsBaseUrl];
            }
            else if (IS_IPHONE_6)
            {
                sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header6@2x.png",appInfo.sponsor.imgsBaseUrl];
            }
            else
            {
                sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
            }
            
//            for (ChampSponsor*champ in appInfo.sponsor.champSponsor) {
//                if (champ.champId==self.champion.idField) {
//                    sponsorUrl=[NSString stringWithFormat:@"%@",champ.imgUrl];
//                    break;
//                }
//            }
//            [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                self.sponsorImgHeightConstraint.constant=25;
//                self.sponsorImg.contentMode=UIViewContentModeScaleToFill;
//            }];
        }
        else{
            self.sponsorImgHeightConstraint.constant=0;
            
        }
    }
    if([sponsorUrl isEqualToString:@""]||sponsorUrl==nil)
    {
        self.sponsorImgHeightConstraint.constant=0;
        
    }
    
}
#pragma mark - Get selected Round
-(NSInteger) getCurrentRoundIndex
{
    for(int i =0;i<self.champion.rounds.count;i++)
    {
        Round * item = self.champion.rounds[i];
        if(item.idField == self.champion.currentRoundId)
        {
            [self.dropdownMenuBtn setTitle:[NSString stringWithFormat:@"   %@",(item.name!=nil?item.name:item.roundTypeName)] forState:UIControlStateNormal];
            return i;
        }
    }
    return 0;
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
-(void)getGroupNames:(Stage*)stage
{
    groupNames = [[NSMutableArray alloc]init];
    for (Group * groupItem in stage.groups) {
        [groupNames addObject:groupItem.name];
    }
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
-(NSArray *) getGroupNamesFromStage:(Stage*)stage
{
    NSMutableArray * groups = [[NSMutableArray alloc]init];
    for (NSDictionary * group in stage.groups) {
        [groups addObject:[[NSDictionary alloc]initWithObjects:@[[group objectForKey:@"name"]] forKeys:@[[group objectForKey:@"id"]]]];
    }
    return groups;
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
        [self.tableView.bottomRefreshControl endRefreshing];
    });
    
}

-(void)getMatchesAPI
{
    __weak __typeof(self) weakSelf = self;

    if(page == 0)
    {
    self.activityIndicator.hidden = NO;
    self.tableView.hidden = YES;
    self.loadingLbl.hidden = NO;
    [self.activityIndicator startAnimating];
    }
    NSDictionary * paramDic;
    Round * selectedRound = self.champion.rounds[selectedPickerIndex];
    
    if(selectedRound.roundTypeId != 10)
    {
        paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and RoundId eq %ld",(long)self.champion.idField,(long)selectedRound.idField],@"Date desc",@"Id,HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,RoundId,GroupId",@"MatchStatusHistory($orderby=StartAt desc;)"] forKeys:@[@"$filter",@"$orderby",@"$select",@"$expand"]];
        self.groupsBtnHeight.constant = 0;
        self.groupsDropdownArrow.hidden = YES;
        
    }
    else
    {
        self.groupsBtnHeight.constant = 35;
        self.groupsDropdownArrow.hidden = NO;
        Stage * stage = [self getCurrentRoundStage:selectedRound];
        if(stage != nil)
            [self getGroupNames:stage];
        if(stage.groups.count>0)
        {
            NSArray * groups = stage.groups;
            Group * groupItem = [groups objectAtIndex:selectedGroupIndex];
            [self.groupsDropDownBtn setTitle:[NSString stringWithFormat:@"   %@",groupNames[selectedGroupIndex]] forState:UIControlStateNormal];
            
//            paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and RoundId eq %ld and GroupId eq %ld",(long)self.champion.idField,(long)selectedRound.idField,groupItem.idField],@"Date desc",@"Id,HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,RoundId,GroupId",@"MatchStatusHistory($orderby=StartAt desc;)",@"10",[NSString stringWithFormat:@"%i",page]] forKeys:@[@"$filter",@"$orderby",@"$select",@"$expand",@"$top",@"$skip"]];
              paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and RoundId eq %ld and GroupId eq %ld",(long)self.champion.idField,(long)selectedRound.idField,groupItem.idField],@"Date desc",@"Id,HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,RoundId,GroupId",@"MatchStatusHistory($orderby=StartAt desc;)"] forKeys:@[@"$filter",@"$orderby",@"$select",@"$expand"]];
        }
        
    }
    if(paramDic != nil)
    {
        [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(id success)
         {
             self.tableView.hidden = NO;
             self.loadingLbl.hidden = YES;
             MatchesList * matchesList = success;
             
             if(matchesList.matches.count>0)
             {
                 [matches addObjectsFromArray:matchesList.matches];
                 [self.tableView reloadData];
                 
             }
           else if(matchesList.matches.count==0)
             {
                 matches=[[NSMutableArray alloc]init];
                 self.loadingLbl.hidden = NO;
                 [self.loadingLbl setText:@"لم يتم العثور علي مباريات"];
                 self.tableView.hidden=YES;
             }
             [self.activityIndicator stopAnimating];
             [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Champion Matches with  ID = %li ",(long)self.champion.idField]  ApiError:@"Success"];
             
             
         }failure:^(NSError *error) {
             [self showDefaultNetworkingErrorMessageForError:error
                                              refreshHandler:^{
                                                  [weakSelf getMatchesAPI];
                                              }];
             self.loadingLbl.hidden = NO;
             [self.loadingLbl setText:@"لا يوجد نتائج في هذه البطولة"];
             IBGLog(@"Matches API Error  : %@",error);
             [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Champion Matches with  ID = %@ ",[NSString stringWithFormat:@"Champion Matches with  ID = %li ",(long)self.champion.idField]] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
             
             [self.activityIndicator stopAnimating];
             
         }];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    MatchCenterDetails * item = [matches objectAtIndex:indexPath.row];
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
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:title.font.pointSize]];
    [title setTextColor:[UIColor whiteColor]];
    [title setTextAlignment:NSTextAlignmentRight];
    [title setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:title];
    headerView.tag=section;
    UITapGestureRecognizer *tapHeader=[[UITapGestureRecognizer alloc] init];
    [tapHeader  addTarget:self action:@selector(championshipHeaderPressed:)];
    
    [headerView addGestureRecognizer:tapHeader];
    [title setText:[NSString stringWithFormat:@"%@",@"مباريات"]];

    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate * appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    MatchCenterDetails * item = [matches objectAtIndex:indexPath.row];
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return matches.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchCenterDetails * item = [matches objectAtIndex:indexPath.row];
    if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]&&item.matchStatusHistory.count>0&&[[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
        return 170;
    }
    else{
        return 128;
    }
}

-(void)championshipHeaderPressed:(UITapGestureRecognizer*) tg
{
    long  tag = tg.view.tag;
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    MatchCenterDetails * item = [matches objectAtIndex:tag] ;
    ChampionShipData * champion = [[ChampionShipData alloc]init];
    champion.idField = item.championshipId;
    champion.name = item.championshipName;
    
    if(item.championshipId != 0)
    {
        UINavigationController * navigationController = delegate.getSelectedNavigationController;
        ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
        detailsScreen.champion = champion;
        [navigationController pushViewController:detailsScreen animated:YES];
    }
    
}

- (IBAction)groupsDropDownBtnPressed:(id)sender{
    
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@""
                                                                                           rows:groupNames
                                                                               initialSelection:selectedGroupIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          [self.activityIndicator startAnimating];
                                                                                          [self.activityIndicator setHidden:NO];
                                                                                          
                                                                                          selectedGroupIndex = selectedIndex;
                                                                                          [self.groupsDropDownBtn setTitle:[NSString stringWithFormat:@"   %@",groupNames[selectedPickerIndex]] forState:UIControlStateNormal];
                                                                                          page = 0;
                                                                                           matches = [[NSMutableArray alloc]init];
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

- (IBAction)dropdownBtnPressed:(id)sender {
    
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@""
                                                                                           rows:tabs
                                                                               initialSelection:selectedPickerIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                      [self.activityIndicator startAnimating];
                                                                                          [self.activityIndicator setHidden:NO];
                                                                                          
                                                                                          selectedPickerIndex = selectedIndex;
                                                                                          
                                                                                          page = 0;
                                                                                          matches = [[NSMutableArray alloc]init];
                                                                                          [self.dropdownMenuBtn setTitle:[NSString stringWithFormat:@"   %@",tabs[selectedPickerIndex]] forState:UIControlStateNormal];
                                                                                          [self getMatchesAPI];
                                                                                      }
                                                                                    cancelBlock:^(ActionSheetStringPicker *picker) {
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
    MatchCenterDetails * item = [matches objectAtIndex:indexPath.row];
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
    MatchCenterDetails * item = [matches objectAtIndex:indexPath.row];

    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"FilGoalPredictions://"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"FilGoalPredictions://https://predictnwin.filgoal.com/prediction/Predict?champId=%li&MatchId=%li",(long)item.championshipId,(long)item.idField]]];
    }
    else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://predictnwin.filgoal.com/prediction/Predict?champId=%li&MatchId=%li",(long)item.championshipId,(long)item.idField]]];
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Predictions"
                                                          action:@"Predict-Button"
                                                           label:[NSString stringWithFormat:@"Match ID = %i ",item.idField]
                                                           value:nil] build]];
}

@end
