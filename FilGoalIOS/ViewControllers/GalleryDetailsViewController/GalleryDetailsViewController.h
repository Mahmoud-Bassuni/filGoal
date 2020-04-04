//
//  GalleryDetailsViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 4/19/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
#import "MWPhotoBrowser.h"
#import "TappableSponsorImageView.h"

@interface GalleryDetailsViewController :ParentViewController<UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource,GADBannerViewDelegate,TeadsAdDelegate,MWPhotoBrowserDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *detailsTxtViewConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bannerSliderHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollContentHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (nonatomic, strong) NSMutableArray * photos;
@property  NSUInteger pageIndex;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *TopimageView;
@property(nonatomic,retain) UIView  *adsview;

@property(nonatomic,strong) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSMutableArray * relatedGalleriesList;
@property(nonatomic,assign) int currentRelatedList;
@property(nonatomic,retain) Album * albumItem;
@property(nonatomic,assign) BOOL canLoadMore;
@property(nonatomic,assign) int fontSize;
@property(nonatomic,assign) int currentNewsIndex;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *indLoader;
@property(nonatomic,weak)IBOutlet UILabel *loadingLabel;
@property(nonatomic,weak)IBOutlet UILabel *titleLbl ;
@property(nonatomic,weak)IBOutlet UILabel *newsDateLabel ;
@property(nonatomic,weak)IBOutlet UILabel *newsWriterLabel;
@property(nonatomic,weak)IBOutlet UIImageView *newsImageView ;
@property(nonatomic,weak)IBOutlet UIImageView *writerImageView ;
@property(nonatomic,weak)IBOutlet UIScrollView *scrollContent;
@property(nonatomic,weak)IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,assign) BOOL isFromPushNotification;
@property (weak, nonatomic) IBOutlet UIButton *commentsBtn;
@property(nonatomic,assign) BOOL isFromNewsWidget;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,retain) IBOutlet TappableSponsorImageView *sponser;

@property(nonatomic,assign) int relatedNewscurrentIndex;
@property(nonatomic,assign) int relatedVideosCurrentIndex;
@property(strong,nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) IBOutlet UIView *bannersSliderView;
@property (strong, nonatomic) IBOutlet UITextView *detailsTxtView;
- (IBAction)albumBtnPressed:(id)sender;


@property (strong, nonatomic) WKWebView * postquareWebView;
@property(nonatomic,strong) NSString * postQuareUrlStr;

@property(nonatomic,retain) NSString * textColor;
@property(strong,nonatomic) UIColor *bgcolor;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;


@end
