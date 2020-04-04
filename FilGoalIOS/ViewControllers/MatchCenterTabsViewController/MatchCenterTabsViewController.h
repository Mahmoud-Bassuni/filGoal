//
//  MatchCenterTabsViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLButtonBarPagerTabStripViewController.h"
#import "MatchEventsWithStatusHistory.h"
#import "TeamProfileViewController.h"
#import <EventKit/EventKit.h>
#import "EventsList.h"
#import <LGPlusButtonsView/LGPlusButton.h>
#import "TappableSponsorImageView.h"


@interface MatchCenterTabsViewController : ParentViewController //UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogoImgView;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLbl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *homeTeamActivityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamPlentyLbl;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogoImgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *awayTeamActivityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamPlentyLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchStatusLbl;
@property (weak, nonatomic) IBOutlet UILabel *counterLbl;
@property (weak, nonatomic) IBOutlet UILabel *championNameWithRoundNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *staduimLbl;
@property (weak, nonatomic) IBOutlet UILabel *refereeNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *channelsNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchDateLbl;
@property (weak, nonatomic) IBOutlet UIView *tabsView;
@property(nonatomic,strong) NSString * champName;
@property (nonatomic,strong) MatchCenterDetails * matchCenterDetails;
@property (weak, nonatomic) IBOutlet UILabel *homeCoachNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayCoachNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *indicatorStatusLbl;
@property (nonatomic,strong) NSMutableArray * matchStatusHistoryList;
@property (nonatomic,strong) NSArray * matchTeamsSquads;
@property (nonatomic,strong) NSMutableArray * matchEvents;
@property (nonatomic,weak) NSArray * afterMatchEvents;
@property(nonatomic,assign) int sectionId;
@property (strong,nonatomic) NSArray * matchStatistics;
@property (nonatomic,strong) MatchEventsWithStatusHistory * matchEventsWithStatusHistory;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *commenterNameLbl;
@property (strong, nonatomic) IBOutlet UIView *matchStadiumView;
@property (strong, nonatomic) IBOutlet UIView *refereeView;
@property (strong, nonatomic) IBOutlet UIView *commenterView;
@property (strong, nonatomic) IBOutlet UIView *channelsView;
@property (weak, nonatomic) IBOutlet UIButton *addToCalendarButton;
@property (strong, nonatomic) LGPlusButtonsView * plusButtonsViewNavBar;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *infoHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UIButton *statisticsBtn;
@property (weak, nonatomic) IBOutlet UIImageView *matchCenterBgImg; //TappableSponsorImageView

- (IBAction)addToCalendarPressed:(UIButton *)sender;
- (IBAction)infoBtnAction:(id)sender;
- (IBAction)statisticalBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *channelsViewHeightConstraint;

//=========For time Counter=======//
@property (nonatomic,strong)NSTimer * timer;
@property (strong, nonatomic) NSDateComponents *componentMint;
@property (strong, nonatomic) NSDateComponents *componentSec;
@property (strong, nonatomic) NSString *counterTime;
@property (strong, nonatomic) IBOutlet TappableSponsorImageView *sponsorImg;

//Predictions Actions
- (IBAction)predictBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *predictBtn;


@end
