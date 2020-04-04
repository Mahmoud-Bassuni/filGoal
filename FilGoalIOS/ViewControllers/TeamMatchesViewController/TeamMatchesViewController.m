//
//  TeamMatchesViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/8/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamMatchesViewController.h"
#import "UsersStatisticsViewController.h"
@import Firebase;
@interface TeamMatchesViewController ()
{
    UIRefreshControl *topRefreshControl;
    int page;
    NSMutableArray * sections;
    NSArray * tabs;
    NSInteger selectedPickerIndex;
}
@end

@implementation TeamMatchesViewController
@synthesize viewType;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self setupTabsTitles];
    [self addBottomPullToRefresh];
    [self addTopPullToRefresh];
    page = 0;
    sections = [[NSMutableArray alloc]init];
    // self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner"] andPosition:@[@"Pos1"]];
    self.selectChampionshipBtn.layer.cornerRadius = 20;
    self.selectChampionshipBtn.clipsToBounds = YES;
    tabs = @[@"مواعيد المباريات",@"نتائج المباريات"];
    self.matchesList = [[NSMutableArray alloc]init];
    if(self.champId==0)
    viewType = @"fixtures";
    if([viewType isEqualToString: @"fixtures"])
    [self.selectChampionshipBtn setTitle:[NSString stringWithFormat:@"   %@",tabs[0]] forState:UIControlStateNormal];
    else
        [self.selectChampionshipBtn setTitle:[NSString stringWithFormat:@"   %@",tabs[1]] forState:UIControlStateNormal];

    [self getTeamMatches:viewType withDate:[NSDate date]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
     self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    if(self.champId==0){
    self.screenName=[NSString stringWithFormat:@"iOS- Team Matches with ID %ld",(long)self.teamId];
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Team Matches with ID %ld",(long)self.teamId]
                                         }];
    }
    else{
        self.screenName=[NSString stringWithFormat:@"iOS- Champion Matches with ID %ld",(long)self.champId];
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Champion Matches with ID %ld",(long)self.champId]
                                         }];
    }
    if(self.champId !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.champId])
    {
        NSString * sponsorUrl=[AppSponsors getListingSponsorImagePathUsingChampionId:self.champId andContentType:@"Matches"];
        self.sponsorImgView.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.champId category:@"Matches"];
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgViewHeightConstraint.constant=image.size.height;
        }];
    }
    else
    {
        self.sponsorImgViewHeightConstraint.constant=0.0;
    }


}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if(self.champId!=0)
    [self setMainSponsor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    /// Main Sponsorship
    if([AppSponsors isChampionActiveUsingId:self.champId])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSpecialChampionshipBannerImagePathUsingId:self.champId]];
    }
    if((mainSponsorUrl==nil||[mainSponsorUrl isEqualToString:@""])&&[AppSponsors isMatchSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationbarChampionSponsorImagePath:self.champId]];
    }
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];
    [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:self.champId section_id:nil activeCategory: nil];
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
- (void)refreshTop {
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    [self.loadingLbl setHidden:NO];
    page = 0;
    [self getTeamMatches:viewType withDate:[NSDate date]];
    
}
-(void)addTopPullToRefresh
{
    topRefreshControl = [UIRefreshControl new];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14],
                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
    topRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"جاري تحميل البيانات" attributes:attributes];
    [topRefreshControl addTarget:self action:@selector(refreshTop) forControlEvents:UIControlEventValueChanged];
    topRefreshControl.tintColor = [UIColor darkGrayColor];
    [self.tableView addSubview:topRefreshControl];
    
    
}
-(void)refreshBottom
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        page += 10;
        [self getTeamMatches:viewType withDate:[NSDate date]];
        [self.tableView.bottomRefreshControl endRefreshing];
    });
    
}

#pragma mark - Get Team Matches
-(void) getTeamMatches:(NSString*)viewTypee withDate:(NSDate*) date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSDictionary * paramDic;
    if(self.champId==0)
    {
    if([viewTypee isEqualToString:@"fixtures"])
    {
        paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"(HomeTeamId eq %i or AwayTeamId eq %i) and Date gt %@",self.teamId,self.teamId,[formatter stringFromDate:date]],[NSString stringWithFormat:@"%i",page],@"Date asc",@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id",@"MatchStatusHistory($orderby=StartAt desc;)",@"10"] forKeys:@[@"$filter",@"$skip",@"$orderby",@"$select",@"$expand",@"$top"]];
    }
    else
    {
        paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"(HomeTeamId eq %i or AwayTeamId eq %i) and Date le %@",self.teamId,self.teamId,[formatter stringFromDate:date]] ,[NSString stringWithFormat:@"%i",page],@"Date desc",@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id",@"MatchStatusHistory($orderby=StartAt desc;)",@"10"] forKeys:@[@"$filter",@"$skip",@"$orderby",@"$select",@"$expand",@"$top"]];
        
    }
    }
    else
    {
        if([viewTypee isEqualToString:@"fixtures"])
        {
            paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and Date gt %@",(long)self.champId,[formatter stringFromDate:date]],[NSString stringWithFormat:@"%i",page],@"Date asc",@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id",@"MatchStatusHistory($orderby=StartAt desc;)",@"10"] forKeys:@[@"$filter",@"$skip",@"$orderby",@"$select",@"$expand",@"$top"]];
        }
        else
        {
            paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and Date le %@",self.champId,[formatter stringFromDate:date]] ,[NSString stringWithFormat:@"%i",page],@"Date desc",@"HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Id",@"MatchStatusHistory($orderby=StartAt desc;)",@"10"] forKeys:@[@"$filter",@"$skip",@"$orderby",@"$select",@"$expand",@"$top"]];

            
        }
    }
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         if(topRefreshControl.isRefreshing)
         {
             [topRefreshControl endRefreshing];
             self.matchesList = [[NSMutableArray alloc]init];
         }
         MatchesList * matchesList = success;
         self.loadingLbl.hidden = YES;
         
         if(matchesList.matches.count>0)
         {
             [self.matchesList addObjectsFromArray:matchesList.matches];
             [self.tableView reloadData];
             [self.tableView layoutIfNeeded];
         }
         else if(self.matchesList.count==0||self.matchesList==nil){
             self.matchesList=[[NSMutableArray alloc]init];
            // [self.tableView reloadData];
             if([viewType isEqualToString:@"fixtures"])
             {
                 [self.loadingLbl setText:@"لا يوجد مواعيد في هذه البطولة"];
             }
             else
             {
                 [self.loadingLbl setText:@"لا يوجد نتائج في هذه البطولة"];
                 
             }
         }
         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Matches with Team ID = %li ",(long)self.teamId]  ApiError:@"Success"];
     }failure:^(NSError *error) {
         self.loadingLbl.hidden = NO;
         [self.loadingLbl setText:@"لا يوجد نتائج في هذه البطولة"];
         IBGLog(@"Matches API Error  : %@",error);
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Matches with Team ID = %li ",(long)self.teamId] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self.tableView.bottomRefreshControl endRefreshing];

         [self.activityIndicator stopAnimating];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getTeamMatches:viewTypee withDate:date];
                                          }];
         
     }];

}
-(BOOL) checkIfListContainsDict
{
    for(NSDictionary *dic in sections){
        if([dic objectForKey:@"مباريات"] != nil){
            [sections removeObject:dic];
            return true;
        }
    }
    return false;
}

#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return self.groupedMatches.count;
    //return sections.count;
    return self.matchesList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section<self.matchesList.count){
    MatchCenterDetails * item = self.matchesList[indexPath.section];
    if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]&&item.matchStatusHistory.count>0&&[[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
        return 170;
    }
    else{
        return 128;
    }
    }else{
        return 0;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    if(indexPath.section<self.matchesList.count){
    MatchCenterDetails * item = self.matchesList[indexPath.section];
    cell =  [MatcheCenterCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchItem:item];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn setTag:item.awayTeamId];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn setTitle:item.awayTeamName forState:UIControlStateNormal];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn addTarget:self action:@selector(awayTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [((MatcheCenterCellLoader*)cell).homeTeamBtn setTag:item.homeTeamId];
    [((MatcheCenterCellLoader*)cell).homeTeamBtn setTitle:item.homeTeamName forState:UIControlStateNormal];
    [((MatcheCenterCellLoader*)cell).homeTeamBtn addTarget:self action:@selector(homeTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [((MatcheCenterCellLoader*)cell).predictMatchBtn addTarget:self action:@selector(predictBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [((MatcheCenterCellLoader*)cell).statisticsBtn addTarget:self action:@selector(statisticalBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    if(self.champId!=0)
    {
        ((MatcheCenterCellLoader*)cell).champNameLbl.hidden=YES;
    }
    else
        ((MatcheCenterCellLoader*)cell).champNameLbl.hidden=NO;

    if([self checkIfMatchDateIsToday:item])
    {
        cell.contentView.backgroundColor = [UIColor colorWithRed:255.0f / 255.0f green:240.0f / 255.0f blue:210.0f / 255.0f alpha:1.0f];
    }
    else
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    }
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate * appdelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = [appdelegate getSelectedNavigationController];
    MatchCenterDetails * item = self.matchesList[indexPath.section];
    MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
    matchCenter.matchCenterDetails = item;
    [navigationController pushViewController:matchCenter animated:YES];
    
}
-(void)championshipHeaderPressed:(UITapGestureRecognizer*) tg
{
    long  tag = tg.view.tag;
    MatchCenterDetails * item = self.matchesList[tag];
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    ChampionShipData * champion = [[ChampionShipData alloc]init];
    Champion * champ=[[Champion alloc]init];
    champ =[[Global getInstance]getChampById:(int) item.championshipId];
    champion.idField = champ.champId;
    champion.name = champ.champName;
    if(champ.champId != 0)
    {
        UINavigationController * navigationController = delegate.getSelectedNavigationController;
        ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
        detailsScreen.champion = champion;
        [navigationController pushViewController:detailsScreen animated:YES];
    }
    
    
}


#pragma mark Group matches by Championships
-(NSMutableArray*)getChampionMatches:(NSArray*)matchesList withSections:(NSMutableArray*)sections{
    //  NSMutableArray *sectiondMatches=[[NSMutableArray alloc] init];
    NSMutableArray *subMatches=[[NSMutableArray alloc] init];
    NSInteger current=-1;
    for (MatchCenterDetails * match  in matchesList ) {
        
        if (current==-1) {
            current=match.championshipId;
            [subMatches addObject:match];
        }
        else if (current!=match.championshipId) {
            current=match.championshipId;
            [sections addObject:subMatches];
            subMatches=[[NSMutableArray alloc] init];
            [subMatches addObject:match];
        }
        else {
            [subMatches addObject:match];
        }
    }
    [sections addObject:subMatches];
    return sections;
    
    
}
#pragma mark - Implement Pager Delegates
#pragma - mark XLPagerTabStripChildItem
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
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
    
    if(components.day == todaycomponents.day && components.month == todaycomponents.month && components.year == todaycomponents.year)
    {
        return true;
    }
    return false;
}

- (IBAction)championshipsBtnPressed:(id)sender {
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@""
                                                                                           rows:tabs
                                                                               initialSelection:selectedPickerIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          [self.activityIndicator startAnimating];
                                                                                          [self.activityIndicator setHidden:NO];
                                                                                          
                                                                                          selectedPickerIndex = selectedIndex;
                                                                                          [self.selectChampionshipBtn setTitle:[NSString stringWithFormat:@"   %@",tabs[selectedPickerIndex]] forState:UIControlStateNormal];
                                                                                          
                                                                                          [self actionsheetSelectionChanged];
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
-(void)actionsheetSelectionChanged
{
    if(selectedPickerIndex == 0)
    {
        viewType = @"fixtures";
    }
    else
    {
        viewType = @"results";
    }
    
    page = 0;
    self.matchesList = [[NSMutableArray alloc]init];
    [self getTeamMatches:viewType withDate:[NSDate date]];
    
}

#pragma mark - UIScrollview delegates
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
    MatchCenterDetails * item = self.matchesList[indexPath.section];
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
    MatchCenterDetails * item = self.matchesList[indexPath.section];

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
