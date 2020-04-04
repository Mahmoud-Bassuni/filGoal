//
//  VideosViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WServicesManager.h"
#import "GAITrackedViewController.h"
#import "ParentViewController.h"
#import "XLPagerTabStripViewController.h"
#import "StoryCell.h"
#import "VideosList.h"
#import "TappableSponsorImageView.h"

@interface VideosViewController : ParentViewController<UISearchBarDelegate,UITableViewDelegate,UIScrollViewDelegate,UIPageViewControllerDataSource,UIWebViewDelegate,UIViewControllerPreviewingDelegate,XLPagerTabStripChildItem,GADBannerViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) IBOutlet TappableSponsorImageView *sponser;
@property(nonatomic,strong) IBOutlet UITableView * tableView;
@property(nonatomic,retain) NSMutableArray * videosList;
@property(nonatomic,assign) BOOL canLoadMore;
@property(nonatomic,retain) IBOutlet UISearchBar *searchBar;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *indLoader;
@property(nonatomic,retain)IBOutlet UILabel *loadingLabel;
@property(nonatomic,assign) int currentVideoIndex;
@property(strong,nonatomic)UIPageViewController *pageController;
@property(nonatomic,retain) UIRefreshControl *refreshControl;
@property(nonatomic,assign) int sectionId;
@property(nonatomic,assign) int index;
@property (assign,nonatomic)  int  playerId;
@property (assign,nonatomic) int champId;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (strong, nonatomic) NSString * teamName;
@property (strong, nonatomic) NSString * champName;
@property (strong, nonatomic) NSString * sectionName;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (assign, nonatomic) int teamId;

- (id)initWithSectionId:(int)sectionId;
@end
