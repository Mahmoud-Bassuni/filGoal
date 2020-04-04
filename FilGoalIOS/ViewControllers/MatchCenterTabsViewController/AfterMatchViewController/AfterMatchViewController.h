//
//  AfterMatchViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"


@interface AfterMatchViewController : ParentViewController<XLPagerTabStripChildItem,UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;
@property (nonatomic, strong) NSMutableArray * photos;
@property(nonatomic,assign) int index;
@property (nonatomic,strong) NSArray * matchEvents;
@property (nonatomic,strong) NSArray * matchEventsList;
@property (nonatomic,strong) NSArray * newsList;
@property (nonatomic,strong) NSArray * videosList;
@property (nonatomic,strong) NSArray * albumsList;
@property (strong,nonatomic) NSMutableArray * matchStatusHistory;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSString * homeTeamName;
@property(nonatomic,strong) NSString * awayTeamName;
@property(nonatomic,strong) NSString * awayTeamLogoUrl;
@property(nonatomic,strong) NSString * homeTeamLogoUrl;
@property(nonatomic,strong) NSString * champName;
@property (strong,nonatomic) NSArray * matchStatistics;
@property(nonatomic,strong) MatchCenterDetails * matchItem; // we will get match item object from old APIs version 1.6
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;
@property (nonatomic,strong) MatchEventsWithStatusHistory * matchEventsWithStatusHistory;
@property(nonatomic,retain) UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (nonatomic,strong) NSMutableArray * matchEventsGroupedByStatuesList;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
