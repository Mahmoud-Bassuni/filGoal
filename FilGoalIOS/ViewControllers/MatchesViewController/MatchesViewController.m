//
//  HomeViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "MatchesViewController.h"
#import "UIImageView+WebCache.h"
#import "MatchesByDateViewController.h"
#import "CalendarViewController.h"
@interface MatchesViewController ()
{
    NSString * sponsorUrl;
    UIButton * filterMatches;
    ActionSheetDatePicker * picker;
    UIButton * rightBarButton;
    CustomIOSAlertView * alertView;
    CalendarViewController * calendarViewController;
    
    
}
@property (nonatomic,strong) MatchCenterDetails * matchSummaryDetails;
@end

@implementation MatchesViewController

-(void)viewDidLoad
{
    [self setupTabsView];
    self.matches=[[NSArray alloc]init];
    [self LoadMatches];

}
-(void)LoadMatches{

        NSString * urlString = [NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]];
        NSDictionary *  paramDic=[[NSDictionary alloc]initWithObjects:@[@"date",@"MatchStatusHistory($orderby=StartAt desc;)",[NSString stringWithFormat:@"Date lt %@ and Date ge %@ and %@",[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'+']],[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'-']],[self getChampionshipIdsString]]] forKeys:@[@"$orderby",@"$expand",@"$filter"]];
        
        [WServicesManager getDataWithURLString:urlString andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(MatchesList * matchesObj)
         {
             [self.activityIndicator stopAnimating];
            self.matchesDic = [[MatchesList alloc]getMatchesWidget:matchesObj.matches andYestardayDate:[self calculateDate:1 andOperator:'-'] andTomorrowDate:[self calculateDate:1 andOperator:'+']];
             self.matches = [self.matchesDic objectForKey:@"today"];

             if(self.matches.count == 0)
             {
                 self.noMatchesLbl.hidden = NO;
                 self.tableView.hidden = YES;
                 [self.noMatchesLbl setText:@"لا يوجد مباريات لهذا اليوم"];

             }
             else
             {
                 self.noMatchesLbl.hidden = YES;
                 self.tableView.hidden = NO;
              }
             self.matches=[self getChampionMatches:self.matches withSections:[[NSMutableArray alloc]init] ];

             [self.tableView reloadData];
            // [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Section Matches Widget"  ApiError:@"Success"];
             
             
         }failure:^(NSError *error)
         {
             [self.activityIndicator stopAnimating];
             self.noMatchesLbl.text=@"لم يتم العثور علي مباريات";
             IBGLog(@"Matches List Error : %@",error);
//             [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Section Matches Widget"  ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
             [self showDefaultNetworkingErrorMessageForError:error
                                              refreshHandler:^{
                                                  [self LoadMatches];
                                              }];
         }];
        
    
}

-(void)setupTabsView
{
    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles: @[@"غدا",@"اليوم",@"أمس"]];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    segmentedControl1.frame = CGRectMake(0, 0, self.tabsView.frame.size.width, self.tabsView.frame.size.height);
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl1.backgroundColor = [UIColor clearColor];
    segmentedControl1.selectionIndicatorBoxColor = [UIColor mainAppYellowColor];
    [segmentedControl1 setSelectionIndicatorBoxOpacity:1.0];
    segmentedControl1.selectionIndicatorHeight = 0.0;
    segmentedControl1.selectedSegmentIndex = 1;
    //segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl1.verticalDividerEnabled = NO;
    segmentedControl1.verticalDividerColor = [UIColor clearColor];
    //  segmentedControl1.verticalDividerWidth = 1.0f;
    [segmentedControl1 setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14]}];
        return attString;
    }];
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    _tabsView.layer.cornerRadius = 17;
    _tabsView.layer.borderWidth = 0.5;
    segmentedControl1.layer.cornerRadius=17;
    segmentedControl1.clipsToBounds=YES;
    _tabsView.clipsToBounds=YES;
    _tabsView.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.5]CGColor];
    [_tabsView addSubview:segmentedControl1];
}
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    if(segmentedControl.selectedSegmentIndex == 2)
    {
        self.matches = [self.matchesDic objectForKey:@"yesterday"];
    }
    else if(segmentedControl.selectedSegmentIndex == 1)
    {
        self.matches = [self.matchesDic objectForKey:@"today"];
        
    }
    else if(segmentedControl.selectedSegmentIndex == 0)
    {
        self.matches = [self.matchesDic objectForKey:@"tomorrow"];
        
    }
    if(self.matches.count>10)
    {
        NSArray *items = [self.matches subarrayWithRange: NSMakeRange( 0, 10 )];
        NSMutableArray * list = [NSMutableArray arrayWithArray:items];
        self.matches =list;
    }

    if(self.matches.count>0)
    {
        self.noMatchesLbl.hidden = YES;
        self.tableView.hidden = NO;
        self.matches=[self getChampionMatches:self.matches withSections:[[NSMutableArray alloc]init] ];
        [self.tableView reloadData];
        [self.tableView layoutIfNeeded];
        
    }
    else
    {
        self.noMatchesLbl.hidden = NO;
        self.tableView.hidden = YES;
        [self.noMatchesLbl setText:@"لا يوجد مباريات لهذا اليوم"];
    }
}

-(NSString*)calculateDate:(int)days andOperator:(char)sign
{
    int offset = [[[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]intValue];
    NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
    [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dtfrm setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dtfrm setLocale:usLocale];
    NSDate * todayDate = [dtfrm dateFromString:[dtfrm stringFromDate:[NSDate date]]];
    // NSTimeInterval seconds = [todayDate timeIntervalSince1970]+(60*60*offset);
    
    // NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDate *date= [todayDate dateByAddingTimeInterval:60*60*offset];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    [outputFormatter setLocale:usLocale];
   // [outputFormatter setLocale:[NSLocale currentLocale]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:date];
    [components setDay:[[[NSExpression expressionWithFormat:[NSString stringWithFormat:@"%ld%c%d",(long)[components day],sign,days]]expressionValueWithObject:nil context:nil]integerValue]];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSString * selectedDateStr = [outputFormatter stringFromDate:[gregorian dateFromComponents:components]];
    return  selectedDateStr;
}
#pragma mark - Get ChampionIds string to append to request
-(NSString*) getChampionshipIdsString
{
    NSString* championIds = [[NSString alloc]init];
    championIds =  [championIds stringByAppendingString:@"("];
    
    for(int i=0 ; i< self.sectionChampions.count ; i++)
    {
        // Concatnate request parameters
        ChampId * champIdItem = self.sectionChampions[i];
        championIds = [championIds stringByAppendingString:[NSString stringWithFormat:@"(championshipId = %li)",(long)champIdItem.champID]];
        if(i<self.sectionChampions.count-1)
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
#pragma - mark XLPagerTabStripChildItem
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
#pragma mark - TableView Datasource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier ;
    cellIdentifier =@"cell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    MatchCenterDetails * item = [[self.matches objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell = [MatcheCenterCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchItem:item];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn setTag:item.awayTeamId];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn setTitle:item.awayTeamName forState:UIControlStateNormal];
    [((MatcheCenterCellLoader*)cell).awayTeamBtn addTarget:self action:@selector(awayTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [((MatcheCenterCellLoader*)cell).homeTeamBtn setTag:item.homeTeamId];
    [((MatcheCenterCellLoader*)cell).homeTeamBtn setTitle:item.homeTeamName forState:UIControlStateNormal];
    [((MatcheCenterCellLoader*)cell).homeTeamBtn addTarget:self action:@selector(homeTeamBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.matches.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, self.tableView.frame.size.width-100, 35)];
    TappableSponsorImageView * sponsorImg=[[TappableSponsorImageView alloc] initWithFrame:CGRectMake(8, 10, 74, 20)];
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
    if(self.matches.count>0&&[(NSArray*)[self.matches objectAtIndex:section]count]>0)
    {
        MatchCenterDetails * item = [[self.matches objectAtIndex:section] objectAtIndex:0];
        [title setText:[NSString stringWithFormat: @"  %@", item.championshipName]];
        if([AppSponsors isChampionCoSponsorActiveUsingId:item.championshipId])
        {
            sponsorImg.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:item.championshipId category:@"Match"];
            [sponsorImg sd_setImageWithURL:[NSURL URLWithString:[AppSponsors getMatchesListSponsorImagePathUsingChampionId:item.championshipId]]];
        }
    }
    return headerView;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray*)[self.matches objectAtIndex:section] count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchCenterDetails * item = [[self.matches objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
    matchCenter.matchCenterDetails = item;
    if(self.navigationController != nil)
        [self.navigationController pushViewController:matchCenter animated:YES];
    else
    {
        UINavigationController * navigationContoller = [GetAppDelegate() getSelectedNavigationController];
        [navigationContoller pushViewController:matchCenter animated:YES];
    }
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSString *string =[list objectAtIndex:section];
//    /* Section header is in 0th index... */
//    [label setText:string];
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
//    return view;
//}


#pragma mark - group champion matches
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
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"time"
                                                                ascending: YES];
    subMatches = (NSMutableArray*)[subMatches sortedArrayUsingDescriptors:@[sortOrder]];
    [sections addObject:subMatches];
    return sections;
    
}
#pragma mark - Actions
-(void)championshipHeaderPressed:(UITapGestureRecognizer*) tg
{
    long  tag = tg.view.tag;
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    MatchCenterDetails * item = [[self.matches objectAtIndex:tag]objectAtIndex:0];
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

@end
