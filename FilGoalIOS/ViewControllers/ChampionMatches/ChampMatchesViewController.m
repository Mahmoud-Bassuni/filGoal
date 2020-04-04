//
//  ChampMatchesViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ChampMatchesViewController.h"
#import "MatchesByWeekViewController.h"
#import "MoreViewController.h"
#import "MatchesByRoundViewController.h"
#import "ChampionshipAllmatchesViewController.h"
#import "UsersStatisticsViewController.h"
@import Firebase;
@interface ChampMatchesViewController ()
{
    NSMutableDictionary * matchesDic;
    NSMutableArray * matchList;
    NSMutableArray * allmatches;
    NSInteger selectedPickerIndex;
    NSMutableArray * tabs;
    
}
@end

@implementation ChampMatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    matchList = [[NSMutableArray alloc]init];
    allmatches = [[NSMutableArray alloc]init];
    self.filterBtn.layer.cornerRadius = 20;
    self.filterBtn.clipsToBounds = YES;
    [self getMatchesWithDate:[NSDate date] andViewType:@"Fixtures"];
    [self getMatchesWithDate:[NSDate date] andViewType:@"Results"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.screenName=[NSString stringWithFormat:@"iOS- Champion Fixtures and Results with ID %ld",(long)self.champion.idField];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Champion Fixtures and Results with ID %ld",(long)self.champion.idField]
                                     }];
    if(self.champion.championshipTypeId==ChampionshipTypeDawery)
    {
        [self getWeekNames];
        [self.filterBtn setTitle:@"  الذهاب إلى مباريات الجولة‎  " forState:UIControlStateNormal];
    }
    else
    {
        [self getRoundNames];
        [self.filterBtn setTitle:@"   تصفية بالادوار  " forState:UIControlStateNormal];
    }
    [self setUIElements:self.aggregatedCards];
    if(self.champion.idField !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.champion.idField])
    {
        NSString * sponsorUrl=[AppSponsors getListingSponsorImagePathUsingChampionId:self.champion.idField andContentType:@"Matches"];
        self.sponsorImgView.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.champion.idField category:@"Matches"];
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

#pragma mark - Get Champion Matches
-(void) getMatchesWithDate:(NSDate*)date andViewType:(NSString*)viewType
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSDictionary * paramDic;
    NSInteger idField=self.champion.idField;
    if([viewType isEqualToString:@"Fixtures"])
    {
        paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %ld and Date ge %@",idField,[NSString stringWithFormat:@"%@",[outputFormatter stringFromDate:date]]],@"Date asc",@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id",@"MatchStatusHistory($orderby=StartAt desc;)",@"10"] forKeys:@[@"$filter",@"$orderby",@"$select",@"$expand",@"$top"]];
    }
    else if([viewType isEqualToString:@"Results"])
    {
        paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %ld and Date le %@",idField,[NSString stringWithFormat:@"%@",[outputFormatter stringFromDate:date]]],@"Date desc",@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id",@"MatchStatusHistory($orderby=StartAt desc;)",@"10"] forKeys:@[@"$filter",@"$orderby",@"$select",@"$expand",@"$top"]];
    }
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         MatchesList * matchesList = success;
         self.loadingLbl.hidden = YES;
         
         if(matchesList.matches.count>0)
         {
             [allmatches addObjectsFromArray:matchesList.matches];
             [self setMatchesList];
             
         }
         else{
             
             // [self.loadingLbl setText:@"لا يوجد مواعيد في هذه البطولة"];
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
                                              [self getMatchesWithDate:date andViewType:viewType];
                                          }];
         [self.activityIndicator stopAnimating];
         
     }];
}
-(void)setMatchesList
{
    NSMutableArray * liveMatches = [[NSMutableArray alloc]initWithCapacity:4];
    NSMutableArray * fixturesMatches = [[NSMutableArray alloc]initWithCapacity:5];
    NSMutableArray * resultsMatches = [[NSMutableArray alloc]initWithCapacity:5];
    //NSMutableArray * mainMatches = [[NSMutableArray alloc]initWithCapacity:3];
    matchList = [[NSMutableArray alloc]init];
    for (MatchCenterDetails * matchItem in allmatches) {
        MatchStatusHistory * statusItem =  matchItem.matchStatusHistory[0];
        if(statusItem.matchStatusIndicatorId == MatchNotStartedIndicatorID || statusItem.currentMatchStatus == KMatchPostponed)
        {
            [fixturesMatches addObject:matchItem];
        }
        else if (statusItem.matchStatusIndicatorId == MatchLiveIndicatorID)
        {
            [liveMatches addObject:matchItem];
        }
        else
        {
            [resultsMatches addObject:matchItem];
        }
        
    }
    
    //    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"coverageTypeId"
    //                                                                ascending: NO];
    //    fixturesMatches = [[NSMutableArray alloc]initWithArray:[fixturesMatches sortedArrayUsingDescriptors:@[sortOrder]]];
    //    resultsMatches = [[NSMutableArray alloc]initWithArray:[resultsMatches sortedArrayUsingDescriptors:@[sortOrder]]];
    
    // Get Main matches 2 from fixtures and one from results
    //    if(fixturesMatches.count>2)
    //    {
    //        NSArray *items = [fixturesMatches subarrayWithRange: NSMakeRange( 0, 2 )];
    //        [mainMatches addObjectsFromArray:items];
    //    }
    //    if(resultsMatches.count>1)
    //    {
    //        NSArray *items = [resultsMatches subarrayWithRange: NSMakeRange( 0, 1 )];
    //        [mainMatches addObjectsFromArray:items];
    //    }
    //
    
    // limit number of appeared matches to 3 matches at fixtures and results
    
    if(fixturesMatches.count>3)
    {
        fixturesMatches = [[NSMutableArray alloc]initWithArray:[fixturesMatches subarrayWithRange: NSMakeRange( 0, 3 )]];
        [fixturesMatches addObject:[[NSString alloc]initWithFormat:@"%@",@"المزيد"]];
    }
    else  if(fixturesMatches.count>0)
    {
        [fixturesMatches addObject:[[NSString alloc]initWithFormat:@"%@",@"المزيد"]];
        
    }
    if(resultsMatches.count>3)
    {
        resultsMatches = [[NSMutableArray alloc]initWithArray:[resultsMatches subarrayWithRange: NSMakeRange( 0, 3 )]];
        [resultsMatches addObject:[[NSString alloc]initWithFormat:@"%@",@"المزيد"]];
    }
    else  if(resultsMatches.count>0)
    {
        [resultsMatches addObject:[[NSString alloc]initWithFormat:@"%@",@"المزيد"]];
    }
    
    
    
    //    if(mainMatches.count>0)
    //        [matchList insertObject:[[NSDictionary alloc]initWithObjects:@[mainMatches] forKeys:@[@"أهم المباريات"]] atIndex:0];
    //     if(mainMatches.count>0 && allmatches.count>0)
    //        [matchList addObject:[[NSDictionary alloc]initWithObjects:@[mainMatches] forKeys:@[@"أهم المباريات"]]];
    
    if(liveMatches.count!=0)
    {
        if(liveMatches.count>3&&fixturesMatches.count>3)
        {
            liveMatches = [[NSMutableArray alloc]initWithArray:[fixturesMatches subarrayWithRange: NSMakeRange( 0, 3 )]];
        }
        [matchList insertObject:[[NSDictionary alloc]initWithObjects:@[liveMatches] forKeys:@[@"مباريات مباشرة"]] atIndex:0];
    }
    if(fixturesMatches.count>0 && matchList.count>1)
        [matchList insertObject:[[NSDictionary alloc]initWithObjects:@[fixturesMatches] forKeys:@[@"مواعيد المباريات"]]atIndex:1];
    else if(fixturesMatches.count>0)
        [matchList addObject:[[NSDictionary alloc]initWithObjects:@[fixturesMatches] forKeys:@[@"مواعيد المباريات"]]];
    
    if(resultsMatches.count>0 && matchList.count>2)
        [matchList insertObject:[[NSDictionary alloc]initWithObjects:@[resultsMatches] forKeys:@[@"نتائج المباريات"]] atIndex:2];
    else if(resultsMatches.count>0)
        [matchList addObject:[[NSDictionary alloc]initWithObjects:@[resultsMatches] forKeys:@[@"نتائج المباريات"]]];
    
    [self.tableView reloadData];
    
}

#pragma mark - UItableview Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return matchList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(matchList.count>0)
    {
        NSDictionary * dic = [matchList objectAtIndex:section];
        NSArray * list = dic.allValues[0] ;
        return list.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(matchList.count>0)
    {
        NSDictionary * dic = [matchList objectAtIndex:indexPath.section];
        if(dic != nil)
        {
            NSArray * list = dic.allValues[0];
            if ([list[indexPath.row] isKindOfClass:[MatchCenterDetails class]]) {
                MatchCenterDetails * item = list[indexPath.row];
                if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]&&item.matchStatusHistory.count>0&&[[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
                    return 170;
                }
                else{
                    return 128;
                }
            }
            else
                return 50;
        }
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary * dic = [matchList objectAtIndex:indexPath.section];
    if(dic != nil)
    {
        NSArray * list = dic.allValues[0];
        if(list.count>0)
        {
            if ([list[indexPath.row] isKindOfClass:[MatchCenterDetails class]]) {
                MatchCenterDetails * item = list[indexPath.row];
                cell =  [MatcheCenterCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchItem:item];
                cell.contentView.backgroundColor = [UIColor whiteColor];
                [((MatcheCenterCellLoader*)cell).homeClubView setBackgroundColor:[UIColor lightGrayAppColor]];
                [((MatcheCenterCellLoader*)cell).awayClubView setBackgroundColor:[UIColor lightGrayAppColor]];
                
                [((MatcheCenterCellLoader*)cell).awayTeamBtn setTag:item.awayTeamId];
                [((MatcheCenterCellLoader*)cell).awayTeamBtn setTitle:item.awayTeamName forState:UIControlStateNormal];
                [((MatcheCenterCellLoader*)cell).awayTeamBtn addTarget:self action:@selector(awayTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                [((MatcheCenterCellLoader*)cell).champNameLbl setHidden:YES];
                
                [((MatcheCenterCellLoader*)cell).homeTeamBtn setTag:item.homeTeamId];
                [((MatcheCenterCellLoader*)cell).homeTeamBtn setTitle:item.homeTeamName forState:UIControlStateNormal];
                [((MatcheCenterCellLoader*)cell).homeTeamBtn addTarget:self action:@selector(homeTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                [((MatcheCenterCellLoader*)cell).predictMatchBtn addTarget:self action:@selector(predictBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [((MatcheCenterCellLoader*)cell).statisticsBtn addTarget:self action:@selector(statisticalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            else
            {
                UITableViewCell *moreCell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
                if (moreCell==nil)
                {
                    moreCell = [[UITableViewCell alloc]init];
                    moreCell.accessoryType = UITableViewCellAccessoryNone;
                    moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    moreCell.backgroundColor=[UIColor clearColor];
                    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
                    view.backgroundColor=[UIColor whiteColor];
                    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
                    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:18]];
                    [title setTextColor:[UIColor mainAppYellowColor]];
                    [title setTextAlignment:NSTextAlignmentCenter];
                    [title setBackgroundColor:[UIColor clearColor]];
                    title.text=list[indexPath.row];
                    [view addSubview:title];
                    [moreCell.contentView addSubview:view];
                    cell.contentView.layer.cornerRadius = 5;
                    cell.contentView.clipsToBounds = YES;
                }
                return moreCell;
            }
            
        }
    }
    
    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]init];
    
    [headerView setBackgroundColor:[UIColor lightGrayAppColor]];
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(8, 5, self.tableView.frame.size.width-30, 25)];
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:title.font.pointSize]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentRight];
    NSDictionary * dic = [matchList objectAtIndex:section];
    [title setText:[dic.allKeys objectAtIndex:0]];
    [title setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:title];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate * appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = [appdelegate getSelectedNavigationController];
    if(matchList != nil)
    {
        NSDictionary * dic = [matchList objectAtIndex:indexPath.section];
        NSArray * list = dic.allValues[0];
        if ([list[indexPath.row] isKindOfClass:[MatchCenterDetails class]]) {
            MatchCenterDetails * item = list[indexPath.row];
            MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
            matchCenter.matchCenterDetails = item;
            [navigationController pushViewController:matchCenter animated:YES];
        }
        else
        {
            
            MatchCenterDetails * item=[list objectAtIndex:indexPath.row-1];
            // More cell pressed
            TeamMatchesViewController * matchesVC = [[TeamMatchesViewController alloc]init];
            matchesVC.champId = self.champion.idField;
            MatchStatusHistory * statusItem =  item.matchStatusHistory[0];
            if(statusItem.matchStatusIndicatorId == MatchNotStartedIndicatorID || statusItem.currentMatchStatus == KMatchPostponed)
            {
                matchesVC.viewType=@"fixtures";
            }
            else
                matchesVC.viewType=@"results";
            
            [navigationController pushViewController:matchesVC animated:YES];
        }
        
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
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

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if( self.champion.idField != 0)
    {
        //        if (targetContentOffset->y > 0){
        //            //NSLog(@"up");
        //            self.tableView.scrollEnabled=YES;
        //        }
        //        else if (targetContentOffset->y == 0){
        //            //self.tableView.scrollEnabled=NO;
        //        }
    }
    else
    {
        if (velocity.y > 0){
            //NSLog(@"up");
            BOOL scroll= true;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"ClubProfileScrollUpNotification"
             object:userInfo];
            
        }
        if (velocity.y < 0){
            //NSLog(@"down");
            BOOL scroll= false;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
            if(scrollView.contentOffset.y<=0)
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"ClubProfileScrollDownNotification"
                 object:userInfo];
            
        }
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
- (IBAction)filterBtnPressed:(id)sender {
    
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@""
                                                                                           rows:tabs
                                                                               initialSelection:selectedPickerIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          selectedPickerIndex = selectedIndex;
                                                                                          [self doneBtnPressed];
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
-(void)cancelBtnPressed
{
    [self dismissViewControllerAnimated:self completion:nil]
    ;
}
-(void)doneBtnPressed
{
    [self.activityIndicator startAnimating];
    [self.activityIndicator setHidden:NO];
    ChampionshipAllmatchesViewController * viewController=[[ChampionshipAllmatchesViewController alloc]init];
    viewController.champion=self.champion;
    if(self.champion.championshipTypeId == ChampionshipTypeDawery)
    {
        viewController.selectedWeek=selectedPickerIndex+1;
    }
    else
    {
        Round * selectedRound = self.champion.rounds[selectedPickerIndex];
        viewController.selectedRound=selectedRound;
    }
    [GetAppDelegate().getSelectedNavigationController pushViewController:viewController animated:YES];
}

#pragma mark - Get roundNames
-(void)getRoundNames
{
    tabs = [[NSMutableArray alloc]init];
    for (Round * roundItem in self.champion.rounds) {
        [tabs addObject:(roundItem.name!=nil?roundItem.name:roundItem.roundTypeName)];
    }
}
#pragma mark - Get week names
-(void)getWeekNames
{
    tabs = [[NSMutableArray alloc]init];
    for (int i = 1; i<= self.champion.weeks; i++) {
        [tabs addObject:[NSString stringWithFormat:@"الإسبوع %i",i]];
    }
}

-(void)setUIElements:(NSArray*)data
{
    for(NSDictionary * dic in data)
    {
        if([[dic objectForKey:@"id"]integerValue] == 1)
        {
            [self.nOfGoalsLbl setText:[NSString stringWithFormat:@"%@ هدف",[dic objectForKey:@"value"]]];
        }
        else if([[dic objectForKey:@"id"]integerValue] == 0)
        {
            [self.nOfMatchesLbl setText:[NSString stringWithFormat:@"%@ مباراة",[dic objectForKey:@"value"]]];
        }
        else if([[dic objectForKey:@"id"]integerValue] == 3)
        {
            [self.nOfYellowCardsLbl setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"value"]]];
        }
        else if([[dic objectForKey:@"id"]integerValue] == 4)
        {
            [self.nOfRedCardsLbl setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"value"]]];
        }
    }
    
    
}

#pragma mark - Handle Prediction Action
- (IBAction)statisticalBtnAction:(UIButton*)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(MatcheCenterCellLoader*)sender.superview.superview];
    NSDictionary * dic = [matchList objectAtIndex:indexPath.section];
    if(dic != nil)
    {
        NSArray * list = dic.allValues[0];
        if ([list[indexPath.row] isKindOfClass:[MatchCenterDetails class]]) {
            MatchCenterDetails * item = list[indexPath.row];
            
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
    }
}
- (IBAction)predictBtnAction:(UIButton*)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(MatcheCenterCellLoader*)sender.superview.superview];
    NSDictionary * dic = [matchList objectAtIndex:indexPath.section];
    if(dic != nil)
    {
        NSArray * list = dic.allValues[0];
        if ([list[indexPath.row] isKindOfClass:[MatchCenterDetails class]]) {
            MatchCenterDetails * item = list[indexPath.row];
            
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
    }
    
}
@end
