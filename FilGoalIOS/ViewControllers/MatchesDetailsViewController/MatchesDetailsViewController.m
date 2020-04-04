//
//  HomeViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "MatchesDetailsViewController.h"
#import "MatchItem.h"
#import "UIImageView+WebCache.h"
#import "Actions.h"
#import "MatchActions.h"
#import "MatchesCellLoader.h"
#import "MatchesCellLoader2.h"
#import "MatchActionCellLoader.h"
#import "TeamAlineUps.h"
#import "LineUpCellLoader.h"
#import "MFSideMenu.h"
#import  "AppInfo.h"
#import "Sponsor.h"
#import "Global.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "ChampSponsor.h"
#import "AppDelegate.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
//#import "GlobalViewController.h"
#import "SVWebViewController.h"
@interface MatchesDetailsViewController ()

@end

@implementation MatchesDetailsViewController
//change font
-(void)changeFont:(UIView *) view{
    for (id View in [view subviews]) {
        if ([View isKindOfClass:[UILabel class]]) {
            UILabel *lbl=(UILabel*)View;
            [lbl setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:lbl.font.pointSize]];
            
        }
        if ([View isKindOfClass:[UIView class]]) {
            [self changeFont:View];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.menuContainerViewController.panMode=MFSideMenuPanModeNone;
    [self changeFont:self.view];
    
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshButton.frame = CGRectMake(0, 0, 35, 35);
    [refreshButton setBackgroundImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    self.navigationItem.rightBarButtonItem = refresh;
    
    if(self.isFromPushNotification)
    {
           self.screenName = [NSString stringWithFormat:@"iOS- Match details-Push with Match ID =%i",self.match.info.iDProperty ];

        if(self.menuContainerViewController.panMode==MFSideMenuPanModeNone)
        {
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            if ([self.parentViewController.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                self.parentViewController.navigationController.interactivePopGestureRecognizer.enabled = NO;
                
            }
            
        }
        
    }
    else if (_isFrom3DTouch)
    {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory: @"iOS-3DTouch"    // Event category (required)
                                                              action: @"Match details-3DTouch" // Event action (required)
                                                               label: [NSString stringWithFormat:@"Match details-3DTouch with Match ID =%i",self.match.info.iDProperty ]
                                                               value:nil] build]];
        
       // self.screenName = [NSString stringWithFormat:@"iOS- Match details-3DTouch with Match ID =%i",self.match.info.iDProperty ];

    }

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithfrom:(NSString*)from matches:(MatchDetails*)partmatches
{
    self = [super init];
    if (self) {
        self.from=from;
        self.match=partmatches;
        // Custom initialization
    }
    return self;
}

- (id)initWithWidgetMatch:(NSString*)from andWidgetMatch:(WidgetMatchModel *)widgetMatch{
    
    self = [super init];
    
    if (self) {
        self.from=from;
        self.match=[[MatchDetails alloc] init];
        self.match.info=[[MatchItem alloc] init];
        [self mappingWidgetModel:widgetMatch];

    }
    return self;
}
- (void)mappingWidgetModel :(WidgetMatchModel *)widgetMatchModel {
    
    self.match.info.time=widgetMatchModel.time;
    self.match.info.fClubName=widgetMatchModel.fClubName;
    self.match.info.sClubName=widgetMatchModel.sClubName;
    self.match.info.fClubLogo=widgetMatchModel.fClubLogo;
    self.match.info.sClubLogo=widgetMatchModel.sClubLogo;
    self.match.info.fClubScoreResult=widgetMatchModel.fClubScoreResult;
    self.match.info.sClubScoreResult=widgetMatchModel.sClubScoreResult;
    self.match.info.fClubScoreLive=widgetMatchModel.fClubScoreLive;
    self.match.info.sClubScoreLive=widgetMatchModel.sClubScoreLive;
    self.match.info.fClubScorePen=widgetMatchModel.fClubScorePen;
    self.match.info.sClubScorePen=widgetMatchModel.sClubScorePen;
    self.match.info.champName =widgetMatchModel.champName;
    
    self.match.info.statusId =widgetMatchModel.statusId;
    
    self.match.info.isLive=widgetMatchModel.isLive;
    self.match.info.place=widgetMatchModel.place;
    self.match.info.club1Id=widgetMatchModel.club1Id;
    self.match.info.club2Id=widgetMatchModel.club2Id;
    self.match.info.matchStatus=widgetMatchModel.matchStatus;
    self.match.info.numOfLiveMatches=widgetMatchModel.numOfLiveMatches;
    self.match.info.formattedDate=widgetMatchModel.formattedDate;
    
    self.match.info.champLogo=widgetMatchModel.champLogo;
    self.match.info.channels=widgetMatchModel.channels;
    
    self.match.info.fACoachName=widgetMatchModel.fACoachName;
    self.match.info.sACoachName=widgetMatchModel.sACoachName;
    
    
    self.match.info.champid=widgetMatchModel.champid;
    self.match.info.date=widgetMatchModel.date;
    self.match.info.championshipsNumOfMatches=widgetMatchModel.championshipsNumOfMatches;
    self.match.info.iDProperty=widgetMatchModel.iDProperty;
    self.match.info.matchStartTime=widgetMatchModel.matchStartTime;
    
}

-(IBAction)backBtnTaped:(id)sender{
//    if ([self.from isEqualToString:@"widget"]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    else
        [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //=====TimeCounter============//
#warning fixed time just for test it needs to replaced with actual date
    
    
    
    
    if (self.match.info.statusId!=0&&self.match.info.statusId!=6) {
        if([self.match.info matchStartTime]!=NULL||[self.match.info.fClubScorePen intValue]!=-1){
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"MMMMM dd yyyy hh:mma"];
            NSDate *dateFromString = [dateFormatter dateFromString:[self.match.info matchStartTime]];
            
            //
            NSCalendar *calendar = [NSCalendar currentCalendar];
            self.componentMint = [calendar components:NSCalendarUnitMinute fromDate:dateFromString toDate:[NSDate date] options:NSCalendarMatchStrictly];
            self.componentSec =  [calendar components:NSCalendarUnitSecond fromDate:dateFromString toDate:[NSDate date] options:NSCalendarMatchStrictly];
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 target: self
                                           selector: @selector(updateTheCounter) userInfo:nil repeats: YES];
        }
        
        
    }
    
    else{
        
        self.matchDateLabel.text=self.match.info.time;
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag==200) {
        
        CGPoint offset = scrollView.contentOffset;
        if (offset.x==0) {
            [self.tab1 setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
            [self.tab2 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
            [self.tab3 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
        }
        if (offset.x==Screenwidth) {
            [self.tab2 setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
            [self.tab1 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
            [self.tab3 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
        }
        if (offset.x==Screenwidth*2) {
            [self.tab3 setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
            [self.tab2 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
            [self.tab1 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
        }
    }
}



-(IBAction)selectTap1:(id)sender{
    [self.tab1 setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.tab2 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.tab3 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = 0;
    if (sender==nil) {
        [self.scrollView setContentOffset:offset];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.scrollView setContentOffset:offset];
        }];
    }
    
}
-(IBAction)selectTap2:(id)sender{
    [self.tab2 setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.tab1 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.tab3 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = Screenwidth;
    if (sender==nil) {
        [self.scrollView setContentOffset:offset];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.scrollView setContentOffset:offset];
        }];
    }
    
}
-(IBAction)selectTap3:(id)sender{
    [self.tab3 setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [self.tab2 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.tab1 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = Screenwidth*2;
    if (sender==nil) {
        [self.scrollView setContentOffset:offset];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            [self.scrollView setContentOffset:offset];
        }];
    }
    
    
}
- (void)viewDidLoad
{
    if(_isFromPushNotification)
    {
        _isFromPushNotification=NO;
           self.screenName = [NSString stringWithFormat:@"iOS- Match details-Push with Match ID =%i",self.match.info.iDProperty ];
    }
    else   if(_isFromMatchWidget)
    {
        _isFromMatchWidget=NO;
        self.screenName = [NSString stringWithFormat:@"iOS- Widget - Match details with Match ID =%i",self.match.info.iDProperty ];
    }
    else
    {
        self.screenName = [NSString stringWithFormat:@"iOS- Match details with Match ID =%i",self.match.info.iDProperty ];

    }
    [super viewDidLoad];
    
    AppInfo *appInfo= [Global getInstance].appInfo;
    if (appInfo.sponsor.isActive==1) {
        NSString *url=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
        if (IS_IPHONE_6_PLUS) {
            url=[NSString stringWithFormat:@"%@/MainSponsor/header6plus@3x.png",appInfo.sponsor.imgsBaseUrl];
        }
        else if (IS_IPHONE_6)
        {
            url=[NSString stringWithFormat:@"%@/MainSponsor/header6@2x.png",appInfo.sponsor.imgsBaseUrl];
        }
        else
        {
            url=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
        }
        

        for (ChampSponsor *cham in appInfo.sponsor.champSponsor) {
            if (cham.champId==self.match.info.champid) {
                url=[NSString stringWithFormat:@"%@",cham.imgUrl];
            }
        }
        
       // [self.sponser setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
       // }];
        [self.sponser sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //[self.sponser setBackgroundColor:[UIColor colorWithRed:3/255.0 green:83/255.0 blue:138/255.0 alpha:1.0]];
            self.sponser.contentMode=UIViewContentModeScaleToFill;            
        }];
    }
    else{
        self.scrollView.frame=CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y-26, Screenwidth,  self.scrollView.frame.size.height+26);
        
    }
    self.minByMinWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, self.tv3.frame.size.height)];
    
    
    
    
    self.canLoadMore=YES;
    //----- Show Loading view
    [self.indLoader startAnimating];
    [self.indLoader setHidden:NO];
    [self.tv setHidden:YES];
    [self.loadingLabel setHidden:NO];
    //----- load Matches
    [self LoadMatches];
    
    [self initUiViews:YES];
    //    self.refreshControl = [[UIRefreshControl alloc] init];
    //    [self.refreshControl addTarget:nil action:@selector(updateArray:) forControlEvents:UIControlEventValueChanged];
    //    [self.tv addSubview:self.refreshControl];
    //
    //    self.refreshControl2 = [[UIRefreshControl alloc] init];
    //    [self.refreshControl2 addTarget:nil action:@selector(updateArray:) forControlEvents:UIControlEventValueChanged];
    //    [self.tv2 addSubview:self.refreshControl2];
    //
    //    self.refreshControl3 = [[UIRefreshControl alloc] init];
    //    [self.refreshControl3 addTarget:nil action:@selector(updateArray:) forControlEvents:UIControlEventValueChanged];
    //    [self.tv3 addSubview:self.refreshControl3];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = Screenwidth;
    
    [self.scrollView setContentOffset:offset];
    //[self.tv setContentOffset:CGPointMake(0, 45) animated:YES];
    
    
    //=====TimeCounter============//
#warning fixed time just for test it needs to replaced with actual date
    
    if (self.match.info.statusId!=0&&self.match.info.statusId!=6) {
    if([self.match.info matchStartTime]!=NULL||[self.match.info.fClubScorePen intValue]!=-1){
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"MMMMM dd yyyy hh:mma"];
        NSDate *dateFromString = [dateFormatter dateFromString:[self.match.info matchStartTime]];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        self.componentMint = [calendar components:NSCalendarUnitMinute fromDate:dateFromString toDate:[NSDate date] options:NSCalendarMatchStrictly];
        self.componentSec =  [calendar components:NSCalendarUnitSecond fromDate:dateFromString toDate:[NSDate date] options:NSCalendarMatchStrictly];
      
        [NSTimer scheduledTimerWithTimeInterval:1.0 target: self
                                       selector: @selector(updateTheCounter) userInfo:nil repeats: YES];
    }
        
        
    }
    
    else{
        
        self.matchDateLabel.text=self.match.info.time;
    }

    
    // Do any additional setup after loading the view from its nib.
}
-(void) updateArray :(UIRefreshControl *)sender {
    
    [self LoadMatches];
    
    
}

-(void)initUiViews:(BOOL)first{
    [self.ind startAnimating];
    [self.ind setHidden:NO];
    self.match.info.fClubLogo= [self.match.info.fClubLogo stringByReplacingOccurrencesOfString:@"black" withString:@"White"];
    
    [self.fClubImageView sd_setImageWithURL:[NSURL URLWithString:self.match.info.fClubLogo ] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   [self.ind stopAnimating];
                                   [self.ind setHidden:YES];
                                   
                               }];
    
    
    
    [self.ind1 startAnimating];
    [self.ind1 setHidden:NO];
    self.match.info.sClubLogo= [self.match.info.sClubLogo stringByReplacingOccurrencesOfString:@"black" withString:@"White"];
    [self.sClubImageView sd_setImageWithURL:[NSURL URLWithString:self.match.info.sClubLogo] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   [self.ind1 stopAnimating];
                                   [self.ind1 setHidden:YES];
                                   
                               }];
    
    
  
    
    
    
    _fClubImageView.layer.cornerRadius = _fClubImageView.frame.size.height /2;
    _fClubImageView.layer.masksToBounds = YES;
    _fClubImageView.layer.borderWidth = 0;
    
    _sClubImageView.layer.cornerRadius = _sClubImageView.frame.size.height /2;
    _sClubImageView.layer.masksToBounds = YES;
    _sClubImageView.layer.borderWidth = 0;
    [self.fClubTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.fClubTitleLabel.font.pointSize]];
    [self.sClubTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.sClubTitleLabel.font.pointSize]];
    [self.fClubScoreLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.fClubScoreLabel.font.pointSize]];
    [self.sClubScoreLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.sClubScoreLabel.font.pointSize]];
    [self.matchStatusLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.matchStatusLabel.font.pointSize]];
    [self.matchDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.matchDateLabel.font.pointSize]];
    [self.fClubPensLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.matchDateLabel.font.pointSize]];
    [self.sClubPensLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.matchDateLabel.font.pointSize]];
    [self.fclubTrainerLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.fclubTrainerLabel.font.pointSize]];
    [self.sclubTrainerLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.fclubTrainerLabel.font.pointSize]];
    
    [self.matchPlaceLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.fclubTrainerLabel.font.pointSize]];
    [self.matchfullDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.fclubTrainerLabel.font.pointSize]];
    [self.matchViewInLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.fclubTrainerLabel.font.pointSize]];
    
    
    self.matchPlaceLabel.text=self.match.info.place;
    self.matchfullDateLabel.text=self.match.info.date;
    NSString *channels=self.match.info.channels;
    if ([channels isEqualToString:@""]) {
        channels=@"غير متوفر حاليا";
    }
    self.matchViewInLabel.text=channels;
    
    self.fClubTitleLabel.text=self.match.info.fClubName;
    self.sClubTitleLabel.text=self.match.info.sClubName;
    NSString *html=[NSString stringWithFormat:@"<html><head><style>body { background-color: trasparent; text-align:right; font-size:17px; color:Black; margin:0; font-family:\"%@\" } </style><meta charset=\"utf-8\"></head><body><div style=\"direction:rtl; background:#FFFDF6; \">%@</div></body></html>",@"DINNextLTW23Regular",self.match.matchLiveComment==nil?@"لا يوجد دقيقة بدقيقة":self.match.matchLiveComment];
    [self.minByMinWebView loadHTMLString:html baseURL:nil];
    self.minByMinWebView.frame= CGRectMake(10, 0, 300,self.tv3.frame.size.height-5);
    self.minByMinWebView.delegate=self;
    if ([self.match.info.fClubScoreResult intValue] ==-1) {
        
        self.fClubScoreLabel.text=[self.match.info.fClubScoreLive  intValue]==-1?@"-":[NSString stringWithFormat:@"%i",[self.match.info.fClubScoreLive intValue]];
        self.sClubScoreLabel.text=[self.match.info.sClubScoreLive intValue]==-1?@"-":[NSString stringWithFormat:@"%i",[self.match.info.sClubScoreLive intValue]];
    }else{
        self.fClubScoreLabel.text=[self.match.info.fClubScoreResult  intValue]==-1?@"-":[NSString stringWithFormat:@"%i",[self.match.info.fClubScoreResult intValue]];
        self.sClubScoreLabel.text=[self.match.info.sClubScoreResult intValue]==-1?@"-":[NSString stringWithFormat:@"%i",[self.match.info.sClubScoreResult intValue]];
    }
    self.matchStatusLabel.text=self.match.info.matchStatus;
    if (self.match.info.matchStartTime==NULL) {
    self.matchDateLabel.text=self.match.info.time;
    }
    self.fclubTrainerLabel.text=self.match.info.fACoachName;
    self.sclubTrainerLabel.text=self.match.info.sACoachName;
    
    
    
    
    if (self.match.info.statusId==0) {
        self.matchStatusImageView.image=[UIImage imageNamed:@"not_yet_btn.png"];
        [ self.matchStatusLabel setHidden:YES];
        [self selectTap1:nil];
    }
    else if (self.match.info.statusId==6) {
        self.matchStatusImageView.image=[UIImage imageNamed:@"done_btn.png"];
        if([self.match.info.fClubScorePen intValue]!=-1){
            [ self.matchStatusLabel setText:@"ركلات الترجيح"];
        }
        else{
            [ self.matchStatusLabel setHidden:YES];
        }
        
        self.fClubPensLabel.text=[self.match.info.fClubScorePen intValue]==-1?@"":[NSString stringWithFormat:@"(%i)",[self.match.info.fClubScorePen intValue]];
        self.sClubPensLabel.text=[self.match.info.sClubScorePen intValue]==-1?@"":[NSString stringWithFormat:@"(%i)",[self.match.info.sClubScorePen intValue]];
        
        [self selectTap2:nil];
        
    }
    else if (self.match.info.statusId==7) {
        self. matchStatusImageView.image=[UIImage imageNamed:@"now_btn.png"];
        self.fClubPensLabel.text=[self.match.info.fClubScorePen intValue]==-1?@"":[NSString stringWithFormat:@"%i",[self.match.info.fClubScorePen intValue]];
        self.sClubPensLabel.text=[self.match.info.sClubScorePen intValue]==-1?@"":[NSString stringWithFormat:@"(%i)",[self.match.info.sClubScorePen intValue]];
        if (self.match.matchLiveComment!=nil&&![self.match.matchLiveComment isEqualToString:@""]) {
            [self selectTap3:nil];
        }
        else{
            [self selectTap2:nil];
        }
        
    }
    else{
        self. matchStatusImageView.image=[UIImage imageNamed:@"now_btn.png"];
        if (self.match.matchLiveComment!=nil&&![self.match.matchLiveComment isEqualToString:@""]) {
            [self selectTap3:nil];
        }
        else{
            [self selectTap2:nil];
        }
        
    }
    if (self.match.info.statusId !=6 && self.match.info.statusId !=0&& [self.match.info.fClubScoreResult intValue] == -1) {
        if (!self.myTimer) {
            
            self.myTimer = [NSTimer scheduledTimerWithTimeInterval: 60.0 target: self
                                                          selector: @selector(callAfterSixtySecond) userInfo: nil repeats: YES];
        }
    }
    else{
        if (self.myTimer) {
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
        
        
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentSize=CGSizeMake(Screenwidth * 3, self.scrollView.frame.size.height);
    
    
    
    
    
    
    //----------- setting for tabs
    //    [self.tab2 setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    //    [self.tab1 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    //    [self.tab3 setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0]];
    [self.tab2.titleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.tab2.titleLabel .font.pointSize]];
    [self.tab3.titleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.tab3.titleLabel .font.pointSize]];
    [self.tab1.titleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.tab1.titleLabel .font.pointSize]];
    //----------------
    if (!first) {
        
        [self.tv reloadData];
        [self.tv2 reloadData];
        [self.tv3 reloadData];
    }
}

-(void)callAfterSixtySecond{
    [self LoadMatches];
}
-(void)LoadMatches{
    if(self.canLoadMore==YES){
        //(int)self.match.info.iDProperty
        NSDictionary *dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",self.match.info.iDProperty],@1, nil] forKeys:[NSArray arrayWithObjects:@"id",@"apiversion", nil] ];
        
        self.canLoadMore=NO;
        [WServicesManager getMatchDetails:dictionary success:^(MatchDetails *matche)  {
            [self.refreshControl endRefreshing];
            [self.refreshControl2 endRefreshing];
            [self.refreshControl3 endRefreshing];
            if (matche.info.champName==nil&&(self.match.info.champName==nil||[self.match.info.champName isEqualToString:@""])) {
                
                UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"لا يوجد محتوي لهذه المباراة" message:nil delegate:self cancelButtonTitle:@"موافق" otherButtonTitles:nil];
                [message show];
                // [self.navigationController popViewControllerAnimated:YES];
                
                
            }
            else{
                self.match=matche;
                [self initUiViews:NO];
                self.canLoadMore=YES;
                
                //hide Loading View
                [self.indLoader stopAnimating];
                [self.indLoader setHidden:YES];
                [self.tv setHidden:NO];
                [self.loadingLabel setHidden:YES];
            }
            
        } failure:^(NSError *error) {
            self.canLoadMore=YES;
            [self.indLoader stopAnimating];
            [self.indLoader setHidden:YES];
            //self.loadingLabel.text=@"لم يتم العثور علي مباريات";
        }];
        
    }
}
#pragma mark tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag==1) {
        if (section==2){
            
            return 0;
        }
        else if (section==1){
            if(self.match.teamAlineUps.count==0&&self.match.teamASubs.count==0)
                return 0;
            return 30;
        }
        else if (section==0){
            if(self.match.teamAlineUps.count==0)
                return 50;
            return 30;
        }
    }
    
    else if (tableView.tag==2) {
        if (section==1){
            return 0;
        }
        else{
            if(self.match.matchActions.count==0)
                return 50;
            return 30;
        }
    }
    else if (tableView.tag==3) {
        if (section==1){
            return 0;
        }
        else{
            return 0;
        }
    }
    return 0;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==1) {
        return  3;
    }
    else if (tableView.tag==2) {
        return  2;
    }
    else if (tableView.tag==3) {
        return  1;
    }
    return 0;
}
- (void)preventBannerCaptureTouch:(GADBannerView*)bannerView
{
    for (UIWebView *webView in bannerView.subviews) {
        if ([webView isKindOfClass:[UIWebView class]]) {
            
            for (UIGestureRecognizer *gestureRecognizer in webView.gestureRecognizers) {
                if ([gestureRecognizer isKindOfClass:NSClassFromString(@"GADImpressionTicketGestureRecognizer")]) {
                    gestureRecognizer.delegate = self;
                }
            }
            
            for (id view in [[[webView subviews] firstObject] subviews]) {
                if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")]) {
                    for (UIGestureRecognizer *recognizer in [view gestureRecognizers]) {
                        if ([recognizer isKindOfClass:NSClassFromString(@"UIWebTouchEventsGestureRecognizer")]) {
                            [view removeGestureRecognizer:recognizer];
                        }
                    }
                    return;
                }
            }
        }
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(8, 0, Screenwidth-15, 25)];
    [title setBackgroundColor:[UIColor clearColor]];
    if (tableView.tag==1) {
        UIImageView *img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matche_event_title"]];
        [img setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
        [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:10]];
        [title setTextColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0  blue:19.0/255.0  alpha:1.0]];
        
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
        if (section==2){
//            [headerView setBackgroundColor:[UIColor clearColor]];
//            GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(320-20, 250));
//            if (self.bannerView1==nil) {
//                
//                
//                self.bannerView1 = [[DFPBannerView alloc] initWithAdSize:customAdSize origin:CGPointMake((Screenwidth-300)/2, 5)];
//                
//                // Specify the ad's "unit identifier." This is your DFP ad unit ID.
//                self.bannerView1.adUnitID = @"/7524/New-FilGoal/Mobile-Application";
//                
//                // Let the runtime know which UIViewController to restore after taking
//                // the user wherever the ad goes and add it to the view hierarchy.
//                self.bannerView1.rootViewController = self;
//                // Initiate a generic request to load it with an ad.
//                [self.bannerView1 loadRequest:[GADRequest request]];
//            }
//            [headerView addSubview:self.bannerView1];
            
        }
        else if (section==0) {
            
            title.text=@"التشكيل الأساسي";
            if(self.match.teamAlineUps.count==0){
                title.text=@"لا يوجد تشكيل";
                title.textAlignment=NSTextAlignmentCenter;
                [title setFrame:CGRectMake(0, 5, Screenwidth, 20)];
                [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:15]];
            }else{
                [headerView addSubview:img];}
            [headerView addSubview:title];
        }
        else if (section==1) {
            title.text=@"البدلاء";
            if(self.match.teamASubs.count==0){
                title.text=@"لا يوجد بدلاء";
                title.textAlignment=NSTextAlignmentCenter;
                [title setFrame:CGRectMake(0, 5, Screenwidth, 20)];
                [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:15]];
            }
            else{
                [headerView addSubview:img];
            }
            [headerView addSubview:title];
        }
        
        
        
    }
    else if (tableView.tag==2) {
        
        [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:title.font.pointSize]];
        [title setTextColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0  blue:19.0/255.0  alpha:1.0]];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
        
        
        
        UIImageView *img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matche_event_title"]];
        [img setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
        [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:10]];
        
        if (section==1){
            [headerView setBackgroundColor:[UIColor clearColor]];
            GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(320-20, 250));
            if (self.bannerView2==nil) {
                
                
                self.bannerView2 = [[DFPBannerView alloc] initWithAdSize:customAdSize origin:CGPointMake((Screenwidth-300)/2, 5)];
                
                // Specify the ad's "unit identifier." This is your DFP ad unit ID.
                self.bannerView2.adUnitID = @"/7524/New-FilGoal/Mobile-Application";
                
                // Let the runtime know which UIViewController to restore after taking
                // the user wherever the ad goes and add it to the view hierarchy.
                self.bannerView2.rootViewController = self;
                // Initiate a generic request to load it with an ad.
                [self.bannerView2 loadRequest:[GADRequest request]];
            }
            [headerView addSubview:self.bannerView2];
            
        }
        else{
            title.text=@"احداث المباراة";
            if(self.match.matchActions.count==0){
                title.text=@"لا يوجد احداث للمباراة";
                title.textAlignment=NSTextAlignmentCenter;
                [title setFrame:CGRectMake(0, 5, Screenwidth, 20)];
                [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:15]];
            }
            else{
                [headerView addSubview:img];
            }
            [headerView addSubview:title];
        }
    }
    else if (tableView.tag==3) {
        if (section==1){
            [headerView setBackgroundColor:[UIColor clearColor]];
            GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(320-20, 250));
            if (self.bannerView3==nil) {
                
                
                self.bannerView3 = [[DFPBannerView alloc] initWithAdSize:customAdSize origin:CGPointMake((Screenwidth-300)/2, 5)];
                
                // Specify the ad's "unit identifier." This is your DFP ad unit ID.
                self.bannerView3.adUnitID = @"/7524/New-FilGoal/Mobile-Application";
                
                // Let the runtime know which UIViewController to restore after taking
                // the user wherever the ad goes and add it to the view hierarchy.
                self.bannerView3.rootViewController = self;
                // Initiate a generic request to load it with an ad.
                [self.bannerView3 loadRequest:[GADRequest request]];
            }
            [headerView addSubview:self.bannerView2];
            
        }
        else{
            return nil;
        }
        
    }
  //  [self preventBannerCaptureTouch:self.bannerView1];
  //  [self preventBannerCaptureTouch:self.bannerView2];
   // [self preventBannerCaptureTouch:self.bannerView3];
    
    
    
    
    
    return headerView;
    
    
}

- (void)adViewDidReceiveAd:(DFPBannerView *)adView {
}

/// Tells the delegate an ad request failed.
- (void)adView:(DFPBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag==1) {
        if (section==0) {
            return [self.match.teamAlineUps count];
        }
        else if(section==1){
            return [self.match.teamASubs count];
        }
        else{
            return 0;
        }
    }
    else if (tableView.tag==2) {
        if (section==0) {
            return [self.match.matchActions count];
        }
        else{
            return 0;
        }
    }
    else if (tableView.tag==3) {
        if (section==0) {
            return 1;
            
        }
        else{
            return 0;
        }
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    
//    
//    if (tableView.tag==1) {
//        if (indexPath.section==0) {
//            TeamAlineUps *item1=[self.match.teamAlineUps objectAtIndex:indexPath.row];
//            TeamAlineUps *item2=nil;
//            if (indexPath.row<self.match.teamBlineUps.count) {
//                item2=[self.match.teamBlineUps objectAtIndex:indexPath.row];
//            }
//            
//            
//            return   [LineUpCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withline1:item1 withline2:item2];
//        }
//        else if (indexPath.section==1) {
//            TeamAlineUps *item1=[self.match.teamASubs objectAtIndex:indexPath.row];
//            TeamAlineUps *item2=nil;
//            if (indexPath.row<self.match.teamBSubs.count) {
//                item2=[self.match.teamBSubs objectAtIndex:indexPath.row];
//            }
//            
//            
//            return   [LineUpCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withline1:item1 withline2:item2];
//        }
//        
//    }
//    else if (tableView.tag==2) {
//        long index=self.match.matchActions.count-1-indexPath.row;
//        MatchActions *item=[self.match.matchActions objectAtIndex:index];
//        return   [MatchActionCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchAction:item clubone:self.match.info.club1Id clubtwo:self.match.info.club2Id];
//    }
//    else if (tableView.tag==3) {
//        
//        static NSString *CellIdentifier = @"Cell";
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, Screenwidth,self.tv3.frame.size.height+30)];
//        }
//        self.minByMinWebView.frame=CGRectMake(0, 0, Screenwidth-10, self.tv3.frame.size.height);
//        [cell.contentView addSubview:self.minByMinWebView];
//        return cell;
//        
//        
//    }
//    
//    
//    return nil;
    
     return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // [self.navigationController pushViewController:  animated:YES];
    
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        return 60;
        
    }
    else if (tableView.tag==2) {
        long index=self.match.matchActions.count-1-indexPath.row;

        MatchActions *item=[self.match.matchActions objectAtIndex:index];
        return   [self getHeightForMatchRow:item];
    }
    else if (tableView.tag==3) {
        return self.tv3.frame.size.height;
    }
    return 0;
}
-(int)getHeightForMatchRow:(MatchActions*)item{
    NSArray *sctions= item.actions;
    int leftHeight=30;
    int rigthHeight=30;
    for(Actions *action in sctions){
        if (action.clubid==self.match.info.club1Id) {
            leftHeight+=22;
        }
        else if (action.clubid== self.match.info.club2Id) {
            rigthHeight+=22;
        }
    }
    return leftHeight>rigthHeight?leftHeight:rigthHeight;
    
}
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if (webView.tag!=123456) {
        
        if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
            NSString *urlToOpen = [NSString stringWithFormat:@"%@",request.URL];
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlToOpen]];
          //  GlobalViewController* webView=[[GlobalViewController alloc]initWithUrl:urlToOpen];
            //[self.navigationController pushViewController:webView animated:YES];
            SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress:urlToOpen];
            [self.navigationController pushViewController:webViewController animated:YES];
            return NO;
        }
        else{
            
            return YES;
        }
    }
    else
        return NO ;
}
-(IBAction)refresh:(id)sender{
    [self LoadMatches];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//=====Counter Methods ========//
- (void)updateTheCounter{
    
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
    
    self.counterTime= [NSString stringWithFormat:@"%d : %d",self.componentMint.minute,self.componentSec.second];
   dispatch_async(dispatch_get_main_queue(), ^{
    self.matchDateLabel.text=self.counterTime;
       });
    return  self.counterTime;
}

- (IBAction)goToHome:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MainViewController  *home;
    home= (MainViewController *)appDelegate.mainViewController;
    [home loadWithType:0 andSection:0];
    [self.navigationController popViewControllerAnimated:NO];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

@end
