//
//  NewsDetailsViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/14/14.
//updated by Nada Gamal on 20/10/2017
//  Copyright (c) 2014 Sarmady. All rights reserved.
//

#import "VideoDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "NewsDetailsViewController.h"
#import  "AppInfo.h"
#import "Global.h"
#import "VideoSectionId.h"
#import "AppDelegate.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "VKVideo.h"
#import "BrightCoveViewController.h"
#import "PagerAdsViewController.h"
#import "NewsVideoWebViewControlleriOS8.h"
#import "Rec.h"
#import "Images.h"
#import "NewsCustomCell.h"
#import "FilGoalIOS-Swift.h"

@import Firebase;
@interface VideoDetailsViewController ()
    {
        NSMutableArray *itemsWithAdsArray;
        AppDelegate *appDelegate;
        NSString * sponsorUrl;
        AppInfo *appInfo;
        float topNewsViewHieght;
        NSArray * postSquarePosts;
        NSMutableDictionary * sections;
        
        
        
    }
    @end

@implementation VideoDetailsViewController
    
- (IBAction)btnPressed:(id)sender {
    NewsVideoWebViewControlleriOS8 *newsVideoWebViewController = [[NewsVideoWebViewControlleriOS8 alloc] init];
    newsVideoWebViewController.videoItem=self.VideoItem;
    [self.navigationController presentViewController:newsVideoWebViewController animated:YES completion:nil];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [super setUpBannerUnderNav:self.view anotherTopView:nil];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isFullScreen=NO;
    UIApplication* application = [UIApplication sharedApplication];
    
    if (application.statusBarOrientation != UIInterfaceOrientationPortrait)
    {
        UIViewController *c = [[UIViewController alloc]init];
        [self presentViewController:c animated:NO completion:nil];
        [self dismissViewControllerAnimated:NO completion:nil];
        c=nil;
        
    }
    [super viewDidAppear:animated];
    if(self.VideoItem.videoId != 0)
    {
        [self addMoreBtnOnNavigationBar];
        UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"Detailsmore"] forState:UIControlStateNormal];
        moreBtn.bounds = CGRectMake(Screenwidth-170,0,16,18);
        [moreBtn addTarget:self action:@selector(showHideButtonsAction) forControlEvents:UIControlEventTouchUpInside];
        
        if(self.parentViewController != nil)
        {
            self.parentViewController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
        }
        if([self.navigationController.topViewController isKindOfClass:[VideoDetailsViewController class]])
        {
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
        }
    }
    else
    self.parentViewController.navigationItem.rightBarButtonItems=nil;
    [self setMainSponsor];
}
    
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
     appDelegate.isFullScreen=NO;
   
}
    
-(void)addMoreBtnOnNavigationBar
    {
        _plusButtonsViewNavBar = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:2
                                                               firstButtonIsPlusButton:NO
                                                                         showAfterInit:NO
                                                                         actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                                  {
                                      // NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                                      if (plusButtonView.hidden == NO) {
                                          if(index==0) {
                                              [self share:nil];
                                          } else if(index==1){
                                              [self commentsBtnAction:nil];
                                              [self showHideButtonsAction]; //if u didn't, when u return to this vc it will be displayed & u won't be apple to hide it
                                          }
                                      }
                                  }];
        
        _plusButtonsViewNavBar.showHideOnScroll = NO;
        _plusButtonsViewNavBar.appearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndPop;
        _plusButtonsViewNavBar.position = LGPlusButtonsViewPositionTopRight;
        
        [_plusButtonsViewNavBar setButtonsImages:@[[UIImage imageNamed:@"share"],[UIImage imageNamed:@"coment"]] forState:UIControlStateNormal forOrientation:LGPlusButtonsViewOrientationAll];
        
        [_plusButtonsViewNavBar setButtonsSize:CGSizeMake(40.f, 40.f) forOrientation:LGPlusButtonsViewOrientationAll];
        [_plusButtonsViewNavBar setButtonsLayerCornerRadius:20 forOrientation:LGPlusButtonsViewOrientationAll];
        [_plusButtonsViewNavBar setButtonsBackgroundColor:[UIColor mainAppYellowColor] forState:UIControlStateNormal];
        [_plusButtonsViewNavBar setButtonsLayerShadowColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.f]];
        [_plusButtonsViewNavBar setButtonsLayerShadowOpacity:0.8];
        [_plusButtonsViewNavBar setBackgroundColor:[UIColor clearColor]];
        [_plusButtonsViewNavBar setDescriptionsTextColor:[UIColor whiteColor]];
        [_plusButtonsViewNavBar setDescriptionsBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.66]];
        [_plusButtonsViewNavBar setDescriptionsLayerCornerRadius:6.f forOrientation:LGPlusButtonsViewOrientationAll];
        [_plusButtonsViewNavBar setDescriptionsContentEdgeInsets:UIEdgeInsetsMake(4.f, 8.f, 4.f, 8.f) forOrientation:LGPlusButtonsViewOrientationAll];
        // self.parentViewController.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:_plusButtonsViewNavBar];
        [self.scrollContent addSubview:_plusButtonsViewNavBar];
        
    }
- (void)showHideButtonsAction
    {
        _plusButtonsViewNavBar.position = LGPlusButtonsViewPositionTopRight;
        if (_plusButtonsViewNavBar.isShowing)
        [_plusButtonsViewNavBar hideAnimated:YES completionHandler:nil];
        else
        [_plusButtonsViewNavBar showAnimated:YES completionHandler:nil];
    }
    
-(void)setNavigationBtns
    {
        // Add rightbar button to refresh match details view
        UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        shareButton.bounds = CGRectMake(Screenwidth-20,0,16,18);
        
        [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commentsBtn setBackgroundImage:[UIImage imageNamed:@"coment"] forState:UIControlStateNormal];
        commentsBtn.bounds = CGRectMake(Screenwidth-70,0,19,18);
        
        [commentsBtn addTarget:self action:@selector(commentsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.parentViewController.navigationItem.rightBarButtonItems=@[ [[UIBarButtonItem alloc] initWithCustomView:shareButton], [[UIBarButtonItem alloc] initWithCustomView:commentsBtn]];
        
        
        CMPopTipView *navBarLeftButtonPopTipView = [[CMPopTipView alloc] initWithMessage:@"A Message"];
        navBarLeftButtonPopTipView.delegate = self;
    }
    

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}
    
-(void)loadPostQuareRequest
    {
        if(self.postQuareUrlStr != nil && ![self.postQuareUrlStr isEqualToString:@""])
        {
            self.postquareWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            [self.postquareWebView setTag:44455];
            self.postquareWebView.navigationDelegate=self;
            [self.postquareWebView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",self.postQuareUrlStr]]]];
        }
        
    }
    
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
    {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            
        }
        return self;
    }
- (id)initWithVideo:(VideoItem*)videoItem
    {
        self = [super init];
        if (self) {
            
            self.VideoItem=videoItem;
            self.currentNewsIndex=1;
        }
        return self;
    }
- (id)initWithVideoIndex:(int)index  withVideosList:(NSMutableArray *)videosList
    {
        self = [super init];
        if (self) {
            self.orginalNewsList=videosList;
            self.VideoItem=[videosList objectAtIndex:index];
            self.currentNewsIndex=index;
        }
        return self;
    }
    
    
-(void)getPostSquarePosts
    {
        postSquarePosts = [[NSArray alloc]init];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:[NSString stringWithFormat:@"%i",152986] forKey:@"pubid"];
        [dic setObject:[NSString stringWithFormat:@"%i",116602] forKey:@"webid"];
        [dic setObject:[NSString stringWithFormat:@"%i",105912] forKey:@"wid"];
        [dic setObject:[NSString stringWithFormat:@"http://www.filgoal.com/videos/%i",self.VideoItem.videoId] forKey:@"url"];
        
        [WServicesManager getDataWithURLString:POSTSQUARE_BASE_URL andParameters:dic WithObjectName:nil andAuthenticationType:NoAuth success:^(NSDictionary *newsData){
            PostSquareClass * posts=[[PostSquareClass alloc]initWithDictionary:newsData];
            if(posts.recs.count>0)
            {
                [sections setObject:posts.recs forKey:@"محتوي قد يعجبك"];
                postSquarePosts = posts.recs;
                [self.tableView reloadData];
                [self.tableView layoutIfNeeded];
                self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
                [self.view updateConstraintsIfNeeded];
            }
            
        } failure:^(NSError *error) {
            IBGLog(@"Postquare  Error  : %@",error);
            
        }];
    }
    
-(void)loadViewsFromNewsItem:(int)currentList{
    self.currentRelatedList=currentList;
    self.newsTitleLabel.text=[NSString stringWithFormat:@"\u200F%@",self.VideoItem.videoTitle ];
    self.newsWriterLabel.text=[NSString stringWithFormat:@"%d",self.VideoItem.videoNumofviews];
    self.newsDateLabel.text=self.VideoItem.videoDate;
    self.newsDetailsWebView.opaque = NO;
    self.newsDetailsWebView.backgroundColor = [UIColor clearColor];
    [self.view updateConstraints];
    if(![self.VideoItem.videoDetails isEqualToString:@""]&&self.VideoItem.videoDetails!=nil)
    {
        [self.newsDetailsWebView loadHTMLString:[NSString stringWithFormat:
                                                 @"<html><head><style>body { background-color: trasparent; text-align: %@; font-size:%ipx; color: Black; margin:0; } a { color: #172983; } img{width:100%%; height:auto} #content > iFrame { width : 100%%} </style></head><body><div id='content' name='content'>%@</div></body></html>",
                                                 @"right",
                                                 self.fontSize,self.VideoItem.videoDetails] baseURL:nil];
    }
    else
    {
        self.webViewHeightConstraint.constant=10;
        
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
    {
        [self.newsDetailsWebView stopLoading];
    }
- (void)viewDidLoad
    {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        sections = [[NSMutableDictionary alloc]init];
        
        [super viewDidLoad];
        [self setScreenAnalytics];
        [self.loadingIndicator startAnimating];
        appInfo= [Global getInstance].appInfo;
        self.adsview=[[UIView alloc] init];
        
        //Tableview
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.tableView.backgroundColor = [UIColor clearColor];
        
        self.fontSize=15;
        if(self.VideoItem.videoTitle!=nil||![self.VideoItem.videoTitle isEqualToString:@""])
        [self loadViewsFromNewsItem:1];
        self.currentRelatedList=1;
        self.relatedNewsList=[[NSMutableArray alloc] init];
        self.relatedVideosList=[[NSMutableArray alloc] init];
        self.canLoadMore=YES;
        
        if(appInfo.isPostquareActive)
        [self getPostSquarePosts];
        
        if (self.VideoItem.videoId!=0) {
            
            [self LoadVideoItem];
            
        }
        else
        {
            //[self dismissProgressbar];
            
            PagerAdsViewController *adsViewController =[[PagerAdsViewController alloc]init];
            [self addChildViewController:adsViewController];
            adsViewController.view.frame=CGRectMake(self.view.frame.origin.x,-40, self.view.frame.size.width,  self.view.frame.size.height+40);;
            [self.view addSubview:adsViewController.view];
            [adsViewController didMoveToParentViewController:self];
        }
        
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(videoImageTapped)];
        
        
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.delegate=self;
        self.videoImageView.userInteractionEnabled= YES;
        [self.videoImageView addGestureRecognizer:tapRecognizer];
        NSString *ioi = self.VideoItem.videoPreviewImage;
        [self.videoImageView  sd_setImageWithURL:[NSURL URLWithString:self.VideoItem.videoPreviewImage] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           [self.previewImageActivityIndicator stopAnimating];
                                       }];
        [self.videoImageView addGestureRecognizer:tapRecognizer];
        
        
        [self loadPostQuareRequest];
        
    }
-(NSArray*)getRelatedDate{
    NSMutableArray * list=[[NSMutableArray alloc]init];
    for (ChampionShipData * champ in self.VideoItem.relatedData.championships) {
        [list addObject:[NSString stringWithFormat:@"بطولة %@",champ.name]];
    }
    for (Player * item in self.VideoItem.relatedData.people) {
        [list addObject:[NSString stringWithFormat:@"لاعب %@",item.name]];
    }
    for (MatchCenterDetails * item in self.VideoItem.relatedData.matches) {
        [list addObject:[NSString stringWithFormat:@"مباراة %@ و %@",item.homeTeamName,item.awayTeamName]];
    }
    return [[NSArray alloc]initWithArray:list];
}
-(NSArray*)getSectionNamesList
    {
        NSMutableArray * sectionNames=[[NSMutableArray alloc]init];
        for (VideoSectionId * item in self.VideoItem.videoSectionId) {
            Section * section =[[Global getInstance]getSectionItemWithSectionID:item.sectionId];
            if(section.sectionName!=nil)
            [sectionNames addObject:[NSString stringWithFormat:@"قسم %@",section.sectionName]];
        }
        return sectionNames;
    }
-(void)setScreenAnalytics
    {
        if(_isFromPushNotification)
        {
            _isFromPushNotification=NO;
            self.screenName = [NSString stringWithFormat:@"iOS-video details From Push with Video ID =%i",self.VideoItem.videoId ];
            [FIRAnalytics logEventWithName:kFIREventViewItem
                                parameters:@{
                                             kFIRParameterItemName:[NSString stringWithFormat:@"iOS-video details From Push with Video ID =%i",self.VideoItem.videoId ]
                                             }];
            
        }
        else if (_isFrom3DTouch)
        {
            id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:  @"iOS-3DTouch"   // Event category (required)
                                                                  action:@"Videos-3DTouch"  // Event action (required)
                                                                   label:[NSString stringWithFormat:@"Video item with ID =%i",self.VideoItem.videoId ]
                                                                   value:nil] build]];
        }
        else
        {
            self.screenName = [NSString stringWithFormat:@"iOS-video details with Video ID =%i",self.VideoItem.videoId ];
            [FIRAnalytics logEventWithName:kFIREventViewItem
                                parameters:@{
                                             kFIRParameterItemName:[NSString stringWithFormat:@"iOS-video details with Video ID =%i",self.VideoItem.videoId ]
                                             }];
        }
        
    }
-(void)setCoSponsorScreenSponsor
    {
        self.sponser.hidden=YES;
        for (VideoSectionId * item in self.VideoItem.videoSectionId) {
            if([AppSponsors isSectionCoSponsorActiveUsingId:item.sectionId])
            {
                self.sponser.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:item.sectionId category: @"Videos"];
                sponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSectionBannerStripeImagePathUsingSectionId:item.sectionId andContentType:@"Videos"]];
                [self.sponser sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if(error)
                    {
                        self.sponser.hidden=YES;
                    }
                    else
                    {
                        self.sponser.hidden=NO;
                    }
                }];
                break;
            }
        }
    }
    
-(void)setMainSponsor
    {
        NSString * mainSponsorUrl=[[NSString alloc]init];
        /// Main Sponsorship
        for (VideoSectionId * item in self.VideoItem.videoSectionId) {
            if([AppSponsors isSectionActiveUsingId:item.sectionId])
            {
                mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSpecialSectionBannerImagePathUsingId:item.sectionId]];
                [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:item.sectionId activeCategory: nil];
                break;
            }
        }
        if((mainSponsorUrl==nil||[mainSponsorUrl isEqualToString:@""])&&[AppSponsors isVideoSponsorContentActive])
        {
            mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"Videos"]];
            [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: @"Videos"];
        }
        //[super setNavigationBarBackgroundImage:mainSponsorUrl];
    }
-(void)LoadVideoItem{
    if(self.canLoadMore==YES){
        NSString *lastDate=@"";
        if ([self.relatedNewsList count]>0) {
            lastDate=((VideoItem*)[self.relatedNewsList objectAtIndex:self.relatedNewsList.count-1]).sourceDate;
            
        }
        NSDictionary *dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",self.VideoItem.videoId], nil] forKeys:[NSArray arrayWithObjects:@"id", nil] ];
        self.canLoadMore=NO;
        [WServicesManager getDataWithURLString:[NSString stringWithFormat:VideoDetailsAPI,[WServicesManager getApiBaseURL]] andParameters:[[NSMutableDictionary alloc]initWithDictionary:dictionary] WithObjectName:@"VideoItem" andAuthenticationType:CMSAPIs success:^(VideoItem *videosItem)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.loadingIndicator stopAnimating];
                 [self.relatedVideosList addObjectsFromArray:videosItem.relatedVideos];
                 [self.relatedNewsList addObjectsFromArray: videosItem.relatedNews];
                 if(self.relatedNewsList.count>0)
                 [sections setObject:self.relatedNewsList forKey:@"أخبار متعلقة"];
                 else if(self.relatedVideosList.count>0)
                 [sections setObject:self.relatedVideosList forKey:@"فيديوهات متعلقة"];
                 [self.tableView reloadData];
                 [self.tableView layoutIfNeeded];
                 self.tableViewHeightConstraint.constant = self.tableView.contentSize.height * 1.35;//1.25 //was + 50
                 self.canLoadMore=YES;
                 [self.loadingLabel setHidden:YES];
                 self.VideoItem=videosItem;
                 [self addWebViewAsSubView];
                 [self setCoSponsorScreenSponsor];
                 [self loadViewsFromNewsItem:1];
                 [self.nOfViewsLbl setText:[NSString stringWithFormat:@"%i", self.VideoItem.videoNumofviews]];
                 [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Video Details with ID = %i ",self.VideoItem.videoId] ApiError:@"Success"];
                 [self setAdView];
                 
                 [self.videoImageView  sd_setImageWithURL:[NSURL URLWithString:self.VideoItem.videoPreviewImage] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                    [self.previewImageActivityIndicator stopAnimating];
                                                }];
             });
             
         } failure:^(NSError *error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.canLoadMore=YES;
                 [self.loadingIndicator stopAnimating];
                 self.loadingLabel.text=@"لم يتم العثور علي اخبار";
                 IBGLog(@"Video Details Error %@",error);
                 [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Video Details with ID = %i ",self.VideoItem.videoId] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
                 [self showDefaultNetworkingErrorMessageForError:error
                                                  refreshHandler:^{
                                                      [self LoadVideoItem];
                                                  }];
                 
             });
         }];
        
    }
}
    
-(void)setAdView{
    NSMutableArray * list=[[NSMutableArray alloc]init];
    [list addObjectsFromArray:[self getSectionNamesList]];
    [list addObjectsFromArray:[self getRelatedDate]];
    [list addObjectsFromArray:@[@"Inner",@"Video"]];
    self.tableView.tableHeaderView=[super setBannerViewFooter:list andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS-video details with Video ID =%i",self.VideoItem.videoId ]];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
    {
        return YES;
    }
- (void)adViewDidReceiveAd:(DFPBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}
    
    /// Tells the delegate an ad request failed.
- (void)adView:(DFPBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adViewDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}
    
- (IBAction)commentsBtnAction:(id)sender {
    
    WebViewControllerWithPopUps *commentsViewController = [[WebViewControllerWithPopUps alloc]init];
    commentsViewController.urlPath = @"https://www.filgoal.com/home/views?name=comments&type=article&id=287023" ;
    [self.navigationController pushViewController:commentsViewController animated:true];
//
//    WebViewControllerWithPopUps *commentsWebViewController = [[WebViewControllerWithPopUPS alloc]init];
//    [self.navigationController pushViewController:commentsWebViewController animated:true];
//
//
    
//    GlobalViewController * webView=[[GlobalViewController alloc]init];
//    webView.url=[NSURL URLWithString:[NSString stringWithFormat:DISQUS_URL,@"video",self.VideoItem.videoId]];
//    [self.navigationController pushViewController:webView animated:YES];
}
    
- (void) videoImageTapped{
    // self.VideoItem.nativeVideoURL = @"http://video.vmp.mezzoz.com/DXS9MSY7/HPU3EAZV/720p.mp4";
    if(self.VideoItem.nativeVideoURL != nil){
        AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:self.VideoItem.nativeVideoURL]];
        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
        [self presentViewController:controller animated:YES completion:nil];
        controller.player = player;
        [player play];
    }
    else if(self.VideoItem.brightCoveVideoID!=nil &&![ self.VideoItem.brightCoveVideoID isEqualToString:@""])
    {
        BrightCoveViewController * brightCovePlayer=[[BrightCoveViewController alloc]init];
        brightCovePlayer.videoID=self.VideoItem.brightCoveVideoID;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.isFullScreen=YES;
        [self.navigationController pushViewController:brightCovePlayer animated:nil];
        
    }
    else
    {
        VideoViewController *newVideoViewcontroller = [[VideoViewController alloc]init];
        if (self.VideoItem.embed)
        {
            newVideoViewcontroller.embed = self.VideoItem.embed ;
            [self.navigationController pushViewController:newVideoViewcontroller animated:YES];
        }
    }
//    {
//        NSRange startVk = [self.VideoItem.videoUrl rangeOfString:@"//vk.com/"];
//
//        if(self.VideoItem.isYouTube)
//        {
//             dispatch_async(dispatch_get_main_queue(), ^{
//                            VideoViewController *newVideoViewcontroller = [[VideoViewController alloc]init];
//
//                 NSString *uhuh = self.VideoItem.embed ;
//                              if (self.VideoItem.embed)
//                              {
//                             newVideoViewcontroller.embed = self.VideoItem.embed ;
//                             [self.navigationController pushViewController:newVideoViewcontroller animated:YES];
//                              }
//            //                NewsVideoWebViewControlleriOS8 *newsVideoWebViewController = [[NewsVideoWebViewControlleriOS8 alloc] init];
//             //              newsVideoWebViewController.videoItem=self.VideoItem;
//            //                [self.navigationController pushViewController:newsVideoWebViewController animated:YES];
//                        });
////            WebViewControllerWithPopUps *commentsViewController = [[WebViewControllerWithPopUps alloc]init];
////            commentsViewController.urlPath = self.VideoItem.videoUrl ;
////            [self.navigationController pushViewController:commentsViewController animated:true];
////
//
//
////            XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:self.VideoItem.videoUrl];
////            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
////            appDelegate.isFullScreen=YES;
////            [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
//        }
//        else if(startVk.location != NSNotFound)
//        {
//            @try {
//
//                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//                appDelegate.isFullScreen=YES;
//
//                NSString *searchedString =  self.VideoItem.videoUrl;
//                NSError* error = nil;
//                NSString* videoUrl;
//                NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"src[\\s]*=[\\s]*\"([^\"]*)\"" options:0 error:&error];
//                NSArray* matches = [regex matchesInString:searchedString options:0 range:NSMakeRange(0, [searchedString length])];
//                for ( NSTextCheckingResult* match in matches )
//                {
//                    NSRange group1 = [match rangeAtIndex:1];
//                    videoUrl =[NSString stringWithFormat:@"http:%@",[searchedString substringWithRange:group1]] ;
//                }
//
//
//                VKVideo *video =  [[VKVideo alloc]init];
//                video.videoTitle=self.VideoItem.videoTitle;
//                video.videoScriptURL=[NSURL URLWithString:videoUrl];
//                [video loadVideoURLWithCompletionHandler:^(NSURL *videoURL) {
//                    dispatch_async(dispatch_get_main_queue(), ^(){
//                        if (videoURL) {
//                            self.mpvc = [[MPMoviePlayerViewController alloc] init];
//                            self.mpvc.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
//                            self.mpvc.moviePlayer.contentURL = videoURL;
//                            [[NSNotificationCenter defaultCenter] removeObserver:self.mpvc];
//                            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                                     selector:@selector(videoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.mpvc.moviePlayer];
//                            [self.navigationController presentMoviePlayerViewControllerAnimated:self.mpvc];
//                        }
//                        else
//                        {
//                            NewsVideoWebViewControlleriOS8 *newsVideoWebViewController = [[NewsVideoWebViewControlleriOS8 alloc] init];
//                            newsVideoWebViewController.videoItem=self.VideoItem;
//                            [appDelegate.navigationController presentViewController:newsVideoWebViewController animated:YES completion:nil];
//                        }
//                    });
//                }];
//            }
//            @catch (NSException *exception) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    VideoViewController *newVideoViewcontroller = [[VideoViewController alloc]init];
//                     if (self.VideoItem.embed)
//                     {
//                    newVideoViewcontroller.embed = self.VideoItem.embed ;
//                    [self.navigationController pushViewController:newVideoViewcontroller animated:YES];
//                     }
////                    NewsVideoWebViewControlleriOS8 *newsVideoWebViewController = [[NewsVideoWebViewControlleriOS8 alloc] init];
////                    newsVideoWebViewController.videoItem=self.VideoItem;
////                    [self.navigationController pushViewController:newsVideoWebViewController animated:YES];
//                });
//
//            }
//            @finally {
//
//            }
//
//        }
//
//        else
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                VideoViewController *newVideoViewcontroller = [[VideoViewController alloc]init];
//                  if (self.VideoItem.embed)
//                  {
//                 newVideoViewcontroller.embed = self.VideoItem.embed ;
//                 [self.navigationController pushViewController:newVideoViewcontroller animated:YES];
//                  }
////                NewsVideoWebViewControlleriOS8 *newsVideoWebViewController = [[NewsVideoWebViewControlleriOS8 alloc] init];
// //              newsVideoWebViewController.videoItem=self.VideoItem;
////                [self.navigationController pushViewController:newsVideoWebViewController animated:YES];
//            });
//        }
//    }
    
    
}
#pragma mark tableView delegate
    
#pragma mark tableView deleg
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return sections.allValues.count;
        
    }
    
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];
    
    [headerView setBackgroundColor:[UIColor lightGrayAppColor]];
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(8, 5, self.tableView.frame.size.width-30, 25)];
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:title.font.pointSize]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentRight];
    // title.text = [[sections allKeys]objectAtIndex:section];
    [title setBackgroundColor:[UIColor clearColor]];
    
    if(sections.count>0)
    {
        title.text = [[sections allKeys]objectAtIndex:section];
    }
    
    [headerView addSubview:title];
    return headerView;
    
    
}
    
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [(NSArray*)[[sections allValues]objectAtIndex:section]count];
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCustomCell *cell;
    if ([[[[sections allValues]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] isKindOfClass:[NewsItem class]]) {
        NewsItem *item=[self.relatedNewsList objectAtIndex:indexPath.row ];
        if (cell == nil)
        {
            cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
            cell.hideDeleteBtn = YES;
            
        }
        if(item.images.count>0)
        {
            Images *imageItem =[item.images objectAtIndex:0];
            [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:imageItem.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                          [((NewsCustomCell*)cell).activityIndicator stopAnimating];
                                                      }];
        }
        
        [( (NewsCustomCell*)cell).itemLbl setText:item.newsTitle];
        
        cell.playImg.hidden=YES;
        ( (NewsCustomCell*)cell).dateLabel.hidden = YES;
        
        return cell;
    }
    else if ([[[[sections allValues]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] isKindOfClass:[VideoItem class]]) {
        VideoItem *item=[self.relatedVideosList objectAtIndex:indexPath.row ];
        if (cell == nil)
        {
            cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
            cell.hideDeleteBtn = YES;
            
        }
        
        [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:item.videoPreviewImage] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                      [((NewsCustomCell*)cell).activityIndicator stopAnimating];
                                                  }];
        
        [( (NewsCustomCell*)cell).itemLbl setText:item.videoTitle];
        
        cell.playImg.hidden=NO;
        ( (NewsCustomCell*)cell).dateLabel.hidden = YES;
        return cell;
    }
    else
    {
        static NSString * cellIdentifier = @"Cell";
        
        Rec * postSqureItem=[postSquarePosts objectAtIndex:indexPath.row ];
        if(postSqureItem.postId==0)
        {
            UITableViewCell * logoCell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
            if(logoCell == nil)
            {
                logoCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                UIImage * image =[UIImage imageNamed:@"Postquare"];
                UIImageView * logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, image.size.width, image.size.height)];
                logoImgView.image = [UIImage imageNamed:@"Postquare"];
                
                [logoCell addSubview:logoImgView];
            }
            return logoCell;
            
        }
        
        else
        {
            if (cell == nil)
            {
                cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
                cell.hideDeleteBtn = YES;
                
            }
            [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",postSqureItem.thumbnailPath]]
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                          [((NewsCustomCell*)cell).activityIndicator stopAnimating];
                                                      }];
            
            NSString * title =[postSqureItem.title stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
            
            [( (NewsCustomCell*)cell).itemLbl setText:title];
            [( (NewsCustomCell*)cell).dateLabel setText:postSqureItem.displayName];
            NSString *urlToOpen = [NSString stringWithFormat:@"%@",postSqureItem.url];
            
            if([urlToOpen rangeOfString:@"/videos"].location  != NSNotFound)
            {
                cell.playImg.image = [UIImage imageNamed:@"play_button"];
                cell.playImg.hidden=NO;
            }
            else if([urlToOpen rangeOfString:@"/albums"].location  != NSNotFound)
            {
                cell.playImg.hidden=NO;
                cell.playImg.image = [UIImage imageNamed:@"ic_album"];
            }
            else
            cell.playImg.hidden=YES;
            
            
            return cell;
        }
        
        
    }
    
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([[[[sections allValues]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] isKindOfClass:[Rec class]])
    {
        Rec * item =[postSquarePosts objectAtIndex:indexPath.row];
        NewsItem * newsItem ;
        VideoItem * videoItem;
        if(item.postId==0)
        {
        }
        else
        {
            NSString *urlToOpen = [NSString stringWithFormat:@"%@",item.url];
            
            if([urlToOpen rangeOfString:@"/articles"].location  != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"articles/"];
                newsItem=[[NewsItem alloc] init];
                if(elts.count>0)
                newsItem.newsId=[[elts objectAtIndex:1] intValue];
                newsItem.newsTitle=item.title;
                NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:newsItem ];
                newsDetailsScreenWebView.postQuareUrlStr = item.clickUrl;
                
                [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
            }
            else   if([urlToOpen rangeOfString:@"/videos"].location  != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"videos/"];
                videoItem=[[VideoItem alloc] init];
                if(elts.count>0)
                videoItem.videoId=[[elts objectAtIndex:1] intValue];
                videoItem.videoTitle=item.title;
                VideoDetailsViewController * newsDetailsScreenWebView=[[VideoDetailsViewController alloc]initWithVideo:videoItem];
                newsDetailsScreenWebView.postQuareUrlStr = item.clickUrl;
                [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
            }
            else   if([urlToOpen rangeOfString:@"/albums"].location  != NSNotFound){
                Album * albumItem = [[Album alloc]init] ;
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"albums/"];
                if(elts.count>0)
                albumItem.albumId=[[elts objectAtIndex:1] intValue];
                albumItem.albumTitle=item.title;
                GalleryDetailsViewController * viewController=[[GalleryDetailsViewController alloc]init];
                viewController.albumItem = albumItem;
                viewController.postQuareUrlStr = item.clickUrl;
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else
            
            {
                GlobalViewController * webView=[[GlobalViewController alloc]init];
                webView.url=[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",item.clickUrl]];
                [self.navigationController pushViewController:webView animated:YES];
            }
            
        }
        
    }
    
    else if (self.relatedNewsList.count>0 && [[[[sections allValues]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] isKindOfClass:[NewsItem class]]) {
        self.relatedNewscurrentIndex=indexPath.row;
        
        self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];self.pageController.view.backgroundColor=[UIColor blackColor];self.pageController.view.backgroundColor=[UIColor blackColor];
        
        self.pageController.dataSource = self;
        self.pageController.view.frame=self.view.bounds;
        NSArray *viewControllers;
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
        viewControllers = [NSArray arrayWithObject:[[NewsDetailsViewControllerWithWKWebView alloc]initWithNewsItem:self.relatedNewscurrentIndex withNewsList:self.relatedNewsList]];
        else
        viewControllers = [NSArray arrayWithObject:[[NewsDetailsViewController alloc]initWithNewsItem:self.relatedNewscurrentIndex withNewsList:self.relatedNewsList]];
        
        if (viewControllers.count>0) {
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            [self.navigationController pushViewController:self.pageController animated:YES];
        }
        
    }
    else if (self.relatedVideosList.count>0 && [[[[sections allValues]objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] isKindOfClass:[VideoItem class]]) {
        self.relatedVideosCurrentIndex=(int)indexPath.row;
        NSArray *itemsArray=self.relatedVideosList;
        
        int repateCount=(int)[Global getInstance].appInfo.adsRepeatCount;
        int numOfAdsOnPager = (repateCount>0) ? (int)itemsArray.count/repateCount : 0;
        
        itemsWithAdsArray=[[NSMutableArray alloc]initWithArray:itemsArray];
        BOOL isPagerAdsEnabled = NO;
        for (AdsEnabledPerVersion *temp in [Global getInstance].appInfo.adsEnabledPerVersion){
            
            if([temp.versionCode isEqualToString: [super appVersion]]){
                
                isPagerAdsEnabled = temp.isPagerAdsEnabled;
                
            }
            
        }
        
        if(isPagerAdsEnabled){
            for (int i=0; i<numOfAdsOnPager; i++) {
                [itemsWithAdsArray insertObject:[[VideoItem alloc]init] atIndex:i+repateCount+repateCount*i];
            }
        }
        
        int newindex;
        newindex= (repateCount>0) ? indexPath.row+((int)indexPath.row/(int)repateCount) : indexPath.row;
        
        self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];self.pageController.view.backgroundColor=[UIColor blackColor];
        
        self.pageController.dataSource = self;
        self.pageController.view.frame=self.view.bounds;
        NSArray *viewControllers = [NSArray arrayWithObject:[[VideoDetailsViewController alloc] initWithVideoIndex:newindex withVideosList:itemsWithAdsArray]];
        if (viewControllers.count>0) {
            
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            [self.navigationController pushViewController:self.pageController animated:YES];
            
        }
        
        
        
    }
    
}
    
#pragma mark UIPageViewController dataSource
    
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (self.currentRelatedList==1) {
        
        int index = [(NewsDetailsViewController *)viewController currentNewsIndex];
        index--;
        
        if (index == NSNotFound||index<0) {
            return nil;
        }
        else{
            UIViewController * childViewController;
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
            childViewController = [[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:index withNewsList:self.relatedNewsList];
            else
            childViewController = [[NewsDetailsViewController alloc] initWithNewsItem:index withNewsList:self.relatedNewsList];
            
            
            return childViewController;
        }
        
    }
    
    else{
        int index = [(VideoDetailsViewController *)viewController currentNewsIndex];
        index--;
        if([Global getInstance].appInfo.adsRepeatCount<=0)
        {
            itemsWithAdsArray=[[NSMutableArray alloc]initWithArray:self.relatedVideosList];
            
        }
        if (index<0) {
            return nil;
        }
        else{
            VideoDetailsViewController *childViewController = [[VideoDetailsViewController alloc] initWithVideoIndex:index withVideosList:itemsWithAdsArray] ;
            
            
            return childViewController;
        }
        
    }
    return nil;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    
    if (self.currentRelatedList==1) {
        
        
        int index = [(NewsDetailsViewController *)viewController currentNewsIndex];
        index++;
        if (index == NSNotFound||index>=self.relatedNewsList.count) {
            return nil;
        }
        else{
            UIViewController * childViewController;
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
            childViewController = [[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:index withNewsList:self.relatedNewsList];
            else
            childViewController = [[NewsDetailsViewController alloc] initWithNewsItem:index withNewsList:self.relatedNewsList];
            return childViewController;
        }
        
    }
    
    else{
        if([Global getInstance].appInfo.adsRepeatCount<=0)
        {
            itemsWithAdsArray=[[NSMutableArray alloc]initWithArray:self.relatedVideosList];
            
        }
        
        int index = [(VideoDetailsViewController *)viewController currentNewsIndex];
        index++;
        if (index>=self.relatedVideosList.count) {
            return nil;
        }
        else{
            
            VideoDetailsViewController *childViewController = [[VideoDetailsViewController alloc] initWithVideoIndex:index withVideosList:itemsWithAdsArray] ;
            return childViewController;
        }
        
    }
    return nil;
}
    
-(IBAction)share:(id)sender{
    
    NSString *text =self.VideoItem.videoTitle;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://filgoal.com/videos/%i",self.VideoItem.videoId]];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url]
     applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    [self presentViewController:controller animated:YES completion:nil];
}
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    NSString *text =self.VideoItem.videoTitle;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://filgoal.com/videos/%i",self.VideoItem.videoId]];
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url]
     applicationActivities:nil];
    
    UIPreviewAction *shareAction =
    [UIPreviewAction actionWithTitle:@"شارك"
                               style:UIPreviewActionStyleDefault
                             handler:^(UIPreviewAction *action,
                                       UIViewController *previewViewController){
                                 
                                 controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                                                      UIActivityTypeMessage,
                                                                      UIActivityTypeMail,
                                                                      UIActivityTypePrint,
                                                                      UIActivityTypeCopyToPasteboard,
                                                                      UIActivityTypeAssignToContact,
                                                                      UIActivityTypeSaveToCameraRoll,
                                                                      UIActivityTypeAddToReadingList,
                                                                      UIActivityTypePostToFlickr,
                                                                      UIActivityTypePostToVimeo,
                                                                      UIActivityTypePostToTencentWeibo,
                                                                      UIActivityTypeAirDrop];
                                 [[NSNotificationCenter defaultCenter]postNotificationName:@"ShareVideoDetails" object:self.VideoItem];
                             }];
    
    
    
    return @[shareAction];
}
    
- (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    
-(void) addWebViewAsSubView
    {
        if(self.VideoItem.isYouTube)
        {
            
        }
        else
        {
            NSString *urlString;
            if(self.VideoItem!=nil)
            {
                //urlString = [NSString stringWithFormat:@"http://www.filgoal.com/Arabic/APIVideoView.aspx?AudioVideoID=%i",self.VideoItem.videoId]  ;
                //https://www.filgoal.com/videos/37292/apivideo/video-title
                
                urlString = [NSString stringWithFormat:@" https://www.filgoal.com/videos/%i",self.VideoItem.videoId] ;
                [urlString stringByAppendingFormat:@"/apivideo/video-title"];
                NSLog(@"%@", urlString);
            }
            NSURL *url = [NSURL URLWithString:urlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSString *jScript = [NSString stringWithFormat:@"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=%f'); document.getElementsByTagName('head')[0].appendChild(meta);",Screenwidth];
            
            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            WKUserContentController *wkUController = [[WKUserContentController alloc] init];
            [wkUController addUserScript:wkUScript];
            WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
            wkWebConfig.userContentController = wkUController;
            
            //was
            //self.webView=[[WKWebView alloc]initWithFrame: CGRectMake(-10,-30,Screenwidth+20,  self.imageViewHeightConstraint.constant+40) configuration:wkWebConfig];
            //Now
            self.webView=[[WKWebView alloc]initWithFrame:CGRectMake(0,0,Screenwidth,  self.imageViewHeightConstraint.constant+40)configuration:wkWebConfig];
            
            self.webView.scrollView.scrollEnabled=NO;
            [self.webView setOpaque:NO];
            [self.webView setTag:500];
            self.webView.navigationDelegate=self;
            [self.webView loadRequest:request];
            
        }
        
    }
- (void)webView:(WKWebView *)aWebView didFinishNavigation:(WKNavigation *)aNavigation
    {
        if(aWebView.tag==123456)
        return;
        if(aWebView.tag == 44455)
        {
            [aWebView stopLoading];
            return;
        }
        if(aWebView.tag==500)
        {
            
            aWebView.scrollView.scrollEnabled=NO;
            self.webView.hidden = NO;
            _videoImageView.gestureRecognizers = nil;
            [self.videoImageView addSubview:self.webView];
            self.playBtn.hidden=YES;
        }
        
    }
    
#pragma mark UIWebview Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    
    int height = [result intValue];
    self.webViewHeightConstraint.constant=height;
    [self.view updateConstraints];
    
}
    
-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl
    {
        [super setFilGoalNavigationBar];
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:mainSponsorUrl];
        if(image!=nil)
        {
            [self.parentViewController.navigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
        }
        else
        {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:mainSponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (image && finished) {
                        [[SDImageCache sharedImageCache] storeImage:image forKey:mainSponsorUrl toDisk:YES];
                        [self.parentViewController.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                    }
                });
            }];
        }
    }
    
    @end
