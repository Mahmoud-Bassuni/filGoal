//
//  HomeViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 6/6/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//
@import Firebase;
#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "WeekMatchesViewController.h"
#import "ChampionDetailsTabsViewController.h"
#import "ActiveChampion.h"
#import "PredictionActiveChampions.h"
#import "PredictionServiceManager.h"
#import "pollsCell.h"
#import "FilGoalIOS-Swift.h"
#import "Poll.h"

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * homeSectionsList;
@property (strong, nonatomic) IBOutlet UIImageView *sponsorImgView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;

@end
#define FeaturedTopNewsComponentHeight 230
#define ExtraPadding 10
@implementation HomeViewController
{
    FeaturedAreaSliderViewController * featuredAreaView;
    UIRefreshControl *topRefreshControl;
    AppDelegate * appDelegate;
    BannersSliderViewController * sliderView;
    CustomIOSAlertView *alertView;
}
- (IBAction)action:(id)sender {
    
}

-(id)initHomeViewWithSectionId:(int)sectionId andChampions:(NSArray*)champions
{
    self = [super init];
    if (self) {
        self.sectionChampions=champions;
        self.sectionId=sectionId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _homeSectionsList = [[NSMutableArray alloc]init];
    appDelegate= (AppDelegate*)[[UIApplication sharedApplication]delegate];
    sliderView=[[BannersSliderViewController alloc]init];
    sliderView.isFromHome = YES;
    featuredAreaView = [[FeaturedAreaSliderViewController alloc]init];
    // [self getHomeDataAPI];
    [self getActiveChampions];
    [self addTopPullToRefresh];
    self.screenName = [NSString stringWithFormat:@"iOS - Home Screen with Id %i",self.sectionId];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS - Home Screen with Id %i",self.sectionId]
                                     }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadMatchesWidget:) name:@"ReloadMatchesWidget" object:nil];
    
    // Some Boolean to handle opening pages and we need to revamp it
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:false forKey:@"notfirstTimeHome"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //Calling AppInfo and MetaDate once per launch
    [self getMetaDataAndAppInfoAPIs];
    self.testBtn.imageView.image= [self.testBtn.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    // to solve cut off of last row
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);
    self.isFirstLoad = YES;
    
//    self.tableView.contentInset = UIEdgeInsetsMake(8, 0, (600 + CGRectGetHeight(self.tabBarController.tabBar.frame)) , 0);
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    
    if(self.isFromLandingScreen)
    {
        self.isFromLandingScreen=NO;
        [self handleLandingScreenButtonActionBasedOnID];
    }
    if (self.sectionId==0) {
        
        self.specialSectionImgView.hidden=NO;
        
        //Smgl new banner - must comment these
        // Just call this line to enable the scrolling navbar
        //[self followScrollView:self.tableView usingTopConstraint:self.topConstraint withDelay:65];
        //[self setShouldScrollWhenContentFits:YES];
    }
    else
    {
        self.bottomHeightConstraint.constant = 80;
    }
    
    [self checkVersionWeekly];
    
    [self handlePushNotificationsAndUniversalLinks];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.tableView.scrollEnabled=YES;

    
    
    
    NSLog(@"SMGL self.parentViewController: %@", self.parentViewController);
    NSLog(@"SMGL self.presentedViewController: %@", self.presentedViewController);
    NSLog(@"SMGL self.presentingViewController: %@", self.presentingViewController);
    NSLog(@"SMGL self.inputViewController: %@", self.inputViewController);
    //[super setUpBannerUnderNavBetween:self.view firstV:self.sponsorImgView secondV:self.tableView];
    //[super setUpBannerUnderNavInPlace:self.view newPlaceView:self.sponsorImgView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:@"ReloadMatchesWidget"];
    [self showNavBarAnimated:NO];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Predictions API
-(void)getActiveChampions{
    
    [PredictionServiceManager getActiveChampionships:^(PredictionActiveChampions * response) {
       __weak typeof(self) weakSelf = self;
        NSArray * champions = response.result;
        [Global getInstance].activePredictionchampions = champions;
        [weakSelf getHomeDataAPI];
        
    } failure:^(NSError *error) {
        __weak typeof(self) weakSelf = self;
        [weakSelf getHomeDataAPI];
        NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        if (statusCode == 401){
            [AFOAuthCredential deleteCredentialWithIdentifier:kPredictCrednitialIdentifier];
            [PredictionServiceManager getToken:^(id result) {
                [weakSelf getActiveChampions];
            } failure:^(NSError *error) {
                
            }];
        }
    }];
}
-(void) loadSponsorImg
{
    NSString * sponserUrl;
    AppInfo * appInfo = [Global getInstance].appInfo;
    self.sponsorImgViewHeightConstraint.constant = 0.0;
    self.specialSectionSpaceConstraint.constant = 0.0;
    
    if (appInfo.sponsor.isActive==1) {
        
        if (sponserUrl == nil)
        {
            
            sponserUrl=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
            if (IS_IPHONE_6_PLUS) {
                sponserUrl=[NSString stringWithFormat:@"%@/MainSponsor/header6plus@3x.png",appInfo.sponsor.imgsBaseUrl];
            }
            else if (IS_IPHONE_6)
            {
                sponserUrl=[NSString stringWithFormat:@"%@/MainSponsor/header6@2x.png",appInfo.sponsor.imgsBaseUrl];
            }
            else
            {
                sponserUrl=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
            }
            [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponserUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(!error)
                {
                    __weak typeof(self) weakSelf = self;
                    //self.sponsorImgViewHeightConstraint.constant = 25.0;
                    weakSelf.sponsorImgViewHeightConstraint.constant=image.size.height;
                    
                }
                // self.sponsorImgView.frame = CGRectMake(0,64, Screenwidth, 25);
                
            }];
        }
    }
    
}

#pragma mark - Add Pull to refresh
-(void)addTopPullToRefresh
{
    topRefreshControl = [UIRefreshControl new];
    topRefreshControl.tintColor = [UIColor darkGrayColor];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    topRefreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"جاري تحميل البيانات" attributes:attributes];
    [topRefreshControl addTarget:self action:@selector(refreshTop) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:topRefreshControl];
}

- (void)refreshTop {
    _homeSectionsList = [[NSMutableArray alloc]init];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    [self.loadingLbl setHidden:NO];
    [self getHomeDataAPI];
    [self getMetaDataAndAppInfoAPIs];
    
}

-(NSString*)calculateDate:(int)days andOperator:(char)sign
{
    int offset = [[[NSUserDefaults standardUserDefaults]objectForKey:TIME_OFFSET]intValue];
    NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
    [dtfrm setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dtfrm setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate * todayDate = [dtfrm dateFromString:[dtfrm stringFromDate:[NSDate date]]];
    NSDate *date= [todayDate dateByAddingTimeInterval:60*60*offset];
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

-(void) getHomeDataAPI
{
    NSDictionary *dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",self.sectionId], nil] forKeys:[NSArray arrayWithObjects:@"SecId", nil] ];
    
    //Section Home with no assigned championships
    if(self.sectionId != 0 && self.sectionChampions.count == 0)
    {
        [WServicesManager getDataWithURLString:[NSString stringWithFormat:HomeSectionNewsAPI,[WServicesManager getApiBaseURL]] andParameters:dictionary WithObjectName:@"Home" andAuthenticationType:CMSAPIs success:^(Home *metaData)
         {
             __weak typeof(self) weakSelf = self;
             if(topRefreshControl.isRefreshing)
             {
                 [topRefreshControl endRefreshing];
             }
             [weakSelf.activityIndicator stopAnimating];
             [weakSelf setHomeData:metaData];
             
         }failure:^(NSError *error) {
             __weak typeof(self) weakSelf = self;
             [weakSelf getMatchesListAPI];
             IBGLog(@"Home Error  : %@",error);
             IBGLogDebug(@"Home Error  : %@",error);
             
             [weakSelf showReloadAlert];
             NSString * errorStr = [NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"NSErrorFailingURLKey"]];
             [weakSelf sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"HomeView" ApiError:[NSString stringWithFormat:@"Failure with Error : %@",errorStr]];
             
         }];
    }
    else
    {
        [WServicesManager getDataWithURLString:[NSString stringWithFormat:HomeSectionNewsAPI,[WServicesManager getApiBaseURL]] andParameters:dictionary WithObjectName:@"Home" andAuthenticationType:CMSAPIs success:^(Home *metaData) {
            __weak typeof(self) weakSelf = self;
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf setHomeData:metaData];
        } failure:^(NSError *error) {
            __weak typeof(self) weakSelf = self;
            [weakSelf.activityIndicator stopAnimating];
            [weakSelf showDefaultNetworkingErrorMessageForError:error
                                             refreshHandler:^{
                                                 __weak typeof(self) weakSelf = self;
                                                 [weakSelf.activityIndicator startAnimating];
                                                 [weakSelf getHomeDataAPI];
                                             }];
            //self.loadingLbl.text=@"لم يتم العثور علي بيانات";
            if(topRefreshControl.isRefreshing)
            {
                [topRefreshControl endRefreshing];
            }}];
        
        
    }
    
}
-(void)getMatchesListAPI
{
    NSDictionary *paramDic;
    NSString * urlString;
    __weak __typeof(self) weakSelf = self;
    
    if(self.sectionId == 0)
    {
        self.bottomTableViewSpaceConstraint.constant = 0;
        paramDic=[[NSDictionary alloc]initWithObjects:@[@"OrderInDay",@"MatchStatusHistory($orderby=StartAt desc;),TvCoverage",@"Id,HomeTeamId,AwayTeamId,HomeTeamName,AwayTeamName,HomeScore,AwayScore,HomePenaltyScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,MatchStatusHistory,Date,OrderInDay",[NSString stringWithFormat:@"Date lt %@ and Date ge %@ and IsDelayed eq false",[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'+']],[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'-']]]] forKeys:@[@"$orderby",@"$expand",@"$select",@"$filter"]];
        urlString = [NSString stringWithFormat:HomeFeaturedMatches,[WServicesManager getSportsEngineApiBaseURL]];
    }
    else
    {
        self.bottomTableViewSpaceConstraint.constant = 20;
        urlString = [NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]];
        paramDic=[[NSDictionary alloc]initWithObjects:@[@"date",@"MatchStatusHistory($orderby=StartAt desc;),TvCoverage",@"Id,HomeTeamId,AwayTeamId,HomeTeamName,AwayTeamName,HomeScore,AwayScore,HomePenaltyScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,MatchStatusHistory,Date",[NSString stringWithFormat:@"Date lt %@ and Date ge %@ and %@",[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'+']],[NSString stringWithFormat:@"%@Z",[self calculateDate:2 andOperator:'-']],[self getChampionshipIdsString]]] forKeys:@[@"$orderby",@"$expand",@"$select",@"$filter"]];
    }
    if(self.sectionChampions.count>0||self.sectionId==0)
    {
        [WServicesManager getDataWithURLString:urlString andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(MatchesList * matches) {
            if(topRefreshControl.isRefreshing)
            {
                [topRefreshControl endRefreshing];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setMatchesWidget:matches.matches];
            });
            [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"HomeView" ApiError:@"Success"];
        } failure:^(NSError *error) {
            [topRefreshControl endRefreshing];
            IBGLog(@"Home MatchesList Error %@",error);
            [self showDefaultNetworkingErrorMessageForError:error
                                             refreshHandler:^{
                                                 [weakSelf getMatchesListAPI];
                                             }];
            NSString * errorStr = [NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"NSErrorFailingURLKey"]];
            [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"HomeView" ApiError:[NSString stringWithFormat:@"Failure with Error : %@",errorStr]];
            //        [self showDefaultNetworkingErrorMessageForError:error
            //                                         refreshHandler:^{
            //                                             [self getMatchesListAPI];
            //                                         }];
            
        }];
    }
    
}
-(void) setMatchesWidget:(NSArray*)matches
{
    NSDictionary * matchesDic = [[NSDictionary alloc]initWithObjects:@[@[[[MatchCenterDetails alloc]init]]] forKeys:@[@"Matches"]];
    
    self.matchesDic = [[MatchesList alloc]getMatchesWidget:matches andYestardayDate:[self calculateDate:1 andOperator:'-'] andTomorrowDate:[self calculateDate:1 andOperator:'+']];
    
    self.widgetVC = [[ MatchesWidgetViewController alloc]init];
    if ([[Global getInstance]getSectionItemWithSectionID:self.sectionId].champId != 0 && [[Global getInstance]getSectionItemWithSectionID:self.sectionId].champId != nil){
        self.widgetVC.championId=[[Global getInstance]getSectionItemWithSectionID:self.sectionId].champId;
    }
    self.widgetVC.matchesDic = self.matchesDic;
    self.widgetVC.sectionId = self.sectionId;
    
    if(self.homeSectionsList.count>2)
    {
        [self.homeSectionsList insertObject:matchesDic atIndex:2];
        NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[@[[[DFPBannerView alloc]init]],@"Pos2"] forKeys:@[@"AdsView",@"Pos"]];
        [_homeSectionsList insertObject:topNewsDic atIndex:3];
        
    }
    else
    {
        [self.homeSectionsList addObject:matchesDic];
    }
    NSArray * matchesList = [self.matchesDic objectForKey:@"today"];
    // Init the first tableview height with today matches count * cell height+ more button
    self.matchesWidgetHeight = (141*matchesList.count) + 160;
    
    
    //Check on Special section from AppInfo to show banner view or not
    if([Global getInstance].appInfo.specialSection.isActive&&(([Global getInstance].appInfo.specialSection.isMainHomeBannersActive&&(self.sectionId==0))||(([Global getInstance].appInfo.specialSection.isHomeSectionBannersActive&&(self.sectionId==[Global getInstance].appInfo.specialSection.sectionID)))))
    {
        NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[@[[[Banner alloc]init]]] forKeys:@[@"SpecialSectionBanner"]];
        
        [_homeSectionsList insertObject:topNewsDic atIndex:1];
    }
    
    [self.tableView reloadData];
}
-(void)reloadMatchesWidget:(NSNotification*)note
{
    self.matchesWidgetHeight = [[note.userInfo objectForKey:@"height"]doubleValue]+100;
    if(!_isFirstLoad){
        [self.tableView reloadData];
    }
    else{
        self.isFirstLoad = NO;
    }
    
}



-(void) setHomeData:(Home*)homeData
{
  
    self.loadingLbl.hidden = YES;
    for (HomeParts * partItem in homeData.homeParts)
    {
        if(partItem.partType == 1)
        {
            NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[partItem.items.partNews] forKeys:@[@"TopNews"]];
            featuredAreaView.topNewsItems = [[[partItem.items.partNews reverseObjectEnumerator] allObjects] mutableCopy];
            NSArray *xx = featuredAreaView.topNewsItems ;
            // [_homeSectionsList addObject:topNewsDic];
            if(partItem.items.partNews.count>0)
            {
                [_homeSectionsList insertObject:topNewsDic atIndex:0];
            }
            
            
        }
        else if (partItem.partType == 2)
        {
            NSMutableArray * list = [[NSMutableArray alloc]initWithArray:partItem.items.partNews];
            if(partItem.items.partNews.count>0)
            {
                [list addObject:[[MoreHeaderCell alloc]init]];
                NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[list] forKeys:@[@"اخر الأخبار"]];
                [_homeSectionsList addObject:topNewsDic];
            }
            NSDictionary * adspace = [[NSDictionary alloc]initWithObjects:@[@[[[DFPBannerView alloc]init]],@"Pos3"] forKeys:@[@"AdsView",@"Pos"]];;
            [_homeSectionsList addObject:adspace];
            
            
            
        }
        else if (partItem.partType == 3)
        {
            NSMutableArray * list = [[NSMutableArray alloc]initWithArray:partItem.items.partVideos];
            if(partItem.items.partVideos.count>0)
            {
                [list addObject:[[MoreHeaderCell alloc]init]];
                NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[list] forKeys:@[@"فيديوهات"]];
                [_homeSectionsList addObject:topNewsDic];
            }
            NSDictionary * adspace = [[NSDictionary alloc]initWithObjects:@[@[[[DFPBannerView alloc]init]],@"Pos4"] forKeys:@[@"AdsView",@"Pos"]];;
            [_homeSectionsList addObject:adspace];
        }
        else if (partItem.partType == 5)
        {
            NSMutableArray * list = [[NSMutableArray alloc]initWithArray:partItem.items.partAlbums];
            if(partItem.items.partAlbums.count>0)
            {
                [list addObject:[[MoreHeaderCell alloc]init]];
                NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[list] forKeys:@[@"صور"]];
                [_homeSectionsList addObject:topNewsDic];
            }
//            NSDictionary * adspace = [[NSDictionary alloc]initWithObjects:@[@[[[DFPBannerView alloc]init]],@"Pos5"] forKeys:@[@"AdsView",@"Pos"]];;
//            [_homeSectionsList addObject:adspace];
        }
         else if (partItem.partType == 6)
                {
                    NSMutableArray * list = [[NSMutableArray alloc]initWithArray:partItem.items.partPolls];
//                    if(partItem.items.partPolls.count>0)
//                    {
                        [list addObject:[[PollsCell alloc]init]];
                        NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[list] forKeys:@[@"polls"]];
                        [_homeSectionsList addObject:topNewsDic];
                  //  }
        //            NSDictionary * adspace = [[NSDictionary alloc]initWithObjects:@[@[[[DFPBannerView alloc]init]],@"Pos5"] forKeys:@[@"AdsView",@"Pos"]];;
        //            [_homeSectionsList addObject:adspace];
                }
    }
    if(self.homeSectionsList.count>1)
    {
        NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[@[[[DFPBannerView alloc]init]],@"Pos1"] forKeys:@[@"AdsView",@"Pos"]];;
        [_homeSectionsList insertObject:topNewsDic atIndex:1];
    }
    [self getMatchesListAPI];
    
    [self.tableView reloadData];
    
    
}

#pragma mark - UITableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if((self.homeSectionsList.count>0&&(([self.homeSectionsList[section] objectForKey:@"AdsView"] != nil)||([self.homeSectionsList[section] objectForKey:@"Matches"] != nil)||([self.homeSectionsList[section] objectForKey:@"polls"] != nil)||([self.homeSectionsList[section] objectForKey:@"TopNews"] != nil))))
    {
        return 1;
    }
    else if (section<self.homeSectionsList.count)
    {
        NSDictionary * dic = [self.homeSectionsList objectAtIndex:section];
        NSArray * list = dic.allValues[0] ;
        return list.count;
    }
    return 0;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.homeSectionsList.count ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    if(self.homeSectionsList.count>0)
    {
        NSDictionary * dic = [self.homeSectionsList objectAtIndex:indexPath.section];
        NSArray * list = dic.allValues[0];
        if([dic objectForKey:@"TopNews"] != nil)
        {
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.frame=CGRectMake(0, 0, Screenwidth,FeaturedTopNewsComponentHeight);
            featuredAreaView.view.frame=CGRectMake(0, 0, Screenwidth,FeaturedTopNewsComponentHeight);
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:featuredAreaView.view];
            return cell;
        }
        else if([[list objectAtIndex:indexPath.row] isKindOfClass:[NewsItem class]])
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
            NewsItem *item =[list objectAtIndex:indexPath.row];
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            [((StoryCell*)cell)initWithNewsItem:item];
            return    cell;
            
        }
        else   if([[list objectAtIndex:indexPath.row] isKindOfClass:[VideoItem class]])
        {
            VideoItem *item = [list objectAtIndex:indexPath.row];
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
            [((StoryCell*)cell)initWithVideoItem:item];
            return    cell;
            
        }
        else if([[list objectAtIndex:indexPath.row] isKindOfClass:[Album class]])
        {
            Album * item = [list objectAtIndex:indexPath.row];
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
            [((StoryCell*)cell)initWithAlbumItem:item];
            return    cell;
            
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[DFPBannerView class]])
        {
            cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 290)];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, Screenwidth-20, 250)];
            view.backgroundColor = [UIColor clearColor];
            UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, view.center.y,view.frame.size.width, 40)];
            [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:title.font.pointSize]];
            [title setTextColor:[UIColor blackColor]];
            [title setTextAlignment:NSTextAlignmentCenter];
            [title setBackgroundColor:[UIColor clearColor]];
            title.text=@"مساحة أعلانية";
            [view addSubview:title];
            if(self.sectionId==0)
                [view addSubview:[super setBannerViewFooter:@[@"Home"] andPosition:@[[dic objectForKey:@"Pos"]]andScreenName:[NSString stringWithFormat:@"iOS - Home Screen with Id %i",self.sectionId]]];
            else
                [view addSubview:[super setBannerViewFooter:@[@"Inner",@"Section",[NSString stringWithFormat:@"قسم %@",self.sectionName]] andPosition:@[[dic objectForKey:@"Pos"]]andScreenName:[NSString stringWithFormat:@"iOS - Home Screen with Id %i",self.sectionId]]];
            
            [cell addSubview:view];
            return cell;
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[Banner class]])
        {
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.frame=CGRectMake(0, 0, Screenwidth, 110);
            sliderView.view.frame=CGRectMake(0, 5, Screenwidth,100);
            sliderView.isFromHome =YES;
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:sliderView.view];
            return cell;
        }
        else  if([[list objectAtIndex:indexPath.row]isKindOfClass:[MatchCenterDetails class]])
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"MatchesWidgetCell"];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc]init];
                cell.contentView.frame = CGRectMake(0, 0, Screenwidth,self.matchesWidgetHeight);
                self.widgetVC.view.frame = cell.contentView.frame;
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=[UIColor clearColor];
                [cell.contentView addSubview:self.widgetVC.view];
            }
            return cell;
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[MoreHeaderCell class]])
        {
            UITableViewCell * moreCell = [[UITableViewCell alloc]init];
            moreCell.backgroundColor=[UIColor clearColor];
            moreCell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIView *view=[[UIView alloc] initWithFrame:CGRectMake(10, 10, Screenwidth-20, 40)];
            view.backgroundColor=[UIColor whiteColor];
            UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0,0, view.frame.size.width, 40)];
            [title setFont:[UIFont defaultMeduimFontOfSize:14.0]];
            [title setTextColor:[UIColor mainAppYellowColor]];
            [title setTextAlignment:NSTextAlignmentCenter];
            [title setBackgroundColor:[UIColor whiteColor]];
            if([[list objectAtIndex:indexPath.row-1]isKindOfClass:[NewsItem class]])
                title.text=@"المزيد من الأخبار";
            else if([[list objectAtIndex:indexPath.row-1]isKindOfClass:[VideoItem class]])
                title.text=@"المزيد من الفيديوهات";
            else if([[list objectAtIndex:indexPath.row-1]isKindOfClass:[Album class]])
                title.text=@"المزيد من الصور";
            
            [view addSubview:title];
            [moreCell addSubview:view];
            return moreCell;
        }
        else if ([[list objectAtIndex:indexPath.row]isKindOfClass:[Polld class]])
        {
            Polld *currentPoll = [list objectAtIndex:indexPath.row] ;
            
          //  NSString *value = [[NSString alloc] initWithFormat:@"%ld", currentPoll.pollID];
          //  NSLog(@"%@", [value integerValue]);
            
          UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(8, 8, Screenwidth - 16, 600)];
            webView.allowsInlineMediaPlayback = YES;
            webView.allowsPictureInPictureMediaPlayback = YES;
            webView.allowsLinkPreview = YES;
          webView.delegate = self;
          NSString *urlString = [@"https://www.filgoal.com/poll/" stringByAppendingFormat:@"%@", currentPoll.pollID];
          NSURL *url = [NSURL URLWithString:urlString];
          NSURLRequest *request = [NSURLRequest requestWithURL:url];
          [webView loadRequest:request];
            NSString *jsCommand = [NSString stringWithFormat:@"document.body.style.zoom = .5;"];
         [webView stringByEvaluatingJavaScriptFromString:jsCommand];
           [cell addSubview:webView];
            cell.backgroundColor = [UIColor clearColor];
          return cell ;
        }
    }
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.homeSectionsList.count>0)
    {
        
        NSDictionary * dic = [self.homeSectionsList objectAtIndex:indexPath.section];
        NSArray * list = dic.allValues[0];
        
        if([dic objectForKey:@"TopNews"] != nil)
        {
            return FeaturedTopNewsComponentHeight;
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[MatchCenterDetails class]])
        {
            return  self.matchesWidgetHeight+ExtraPadding;
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[DFPBannerView class]])
        {
            return  290;
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[Banner class]])
        {
            return  110;
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[MoreHeaderCell class]])
        {
            return 60;
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[Polld class]])
        {
            return 600;
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[Album class]]||[[list objectAtIndex:indexPath.row]isKindOfClass:[NewsItem class]]||[[list objectAtIndex:indexPath.row]isKindOfClass:[VideoItem class]])
        {
            if (IS_IPHONE_6_PLUS) {
                return IPHONE_6Plus_Cell_Hieght+ExtraPadding;
            }
            else if (IS_IPHONE_6)
            {
                return IPHONE_6_Cell_Hieght+ExtraPadding;
            }
            else
            {
                return IPHONE_4_5_Cell_Hieght+ExtraPadding;
            }
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section != 0 && self.homeSectionsList.count>0)
    {
        NSDictionary * dic = [self.homeSectionsList objectAtIndex:section];
        NSArray * list = dic.allValues[0];
        if(![[list objectAtIndex:0]isKindOfClass:[MatchCenterDetails class]]&&![[list objectAtIndex:0]isKindOfClass:[DFPBannerView class]]&& [[list objectAtIndex:0]isKindOfClass:[PollsCell class]]&&![[list objectAtIndex:0]isKindOfClass:[Banner class]])
            return 58;
    }
    return 0;
}
//-(void)setupWKWebView
//{
//    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.webViewSubView.frame.size.width, 100)];
//    self.webView.opaque = NO;
//    self.webView.scrollView.scrollEnabled = NO;
//    self.webView.backgroundColor = [UIColor clearColor];
//    self.webView.navigationDelegate=self;
//    self.webView.tintColor = [UIColor mainAppYellowColor];
//    self.webView.scrollView.bounces = YES;
//    UIView *containerWebVIew = self.webViewSubView;
//    UIView *subview = _webView;
//    _webView.translatesAutoresizingMaskIntoConstraints = NO;
//    [containerWebVIew addSubview:subview];
//    [containerWebVIew addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[subview]-0-|"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:NSDictionaryOfVariableBindings(subview)]];
//
//    [containerWebVIew addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[subview]-0-|"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:NSDictionaryOfVariableBindings(subview)]];
//
//    // self.webView.autoresizingMask =UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.webView.contentMode = UIViewContentModeScaleToFill;
//
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // UIView *headerView=[[UIView alloc]init];
    
    
    UIView *headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 58)];
    headerView.backgroundColor = [UIColor clearColor];
    if(self.homeSectionsList.count>0)
    {
        if(section != 0 && self.homeSectionsList.count>0)
        {
            NSDictionary * dic = [self.homeSectionsList objectAtIndex:section];
            NSArray * list = dic.allValues[0] ;
            if(list.count>0 &&(![list[0] isKindOfClass:[MatchCenterDetails class]]&&![list[0] isKindOfClass:[PollsCell class]]&&![[list objectAtIndex:0]isKindOfClass:[DFPBannerView class]]&&![[list objectAtIndex:0]isKindOfClass:[Banner class]]))
            {
                HomeHeaderView * headerCell = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:self options:nil]objectAtIndex:0];
                UIView * subView = [[UIView alloc]initWithFrame: CGRectMake(10, 0, Screenwidth-20, 40)];
                headerCell.frame = CGRectMake(0, 0,subView.frame.size.width , 40);
                subView.backgroundColor = [UIColor colorWithRed:0.23 green:0.24 blue:0.24 alpha:1.0];
                NSDictionary * dic = [self.homeSectionsList objectAtIndex:section];
                [headerCell.titleLbl setText:[dic.allKeys objectAtIndex:0]];
                [subView addSubview:headerCell];
                [headerView addSubview:subView];
                UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreBtnPressed:)];
                gesture.numberOfTapsRequired = 1;
                headerView.userInteractionEnabled = YES;
                headerView.tag = section;
                [headerView addGestureRecognizer:gesture];
                headerCell.sponsorImg.hidden=YES;
                if(self.sectionId!=0&&[AppSponsors isSectionCoSponsorActiveUsingId:self.sectionId])
                {
                    NSString * sponsorUrl;
                    headerCell.sponsorImg.hidden=NO; 
                    if([list[0]isKindOfClass:[NewsItem class]]) {
                        sponsorUrl=[AppSponsors getHomeWidgetsSponsorImagePathUsingSectionId:self.sectionId andContentType:@"News"];
                        headerCell.sponsorImg.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:self.sectionId category:@"News"];
                    } else if([list[0]isKindOfClass:[VideoItem class]]) {
                        sponsorUrl=[AppSponsors getHomeWidgetsSponsorImagePathUsingSectionId:self.sectionId andContentType:@"Videos"];
                        headerCell.sponsorImg.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:self.sectionId category:@"Videos"];
                    } else if([list[0]isKindOfClass:[Album class]]) {
                        sponsorUrl=[AppSponsors getHomeWidgetsSponsorImagePathUsingSectionId:self.sectionId andContentType:@"Albums"];
                        headerCell.sponsorImg.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:self.sectionId category:@"Albums"];
                    }
                    [headerCell.sponsorImg sd_setImageWithURL:[NSURL URLWithString:sponsorUrl]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        headerCell.sponsorWidthConstraint.constant = image.size.width;
                    }];
                }
                
                return headerView;
                
            }
            else{
                return [[UIView alloc]init];
            }
            
        }
    }
    
    return nil;
    
}

#pragma mark - Handle calling metadata and AppInfo APIs
-(void)getMetaDataAPI
{
    NSDictionary *dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0",nil] forKeys:[NSArray arrayWithObjects:@"countryId", nil] ];
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MetaDataAPI,[WServicesManager getApiBaseURL]] andParameters:dictionary WithObjectName:@"MetaData" andAuthenticationType:CMSAPIs
                                   success:^(MetaData *metaData)
     //         [WServicesManager getDataWithURLString:MetaData_URL andParameters:nil WithObjectName:@"MetaData" andAuthenticationType:NoAuth
     //                                        success:^(MetaData *metaData)
     {
         __weak typeof(self) weakSelf = self;
         if (metaData ==nil) {
         }
         else{
             [Global getInstance].metaData = metaData;
         }
         [weakSelf sendAppSpeedTimeIntervalWithTime:[weakSelf stopMeasuring] AndScreenName:@"Splash Screen"  ApiError:@"Success"];
     } failure:^(NSError *error) {
         __weak typeof(self) weakSelf = self;
         IBGLog(@"MetaData Error  : %@",error);
         [weakSelf sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Splash Screen"  ApiError:[NSString stringWithFormat:@"Failure with error %@",error.description]];
     }];
}
-(void)getAppInfoAPI
{
#ifdef DEBUG
    
    //RELEASE
    [WServicesManager getDataWithURLString:AppInfo_URL andParameters:nil WithObjectName:@"AppInfo" andAuthenticationType:NoAuth success:^(AppInfo *appInfo) {
         if (appInfo==nil) { }
         else {
             [Global getInstance].appInfo=appInfo;
             [self saveAppInfoAndMetaData:appInfo];
         }
     } failure:^(NSError *error) {
         UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"لم يتم العثور علي البيانات  " message:[error description] delegate:self cancelButtonTitle:@"موافق" otherButtonTitles:nil];
         //[message show];
         IBGLog(@"AppInfo Error : %@",error.description);
     }];


   /*
    //TESTING
    //1st
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testAppInfo2" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *JSONDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    //2nd.1
    NSString *obj = @"AppInfo";
    AppInfo *success;
    //2nd.2
    id object = NSClassFromString(obj);
    if (object == nil) {
        success = JSONDict;

    } else {
        if( [JSONDict isKindOfClass:[NSArray class]]&&([obj isEqualToString:@"Albums"]||[obj isEqualToString:@"NewsList"] ||[obj isEqualToString:@"VideosList"])) {
            object = [[object alloc]initWithArrayList:(NSArray*)JSONDict];
            success = object;
        } else {
            object=[[object alloc] initWithDictionary:(NSDictionary*)JSONDict];
            success = object;
        }

    }
    //3rd
    [Global getInstance].appInfo = success;
    [self saveAppInfoAndMetaData: success];
    */
#else
    [WServicesManager getDataWithURLString:AppInfo_URL andParameters:nil WithObjectName:@"AppInfo" andAuthenticationType:NoAuth success:^(AppInfo *appInfo)
     {
         __weak __typeof(self)weakSelf = self;
         if (appInfo==nil) {
         }
         else{
             [Global getInstance].appInfo=appInfo;
             [weakSelf saveAppInfoAndMetaData:appInfo];
         }
         
     } failure:^(NSError *error) {
          __weak __typeof(self)weakSelf = self;
         UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"لم يتم العثور علي البيانات  " message:[error description] delegate:weakSelf cancelButtonTitle:@"موافق" otherButtonTitles:nil];
         //[message show];
         IBGLog(@"AppInfo Error : %@",error.description);
     }];
#endif
}
-(void) getMetaDataAndAppInfoAPIs
{
    [self getMetaDataAPI];
    [self getAppInfoAPI];
    
}
-(void)saveAppInfoAndMetaData:(AppInfo*)appInfo
{
    [Global getInstance].selectedIntersitialIndex = 0;
    if([Global getInstance].appInfo.interstatialAdsPattern.count>0)
        [Global getInstance].screenViewsCount = [[Global getInstance].appInfo.interstatialAdsPattern[[Global getInstance].selectedIntersitialIndex]intValue];
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    if (appInfo != nil) {
        [dataDict setObject:appInfo forKey:@"AppInfo"];
    }
    if([Global getInstance].metaData !=nil)
    {
        [dataDict setObject:[Global getInstance].metaData forKey:@"MetaData"];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    [NSKeyedArchiver archiveRootObject:dataDict toFile:filePath];
    
    // Crash Fix
    if([Global getInstance].appInfo != nil && [Global getInstance].appInfo.adsEnabledPerVersion.count>0)
    {
        for (AdsEnabledPerVersion *temp in [Global getInstance].appInfo.adsEnabledPerVersion){
            
            if([temp.versionCode isEqualToString: [super appVersion]]){
                
                [Global getInstance].isAdsEnabledAtApp=YES;
            }
            
        }
    }
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [self.homeSectionsList objectAtIndex:indexPath.section];
    NSArray * list = dic.allValues[0];
    if(list.count>0)
    {
        
        if([[list objectAtIndex:indexPath.row] isKindOfClass:[NewsItem class]])
        {
            NewsItem *item =[list objectAtIndex:indexPath.row];
            NSMutableArray * stories = [[NSMutableArray alloc]initWithArray:list];
            
            [stories removeLastObject]; // More Button
            stories = [[CustiomizeAdTypes alloc]initializeIntersitialCustomAdsWithUnitID:Pager_AD_UNIT_ID andItemsList:stories andRepeatCount:[Global getInstance].appInfo.adsRepeatCount andViewController:self];
            
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
            {
                NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:item ];

                //newsDetailsScreenWebView.pageIndex = indexPath.row;
                //The Ad after "adsRepeatCount" at exactly (adsRepeatCount + 1), thats why if indexPath was equal or greater to that (adsRepeatCount + 1) then increase the count by one and if it was less then pass that exact indexPath
                if (indexPath.row >= [Global getInstance].appInfo.adsRepeatCount) {
                    //1- know how many ads will be there in the array
                    NSPredicate *numberOfAdsPred =[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                        if ([evaluatedObject isKindOfClass:[GADInterstitial class]]) {
                            return YES;
                        }
                        return NO;
                    }];
                    NSInteger numberOfAdsInsideTheStoriesArray = [stories filteredArrayUsingPredicate:numberOfAdsPred].count;
                    newsDetailsScreenWebView.pageIndex = indexPath.row + numberOfAdsInsideTheStoriesArray; //2- add that number of ads to the indexPath row
                } else {
                    newsDetailsScreenWebView.pageIndex = indexPath.row;
                }
                
                [self addViewControllerToPagerView:newsDetailsScreenWebView withList:stories andSelectedItem:item andCurrentIndex:(int)indexPath.row];
            }
            else
            {
                NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:item];
                
                //newsDetailsScreen.pageIndex = indexPath.row;
                //The Ad after "adsRepeatCount" at exactly (adsRepeatCount + 1), thats why if indexPath was equal or greater to that (adsRepeatCount + 1) then increase the count by one and if it was less then pass that exact indexPath
                if (indexPath.row >= [Global getInstance].appInfo.adsRepeatCount) {
                    //1- know how many ads will be there in the array
                    NSPredicate *numberOfAdsPred =[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                        if ([evaluatedObject isKindOfClass:[GADInterstitial class]]) {
                            return YES;
                        }
                        return NO;
                    }];
                    NSInteger numberOfAdsInsideTheStoriesArray = [stories filteredArrayUsingPredicate:numberOfAdsPred].count;
                    newsDetailsScreen.pageIndex = indexPath.row + numberOfAdsInsideTheStoriesArray; //2- add that number of ads to the indexPath row
                } else {
                    newsDetailsScreen.pageIndex = indexPath.row;
                }
                
                [self addViewControllerToPagerView:newsDetailsScreen withList:stories andSelectedItem:item andCurrentIndex:(int)indexPath.row];
            }
            
        }
        else if([[list objectAtIndex:indexPath.row] isKindOfClass:[VideoItem class]])
        {
            VideoItem *item =[list objectAtIndex:indexPath.row];
            NSMutableArray * stories = [[NSMutableArray alloc]initWithArray:list];
            
            [stories removeLastObject];
            stories = [[CustiomizeAdTypes alloc]initializeIntersitialCustomAdsWithUnitID:Pager_AD_UNIT_ID andItemsList:stories andRepeatCount:[Global getInstance].appInfo.adsRepeatCount andViewController:self];
            
            VideoDetailsViewController * videoDetailsScreen=[[VideoDetailsViewController alloc] initWithVideo:item];
            
            //videoDetailsScreen.pageIndex = indexPath.row;
            //The Ad after "adsRepeatCount" at exactly (adsRepeatCount + 1), thats why if indexPath was equal or greater to that (adsRepeatCount + 1) then increase the count by one and if it was less then pass that exact indexPath
            if (indexPath.row >= [Global getInstance].appInfo.adsRepeatCount) {
                //1- know how many ads will be there in the array
                NSPredicate *numberOfAdsPred =[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                    if ([evaluatedObject isKindOfClass:[GADInterstitial class]]) {
                        return YES;
                    }
                    return NO;
                }];
                NSInteger numberOfAdsInsideTheStoriesArray = [stories filteredArrayUsingPredicate:numberOfAdsPred].count;
                videoDetailsScreen.pageIndex = indexPath.row + numberOfAdsInsideTheStoriesArray; //2- add that number of ads to the indexPath row
            } else {
                videoDetailsScreen.pageIndex = indexPath.row;
            }
            
            [self addViewControllerToPagerView:videoDetailsScreen withList:stories andSelectedItem:item andCurrentIndex:(int)indexPath.row];
            
        }
        else if([[list objectAtIndex:indexPath.row] isKindOfClass:[Album class]])
        {
            Album * item = [list objectAtIndex:indexPath.row];
            NSMutableArray * stories = [[NSMutableArray alloc]initWithArray:list];
            
            [stories removeLastObject];
            stories = [[CustiomizeAdTypes alloc]initializeIntersitialCustomAdsWithUnitID:Pager_AD_UNIT_ID andItemsList:stories andRepeatCount:[Global getInstance].appInfo.adsRepeatCount andViewController:self];
            
            GalleryDetailsViewController * detailsVC = [[GalleryDetailsViewController alloc]init];
            detailsVC.albumItem = item;
            
            //detailsVC.pageIndex = indexPath.row;
            //The Ad after "adsRepeatCount" at exactly (adsRepeatCount + 1), thats why if indexPath was equal or greater to that (adsRepeatCount + 1) then increase the count by one and if it was less then pass that exact indexPath
            if (indexPath.row >= [Global getInstance].appInfo.adsRepeatCount) {
                //1- know how many ads will be there in the array
                NSPredicate *numberOfAdsPred =[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                    if ([evaluatedObject isKindOfClass:[GADInterstitial class]]) {
                        return YES;
                    }
                    return NO;
                }];
                NSInteger numberOfAdsInsideTheStoriesArray = [stories filteredArrayUsingPredicate:numberOfAdsPred].count;
                detailsVC.pageIndex = indexPath.row + numberOfAdsInsideTheStoriesArray; //2- add that number of ads to the indexPath row
            } else {
                detailsVC.pageIndex = indexPath.row;
            }
            
            [self addViewControllerToPagerView:detailsVC withList:stories andSelectedItem:item andCurrentIndex:(int)indexPath.row];
            
        }
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[MoreHeaderCell class]])
        {
            [self moreBtnPressedWithClassObject:list[indexPath.row-1]];
        }
        
    }
}
-(void)addViewControllerToPagerView:(UIViewController*) viewController withList:(NSArray*)list andSelectedItem:(id)selectedItem andCurrentIndex:(int) currentIndex
{
    PagerViewController * pagerViewController = [[PagerViewController alloc]init];
    pagerViewController = [[PagerViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pagerViewController.storiesListWithAds = [[NSMutableArray alloc]initWithArray:list];
    pagerViewController.stories = [[NSMutableArray alloc]initWithArray:list];
    if([selectedItem isKindOfClass:[NewsItem class]])
        pagerViewController.selectedNewsItem = selectedItem;
    else  if([selectedItem isKindOfClass:[VideoItem class]])
        pagerViewController.selectedVideoItem = selectedItem;
    else  if([selectedItem isKindOfClass:[Album class]])
        pagerViewController.selectedAlbum = selectedItem;
    pagerViewController.currentIndex = currentIndex;
    pagerViewController.pageNum = 0;
    [pagerViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [appDelegate.getSelectedNavigationController pushViewController:pagerViewController animated:YES];
}
-(void) moreBtnPressedWithClassObject:(id)object
{
    if(self.sectionId == 0)
    {
        if([object isKindOfClass:[NewsItem class]])
        {
            //  NewsHomeViewController * newsListVC = [[NewsHomeViewController alloc]initWithSectionId:0 TypeId:1];
            [self.tabBarController setSelectedIndex:3];
        }
        else  if([object isKindOfClass:[VideoItem class]])
        {
            // VideosViewController* videosViewController=[[VideosViewController alloc]initWithSectionId:0];
            // [appDelegate.getSelectedNavigationController pushViewController:videosViewController animated:YES];
            [self.tabBarController setSelectedIndex:1];
            
        }
        else  if([object isKindOfClass:[Album class]])
        {
            GalleriesViewController * galleriesViewController=[[GalleriesViewController alloc]init];
            
            [appDelegate.getSelectedNavigationController pushViewController:galleriesViewController animated:YES];
        }
    }
    else
    {
        // for tabs transition
        if([object isKindOfClass:[NewsItem class]])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"TabIndex" object:[NSString stringWithFormat:@"%i",1 ]];
            
        }
        else  if([object isKindOfClass:[VideoItem class]])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"TabIndex" object:[NSString stringWithFormat:@"%i",2 ]];
            
        }
        else  if([object isKindOfClass:[Album class]])
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"TabIndex" object:[NSString stringWithFormat:@"%i",3 ]];
            
        }
        
        
    }
}
- (IBAction)moreBtnPressed:(UITapGestureRecognizer*)sender
{
    NSDictionary * dic = [self.homeSectionsList objectAtIndex:sender.view.tag];
    NSArray * list = dic.allValues[0];
    if(list.count>0)
    {
        [self moreBtnPressedWithClassObject:list[0]];
        
    }
}

#pragma mark - Handle Push Notifications and Universal Links and Spotlight search and widgets :D , we need to refactor this method

-(void) handlePushNotificationsAndUniversalLinks
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL notfirstTime=[defaults boolForKey:@"notfirstTimeHome"];
    if (!notfirstTime) {
        [defaults setBool:true forKey:@"notfirstTimeHome"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if (appDelegate.haveNoti) {
            appDelegate.haveNoti=NO;
            if([[appDelegate.userInfo objectForKey:@"aps"]objectForKey:@"category"]!=nil&&[[[appDelegate.userInfo objectForKey:@"aps"]objectForKey:@"category"] isEqualToString:@"BookmarkAction"])
            {
            }
            else
            {
                [appDelegate handelNoti:appDelegate.userInfo];
            }
        }
        else if (appDelegate.isFromSpotLightSearch)
        {
            appDelegate.isFromSpotLightSearch=NO;
            [appDelegate handleSpotLightSearchWithKeyword:appDelegate.Keyword];
            
        }
        else if (appDelegate.isFromForceTouch)
        {
            appDelegate.isFromForceTouch=NO;
            [self handleForcTouch:appDelegate.item];
            
        }
        else if (appDelegate.isFromNewsWidget)
        {
            NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.FilGoal.NewsWidget"];
            [defaults setBool:NO forKey:@"IsFromNewsWidget"];
            [defaults synchronize];
            appDelegate.isFromNewsWidget=NO;
            NewsDetailsViewControllerWithWKWebView * newsDetailsScreen=[[NewsDetailsViewControllerWithWKWebView alloc]initWithNewsItem:appDelegate.newsItem];
            newsDetailsScreen.isFromNewsWidget=YES;
            [appDelegate.getSelectedNavigationController pushViewController:newsDetailsScreen animated:YES];
            
        }
        else if (appDelegate.isFromMatchesWidget)
        {
            appDelegate.isFromMatchesWidget=NO;
            [self.tabBarController setSelectedIndex:2];
        }
        else if (appDelegate.isToMatchDetails)
        {
            appDelegate.isToMatchDetails=NO;
            MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
            matchCenter.matchCenterDetails = appDelegate.matchItemm;
            [appDelegate.getSelectedNavigationController pushViewController:matchCenter animated:YES];
        }
    }
}
-(void)handleForcTouch:(int)item
{
    NSArray *items = @[@"ALAhli-News",@"AlZamalek-News", @"Videos", @"Matches"];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"iOS-3DTouch"    // Event category (required)
                                                          action:@"AppIcon-3DTouch"  // Event action (required)
                                                           label: [NSString stringWithFormat:@"AppIcon-3DTouch with item =%@",[items objectAtIndex:item-1] ]
                                                           value:nil] build]];
    if(item==1)
    {
        //search for alahly news
        SearchViewController * searchView=[[SearchViewController alloc]initWithKeyWord:@"الاهلي" andTypeId:newsType];
        searchView.isFromForceTouch=true;
        [appDelegate.getSelectedNavigationController pushViewController:searchView animated:YES];
        
        
    }
    else if (item==2)
    {
        [appDelegate.tabbarController setSelectedIndex:1];
    }
    
    else if(item==4)
    {
        [appDelegate.tabbarController setSelectedIndex:2];
        
    }
    
}
#pragma mark - Special Section Landing Screen
-(void) handleLandingScreenButtonActionBasedOnID
{
    NSInteger type=[AppSponsors getLandingItem].type;
    NSInteger itemID=[AppSponsors getLandingItem].idField;
    if(itemID !=0)
    {
        switch (type) {
            case 1:
            {
                NewsItem * newsItem=[[NewsItem alloc]init];
                newsItem.newsId = (int)itemID;
                NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:newsItem ];
                NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:newsItem ];
                if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
                    [appDelegate.getSelectedNavigationController pushViewController:newsDetailsScreenWebView animated:YES];
                else
                    [appDelegate.getSelectedNavigationController pushViewController:newsDetailsScreen animated:YES];
                break;
                
            }
            case 2:
            {
                VideoItem * videoItem=[[VideoItem alloc]init];
                videoItem.videoId=(int)itemID;
                VideoDetailsViewController * videoDetailsScreen =[[VideoDetailsViewController alloc]initWithVideo:videoItem];
                [appDelegate.getSelectedNavigationController pushViewController:videoDetailsScreen animated:YES];
                break;
                
            }
            case 3:
            {
                MatchCenterDetails * matchItem=[[MatchCenterDetails alloc]init];
                matchItem.idField=itemID;
                MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
                matchCenter.matchCenterDetails=matchItem;
                [appDelegate.getSelectedNavigationController pushViewController:matchCenter animated:YES];
                break;
                
            }
            case 4:
            {
                Section * item =[[Section alloc]init];
                item=[[Global getInstance] getSectionItemWithSectionID:itemID];
                if(item.sectionId !=0)
                {
                    MainSectionViewController* mainSection=[[MainSectionViewController alloc]initWithSection:item];
                    mainSection.section=item;
                    [appDelegate.getSelectedNavigationController pushViewController:mainSection animated:YES];
                }
                break;
                
            }
            case 5:
            {
                // AppInfo *appInfo= [Global getInstance].appInfo;
                //            featuredPagerViewController *pager = [[featuredPagerViewController alloc]init];
                //            pager.title=appInfo.iSection.homeFeaturedSection.featuredSection.sectionName;
                //            pager.featuredSection=appInfo.iSection.homeFeaturedSection.featuredSection;
                //            // pager.selectedDate=[[self dateFormatter]dateFromString:date];
                //            pager.metaDataJsonUrl=appInfo.iSection. homeFeaturedSection.featuredSection.metaDataJsonUrl;
                //            [appDelegate.getSelectedNavigationController pushViewController:pager animated:YES];
                break;
                
            }
            case 6:
            {
                GlobalViewController * webView=[[GlobalViewController alloc]init];
                webView.url=[NSURL URLWithString:[AppSponsors getLandingItem].pageUrl];
                [appDelegate.getSelectedNavigationController pushViewController:webView animated:YES];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - Add Update Alert
#pragma mark - check version weekly
- (void)checkVersionWeekly
{
    self.lastVersionCheckPerformedOnDate=[[NSUserDefaults standardUserDefaults]objectForKey:NEW_UPDATE_STORED_DATE];
    if (![self lastVersionCheckPerformedOnDate]) {
        self.lastVersionCheckPerformedOnDate = [NSDate date];
        [self checkVersion];
    }
    if ([self daysBetweenDate:[self lastVersionCheckPerformedOnDate] andDate:[NSDate date]] >= 3) {
        [self checkVersion];
    }
}
- (NSUInteger)numberOfDaysElapsedBetweenLastVersionCheckDate
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitDay
                                                      fromDate:[self lastVersionCheckPerformedOnDate]
                                                        toDate:[NSDate date]
                                                       options:0];
    return [components day];
}
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;   
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

-(void)showNewUpdateAlert
{
    NewUpdateViewController *controller = [[NewUpdateViewController alloc]init];
    CGRect rect;
    rect = CGRectMake(0, 0, 280, 321);
    [controller setPreferredContentSize:rect.size];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"تنزيل التحديث" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController setValue:controller forKey:@"contentViewController"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"إلغاء" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)checkVersion
{
    // check app version to show alert
   
    if([Global getInstance].appInfo.app.isActive&&![[Global getInstance].appInfo.app.version isEqualToString:[super appVersion]])
    {
        [self showNewUpdateAlert];
        self.lastVersionCheckPerformedOnDate = [NSDate date];
        [[NSUserDefaults standardUserDefaults] setObject:[self lastVersionCheckPerformedOnDate] forKey:NEW_UPDATE_STORED_DATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - Create Custom Dialogue
- (void)showReloadAlert
{
    alertView = [[CustomIOSAlertView alloc] init];
    ReloadViewController * reloadViewController = [[ReloadViewController alloc]init];
    [alertView setContainerView:reloadViewController.view];
    [reloadViewController.retryBtn addTarget:self action:@selector(reloadAgain) forControlEvents:UIControlEventTouchUpInside];
    [alertView setButtonTitles:nil];
    [alertView setUseMotionEffects:true];
    [alertView show];
}
-(void)reloadAgain
{
    [alertView close];
    [self.loadingLbl setText:@"برجاء الانتظار قليلا ....."];
    [self.activityIndicator startAnimating];
    [self.activityIndicator setHidden:NO];
    [self.loadingLbl setHidden:NO];
    alertView = nil;
    _homeSectionsList = [[NSMutableArray alloc]init];
    [self getHomeDataAPI];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    //Smgl new banner - must comment these
    //[self performSelector:@selector(showNavbar) withObject:nil afterDelay:0.1];
    return YES;
}
- (IBAction)testAction:(id)sender {
    GADDebugOptionsViewController *debugOptionsViewController =
    [GADDebugOptionsViewController debugOptionsViewControllerWithAdUnitID:MeduimRectangle_AD_UNIT_ID];
    debugOptionsViewController.delegate=self;
    [self presentViewController:debugOptionsViewController animated:YES completion:nil];
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    if(self.sectionId !=0)
    {
        //        if (targetContentOffset->y > 0){
        //            //NSLog(@"up");
        //            self.tableView.scrollEnabled=YES;
        //        }
        //        else if (targetContentOffset->y == 0){
        //            self.tableView.scrollEnabled=NO;
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
@end
