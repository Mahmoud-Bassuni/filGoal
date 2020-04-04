//
//  MatchFormulationTabViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/7/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchCenterDetails.h"
#import "JDFTooltips.h"

@interface MatchFormulationTabViewController : ParentViewController <XLPagerTabStripChildItem,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,GADBannerViewDelegate>
@property (nonatomic, strong) JDFSequentialTooltipManager *tooltipManager;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray * matchTeamsSquads;
@property (nonatomic,strong) NSArray * matchEvents;
@property (nonatomic,strong) MatchCenterDetails* matchDetails;
@property(nonatomic,strong) NSMutableArray * homeTeamSquad;
@property(nonatomic,strong) NSMutableArray * awayTeamSquad;
@property(nonatomic,strong) NSMutableArray * homeSpareTeamSquad;
@property(nonatomic,strong) NSMutableArray * awaySpareTeamSquad;
@property (strong, nonatomic) IBOutlet UIView *formulationHeaderView;
@property (strong, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (strong, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;

@property (strong, nonatomic) IBOutlet UILabel *awayTeamFormlutionTypeLbl;
@property (strong, nonatomic) IBOutlet UILabel *homeTeamFormlutionTypeLbl;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;

@end
