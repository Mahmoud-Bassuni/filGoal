//
//  MatchOverviewViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"


@interface MatchOverviewViewController : ParentViewController<XLPagerTabStripChildItem,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign) int index;
@property(nonatomic,strong) MatchCenterDetails * matchItem;
@property(nonatomic,retain) UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;

@property (strong,nonatomic) NSArray * matchStatistics;
@end
