//
//  VideosViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WServicesManager.h"
#import "VideosCellLoader.h"
#import "GAITrackedViewController.h"
#import "ParentViewController.h"

@interface VideoSearchViewController : ParentViewController<UITableViewDelegate,UIScrollViewDelegate,UIPageViewControllerDataSource,UIWebViewDelegate>

@property(nonatomic,strong) IBOutlet UITableView *tv;
@property(nonatomic,retain) NSString *keyword;
@property(nonatomic,retain) NSMutableArray * VideosList;
@property(nonatomic,assign) BOOL canLoadMore;
@property(nonatomic,retain) IBOutlet UIImageView *sponser;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *indLoader;
@property(nonatomic,retain)IBOutlet UILabel *loadingLabel;
@property(nonatomic,assign) int currentVideoIndex;
@property(strong,nonatomic)UIPageViewController *pageController;
- (id)initWithKeyWord:(NSString*)keyword;
@property (weak, nonatomic) IBOutlet UILabel *keywordLbl;

@end
