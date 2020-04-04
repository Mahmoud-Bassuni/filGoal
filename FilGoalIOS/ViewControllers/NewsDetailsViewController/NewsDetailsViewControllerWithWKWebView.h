//
//  NewsDetailsViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/14/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"
#import "GAITrackedViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>//#import "DFPBannerView.h"
#import <GoogleMobileAds/GoogleMobileAds.h>//#import "DFPBannerView.h"
#import <TeadsSDK/TeadsSDK.h>
#import "ParentViewController.h"
#import <WebKit/WebKit.h>
#import "CMPopTipView.h"
#import <MXParallaxHeader/MXParallaxHeader.h>
#import <MXParallaxHeader/MXScrollView.h>
#import "AuthorProfileViewController.h"
#import "TappableSponsorImageView.h"


@interface NewsDetailsViewControllerWithWKWebView : ParentViewController<UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource,GADBannerViewDelegate,TeadsAdDelegate,WKNavigationDelegate,WKScriptMessageHandler,CMPopTipViewDelegate>
@property  NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *sponsorFirstView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bannerSliderHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollContentHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *webViewHeightConstraint;
@property (strong, nonatomic) LGPlusButtonsView * plusButtonsViewNavBar;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topImageViewConstraint;
@property (nonatomic, strong) TeadsAd *teadsInRead;
@property (weak, nonatomic) IBOutlet UIView *TopimageView;
@property(nonatomic,retain) UIView  *adsview;
@property(nonatomic,retain) DFPBannerView  *bannerView;
@property(nonatomic,strong) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSMutableArray * orginalNewsList;
@property(nonatomic,retain) NSMutableArray * relatedNewsList;
@property(nonatomic,retain) NSMutableArray * relatedVideosList;
@property(nonatomic,assign) int currentRelatedList;
@property(nonatomic,retain) NewsItem *newsItem;
@property(nonatomic,assign) BOOL canLoadMore;
@property(nonatomic,assign) int fontSize;
@property(nonatomic,assign) int currentNewsIndex;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indLoader;
@property(nonatomic,weak)IBOutlet UILabel *loadingLabel;
@property(nonatomic,weak)IBOutlet UILabel *newsTitleLabel ;
@property(nonatomic,weak)IBOutlet UILabel *newsDateLabel ;


@property(nonatomic,weak)IBOutlet UITextView *newsWriterTxt;
@property(nonatomic,weak)IBOutlet UIImageView *newsImageView ;
@property(nonatomic,weak)IBOutlet UIImageView *writerImageView ;
@property(nonatomic,weak)IBOutlet UIScrollView *scrollContent;
@property(nonatomic,weak)IBOutlet UIView *contentView;
@property(nonatomic,assign) BOOL isFromPushNotification;
@property (weak, nonatomic) IBOutlet UIButton *commentsBtn;
@property(nonatomic,assign) BOOL isFromNewsWidget;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,retain) IBOutlet TappableSponsorImageView *sponser;
@property (weak, nonatomic) IBOutlet UIView *webViewSubView;
@property(nonatomic,assign) int relatedNewscurrentIndex;
@property(nonatomic,assign) int relatedVideosCurrentIndex;
@property(strong,nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) IBOutlet UIView *bannersSliderView;
@property (strong, nonatomic) IBOutlet UIView *wkWebSubView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *articleInfoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topScrollContentConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorFirstImgHeightConstraint ;
@property (strong, nonatomic) WKWebView * webView;
@property (strong, nonatomic) WKWebView * postquareWebView;
@property(nonatomic,strong) NSString * postQuareUrlStr;
@property(nonatomic,retain) NSString * textColor;
@property(strong,nonatomic) UIColor *bgcolor;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
- (id)initWithNewsItem:(NewsItem*)newsItem;
- (id)initWithNewsItem:(int)index  withNewsList:(NSMutableArray *)newsList;
-(IBAction)changeFontTape:(id)sender;
-(IBAction)relatedNewBtnTaped:(id)sender;
-(IBAction)relatedVideosBtnTaped:(id)sender;
@end