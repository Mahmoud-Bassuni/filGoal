//
//  SearchViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/14/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "ParentViewController.h"

@interface SearchViewController : ParentViewController<UITableViewDelegate,UIScrollViewDelegate,UIPageViewControllerDataSource,UIWebViewDelegate>
@property(nonatomic,retain)NSString*keyword;
@property(nonatomic,strong) IBOutlet UITableView *tv;
@property(nonatomic,retain) NSMutableArray * NewsList;
@property(nonatomic,assign) BOOL canLoadMore;
@property(nonatomic,assign) BOOL isFromSpotLightSearch;
@property(nonatomic,assign) BOOL isFromForceTouch;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *indLoader;
@property(nonatomic,retain)IBOutlet UILabel *loadingLabel;
@property(strong,nonatomic)UIPageViewController *pageController;
@property(nonatomic,assign) int currentNewsIndex;
@property(nonatomic,retain) IBOutlet UIImageView *sponser;
- (id)initWithKeyWord:(NSString*)keyword andTypeId:(int)type;
@property (weak, nonatomic) IBOutlet UILabel *keywordLbl;
-(IBAction)backBtnTaped:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;
@end
