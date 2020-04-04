//
//  MatchesByDateViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 4/18/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "MatchesByDateViewController.h"
#import "MatcheCenterCellLoader.h"
#import "UIImageView+WebCache.h"
#import "UsersStatisticsViewController.h"
#import "TappableSponsorImageView.h"
@import Firebase;
@interface MatchesByDateViewController ()
{
    NSArray * matches;
    ActionSheetDatePicker * picker;
    AppDelegate * appDelegate;
    UIRefreshControl *topRefreshControl;
}
@end

@implementation MatchesByDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
//    self.tableView.emptyDataSetSource = self;
//    self.tableView.emptyDataSetDelegate = self;
    self.screenName = @"iOS-Get Matches by Date ";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS-Get Matches by Date "
                                     }];
    //self.tableView.tableFooterView = [super setBannerViewFooter:@[@"Inner",@"Match"] andPosition:@[@"Pos1"]andScreenName: @"iOS-Get Matches by Date"];

    [self createNavigationFilterBtn];
    [self.tableView setHidden:YES];
    // self.tableView.tableFooterView=[super setBannerViewFooter];
    [self getMatchesByDate];
    if(!self.isFromMatchesView)
    {
       // [self setScreenSponsor];
        [self.dateLbl setText:self.selectedDateStr];
        //self.title = @"مباريات";
    }
    else{
        self.sponsorImgHeightConstraint.constant = 0.0;
        self.dateLblHeightConstraint.constant = 0.0;
        self.topSpaceHeightConstraint.constant = 0.0;
        self.isFromMatchesView = NO;
        [self setMainSponsor];
    }
    [self addTopPullToRefresh];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[super setUpBannerUnderNav:self.view anotherTopView:nil];
}

-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    if([AppSponsors isMatchSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"Matches"]];
        [self setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: @"Matches"];
    } else {
        [self setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: nil];
    }
    //[self setNavigationBarBackgroundImage:mainSponsorUrl];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTopPullToRefresh
{
    topRefreshControl = [UIRefreshControl new];
    topRefreshControl.tintColor = [UIColor blackColor];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14],
                                 NSForegroundColorAttributeName: [UIColor blackColor]};
    topRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"جاري تحميل البيانات" attributes:attributes];
    [topRefreshControl addTarget:self action:@selector(getMatchesByDate) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:topRefreshControl];
}
-(void)createNavigationFilterBtn
{
    UIButton * filterMatches = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterMatches setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    filterMatches.bounds = CGRectMake(0,0,30,30);
    [filterMatches addTarget:self action:@selector(filterMatchesUsingDate:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterMatches];
    [filterMatches addTarget:self action:@selector(filterMatchesUsingDate:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)filterMatchesUsingDate:(id)sender
{
    NSDate * date=[NSDate date];
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    if(_selectedDateStr != nil)
    {
        date=[formatter dateFromString:_selectedDateStr];
    }
    picker = [[ActionSheetDatePicker alloc]initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:date target:self action:@selector(getMatchesByDate:) origin:sender];
    picker.toolbarBackgroundColor = [UIColor darkGrayColor];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTintColor:[UIColor darkGrayColor]];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"إلغاء" forState:UIControlStateNormal];
    [cancelButton setFrame:CGRectMake(0, 0, 32, 32)];
    [picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:cancelButton]];
    
    UIButton * doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // [doneButton addTarget:self action:@selector(getMatchesByDate:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTintColor:[UIColor darkGrayColor]];
    [doneButton setTitle:@"تم" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setFrame:CGRectMake(0, 0, 32, 32)];
    [picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:doneButton]];
    
    [picker showActionSheetPicker];
}
-(void)getMatchesByDate:(NSDate *)selectedDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:selectedDate];
    [components setDay:[components day]-1];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSDate * afterDate = [gregorian dateFromComponents:components];
    self.selectedDateStr = [outputFormatter stringFromDate:selectedDate];
    self.dayBeforeSelectedDateStr = [outputFormatter stringFromDate:afterDate];
    [self getMatchesByDate];
    
    
}

#pragma mark - Calculate Date
-(NSString*)calculateDate:(int)days andOperator:(char)sign
{
    int offset = [[[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]intValue];
    NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
    [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dtfrm setDateFormat:@"yyyy-MM-dd"];
    NSDate * selectedDate = [dtfrm dateFromString:self.selectedDateStr];
    NSTimeInterval seconds = [selectedDate timeIntervalSince1970]+(60*60*offset);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [outputFormatter setLocale:usLocale];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    [components setDay:[[[NSExpression expressionWithFormat:[NSString stringWithFormat:@"%ld%c%d",(long)[components day],sign,days]]expressionValueWithObject:nil context:nil]integerValue]];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    [components setHour:[components hour]];
    [components setMinute:[components minute]];
    NSString * selectedDateStr = [outputFormatter stringFromDate:[gregorian dateFromComponents:components]];
    return  selectedDateStr;
}
-(void) getMatchesByDate
{
    [self.dateLbl setText:self.selectedDateStr];
    // NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"Date lt %@ and Date ge %@",[NSString stringWithFormat:@"%@T22:00:00Z",self.selectedDateStr],[NSString stringWithFormat:@"%@T22:00:00Z",self.dayBeforeSelectedDateStr]],@"championshipId",@"MatchStatusHistory"] forKeys:@[@"$filter",@"$orderby",@"$expand"]];
    NSDictionary * paramDic =[[NSDictionary alloc]initWithObjects:@[@"Date desc",@"MatchStatusHistory($orderby=StartAt desc;)",@"Id,HomeTeamId,AwayTeamId,HomeTeamName,AwayTeamName,HomeScore,AwayScore,HomePenaltyScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,ChampionshipOrder,MatchStatusHistory,Date,OrderInDay",[NSString stringWithFormat:@"Date lt %@ and Date ge %@",[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'+']],[NSString stringWithFormat:@"%@Z",[self calculateDate:1 andOperator:'-']]]] forKeys:@[@"$orderby",@"$expand",@"$select",@"$filter"]];
    
    [self.activityIndicator startAnimating];
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         if(topRefreshControl.refreshing)
         {
             [topRefreshControl endRefreshing];
         }
         MatchesList * matchesList = success;
         matches = [matchesList getMatchesListByDate:self.selectedDateStr andMatches: matchesList.matches];
         NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"championOrder" ascending: YES];
         NSArray * list = [[[NSMutableArray alloc]initWithArray:matches] sortedArrayUsingDescriptors:@[sortOrder]];
         matches=[self getChampionMatches:list withSections:[[NSMutableArray alloc]init] ];
         [self.activityIndicator setHidden:YES];
         [self.activityIndicator stopAnimating];
         [self.loadingLbl setHidden:YES];
         
         if(matches.count>0&&[(NSArray*)[matches objectAtIndex:0]count]>0)
         {
             [self.tableView setHidden:NO];
             [self.tableView reloadData];
         }
         else
         {
             [self.loadingLbl setText:@"لم يتم العثور علي مباريات"];
             [self.loadingLbl setHidden:NO];
             self.tableView.hidden = YES;
         }
         
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Matches by Date = %@",self.selectedDateStr]  ApiError:@"Success"];
         
     }failure:^(NSError *error) {
         [self.loadingLbl setText:@"لم يتم العثور علي مباريات"];
         [self.loadingLbl setHidden:NO];
         [self.activityIndicator setHidden:YES];
         [self.activityIndicator stopAnimating];
         IBGLog(@"Match By Date Error  : %@",error);
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Matches by Date = %@",self.selectedDateStr] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getMatchesByDate];
                                          }];
     }];
}
-(NSArray*)sortArrayBasedOnChampionshipDisplayOrder:(NSArray*)list
{
    NSMutableArray * matchesList = [[NSMutableArray alloc]init];
    for (NSArray * matches in list) {
        
    }
    
    return [[NSArray alloc]initWithArray:matchesList];
}
-(NSMutableArray*)getChampionMatches:(NSArray*)matchesList withSections:(NSMutableArray*)sections{
    //  NSMutableArray *sectiondMatches=[[NSMutableArray alloc] init];
    NSMutableArray *subMatches=[[NSMutableArray alloc] init];
    NSInteger current=-1;
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"time"
                                                                ascending: NO];
    for (MatchCenterDetails * match  in matchesList ) {
        
        if (current==-1) {
            current=match.championshipId;
            [subMatches addObject:match];
        }
        else if (current!=match.championshipId) {
            current=match.championshipId;
            subMatches = (NSMutableArray*)[subMatches sortedArrayUsingDescriptors:@[sortOrder]];
            [sections addObject:subMatches];
            subMatches=[[NSMutableArray alloc] init];
            [subMatches addObject:match];
        }
        else {
            [subMatches addObject:match];
        }
    }

    subMatches = (NSMutableArray*)[subMatches sortedArrayUsingDescriptors:@[sortOrder]];
    [sections addObject:subMatches];
    return sections;
    
}
-(void)setScreenSponsor
{
    AppInfo *appInfo= [Global getInstance].appInfo;
    NSString * sponsorUrl;
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
        
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
    }
    else{
        self.sponsorImgHeightConstraint.constant = 0;
        
    }
    if([sponsorUrl isEqualToString:@""]||sponsorUrl==nil)
    {
        self.sponsorImgHeightConstraint.constant = 0;
    }
}
#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return matches.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray*)[matches objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchCenterDetails * item = [[matches objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]&&item.matchStatusHistory.count>0&&[[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
        return 170;
    }
    else{
    return 128;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchCenterDetails * item = [[matches objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell = [MatcheCenterCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchItem:item];
    [((MatcheCenterCellLoader*)cell).champNameLbl setHidden:YES];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn setTag:item.awayTeamId];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn setTitle:item.awayTeamName forState:UIControlStateNormal];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn addTarget:self action:@selector(awayTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [((MatcheCenterCellLoader*)cell).homeTeamBtn setTag:item.homeTeamId];
    [((MatcheCenterCellLoader*)cell).homeTeamBtn setTitle:item.homeTeamName forState:UIControlStateNormal];
    [((MatcheCenterCellLoader*)cell).homeTeamBtn addTarget:self action:@selector(homeTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [((MatcheCenterCellLoader*)cell).predictMatchBtn addTarget:self action:@selector(predictBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [((MatcheCenterCellLoader*)cell).statisticsBtn addTarget:self action:@selector(statisticalBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.contentView.backgroundColor = [UIColor whiteColor];

    return cell;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, self.tableView.frame.size.width-100, 35)];
    TappableSponsorImageView * sponsorImg=[[TappableSponsorImageView alloc] initWithFrame:CGRectMake(8, 5, 100, 30)];
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:14]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentRight];
    [title setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:sponsorImg];
    [headerView addSubview:title];
    headerView.tag=section;
    UITapGestureRecognizer *tapHeader=[[UITapGestureRecognizer alloc] init];
    [tapHeader  addTarget:self action:@selector(championshipHeaderPressed:)];
    
    [headerView addGestureRecognizer:tapHeader];
    if(matches.count>0&&[(NSArray*)[matches objectAtIndex:section]count]>0)
    {
        MatchCenterDetails * item = [[matches objectAtIndex:section] objectAtIndex:0];
        [title setText:[NSString stringWithFormat: @"  %@", item.championshipName]];
        if([AppSponsors isChampionCoSponsorActiveUsingId:item.championshipId])
        {
            sponsorImg.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:item.championshipId category:@"Matches"];
            [sponsorImg sd_setImageWithURL:[NSURL URLWithString:[AppSponsors getMatchesListSponsorImagePathUsingChampionId:item.championshipId]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                sponsorImg.frame = CGRectMake(8, 5, image.size.width, image.size.height);
            }];
        }

    }
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchCenterDetails * item = [[matches objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
    matchCenter.matchCenterDetails = item;
    if(self.navigationController != nil)
        [self.navigationController pushViewController:matchCenter animated:YES];
    else
    {
        UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
        [navigationContoller pushViewController:matchCenter animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 270;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *fullView = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 290)];
    UIView *adsView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, Screenwidth-20, 250)];
    //spaceView.backgroundColor = UIColor.grayColor ;
    //[fullView addSubview:spaceView];
    NSString *myString = @"Pos";
    NSInteger sectionNumber = section + 1;
    NSString* sectionNumberString = [NSString stringWithFormat:@"%li", (long)sectionNumber];
     NSString *str = [myString stringByAppendingString:sectionNumberString];
    NSLog(@"%@", str);
   
  [adsView addSubview: [super setBannerViewFooter:@[@"Inner",@"Match"] andPosition:@[str]andScreenName: @"iOS-Get Matches by Date"]];
    [fullView addSubview:adsView];
    return fullView;
    
}
-(void)championshipHeaderPressed:(UITapGestureRecognizer*) tg
{
    long  tag = tg.view.tag;
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    MatchCenterDetails * item = [[matches objectAtIndex:tag]objectAtIndex:0];
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
#pragma mark - DZEmptyDataSets
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"لم يتم العثور علي مباريات";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:16],
                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
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

- (IBAction)homeTeamBtnPressed:(UIButton*)sender {
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [appDelegate.getSelectedNavigationController pushViewController:teamProfile animated:YES];
}

- (IBAction)awayTeamBtnPressed:(UIButton*)sender {
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)sender.tag;
    teamProfile.teamName = sender.titleLabel.text;
    [appDelegate.getSelectedNavigationController pushViewController:teamProfile animated:YES];
}
#pragma mark - Handle Prediction Action
#pragma mark - Handle Prediction Action
- (IBAction)statisticalBtnAction:(UIButton*)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(MatcheCenterCellLoader*)sender.superview.superview];
    MatchCenterDetails * item = [[matches objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];

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
    MatchCenterDetails * item = [[matches objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];

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
