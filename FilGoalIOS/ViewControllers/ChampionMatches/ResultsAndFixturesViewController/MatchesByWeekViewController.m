//
//  ResultsAndFixturesMatchesViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/26/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "MatchesByWeekViewController.h"
#import "UsersStatisticsViewController.h"
@import Firebase;
@interface MatchesByWeekViewController ()
{
    NSMutableArray * matches;
    NSMutableArray * tabs;
    NSInteger selectedPickerIndex;
}
@end

@implementation MatchesByWeekViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName=[NSString stringWithFormat:@"iOS- Champion Weeks with ID %ld",(long)self.champion.idField];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Champion Weeks with ID %ld",(long)self.champion.idField]
                                     }];
    matches = [[NSMutableArray alloc]init];
    selectedPickerIndex = 0;
    self.dropdownMenuBtn.layer.cornerRadius = 20;
    self.dropdownMenuBtn.clipsToBounds = YES;
    if(self.champion.championshipTypeId == ChampionshipTypeDawery)
    {
        selectedPickerIndex = self.champion.currentWeek-1;
        [self getWeekNames];
        [self getMatchesAPI];

    }
    else
    {
       // [self getRoundNames];
    }
    if(selectedPickerIndex<tabs.count)
    {
        [self.dropdownMenuBtn setTitle:[NSString stringWithFormat:@"   %@",tabs[selectedPickerIndex]] forState:UIControlStateNormal];
    }
    [self.navigationController.navigationBar setTranslucent:NO];
    self.title=@"مباريات";
    [self loadSponsor];

    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Get week names
-(void)getWeekNames
{
    tabs = [[NSMutableArray alloc]init];
    for (int i = 1; i<= self.champion.weeks; i++) {
        [tabs addObject:[NSString stringWithFormat:@"الإسبوع %i",i]];
    }
}
#pragma mark - Get roundNames
-(void)getRoundNames
{
    tabs = [[NSMutableArray alloc]init];
    for (Round * roundItem in self.champion.rounds) {
        [tabs addObject:roundItem.roundTypeName];
    }
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
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"championshipId eq %li and Week eq %li",(long)self.champion.idField,(long)selectedPickerIndex+1],@"Date desc",@"Id,HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,Date,HomeScore,HomePenaltyScore,AwayScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,Week",@"MatchStatusHistory($orderby=StartAt desc;)"] forKeys:@[@"$filter",@"$orderby",@"$select",@"$expand"]];
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         MatchesList * matchesList = success;
         self.tableView.hidden = NO;
         self.loadingLbl.hidden = YES;
         
         if(matchesList.matches.count>0)
         {
             matches = [[NSMutableArray alloc]initWithArray:matchesList.matches];

         }
         else if(matchesList.matches.count==0)
         {
             matches=[[NSMutableArray alloc]init];
             self.loadingLbl.hidden = NO;
             [self.loadingLbl setText:@"لم يتم العثور علي مباريات"];
             self.tableView.hidden=YES;
         }
         [self.tableView reloadData];

         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Champion Matches with  ID = %li ",(long)self.champion.idField]  ApiError:@"Success"];
         
         
     }failure:^(NSError *error) {
         self.loadingLbl.hidden = NO;
         [self.loadingLbl setText:@"لا يوجد نتائج في هذه البطولة"];
         IBGLog(@"Matches API Error  : %@",error);
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Champion Matches with  ID = %@ ",[NSString stringWithFormat:@"Champion Matches with  ID = %li ",(long)self.champion.idField]] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [weakSelf getMatchesAPI];
                                          }];
         
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
    if(matches.count>0&&self.champion.championshipTypeId == ChampionshipTypeDawery)
    {
        [title setText:[NSString stringWithFormat:@"%@",tabs[selectedPickerIndex]]];
    }
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

- (IBAction)dropdownBtnPressed:(id)sender {
    
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@""
                                                                                           rows:tabs
                                                                               initialSelection:selectedPickerIndex
                                                                              doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          [self.activityIndicator startAnimating];
                                                                                          [self.activityIndicator setHidden:NO];
                                                                                          
                                                                                          selectedPickerIndex = selectedIndex;
                                                                                          [self.dropdownMenuBtn setTitle:[NSString stringWithFormat:@"   %@",tabs[selectedPickerIndex]] forState:UIControlStateNormal];
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
