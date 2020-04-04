//
//  MatchCommentsViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/14/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchCommentsViewController : ParentViewController<XLPagerTabStripChildItem,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,GADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray * matchComments;
@property (strong,nonatomic)NSMutableArray * matchCommentsSignalR;

@property (strong,nonatomic)NSArray * matchEvents;
@property (strong,nonatomic) MatchCenterDetails * matchItem;
@property (nonatomic,strong) NSMutableArray * matchStatusHistoryList;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;

@end
