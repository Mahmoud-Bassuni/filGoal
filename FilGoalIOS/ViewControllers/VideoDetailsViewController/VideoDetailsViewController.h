//
//  NewsDetailsViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/14/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoItem.h"
#import "GAITrackedViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>//#import "DFPBannerView.h"
#import <GoogleMobileAds/GoogleMobileAds.h>//#import "DFPBannerView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NewsVideoWebViewController.h"
#import "ParentViewController.h"
#import "TappableSponsorImageView.h"

@interface VideoDetailsViewController : ParentViewController<UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIGestureRecognizerDelegate,WKNavigationDelegate>
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property  NSUInteger pageIndex;
@property(nonatomic,strong) UIView  *adsview;
@property (weak, nonatomic) IBOutlet UIView *TopimageView;
@property (weak, nonatomic) IBOutlet UIView *dateContainerView;
@property(nonatomic,strong)  WKWebView * webView;
@property (strong, nonatomic) LGPlusButtonsView * plusButtonsViewNavBar;

@property(nonatomic,strong) DFPBannerView  *bannerView;
@property(nonatomic,strong) IBOutlet TappableSponsorImageView *sponser;
@property(nonatomic,strong) IBOutlet UITableView * tableView;
@property(nonatomic,strong) NSMutableArray * orginalNewsList;
@property(nonatomic,strong) NSMutableArray * relatedNewsList;
@property(nonatomic,strong) NSMutableArray * relatedVideosList;
@property(nonatomic,assign) int currentRelatedList;
@property(nonatomic,strong) VideoItem *VideoItem;
@property(nonatomic,assign) BOOL canLoadMore;
@property(nonatomic,assign) int fontSize;
@property(nonatomic,assign) int currentNewsIndex;
@property(nonatomic,strong)IBOutlet UILabel *loadingLabel;
@property(nonatomic,strong)IBOutlet UILabel *newsTitleLabel ;
@property(nonatomic,strong)IBOutlet UILabel *newsDateLabel ;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *previewImageActivityIndicator;
@property(nonatomic,strong)IBOutlet UILabel *newsWriterLabel;
@property(nonatomic,strong)IBOutlet UIWebView *newsDetailsWebView;
@property(nonatomic,strong)IBOutlet UIScrollView *scrollContent;
@property(nonatomic,strong)IBOutlet UIView *contentView;
@property(nonatomic,assign) BOOL isFromPushNotification;
@property(nonatomic,assign) BOOL isFrom3DTouch;

@property(nonatomic,strong) IBOutlet UIImageView *videoImageView;
@property(nonatomic,assign) int relatedNewscurrentIndex;
@property(nonatomic,assign) int relatedVideosCurrentIndex;
@property(strong,nonatomic) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet UIButton *commentsBtn;
@property (nonatomic) MPMoviePlayerViewController *mpvc;
@property (strong, nonatomic) WKWebView * postquareWebView;
@property(nonatomic,strong) NSString * postQuareUrlStr;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UILabel *nOfViewsLbl;

- (id)initWithVideo:(VideoItem*)videoItem;
- (id)initWithVideoIndex:(int)index  withVideosList:(NSMutableArray *)videosList;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *webViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@end
