//
//  TodayViewController.m
//  MatchesWidget
//
//  Created by Yomna Ahmed on 10/23/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "WidgetCellTableViewCell.h"
#import "MatchesWidgetData.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "MatchesWidgetDataHandler.h"
#import <UIKit/UIKit.h>
#import "GAI.h"
#import "Constants.h"
#import "Global.h"
//#import "WServicesManager.h"
#import "MatchesList.h"
#import "MatchCenterDetails.h"
#import "AFOAuth2Manager.h"
#import "HMACAuthentication.h"
#import "HelperMethods.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"

@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UIButton *tomorrowButton;
@property (weak, nonatomic) IBOutlet UIButton *yesterdayButton;
@property (weak, nonatomic) IBOutlet UIButton *todayButton;
@property (weak, nonatomic) IBOutlet UITableView *todayTableView;





@property (nonatomic, strong)  NSMutableArray *tomorrowChampList;
@property (nonatomic, strong)  NSMutableArray *todayChampList;
@property (nonatomic, strong)  NSMutableArray *yesterdayChampList;
@property (nonatomic, strong)  NSMutableArray *sectionsObject;



-(IBAction)selectTap1:(id)sender;
-(IBAction)selectTap2:(id)sender;
-(IBAction)selectTap3:(id)sender;

@end

@implementation TodayViewController
static NSString * const kClientID=@"FG";
static NSString * const kUserName=@"FilGoalIOS";
static NSString * const kPassword=@"F!lgo@L@$poRtsEng!ne";
static NSString * const kGrantType=@"password";
static NSString * const kClientSecret=@"F!LGo@L2016";
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.screenName=@"iOS-Matches Widget screen";
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    
    //production  --  UA-697331-9
    //Development  --  UA-51739634-1
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-697331-9"];
    [self.todayButton setSelected:YES];
    [self.todayButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    whichButtonIsTapped=2;
    // CGRect  screenRect = [[UIScreen mainScreen] bounds];
    //  CGFloat Screenwidthwidget = screenRect.size.width;
    self.noMatchesView = [[UILabel alloc] init];
    self.noMatchesView.frame = CGRectMake(Screenwidthwidget/2-80, 50,180, 36);
    [self.noMatchesView setBackgroundColor:[UIColor clearColor]];
    [self.noMatchesView setTextColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.noMatchesView setTextAlignment:NSTextAlignmentCenter];
    [self.noMatchesView setFont:[UIFont boldSystemFontOfSize:14.0f]];
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        isFail=YES;
        [self.view addSubview:self.noMatchesView];
        
    }
    self.todayTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.moreButton=[[UIButton alloc] initWithFrame:CGRectMake(0, self.todayTableView.frame.size.height-50,self.todayTableView.frame.size.width,35)];
    [self.moreButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.moreButton setTitle:@"المزيد" forState:UIControlStateNormal];
    self.moreButton.titleLabel.font=[UIFont fontWithName:@"System Bold" size:20];
    [self.moreButton addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    self.todayTableView.tableFooterView=self.moreButton;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
        [self.extensionContext setWidgetLargestAvailableDisplayMode:NCWidgetDisplayModeExpanded];
    
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    
    [defaults setBool:NO forKey:@"isMore"];
    [defaults synchronize];
    [self getToken];

    
    
}
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        
        if(whichButtonIsTapped==1)
        {
            self.preferredContentSize = CGSizeMake(Screenwidthwidget,[self.tomorrowMatches count]*59+[self.tomorrowChampList count]*25+60);
            
        }
        else if(whichButtonIsTapped==2)
        {
            self.preferredContentSize = CGSizeMake(Screenwidthwidget,[self.todayMatches count]*59+[self.todayChampList count]*25+60);
        }
        else if(whichButtonIsTapped==3)
        {
            self.preferredContentSize = CGSizeMake(Screenwidthwidget,[self.yesterdayMatches count]*59+[self.yesterdayChampList count]*25+60);
        }
    } else if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        // self.preferredContentSize = maxSize;
        self.preferredContentSize = maxSize;
        //self.preferredContentSize = CGSizeMake(0.0, 800.0);
        
        
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated{
    [self widgetPerformUpdateWithCompletionHandler:^(NCUpdateResult result) {
        if (result==NCUpdateResultNewData) {
            [self.todayTableView reloadData];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        isFail=YES;
        [self.view addSubview:self.noMatchesView];
        
    }
    else{
        // AFOAuthCredential *credential =
        //  [AFOAuthCredential retrieveCredentialWithIdentifier:kCrednitialIdentifier];
        NSString * urlString = [NSString stringWithFormat:HomeFeaturedMatches,@"http://seapi.filgoal.com/"];
        NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[@"OrderInDay",@"MatchStatusHistory($orderby=StartAt desc;)",@"Id,HomeTeamId,AwayTeamId,HomeTeamName,AwayTeamName,HomeScore,AwayScore,HomePenaltyScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,MatchStatusHistory,Date,Week,RoundName,OrderInDay",[NSString stringWithFormat:@"Date lt %@ and Date ge %@",[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'+']],[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'-']]]] forKeys:@[@"$orderby",@"$expand",@"$select",@"$filter"]];
        [self getDataWithURLString:urlString andParameters:paramDic WithObjectName:@"MatchesList" success:^(MatchesList * matchesObj)
         {
             NSArray * list = [[NSArray alloc]initWithArray:matchesObj.matches];

             self.matchesDic = [[MatchesList alloc]getMatchesWidget:list andYestardayDate:[self calculateDate:1 andOperator:'-'] andTomorrowDate:[self calculateDate:1 andOperator:'+']];
             self.todayMatches = [self.matchesDic objectForKey:@"today"];
             self.yesterdayMatches = [self.matchesDic objectForKey:@"yesterday"];
             self.tomorrowMatches = [self.matchesDic objectForKey:@"tomorrow"];
             
             
             [self updateTheTable];
             
         }failure:^(NSError *error)
         {
             [self.todayTableView setHidden:YES];
             self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
             [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
             isFail=YES;
             [self.view addSubview:self.noMatchesView];
         }];
        
    }
    
    
}

-(NSString*)calculateDate:(int)days andOperator:(char)sign
{
    int offset = 0;
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    
    if( [[defaults objectForKey:TIME_OFFSET]intValue] == 0)
    {
        offset = 2;
    }
    else
        offset = [[defaults objectForKey:TIME_OFFSET] intValue];
    
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
    //[outputFormatter setLocale:[NSLocale currentLocale]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:date];
    [components setDay:[[[NSExpression expressionWithFormat:[NSString stringWithFormat:@"%ld%c%d",(long)[components day],sign,days]]expressionValueWithObject:nil context:nil]integerValue]];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSString * selectedDateStr = [outputFormatter stringFromDate:[gregorian dateFromComponents:components]];
    return  selectedDateStr;
}
- (UIEdgeInsets ) widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    
    return UIEdgeInsetsZero;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (whichButtonIsTapped == 1 ){
        if ([self.tomorrowMatches count]!=0) {
            if(section<self.tomorrowChampList.count)
            {
                NSArray * list = [self.tomorrowChampList objectAtIndex:section];
                return list.count;
            }
        }
        
        return 0;
    }
    
    if (whichButtonIsTapped ==2){
        if ([self.todayMatches count]!=0) {
            if(section<self.todayChampList.count)
            {
                NSArray * list = [self.todayChampList objectAtIndex:section];
                
                return list.count;
            }
        }
        return 0;
    }
    else{
        if ([self.yesterdayMatches count]!=0) {
            if(section<self.yesterdayChampList.count)
            {
                NSArray * list = [self.yesterdayChampList objectAtIndex:section];
                return list.count;
            }
        }
        return 0;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable){
        isFail=YES;
        return 0;
    }
    
    
    if (whichButtonIsTapped == 1)
        return [self.tomorrowChampList count];
    
    
    if (whichButtonIsTapped ==2)
        
        return [self.todayChampList count];
    
    if (whichButtonIsTapped ==3)
        return [self.yesterdayChampList count];
    
    return 0;
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 59.0;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //=====set Hearder view ==============//
    
    UIView *headerView=[[UIView alloc]init];
    [headerView setBackgroundColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0  blue:68.0/255.0  alpha:1.0]];
    
    UILabel *title;
    if(Screenwidthwidget>320&&Screenwidthwidget<380)
        title=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, Screenwidthwidget-30, 22)];
    else if (Screenwidthwidget>380)
        title=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, Screenwidthwidget-30, 22)];
    else{
        title=[[UILabel alloc] initWithFrame:CGRectMake(8, 0, Screenwidthwidget-15, 22)];
        
    }
    
    [title setTextAlignment:NSTextAlignmentRight];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont boldSystemFontOfSize:13.0]];
    [title setTextColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    
    if (whichButtonIsTapped == 1){
        if ([self.tomorrowMatches count]!=0) {
            title.text= [NSString stringWithFormat:@"  %@",[[[self.tomorrowChampList objectAtIndex:section] objectAtIndex:0] championshipName]];
            [headerView addSubview:title];
        }
        else
            headerView=nil;
    }
    if (whichButtonIsTapped ==2){
        
        if ([self.todayMatches count]!=0){
            title.text= [NSString stringWithFormat:@"  %@",[[[self.todayChampList objectAtIndex:section] objectAtIndex:0] championshipName]];
            [headerView addSubview:title];
        }
        
        else{
            headerView=nil;
        }
    }
    
    if (whichButtonIsTapped ==3) {
        
        if ([self.yesterdayMatches count]!=0){
            title.text=[NSString stringWithFormat:@"  %@",[[[self.yesterdayChampList objectAtIndex:section] objectAtIndex:0] championshipName]];
            [headerView addSubview:title];
        }
        
        else
            headerView=nil;
    }
    
    return headerView;
}






- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    isMore=NO;
    MatchCenterDetails *match;
    if (whichButtonIsTapped ==1) {
        match=[[self.tomorrowChampList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }
    
    if (whichButtonIsTapped ==2) {
        
        match=[[self.todayChampList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }
    if (whichButtonIsTapped ==3) {
        
        match=[[self.yesterdayChampList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }
    
    NSURL *url = [NSURL URLWithString:@"FilgoalWidget://com.sarmady.filgoalWidget"];
    
    [self.extensionContext openURL:url completionHandler:nil];
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:match];
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    [defaults setObject:encodedObject forKey:@"MatchWidget"];
    [defaults setBool:YES forKey:@"IsFromMatchesWidget"];
    
    [defaults setBool:NO forKey:@"isMore"];
    [defaults synchronize];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellIdentifier= @"TomorrowMatchesWidgetCell";
    
    WidgetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[WidgetCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //cell.layoutMargins = UIEdgeInsetsZero;
    MatchCenterDetails *matchModel;
    if (whichButtonIsTapped == 1 && self.tomorrowChampList.count !=0){
        matchModel= (MatchCenterDetails *)([[self.tomorrowChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    }
    else if (whichButtonIsTapped == 2 && self.todayChampList.count !=0)
    {
        matchModel= (MatchCenterDetails *)([[self.todayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    }
    else if (whichButtonIsTapped == 3 && self.yesterdayChampList.count !=0)
    {
        matchModel= (MatchCenterDetails *)([[self.yesterdayChampList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    }
    
    // cell.matchStatusLbl.text = matchModel.matchStatus;
    if(matchModel != nil)
    {
        cell.contentView.backgroundColor=[UIColor colorWithRed:54/255.0 green:54/255.0 blue:54/255.0 alpha:1.0];
        cell.team1Name.text=matchModel.homeTeamName;
        cell.team2Name.text=matchModel.awayTeamName;
        
        cell.teamscore1Label.text=[NSString stringWithFormat:@"%li",(long)matchModel.homeScore];
        cell.teamscore2Label.text=[NSString stringWithFormat:@"%li",(long)matchModel.awayScore];
        [cell.matchStatus setText:@""];
        [cell.matchCounter setText:@""];
        
        [cell.teamImage2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)matchModel.awayTeamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      
                                  }];
        
        [cell.teamImage1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)matchModel.homeTeamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      
                                  }];
        
        
        cell.timeOfTheMatch.text= matchModel.time;
        if(matchModel.matchStatusHistory.count>0)
        {
            MatchStatusHistory * matchStatusItem=[matchModel.matchStatusHistory objectAtIndex:0];
            cell.matchStatusLbl.text=matchStatusItem.matchStatusName;
            [cell.matchStatusLbl setBackgroundColor:matchStatusItem.matchStatusColor];
            
            if (matchStatusItem.matchStatusIndicatorId == MatchNotStartedIndicatorID||matchStatusItem.matchStatusId == KMatchPostponed)  {
                
                cell.teamscore1Label.text = @"-";
                cell.teamscore2Label.text = @"-";
            }
            else{
                cell.teamscore1Label.text= [NSString stringWithFormat:@"%li",(long)matchModel.homeScore];
                cell.teamscore2Label.text= [NSString stringWithFormat:@"%li",(long)matchModel.awayScore];
                
                
            }
            if(matchStatusItem.matchStatusIndicatorId == MatchLiveIndicatorID)
            {
                [cell.matchStatusLbl setText:@"مباشر"];
            }
            
            
            if(matchModel.homePenaltyScore !=0 || matchModel.awayPenaltyScore != 0)
            {
                cell.teamscore1Label.text= [cell.teamscore1Label.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",matchModel.homePenaltyScore==-1?@"":[NSString stringWithFormat:@"(%li)",(long)matchModel.homePenaltyScore ]]];
                
                cell.teamscore2Label.text= [cell.teamscore2Label.text stringByAppendingString:[NSString stringWithFormat:@"\n%@",matchModel.awayPenaltyScore==-1?@"":[NSString stringWithFormat:@"(%li)",(long)matchModel.awayPenaltyScore ]]];
            }
            
        }
    }
    
    return cell;
    
}
-(UIColor*) getMatchStatusColorUsingStatusID:(NSInteger)statusID
{
    UIColor * matchStatusColor;
    switch (statusID) {
        case KMatchNotStarted:
            matchStatusColor=[UIColor colorWithRed:0.85 green:0.51 blue:0.14 alpha:1.0];;
            break;
        case KMatchSoon:
            matchStatusColor=[UIColor colorWithRed:0.85 green:0.51 blue:0.14 alpha:1.0];;
            break;
        case KMatchFirstHalf:
            matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchBreak:
            matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchSecondHalf:
            matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchFirstExtraHalf:
            matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchSecondExtraHalf:
            matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KPlenties:
            matchStatusColor=[UIColor colorWithRed:0.71 green:0.00 blue:0.00 alpha:1.0];;
            break;
        case KMatchEnd:
            matchStatusColor=[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0];
            break;
        case KMatchStopped:
            matchStatusColor=[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0];
            break;
        case KMatchPostponed:
            matchStatusColor=[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0];
            break;
        case KMatchCancelled:
            matchStatusColor=[UIColor colorWithRed:0.62 green:0.62 blue:0.62 alpha:1.0];
            break;
            
        default:
            break;
    }
    return matchStatusColor;
}


-(IBAction)selectTap1:(id)sender{
    [self.tomorrowButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.todayButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.yesterdayButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    whichButtonIsTapped=1;
    if ([self.tomorrowMatches count]==0&&isFail==YES) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noMatchesView];
    }
    
    else if ([self.tomorrowMatches count]==0&&isFail==NO) {
        
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.noMatchesView setText:@" لا يوجد مباريات "];
        [self.view addSubview:self.noMatchesView];
    }
    
    else {
        [self.todayTableView setHidden:NO];
        self.todayTableView.contentSize = CGSizeMake(Screenwidthwidget, [self.tomorrowMatches count]*59+[self.tomorrowChampList count]*25+70);
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,self.todayTableView.contentSize.height);
        [self.noMatchesView removeFromSuperview];
        [self.todayTableView reloadData];
    }
    
    
    
}
-(IBAction)selectTap2:(id)sender{
    [self.todayButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.tomorrowButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.yesterdayButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    whichButtonIsTapped=2;
    
    if ([self.todayMatches count]==0&&isFail==YES) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noMatchesView];
    }
    
    else if ([self.self.todayMatches count]==0&&isFail==NO) {
        
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.noMatchesView setText:@" لا يوجد مباريات "];
        [self.view addSubview:self.noMatchesView];
    }
    
    else {
        [self.todayTableView setHidden:NO];
        self.todayTableView.contentSize = CGSizeMake(Screenwidthwidget, [self.todayMatches count]*59+[self.todayChampList count]*25+70);
        
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,self.todayTableView.contentSize.height);
        [self.noMatchesView removeFromSuperview];
        [self.todayTableView reloadData];
    }
}
-(IBAction)selectTap3:(id)sender{
    
    [self.yesterdayButton setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.todayButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.tomorrowButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    whichButtonIsTapped=3;
    
    if ([self.yesterdayMatches count]==0&&isFail==YES) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noMatchesView];
    }
    
    else if ([self.self.yesterdayMatches count]==0&&isFail==NO) {
        
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.noMatchesView setText:@" لا يوجد مباريات "];
        [self.view addSubview:self.noMatchesView];
    }
    
    else {
        [self.todayTableView setHidden:NO];
        self.todayTableView.contentSize = CGSizeMake(Screenwidthwidget, [self.yesterdayMatches count]*59+[self.yesterdayChampList count]*25+70);
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,self.todayTableView.contentSize.height);
        [self.noMatchesView removeFromSuperview];
        [self.todayTableView reloadData];
    }
}

- (void)updateTheTable{
    
    
    if ( ([self.tomorrowMatches count]==0 || [self.yesterdayMatches count]==0 || [self.todayMatches count] == 0)&&isFail==NO) {
        [self.noMatchesView setText:@" لا يوجد مباريات "];
        
    }
    if (([self.tomorrowMatches count]==0 || [self.yesterdayMatches count]==0 ||[self.todayMatches count] == 0)&&isFail==YES) {
        [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
    }
    
    
    if ([self.tomorrowMatches count]!=0 || [self.yesterdayMatches count]!=0 ||[self.todayMatches count] != 0){
        
        [self getSectionsArray];
    }
    
    
    if ([self.todayMatches count]==0 && whichButtonIsTapped==2 && isFail==NO) {
        [self.todayTableView setHidden:YES];
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
        [self.view addSubview:self.noMatchesView];
        
    }
    
}

-(NSMutableArray*)getSectionArray:(NSArray*)matches{
    
    
    NSMutableArray *sectiondMatches=[[NSMutableArray alloc] init];
    NSMutableArray *subMatches=[[NSMutableArray alloc] init];
    int current=-1;
    for (MatchCenterDetails * match  in matches ) {
        
        if (current==-1) {
            current = (int)match.championshipId;
            [subMatches addObject:match];
        }
        else if (current!=match.championshipId) {
            current = (int)match.championshipId;
            [sectiondMatches addObject:subMatches];
            subMatches=[[NSMutableArray alloc] init];
            [subMatches addObject:match];
        }
        else {
            [subMatches addObject:match];
        }
    }
    [sectiondMatches addObject:subMatches];
    return sectiondMatches;
}


- (void)getSectionsArray{
    
    /// === getting today sections
    self.todayChampList=[[NSMutableArray alloc] init];
    self.tomorrowChampList=[[NSMutableArray alloc] init];
    self.yesterdayChampList=[[NSMutableArray alloc]init];
    if(self.todayMatches.count>6)
    self.todayMatches = [[NSMutableArray alloc]initWithArray:[self.todayMatches subarrayWithRange:NSMakeRange(0, 5)]];
    if(self.tomorrowMatches.count>6)
        self.tomorrowMatches = [[NSMutableArray alloc]initWithArray:[self.tomorrowMatches subarrayWithRange:NSMakeRange(0, 5)]];
    if(self.yesterdayMatches.count>6)
        self.yesterdayMatches= [[NSMutableArray alloc]initWithArray:[self.yesterdayMatches subarrayWithRange:NSMakeRange(0, 5)]];
    self.todayChampList =[self getSectionArray:self.todayMatches];
    self.yesterdayChampList=[self getSectionArray:self.yesterdayMatches];
    self.tomorrowChampList = [self getSectionArray:self.tomorrowMatches];
    
    
    if (whichButtonIsTapped==2 && [self.todayMatches count]!=0) {
        self.todayTableView.contentSize = CGSizeMake(Screenwidthwidget, [self.todayMatches count]*75+[self.todayChampList count]*25);
        self.preferredContentSize = CGSizeMake(Screenwidthwidget,self.todayTableView.contentSize.height+100);
    }
    [self.todayTableView reloadData];
    
}


- (void) updateWidgetView:(NSTimer *)t{
    
   // [NSThread detachNewThreadSelector:@selector(loadTheUpdatedView:) toTarget:self withObject:nil];
    
}

- (void)loadTheUpdatedView{
    NSString * urlString = [NSString stringWithFormat:HomeFeaturedMatches,@"http://seapi.filgoal.com/"];

    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[@"OrderInDay",@"MatchStatusHistory($orderby=StartAt desc;)",@"Id,Slug,HomeTeamId,AwayTeamId,HomeTeamName,HomeTeamSlug,AwayTeamName,AwayTeamSlug,HomeScore,AwayScore,HomePenaltyScore,AwayPenaltyScore,ChampionshipName,ChampionshipSlug,ChampionshipId,MatchStatusHistory,Date,Week,RoundName,OrderInDay",[NSString stringWithFormat:@"Date lt %@ and Date ge %@",[NSString stringWithFormat:@"%@Z",[self calculateDate:1 andOperator:'+']],[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'-']]]] forKeys:@[@"$orderby",@"$expand",@"$select",@"$filter"]];
    [self getDataWithURLString:urlString andParameters:paramDic WithObjectName:@"" success:^(NSDictionary * matches)
     {
         MatchesList * matchesObj = [[MatchesList alloc]initWithDictionary:matches];
         
         self.matchesDic = [[MatchesList alloc]getMatchesWidget:matchesObj.matches andYestardayDate:[self calculateDate:1 andOperator:'-'] andTomorrowDate:[self calculateDate:1 andOperator:'+']];
         self.todayMatches = [self.matchesDic objectForKey:@"today"];
         self.yesterdayMatches = [self.matchesDic objectForKey:@"yesterday"];
         self.tomorrowMatches = [self.matchesDic objectForKey:@"tomorrow"];
         self.widgetAllMatches= [[NSMutableArray alloc]initWithArray:matchesObj.matches];
         [self updateTheTable];
         isFail=NO;
         
     }failure:^(NSError *error)
     {
         //[self getToken];
         [self.todayTableView setHidden:YES];
         self.preferredContentSize = CGSizeMake(Screenwidthwidget,100);
         [self.noMatchesView setText:@"لا يوجد اتصال بالانترنت"];
         isFail=YES;
         [self.view addSubview:self.noMatchesView];
     }];
    
}



- (void)loadMore{
    
    isMore=YES;
    NSURL *url = [NSURL URLWithString:@"FilgoalWidget://com.sarmady.filgoalWidget"];
    
    [self.extensionContext openURL:url completionHandler:nil];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    [defaults setBool:YES forKey:@"isMore"];
    [defaults setInteger:whichButtonIsTapped forKey:@"SelectedTab"];
    NSData *todaymatches = [NSKeyedArchiver archivedDataWithRootObject:self.todayMatches];
    NSData *yestardayMatches= [NSKeyedArchiver archivedDataWithRootObject:self.yesterdayMatches];
    NSData *tommorowMatches= [NSKeyedArchiver archivedDataWithRootObject:self.tomorrowMatches];
    if (whichButtonIsTapped ==1) {
        [defaults setObject:tommorowMatches forKey:@"TommorowMatches"];
        
    }
    else if (whichButtonIsTapped ==2)
    {
        [defaults setObject:todaymatches forKey:@"TodayMatches"];
        
    }
    else
    {
        [defaults setObject:yestardayMatches forKey:@"YestardayMatches"];
        
    }
    
    [defaults setBool:YES forKey:@"IsFromMatchesWidget"];
    
    [defaults synchronize];
    
}
-(void)getToken
{
    NSLog(@"SMGL getToken 2");
    NSString * urlString = @"http://seapi.filgoal.com/";
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:[NSURL URLWithString:urlString]
                                    clientID:kClientID
                                      secret:kClientSecret];
    
    NSLog(@"SMGL 2 clientID : %@ \n",kClientID);
    NSLog(@"SMGL 2 secret : %@ \n",kClientSecret);
    
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/oauth/token"
                                              username:kUserName
                                              password:kPassword
                                                 scope:kGrantType
                                               success:^(AFOAuthCredential *credential) {
                                                   [AFOAuthCredential storeCredential:credential
                                                                       withIdentifier:kCrednitialIdentifier];
                                                   if(self.matchesDic==nil)
                                                   [self loadTheUpdatedView];
                                                   isFail=NO;
                                               }
                                               failure:^(NSError *error) {
                                                   NSLog(@"\n\ngetToken Token 2 Error  : %@ \n",error);
                                                   NSLog(@"\n\nlocalized description 2 Error : %@ \n",error.localizedDescription);
                                               }];
}
-(void)getDataWithURLString:(NSString *)urlString andParameters:(id)parameters WithObjectName:(NSString *)obj success:(void (^)(id result))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFOAuthCredential *credential =
    [AFOAuthCredential retrieveCredentialWithIdentifier:kCrednitialIdentifier];

    [manager.requestSerializer setValue:@"ar-EG" forHTTPHeaderField:@"Accept-Language"];
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithCredential:credential];
    NSLog(@"service UrlString: %@ parameters : %@  ",urlString,parameters);
    
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id object = NSClassFromString(obj);
        if (object == nil) {
            success(responseObject);
            
        }
        else{
            object=[[object alloc] initWithDictionary:(NSDictionary*)responseObject];
            success(object);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        if (statusCode == 401){
            [self getToken];
        }

        failure(error);

    }];
    
}

@end
