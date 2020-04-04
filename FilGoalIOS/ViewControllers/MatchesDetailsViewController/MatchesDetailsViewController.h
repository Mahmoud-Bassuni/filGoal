//
//  HomeViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WServicesManager.h"
#import "MatchDetails.h"
#import <GoogleMobileAds/GoogleMobileAds.h>//#import "DFPBannerView.h"
#import <GoogleMobileAds/GoogleMobileAds.h>//#import "DFPBannerView.h"

#import "ParentViewController.h"




@interface MatchesDetailsViewController : ParentViewController<UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate>

@property(nonatomic,retain) DFPBannerView  *bannerView1;
@property(nonatomic,retain) DFPBannerView  *bannerView2;
@property(nonatomic,retain) DFPBannerView  *bannerView3;

@property(nonatomic,strong) IBOutlet UITableView *tv;
@property(nonatomic,strong) IBOutlet UITableView *tv2;
@property(nonatomic,strong) IBOutlet UITableView *tv3;

@property(nonatomic,retain) IBOutlet UIButton *tab1;
@property(nonatomic,retain) IBOutlet UIButton *tab2;
@property(nonatomic,retain) IBOutlet UIButton *tab3;

@property(nonatomic,retain) IBOutlet UIImageView *background;
@property(nonatomic,retain) NSString *from;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) UIRefreshControl *refreshControl;
@property(nonatomic,retain) UIRefreshControl *refreshControl2;
@property(nonatomic,retain) UIRefreshControl *refreshControl3;
@property(nonatomic,retain) IBOutlet UIImageView *sponser;
@property(nonatomic,retain) NSMutableArray * chamsList;
@property(nonatomic,assign) BOOL isFromMatchWidget;
@property (nonatomic,assign) BOOL isFrom3DTouch;

@property(nonatomic,retain) IBOutlet UIView  *tabsView;
@property(nonatomic,retain) NSTimer  *myTimer;

@property(nonatomic,retain) MatchDetails *match;
@property(nonatomic,assign) BOOL canLoadMore;

@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *indLoader;
@property(nonatomic,retain)IBOutlet UILabel *loadingLabel;
@property(nonatomic,assign) int currentNewsIndex;

@property(nonatomic,assign) BOOL isFromPushNotification;

@property(nonatomic,retain) IBOutlet UIImageView *fClubImageView ;
@property(nonatomic,retain)IBOutlet UIImageView *sClubImageView ;
@property(nonatomic,retain)IBOutlet UIImageView *matchStatusImageView;
@property(nonatomic,retain) IBOutlet UILabel *fClubTitleLabel ;
@property(nonatomic,retain) IBOutlet UILabel *sClubTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel *fClubScoreLabel ;
@property(nonatomic,retain) IBOutlet UILabel *sClubScoreLabel ;
@property(nonatomic,retain) IBOutlet UILabel *fClubPensLabel;
@property(nonatomic,retain) IBOutlet UILabel *sClubPensLabel;
@property(nonatomic,retain) IBOutlet UILabel *matchStatusLabel ;
@property(nonatomic,retain) IBOutlet UILabel *matchDateLabel ;
@property(nonatomic,retain) IBOutlet UILabel *fclubTrainerLabel ;
@property(nonatomic,retain) IBOutlet UILabel *sclubTrainerLabel ;
@property(nonatomic,retain) IBOutlet UILabel *matchPlaceLabel ;
@property(nonatomic,retain) IBOutlet UILabel *matchfullDateLabel ;
@property(nonatomic,retain) IBOutlet UILabel *matchViewInLabel ;
@property(nonatomic,retain) IBOutlet  UIActivityIndicatorView *ind;
@property(nonatomic,retain) IBOutlet  UIActivityIndicatorView *ind1;
@property(nonatomic,retain) IBOutlet UIWebView *minByMinWebView;


//=========For time Counter=======//
@property(nonatomic,retain) IBOutlet UILabel *timeCounterLabel ;
@property (strong, nonatomic) NSDateComponents *componentMint;
@property (strong, nonatomic) NSDateComponents *componentSec;
@property (strong, nonatomic) NSString *counterTime;






- (id)initWithWidgetMatch:(NSString*)from andWidgetMatch:(WidgetMatchModel *)widgetMatch;
- (id)initWithfrom:(NSString*)from matches:(MatchDetails*)partmatches;
-(IBAction)selectTap1:(id)sender;
-(IBAction)selectTap2:(id)sender;
-(IBAction)selectTap3:(id)sender;
@end
