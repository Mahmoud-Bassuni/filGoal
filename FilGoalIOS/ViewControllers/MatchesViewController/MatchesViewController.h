//
//  HomeViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//
#import "TappableSponsorImageView.h"


@class HomeViewController;
@interface MatchesViewController : UIViewController<UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UIWebViewDelegate,UIViewControllerPreviewingDelegate,XLPagerTabStripChildItem>{
    int whichTableIsViewed;


}
@property (strong,nonatomic) NSDictionary * matchesDic;
@property (strong,nonatomic) NSArray * matches;
@property (assign,nonatomic) int sectionId;
@property (weak, nonatomic) IBOutlet UIView *tabsView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *noMatchesLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicator;
@property(nonatomic,strong) NSArray * sectionChampions;

@end
