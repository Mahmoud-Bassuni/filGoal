//
//  MatchCenterTabsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCenterTabsViewController.h"
#import "AfterMatchViewController.h"
#import "MatchTabsViewController.h"
#import "MatchOverviewViewController.h"
#import "UIImageView+WebCache.h"
#import "MatchFormulationTabViewController.h"
#import "MatchCommentsViewController.h"
#import "MatchEventTabViewController.h"
#import "MatchDetailsTabsViewController.h"
#import "PlayerAWithNumberCellTableViewCell.h"
#import "UsersStatisticsViewController.h"
#import "MatchInfoViewController.h"
#import "TvCoverage.h"
#import "UIButton+WebCache.h"
@interface MatchCenterTabsViewController ()
{
    NSArray * matchCommentsList;
    NSArray * matchEventsList;
    UIBarButtonItem *refresh;
    bool isRefresing;
    bool isSponserLoaded;
    NSString * sponsorUrl;
    NSString * eventIdentifier;
    NSInteger  selectedPeriod;
    
    
}
@end

@implementation MatchCenterTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    selectedPeriod = 15;
    matchEventsList=[[NSArray alloc]init];
    matchCommentsList=[[NSArray alloc]init];
    self.afterMatchEvents=[[NSArray alloc]init];
    self.matchStatusHistoryList=[[NSMutableArray alloc]init];
    GetAppDelegate().isFullScreen=NO;
    [self setNavigationBtns];
    [self getMatchDetails];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    self.matchStatusLbl.layer.cornerRadius = 14.0;
    self.matchStatusLbl.clipsToBounds =YES;
    [self setPredictionSponsor];
    [self setMatchcenterBackgroundImage];

    
}
-(void)showPredictionBtn{
    if ([[Global getInstance]isActiveChampion:(int)self.matchCenterDetails.championshipId andRoundId:(int)self.matchCenterDetails.roundId]&&self.matchCenterDetails.matchStatusHistory.count>0&&[[self.matchCenterDetails.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
        [self.predictBtn setHidden:NO];
        self.statisticsBtn.hidden = NO;
    }
    else{
        if ([[Global getInstance]isActiveChampion:(int)self.matchCenterDetails.championshipId andRoundId:(int)self.matchCenterDetails.roundId]){
            self.statisticsBtn.hidden = NO;
            
        }
        else{
            [self.statisticsBtn removeFromSuperview];
        }
        [self.predictBtn removeFromSuperview];
    }
    
}
-(void)setPredictionSponsor{
    
    if([AppSponsors isPredictionChampionActiveUsingId:self.matchCenterDetails.championshipId]){
        [self.predictBtn sd_setBackgroundImageWithURL: [NSURL URLWithString:[AppSponsors getPredictionMatchDetailsSponsorImagePathUsingChampionId:self.matchCenterDetails.championshipId]] forState:UIControlStateNormal];
    }
    else{
        [self.predictBtn setBackgroundImage:[UIImage imageNamed:@"predictBtn"] forState:UIControlStateNormal];
    }
}
#pragma mark - setNavigationBar Image
-(void)setMatchcenterBackgroundImage
{
    if([AppSponsors isChampionCoSponsorActiveUsingId:self.matchCenterDetails.championshipId])
    {
        sponsorUrl=[AppSponsors getMatchDetailsHeaderSponsorImagePathUsingChampionId:self.matchCenterDetails.championshipId];
        //self.matchCenterBgImg.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.matchCenterDetails.championshipId category:@"Match"];
        [self.matchCenterBgImg sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] placeholderImage:[UIImage imageNamed:@"MatchCenterBg"]];
    }
    else{
        
    }
    
}

-(void)addMoreBtnOnNavigationBar
{
    _plusButtonsViewNavBar = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:2
                                                           firstButtonIsPlusButton:NO
                                                                     showAfterInit:NO
                                                                     actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                              {
                                  // NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                                  if (plusButtonView.hidden == NO) {
                                      if(index==0) {
                                          [self refresh:nil];
                                      } else if(index==1) {
                                          [self commentsBtnAction:nil];
                                          [self showHideButtonsAction]; //if u didn't, when u return to this vc it will be displayed & u won't be apple to hide it
                                      }
                                  }
                              }];
    
    _plusButtonsViewNavBar.showHideOnScroll = NO;
    _plusButtonsViewNavBar.appearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndPop;
    _plusButtonsViewNavBar.position = LGPlusButtonsViewPositionTopRight;
    [_plusButtonsViewNavBar setButtonsImages:@[[UIImage imageNamed:@"refresh"],[UIImage imageNamed:@"comment"]] forState:UIControlStateNormal forOrientation:LGPlusButtonsViewOrientationAll];
    
    [_plusButtonsViewNavBar setButtonsSize:CGSizeMake(40.f, 40.f) forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewNavBar setButtonsLayerCornerRadius:20 forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewNavBar setButtonsBackgroundColor:[UIColor mainAppYellowColor] forState:UIControlStateNormal];
    [_plusButtonsViewNavBar setButtonsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.f]];
    [_plusButtonsViewNavBar setButtonsLayerShadowOpacity:0.8];
    [_plusButtonsViewNavBar setBackgroundColor:[UIColor clearColor]];
     [_plusButtonsViewNavBar setButtonsLayerShadowRadius:3.f];
    [_plusButtonsViewNavBar setButtonsLayerShadowOffset:CGSizeMake(0.f, 2.f)];
    
    [_plusButtonsViewNavBar setDescriptionsTextColor:[UIColor whiteColor]];
    [_plusButtonsViewNavBar setDescriptionsBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.66]];
    [_plusButtonsViewNavBar setDescriptionsLayerCornerRadius:6.f forOrientation:LGPlusButtonsViewOrientationAll];
    [_plusButtonsViewNavBar setDescriptionsContentEdgeInsets:UIEdgeInsetsMake(4.f, 8.f, 4.f, 8.f) forOrientation:LGPlusButtonsViewOrientationAll];
    // self.parentViewController.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:_plusButtonsViewNavBar];
    [self.view addSubview:_plusButtonsViewNavBar];
    
}

-(void)setNavigationBtns
{
    [self addMoreBtnOnNavigationBar];
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"Detailsmore"] forState:UIControlStateNormal];
    moreBtn.bounds = CGRectMake(Screenwidth-170,0,16,18);
    [moreBtn addTarget:self action:@selector(showHideButtonsAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];

    
}

- (void)commentsBtnAction:(id)sender {
    NSInteger  matchId;
    if(self.matchCenterDetails.idField != 0)
        matchId = self.matchCenterDetails.idField;
    else
        matchId = self.matchCenterDetails.idField;
    GlobalViewController * webView=[[GlobalViewController alloc]init];
    webView.url=[NSURL URLWithString:[NSString stringWithFormat:DISQUS_URL,@"match",matchId]];
    [self.navigationController pushViewController:webView animated:YES];
    
    
}
- (void)showHideButtonsAction
{
    _plusButtonsViewNavBar.position = LGPlusButtonsViewPositionTopRight;
    if (_plusButtonsViewNavBar.isShowing)
        [_plusButtonsViewNavBar hideAnimated:YES completionHandler:nil];
    else
        [_plusButtonsViewNavBar showAnimated:YES completionHandler:nil];
}
-(void)clearMemory
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    ShowInternetIndicator;
    //  [self.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollNotification:)
                                                 name:@"scrollUpNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addObserverOfscrollingMatchView)
                                                 name:@"AddScrollingObserver"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //self.title = @"مباريات";
    
    
}

// Sponsors
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    /// Main Sponsorship
    if([AppSponsors isChampionActiveUsingId:self.matchCenterDetails.championshipId])
    {
    mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSpecialChampionshipBannerImagePathUsingId:self.matchCenterDetails.championshipId]];
        [super setNavigationBarBackgroundFromChildViewControllerImageStr:mainSponsorUrl champs_id:self.matchCenterDetails.championshipId section_id:nil  activeCategory: nil];
    }
    if((mainSponsorUrl==nil||[mainSponsorUrl isEqualToString:@""])&&[AppSponsors isMatchSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"Matches"]];
        [super setNavigationBarBackgroundFromChildViewControllerImageStr:mainSponsorUrl champs_id:self.matchCenterDetails.championshipId section_id:nil  activeCategory: @"Matches"];
    }
    
    //If Still Nil then set the default bg sponsor image
    if (mainSponsorUrl == nil || [mainSponsorUrl isEqualToString:@""]) {
        [super setNavigationBarBackgroundImage];
    }
    
    //[self setNavigationBarBackgroundImage:mainSponsorUrl];
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];
    
    //[super setNavigationBarBackgroundFromChildViewControllerImageStr:mainSponsorUrl];
    

}
-(void)setNavigationBarBackgroundImage
{
    [self setFilGoalNavigationBar];
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
                
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (image && finished) {
                        //Commented beacuse this line was somehow decreassing the image quality when it was getting retrived
                        //[[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                        
                        //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                    }
                }];
                
            });
            
            
        }
    }
    
}
-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl
{
    [self setFilGoalNavigationBar];
    UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:mainSponsorUrl];
    if(image!=nil)
    {
        //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
    }
    else    if(mainSponsorUrl!=nil&&![mainSponsorUrl isEqualToString:@""])
    {
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:mainSponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
                [[SDImageCache sharedImageCache] storeImage:image forKey:mainSponsorUrl toDisk:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                });
            }
        }];
    }
    else
    {
        [self setNavigationBarBackgroundImage];
    }
    
}
-(void)setFilGoalNavigationBar
{
    [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    /*if(IS_IPHONE_4) {
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
    } else if(IS_IPHONE_5) {
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
    } else if (IS_IPHONE_6) {
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
    }  else {
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
    }*/
}
-(void)setAddToCalendarBtnImg
{
    self.addToCalendarButton.hidden = NO;
    NSString *title=  [NSString stringWithFormat:@"%@ vs %@",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName];
    
    EKEventStore *store = [EKEventStore new];
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if(status == EKAuthorizationStatusAuthorized)
    {
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted) { return; }
            if([self findEventWithTitle:title inEventStore:store])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [ self.addToCalendarButton setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
                });
                
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                [ self.addToCalendarButton setImage:[UIImage imageNamed:@"add_h"] forState:UIControlStateNormal];
                });
                
            }
        }];
    }
}
-(void)addObserverOfscrollingMatchView
{
    [[NSNotificationCenter defaultCenter]removeObserver:@"AddScrollingObserver"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollNotification:)
                                                 name:@"scrollUpNotification"
                                               object:nil];
}
- (void)becomeActive:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollNotification:)
                                                 name:@"scrollUpNotification"
                                               object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super setUpBannerUnderNav:self.view anotherTopView:nil];
    //self.buttonBarView.backgroundColor=[UIColor clearColor];;
    //self.isFromMatchDetails=YES;
    
    //SMGL EDIT
    [self setMainSponsor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)refresh:(id)sender
{
    self.navigationItem.rightBarButtonItem.enabled=NO;
    isRefresing=YES;
    [self getMatchDetails];
    
}
-(void)loadSponsor
{

    if([AppSponsors isChampionCoSponsorActiveUsingId:self.matchCenterDetails.championshipId])
    {
        sponsorUrl=[AppSponsors getMatchDetailsSponsorImagePathUsingChampionId:self.matchCenterDetails.championshipId];
        self.sponsorImg.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.matchCenterDetails.championshipId category:@"Matches"];
        [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImg.hidden = NO;
            self.sponsorImgWidthConstraint.constant=image.size.width/3;
            self.sponsorImgHeightConstraint.constant=image.size.height/3;
            self.infoHeightConstraint.constant=self.infoHeightConstraint.constant+self.sponsorImgHeightConstraint.constant;
        }];
    }
    else
    {
        self.sponsorImgWidthConstraint.constant=10;
        self.sponsorImgHeightConstraint.constant=0;
        self.infoHeightConstraint.constant=self.infoHeightConstraint.constant+self.sponsorImgHeightConstraint.constant;
    }

}

#pragma mark - Get Match Details Top Cell from API
-(void)getMatchDetails
{
    NSInteger matchID=0;
    matchID=self.matchCenterDetails.idField;
    NSDictionary * parameters=[[NSDictionary alloc]initWithObjects:@[@"MatchStatusHistory($orderby=StartAt desc),MatchStatistics,TvCoverage,MatchTeamsSquads($orderby=Order)",@"Id,TvCoverage,HomeTeamId,HomeTeamName,AwayTeamId,AwayTeamName,HomeScore,AwayScore,HomePenaltyScore,AwayPenaltyScore,ChampionshipName,ChampionshipId,MatchStatusHistory,Date,StadiumName,Week,StadiumId,RefereeName,RefereeId,HomeTeamCoachId,HomeTeamCoachName,AwayTeamCoachId,AwayTeamCoachName,RoundName,HomeTeamFormationId,HomeTeamFormationName,AwayTeamFormationId,AwayTeamFormationName"] forKeys:@[@"$expand",@"$select"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchDetailsAPI,[WServicesManager getSportsEngineApiBaseURL],matchID]  andParameters:parameters WithObjectName:@"MatchCenterDetails" andAuthenticationType:SportesEngineAPIs success:^(MatchCenterDetails* matchDetails) {
        self.matchCenterDetails=matchDetails;
        self.matchCenterDetails=matchDetails;
        self.matchTeamsSquads=matchDetails.matchTeamsSquads;
        self.matchStatistics= matchDetails.matchStatistics;
        self.matchStatusHistoryList = (NSMutableArray*) matchDetails.matchStatusHistory;
        [self setMatchDetailsUI:matchDetails];
        [self showPredictionBtn];

        if(!isSponserLoaded)
            [self loadSponsor];
        
        [self getEventsAPI];
        
    } failure:^(NSError *error) {
        [self.activityIndicator stopAnimating];
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
        IBGLog(@"Match Center Error : %@",error);
        [self showDefaultNetworkingErrorMessageForError:error
                                         refreshHandler:^{
                                             if(error.code == NSURLErrorUserCancelledAuthentication)
                                             {
                                                 [WServicesManager getToken];
                                             }
                                             [self getMatchDetails];

                                         }];
//        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Center with ID = %li ",(long)matchID] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
    }];
    
    
    
    
}
-(void)getEventsAPI
{
    NSInteger matchID=0;
    matchID=self.matchCenterDetails.idField;
    
    NSDictionary * eventsParameters = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"MatchId eq %li",(long)matchID],@"Time asc" ]forKeys:@[@"$filter",@"$orderby"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchEventsAPI,[WServicesManager getSportsEngineApiBaseURL],matchID]  andParameters:eventsParameters WithObjectName:@"EventsList" andAuthenticationType:SportesEngineAPIs success:^(EventsList* matchEvents) {
        self.matchEvents = [[NSMutableArray alloc]initWithArray:matchEvents.events];
        self.afterMatchEvents= matchEvents.events;
        self.loadingLbl.hidden=YES;
        [self.activityIndicator stopAnimating];
        self.matchEventsWithStatusHistory=[[MatchEventsWithStatusHistory alloc]initWithMatchEvents:matchEvents.events andMatchStatusHistory:self.matchStatusHistoryList andIsAfterMatch:NO];
        [self addTabsViewController];
        //        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"MatchCenter Screen" ApiError:@"Success"];
        
    } failure:^(NSError *error) {
        [self.activityIndicator stopAnimating];
        self.loadingLbl.text=@"لم يتم العثور علي بيانات";
        IBGLog(@"Match Center Error : %@",error);
        [self showDefaultNetworkingErrorMessageForError:error
                                         refreshHandler:^{
                                             [self getEventsAPI];
                                         }];
//        [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Center with ID = %li ",(long)matchID] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
    }];
    
}
#pragma mark - Setting Top Match Details Cell
-(void)setMatchDetailsUI:(MatchCenterDetails*)matchDetails
{
    [self.statisticsBtn setHidden:NO];
    [self.infoBtn setHidden:NO];
    [self.matchStatusLbl setHidden:NO];
    [self.homeTeamActivityIndicator startAnimating];
    [self.homeTeamActivityIndicator setHidden:NO];
    [self.awayTeamActivityIndicator startAnimating];
    [self.awayTeamActivityIndicator setHidden:NO];
    [self.homeCoachNameLbl setText:matchDetails.homeTeamCoachName];
    [self.awayCoachNameLbl setText:matchDetails.awayTeamCoachName];
    if(matchDetails.refereeName!=nil&&![matchDetails.refereeName isEqualToString:@""])
        [self.refereeNameLbl setText:matchDetails.refereeName];
    else
        self.refereeView.hidden=YES;
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(champNamePressed:)];
    // if labelView is not set userInteractionEnabled, you must do so
    [self.championNameWithRoundNameLbl setUserInteractionEnabled:YES];
    [self.championNameWithRoundNameLbl addGestureRecognizer:gesture];
    //if championName is not league then we will take round name instead of week
    if(matchDetails.roundName!=nil)
        self.championNameWithRoundNameLbl.text=[NSString stringWithFormat:@"%@ - %@",matchDetails.championshipName,matchDetails.roundName];
    
    else
        self.championNameWithRoundNameLbl.text=[NSString stringWithFormat:@"%@  - الاسبوع %ld",matchDetails.championshipName,(long)matchDetails.week];
    
    ///////// Convert ISO Date to NSDate and setting match date and time values
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    self.matchDateLbl.text= matchDetails.longDateStr;
    if(matchDetails.stadiumName!=nil&&![matchDetails.stadiumName isEqualToString:@""])
        [self.staduimLbl setText:matchDetails.stadiumName];
    else
    {
        self.matchStadiumView.hidden=YES;
        if([self.refereeView isHidden])
        {
           // [self.channelsView setFrame:self.matchStadiumView.frame];
        }
    }
    
    /////////////////////////////////////////////////////////
    if (matchDetails.tvCoverage.count==0) {
        //self.channelsNameLbl.text=@"غير متوفر حاليا";
        self.channelsView.hidden=YES;
    }
    else
    {
        TvCoverage * channelItem = [matchDetails.tvCoverage objectAtIndex:0];
       // self.channelsNameLbl.text=[[matchDetails.tvCoverage valueForKey:@"description"] componentsJoinedByString:@""];
        self.channelsNameLbl.text=channelItem.tvChannelName;
        if(![channelItem.commenterName isKindOfClass:[NSNull class]]&&![channelItem.commenterName isEqualToString:@""])
            self.commenterNameLbl.text=channelItem.commenterName;
        else
            self.commenterView.hidden=YES;
        
    }
    
    if(matchDetails.matchStatusHistory.count>0)
    {
        MatchStatusHistory * matchStatusItem=[matchDetails.matchStatusHistory objectAtIndex:0];
        [self handleCounter:matchStatusItem];
        
        //self.counterLbl.text = matchDetails.time;
        
        if(matchStatusItem.matchStatusIndicatorId == MatchLiveIndicatorID )
        {
            // setting score with zero
            // if match is live we will register for websockets
            
            ////////////
            if(matchStatusItem.matchStatusId == KMatchBreak)
            {
                self.timer = nil;
            }
            else
            {
                self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target: self
                                                          selector: @selector(updateTheCounter:) userInfo:matchStatusItem repeats: YES];
            }
            [self.matchStatusLbl setText:@"مباشر"];
            [self.indicatorStatusLbl setHidden:NO];
            [self.indicatorStatusLbl setText:matchStatusItem.matchStatusName];
             
             [self.addToCalendarButton setHidden:YES];
            
        }
        
        else if(matchStatusItem.matchStatusId == KMatchNotStarted||matchStatusItem.matchStatusId == KMatchSoon)
        {
            // before match
            [self.matchStatusLbl setText:((MatchStatusHistory*)[matchDetails.matchStatusHistory objectAtIndex:0]).matchStatusName];
            [self.indicatorStatusLbl setHidden:YES];
            //self.counterLbl.text=[outputFormatter stringFromDate:datePlusTimeOffest];
            self.counterLbl.text= matchDetails.time;
            [self setAddToCalendarBtnImg];
            [self.addToCalendarButton setHidden:NO];

        }
        else
        {
            
            [self.matchStatusLbl setText:((MatchStatusHistory*)[matchDetails.matchStatusHistory objectAtIndex:0]).matchStatusName];
            [self.indicatorStatusLbl setHidden:YES];
            //self.counterLbl.text=[outputFormatter stringFromDate:datePlusTimeOffest];
            self.counterLbl.text= matchDetails.time;
            [self.addToCalendarButton setHidden:YES];

            
        }
        [self.matchStatusLbl setBackgroundColor:((MatchStatusHistory*)[matchDetails.matchStatusHistory objectAtIndex:0]).matchStatusColor];
    }
    
    [self.homeTeamLogoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)matchDetails.homeTeamId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           [self.homeTeamActivityIndicator stopAnimating];
                                           [self.homeTeamActivityIndicator setHidden:YES];
                                           
                                       }];
    
    [self.awayTeamNameLbl setText:matchDetails.awayTeamName];
    if(matchDetails.matchStatusHistory.count>0)
    {
        MatchStatusHistory * matchStatusItem=[matchDetails.matchStatusHistory objectAtIndex:0];
        if(matchStatusItem.matchStatusIndicatorId==MatchNotStartedIndicatorID||matchStatusItem.matchStatusId==11||matchStatusItem.matchStatusId==12)
        {
            [self.awayTeamScoreLbl setText:@"-"];
            [self.homeTeamScoreLbl setText:@"-"];
        }
        else
        {
            [self.awayTeamScoreLbl setText:[NSString stringWithFormat:@"%li",(long)matchDetails.awayScore]];
            [self.homeTeamScoreLbl setText:[NSString stringWithFormat:@"%li",(long)matchDetails.homeScore]];
            
        }
    }
    //  [self.awayTeamScoreLbl setText:[NSString stringWithFormat:@"%li",(long)matchDetails.awayScore]];
    [self.awayTeamPlentyLbl setText:[NSString stringWithFormat:@"(%li)",(long)matchDetails.awayPenaltyScore]];
    [self.homeTeamNameLbl setText:matchDetails.homeTeamName];
    // [self.homeTeamScoreLbl setText:[NSString stringWithFormat:@"%li",(long)matchDetails.homeScore]];
    [self.homeTeamPlentyLbl setText:[NSString stringWithFormat:@"(%li)",(long)matchDetails.homePenaltyScore]];
    
    
    [self.awayTeamLogoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)matchDetails.awayTeamId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           [self.awayTeamActivityIndicator stopAnimating];
                                           [self.awayTeamActivityIndicator setHidden:YES];
                                           
                                       }];
    
    if(![self.matchStadiumView isHidden]&&[self.refereeView isHidden]&&![self.channelsView isHidden])
    {
      //  self.channelsView.frame=self.refereeView.frame;
    }
    
    if(matchDetails.homePenaltyScore!=0)
    {
        self.homeTeamPlentyLbl.hidden=NO;
    }
    else
    {
        self.homeTeamPlentyLbl.hidden=YES;
        
    }
    
    if(matchDetails.awayPenaltyScore!=0)
    {
        self.awayTeamPlentyLbl.hidden=NO;
    }
    else
    {
        self.awayTeamPlentyLbl.hidden=YES;
    }
    
}
-(void)handleCounter:(MatchStatusHistory*)matchStatusItem
{
    
    ///////// Convert ISO Date to NSDate and setting match date and time values
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    //[formatter setLocale:[NSLocale currentLocale]];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    //Match Time with cairo time offset (+2)
    NSDate * datePlusTimeOffest = [[formatter dateFromString:matchStatusItem.startAt] dateByAddingTimeInterval:60*60*[kCairoTimeOffset integerValue]];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMMM dd yyyy hh:mma"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if(datePlusTimeOffest != nil)
        self.componentMint = [calendar components:NSCalendarUnitMinute fromDate:datePlusTimeOffest toDate:[NSDate date] options:NSCalendarMatchStrictly];
    if(datePlusTimeOffest != nil)
        self.componentSec =  [calendar components:NSCalendarUnitSecond fromDate:datePlusTimeOffest toDate:[NSDate date] options:NSCalendarMatchStrictly];
    
    
    if(matchStatusItem.isCounterEnabled)
    {
        if(!isRefresing)
        {
            
            self.counterLbl.text=[outputFormatter stringFromDate:datePlusTimeOffest];
        }
        else
        {
            isRefresing=NO;
            [self.timer invalidate];
            self.timer=nil;
            
        }
        
    }
    else
    {
        [self.timer invalidate];
        
    }
    
}


-(void) addTabsViewController
{
    self.navigationItem.rightBarButtonItem.enabled=YES;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
   // [formatter setLocale:[NSLocale currentLocale]];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:usLocale];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd-MM-yyyy"];
    //Match Time with cairo time offset (+2)
    NSDate * datePlusTimeOffest = [[formatter dateFromString:self.matchCenterDetails.date] dateByAddingTimeInterval:60*60*[kCairoTimeOffset integerValue]];
    MatchOverviewViewController * matchOverViewController=[[MatchOverviewViewController alloc]init];
    MatchStatusHistory * matchStatusItem;
    if(self.matchCenterDetails.matchStatusHistory.count>0)
        matchStatusItem=[self.matchCenterDetails.matchStatusHistory objectAtIndex:0];
    
    matchOverViewController.matchItem=self.matchCenterDetails;
    matchOverViewController.title=@"نظرة عامة";
    //matchOverViewController.matchDate=self.matchCenterDetails.date;
    matchOverViewController.index=0;
    matchOverViewController.matchStatistics=self.matchStatistics;
    MatchTabsViewController * matchTabsViewController=[[MatchTabsViewController alloc]init];
    matchTabsViewController.title=@"احداث المباراة";
    matchTabsViewController.matchDetails=self.matchCenterDetails;
    matchTabsViewController.matchStatusHistoryList=self.matchStatusHistoryList;
    matchTabsViewController.matchEventsWithStatusHistory=self.matchEventsWithStatusHistory;
    matchTabsViewController.matchTeamsSquads=self.matchTeamsSquads;
    matchTabsViewController.matchEventsList=self.matchEvents;
    matchTabsViewController.matchItem=self.matchCenterDetails;
    matchTabsViewController.isFromMatchEventsTabs=YES;
    if(matchStatusItem!=nil&&matchStatusItem.matchStatusIndicatorId==2)
        matchTabsViewController.isMatchStarted=YES;
    else
        matchTabsViewController.isMatchStarted=NO;
    
    
    matchTabsViewController.index=1;
    AfterMatchViewController * afterMatchViewController= [[AfterMatchViewController alloc]init];
    afterMatchViewController.title=@"بعد المباراة";
    afterMatchViewController.matchStatistics=self.matchStatistics;
    afterMatchViewController.matchEventsWithStatusHistory=self.matchEventsWithStatusHistory;
    afterMatchViewController.matchItem=self.matchCenterDetails;
    afterMatchViewController.matchStatusHistory=self.matchStatusHistoryList;
    afterMatchViewController.matchEventsList=self.afterMatchEvents;
    self.afterMatchEvents=nil;
    self.matchEvents=nil;
    afterMatchViewController.index=2;
    NSMutableArray * childViewControllers=[[NSMutableArray alloc]initWithObjects:afterMatchViewController,matchTabsViewController,matchOverViewController, nil];
    
    MatchDetailsTabsViewController * tabsViewController=[[MatchDetailsTabsViewController alloc]init];
    tabsViewController.matchStatusHistoryList=self.matchStatusHistoryList;
    tabsViewController.childViewControllers=childViewControllers;
    tabsViewController.matchCenterItem=self.matchCenterDetails;
    tabsViewController.isFromMatchDetails=YES;
    [self addChildViewController:tabsViewController];
    [tabsViewController.view setFrame:CGRectMake(0,0, self.tabsView.frame.size.width, self.tabsView.frame.size.height)];
    [self.tabsView addSubview:tabsViewController.view];
    [tabsViewController.view setBackgroundColor:[UIColor clearColor]];
    // [self.view bringSubviewToFront:self.tabsView];
    [tabsViewController didMoveToParentViewController:self];
}
-(void)champNamePressed:(UITapGestureRecognizer*)gesture
{
    ChampionShipData * champion = [[ChampionShipData alloc]init];
    Champion * item=[[Champion alloc]init];
    item =[[Global getInstance]getChampById:(int)self.matchCenterDetails.championshipId];
    champion.idField = item.champId;
    champion.name = item.champName;
    if(item.champId != 0)
    {
        UINavigationController * navigationController = GetAppDelegate().getSelectedNavigationController;
        ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
        detailsScreen.champion = champion;
        [navigationController pushViewController:detailsScreen animated:YES];
    }
    
}

- (IBAction)backPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.timer=nil;
    [self.timer invalidate];
    [[NSNotificationCenter defaultCenter]removeObserver:UIApplicationDidBecomeActiveNotification];
    
}

// scrolling animation
- (void) scrollNotification:(NSNotification *) notification
{
    BOOL scrollUp= [[notification.object objectForKey:@"scroll"] boolValue];
    if (scrollUp)
    {
        self.infoView.hidden=YES;
        self.infoHeightConstraint.constant=0.0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(scrollNotification:)
                                                     name:@"scrollDownNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"scrollUpNotification" object:nil];
        
    }
    else
    {
        self.infoView.hidden=NO;
        self.infoHeightConstraint.constant=219+self.sponsorImgHeightConstraint.constant;

        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"scrollDownNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(scrollNotification:)
                                                     name:@"scrollUpNotification"
                                                   object:nil];
    }
}
- (BOOL)shouldAutorotate {
    return NO;
}

//=====Counter Methods ========//
- (void)updateTheCounter:(NSTimer*)sender{
    
    [NSThread detachNewThreadSelector:@selector(updateCountdown) toTarget:self withObject:nil];
}

-(NSString *) updateCountdown{
    
    if (self.componentSec.second<60) {
        self.componentSec.second=self.componentSec.second+1;
    }
    else{
        self.componentMint.minute=self.componentMint.minute+1;
        self.componentSec.second=00;
        
    }
    
    
    self.counterTime= [NSString stringWithFormat:@"%ld : %ld",(long)self.componentMint.minute,(long)self.componentSec.second];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.counterLbl.text=self.counterTime;
    });
    // NSLog(@"the counter is  %@", self.counterTime);
    return  self.counterTime;
}
-(void)organizeLocalPushNotification
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"request succeeded!");
                                      [self setLocalNotificationsiOS10];
                                  }
                              }];
    }
    else
    {
        [self setLocalNotificationsiOS9];
    }
    
}
-(void)setLocalNotificationsiOS10
{
    
    NSDictionary * alertDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"تابع لحظة بلحظة مباراة %@ ضد %@ بعد %ld دقائق",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName,(long)selectedPeriod]
                                                                     ] forKeys:@[@"alert"]];
    NSDictionary * dictionary=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%li",(long)self.matchCenterDetails.idField],@"3",alertDic] forKeys:@[@"id",@"type",@"aps"]];
    
    //NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
  //  [dateformat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate * matchStartDate=[dateFormatter dateFromString:self.matchCenterDetails.date];
    NSDate *datePlusOneMinute = [matchStartDate dateByAddingTimeInterval:60*60*2];
    
    NSDate *alarmDate = [datePlusOneMinute dateByAddingTimeInterval:-60*selectedPeriod];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calendar setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitTimeZone fromDate:alarmDate];
    
    dispatch_async(dispatch_get_main_queue(), ^{
    UNMutableNotificationContent *objNotificationContent = [[UNMutableNotificationContent alloc] init];
    objNotificationContent.userInfo = dictionary;
    
    objNotificationContent.body = [NSString stringWithFormat:@"تابع لحظة بلحظة مباراة %@ ضد %@ بعد %ld دقائق",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName,(long)selectedPeriod];
    objNotificationContent.sound = [UNNotificationSound defaultSound];
    
    objNotificationContent.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
    
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ten"
                                                                          content:objNotificationContent trigger:trigger];
    /// 3. schedule localNotification
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Local Notification succeeded");
        }
        else {
            NSLog(@"Local Notification failed");
        }
    }];
    
    
    });
}
-(void)setLocalNotificationsiOS9
{
    
    //NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    //[dateformat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    NSDate * matchStartDate=[dateFormatter dateFromString:self.matchCenterDetails.date];
    NSDate *datePlusOneMinute = [matchStartDate dateByAddingTimeInterval:60*60*2];
    
    NSDate *alarmDate = [datePlusOneMinute dateByAddingTimeInterval:-60*selectedPeriod];
    // NSDate *alarmDate = [[NSDate date] dateByAddingTimeInterval:60*1];
    
    NSDictionary * alertDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"تابع لحظة بلحظة مباراة %@ ضد %@ بعد %ld دقائق",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName,(long)selectedPeriod]
                                                                     ] forKeys:@[@"alert"]];
    NSDictionary * dictionary=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%li",(long)self.matchCenterDetails.idField],@"3",alertDic] forKeys:@[@"id",@"type",@"aps"]];
    // Schedule the notification
    // NSDate * date = [[NSDate alloc]init];
    //  date = [dateFormatter dateFromString:@"2017-04-29T15:43:00"];
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = alarmDate;
    localNotification.alertBody =[NSString stringWithFormat:@"تابع لحظة بلحظة مباراة %@ ضد %@ بعد %ld دقائق",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName,(long)selectedPeriod];
    
    localNotification.alertTitle =[NSString stringWithFormat:@"تابع لحظة بلحظة مباراة %@ ضد %@ بعد %ld دقائق",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName,(long)selectedPeriod];
    
    localNotification.alertAction = @"تفاصيل المباراة";
    localNotification.userInfo=dictionary;
    // localNotification.repeatInterval = NSDayCalendarUnit;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)showCalendarPicker:(UIButton *)sender
{
    NSArray * notificationPeriods = @[@"5",@"10",@"15",@"60"];
    selectedPeriod = 15;
    ActionSheetStringPicker * picker = [[ActionSheetStringPicker alloc]initWithTitle:@"وقت تنبيه المباراة بالدقائق"
                                                                                rows:notificationPeriods
                                                                    initialSelection:2
                                                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                               
                                                                               selectedPeriod = [[notificationPeriods objectAtIndex:selectedIndex]integerValue];
                                                                               [self addEventToCalendar];
                                                                               [self organizeLocalPushNotification];
                                                                               
                                                                           }cancelBlock:^(ActionSheetStringPicker *picker) {
                                                                           }
                                                                              origin:sender];
    picker.toolbarBackgroundColor = [UIColor darkGrayColor];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTintColor:[UIColor darkGrayColor]];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"إلغاء" forState:UIControlStateNormal];
    [cancelButton setFrame:CGRectMake(0, 0, 32, 32)];
    [picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:cancelButton]];
    
    UIButton * doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTintColor:[UIColor darkGrayColor]];
    [doneButton setTitle:@"تم" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setFrame:CGRectMake(0, 0, 32, 32)];
    [picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:doneButton]];
    
    [picker showActionSheetPicker];
}

- (IBAction)addToCalendarPressed:(UIButton *)sender
{
    NSString *title=  [NSString stringWithFormat:@"%@ vs %@",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName];
    
    EKEventStore *store = [EKEventStore new];
    
    if(![self findEventWithTitle:title inEventStore:store])
        [self showCalendarPicker:sender];
    else
        [self removeEventFromCalendar];
    
    
    
}
#pragma mark - Info btn Action
-(NSDictionary*)getMatchInfoList{
    NSMutableArray * iconsList=[[NSMutableArray alloc]init];
    NSMutableArray * list = [[NSMutableArray alloc]init];
    
    if(self.matchCenterDetails.stadiumName != nil)
    {
        [list addObject:@{@"ملعب : ":@[self.matchCenterDetails.stadiumName]}];
        [iconsList addObject:@"staduim-1"];
    }
    if(self.matchCenterDetails.dateStr != nil){
        [list addObject:@{@"التوقيت :  ":@[self.matchCenterDetails.dateStr]}];
        [iconsList addObject:@"calendar"];
    }
    NSDictionary *dic = [self getChannelsName:self.matchCenterDetails.tvCoverage];
    if(self.matchCenterDetails.tvCoverage != nil && self.matchCenterDetails.tvCoverage.count>0 && [dic objectForKey:@"Channels"] != nil){
        [list addObject:@{@"القنوات الناقلة :":[dic objectForKey:@"Channels"]}];
        [iconsList addObject:@"TV"];
    }
    if(self.matchCenterDetails.tvCoverage != nil && self.matchCenterDetails.tvCoverage.count>0 && [dic objectForKey:@"Commenters"] != nil){
        [list addObject:@{@"المقدم : ":[dic objectForKey:@"Commenters"]}];
        [iconsList addObject:@"commenter"];
    }
    if(self.matchCenterDetails.refereeName != nil){
        [list addObject:@{@"الحكم :":@[self.matchCenterDetails.refereeName]}];
        [iconsList addObject:@"referee"];
    }
    NSDictionary * infodic = @{@"Titles":list,@"Icons":iconsList};
    return infodic;
}
-(NSDictionary*)getChannelsName:(NSArray*)channels{
    NSMutableArray * channelslist = [[NSMutableArray alloc]init];
    NSMutableArray * commenterlist = [[NSMutableArray alloc]init];

    NSMutableDictionary * channelsDic = [[NSMutableDictionary alloc]init];
    for (TvCoverage * item in channels) {
        if(item.tvChannelName != nil){
            [channelslist addObject:item.tvChannelName];
        }
        if(item.commenterName != nil){
            [commenterlist addObject:item.commenterName];
        }
    }
    if (channelslist.count>0){
        [channelsDic setObject:channelslist forKey:@"Channels"];
    }
    if(commenterlist.count>0){
        [channelsDic setObject:commenterlist forKey:@"Commenters"];
    }
    return channelsDic;
}
- (IBAction)infoBtnAction:(id)sender {
    NSDictionary * dic = [self getMatchInfoList];
    MatchInfoViewController * viewController = [[MatchInfoViewController alloc]init];
    viewController.items = [dic objectForKey:@"Titles"];
    viewController.itemsIcons = [dic objectForKey:@"Icons"];
    // viewController.delegate = self;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:viewController];
    popupController.style = STPopupStyleFormSheet;
    [popupController presentInViewController:self];
}
#pragma mark - Handle UserStatistics Action
- (IBAction)statisticalBtnAction:(id)sender {
    UsersStatisticsViewController * viewController = [[UsersStatisticsViewController alloc]init];
    viewController.matchItem = self.matchCenterDetails;
   // viewController.delegate = self;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:viewController];
    popupController.style = STPopupStyleFormSheet;
    [popupController presentInViewController:self];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Predictions"
                                                          action:@"Statistics-Button"
                                                           label:[NSString stringWithFormat:@"Match ID = %li ",(long)self.matchCenterDetails.idField]
                                                           value:nil] build]];
}
-(void)addEventToCalendar
{
    //NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
   // [dateformat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    NSDate * matchStartDate=[dateFormatter dateFromString:self.matchCenterDetails.date];
    NSDate *datePlusOneMinute = [matchStartDate dateByAddingTimeInterval:60*60*2];
    
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = [NSString stringWithFormat:@"%@ vs %@",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName];
        
        bool isEventFound = [self findEventWithTitle:event.title inEventStore:store];
        event.notes=[NSString stringWithFormat:@"هذا الحدث تم إضافته بواسطه تطبيق فليجول \n %@  \n %@ \n http://www.filgoal.com/matches/%ld \n",self.matchCenterDetails.championshipName, self.matchCenterDetails.stadiumName,(long)self.matchCenterDetails.idField];
        event.startDate = datePlusOneMinute; //today
        event.endDate = [event.startDate dateByAddingTimeInterval:120*60];  //set 1 hour meeting
        event.calendar = [store defaultCalendarForNewEvents];
        event.location= self.matchCenterDetails.stadiumName;
        //NSLog(@"%@",event.eventIdentifier);
        NSError *err = nil;
        if(!isEventFound)
        {
            EKReminder *reminder = [EKReminder reminderWithEventStore:store];
            reminder.title = event.title;
            reminder.calendar = [store defaultCalendarForNewEvents];
            NSError *error = nil;
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:event.startDate];
            alarm.relativeOffset = -selectedPeriod*60;
            [event addAlarm:alarm];
            [store saveReminder:reminder commit:YES error:&error];
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [ self.addToCalendarButton setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
                
                
            });
            
        }
        
    }];
    
    
    
}
-(void)removeEventFromCalendar
{
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = [NSString stringWithFormat:@"%@ vs %@",self.matchCenterDetails.homeTeamName,self.matchCenterDetails.awayTeamName];
        
        bool isEventFound = [self findEventWithTitle:event.title inEventStore:store];
        
        if(isEventFound)
        {
            EKEvent* event2;
            event2 = [store eventWithIdentifier:eventIdentifier];
            if (event2 != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self deleteLocalNotifcation];
                    [ self.addToCalendarButton setImage:[UIImage imageNamed:@"add_h"] forState:UIControlStateNormal];
                    
                    
                });
                UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"تم حذف المباراة من جدولك" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView performSelectorOnMainThread:@selector(show)
                                            withObject:nil waitUntilDone:NO];
                
                NSError* error = nil;
                [store removeEvent:event2 span:EKSpanThisEvent commit:YES error:&error];
                
                
                
            }
            
        }
        
        
    }];
}
-(void) deleteLocalNotifcation
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString * matchID=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"id"]];
        if ([matchID isEqualToString:[NSString stringWithFormat:@"%li",(long)self.matchCenterDetails.idField]])
        {
            //Cancelling local notification
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }
}
- (BOOL)findEventWithTitle:(NSString *)title inEventStore:(EKEventStore *)store
{
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Create the start range date components
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    
    // Create the end range date components
    NSDateComponents *oneWeekFromNowComponents = [[NSDateComponents alloc] init];
    oneWeekFromNowComponents.day = 7;
    NSDate *oneWeekFromNow = [calendar dateByAddingComponents:oneWeekFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:oneDayAgo
                                                            endDate:oneWeekFromNow
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    
    for (EKEvent *event in events)
    {
        NSString * eventTitle=[NSString stringWithFormat:@"%@",event.title];
        eventTitle = [eventTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([eventTitle isEqualToString:title])
        {
            eventIdentifier=event.eventIdentifier;
            return YES;
        }
    }
    
    return NO;
}



- (IBAction)homeTeamBtnPressed:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController * navigationController = [delegate getSelectedNavigationController];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)self.matchCenterDetails.homeTeamId;
    teamProfile.teamName = self.matchCenterDetails.homeTeamName;
    [navigationController pushViewController:teamProfile animated:YES];
}

- (IBAction)awayTeamBtnPressed:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController * navigationController = [delegate getSelectedNavigationController];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)self.matchCenterDetails.awayTeamId;
    teamProfile.teamName = self.matchCenterDetails.awayTeamName;
    [navigationController pushViewController:teamProfile animated:YES];
}

- (IBAction)predictBtnAction:(id)sender {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Predictions"
                                                          action:@"Predict-Button" 
                                                           label:[NSString stringWithFormat:@"Match ID = %li ",(long)self.matchCenterDetails.idField]
                                                           value:nil] build]];
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"FilGoalPredictions://"]])
    {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"FilGoalPredictions://https://predictnwin.filgoal.com/prediction/Predict?champId=%li&MatchId=%li",(long)self.matchCenterDetails.championshipId,(long)self.matchCenterDetails.idField]]];
    }
    else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://predictnwin.filgoal.com/prediction/Predict?champId=%li&MatchId=%li",(long)self.matchCenterDetails.championshipId,(long)self.matchCenterDetails.idField]]];
    }
    
}
@end
