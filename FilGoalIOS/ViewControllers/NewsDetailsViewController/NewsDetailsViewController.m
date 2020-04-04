//
//  NewsDetailsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 1/3/17.
//  Copyright (c) 2014 Sarmady. All rights reserved.
//

#import "NewsDetailsViewController.h"
@import Firebase;
#define NAVBAR_CHANGE_POINT 50

@interface NewsDetailsViewController ()
{
    NSMutableArray *itemsWithAdsArray;
    UIScrollView * footerView;
    NSString * sponsorUrl;
    AppInfo *appInfo;
    AppDelegate * appDelegate;
    CustomIOSAlertView *alertView;
    NSDate * apiFireDate;
    float  webViewHeight;
    NSArray * postSquarePosts;
    bool isLoaded;
    NSInteger failuresCount;
    NSMutableArray * sectionsList;
    NSMutableArray * arrMinMax;
    NSArray * authors;
    BOOL isPressed;
    
}
@end

@implementation NewsDetailsViewController
#define PADDING 30

- (void)viewDidLoad
{
    appInfo= [Global getInstance].appInfo;
    failuresCount = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [super viewDidLoad];
    [self setGoogleAnalyticsScreens];
    
    // sections = [[NSMutableDictionary alloc]init];
    
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [self addPullToRefresh];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.commentsBtn.hidden=NO;
    self.adsview=[[UIView alloc] init];
    self.bgcolor=[Global getInstance].bgcolor;
    self.textColor=[Global getInstance].textColor;
    self.fontSize=[Global getInstance].fontSize;
    self.currentRelatedList=1;
    self.relatedNewsList=[[NSMutableArray alloc] init];
    self.relatedVideosList=[[NSMutableArray alloc] init];
    self.canLoadMore=YES;
    
    //Show Loading view
    [self.indLoader startAnimating];
    [self.indLoader setHidden:NO];
    [self.tableView setHidden:YES];
    [self.loadingLabel setHidden:NO];
    self.scrollContent.scrollsToTop=YES;
    self.tableView.scrollsToTop=NO;
    isPressed=YES;
    self.webView.scrollView.scrollsToTop=NO;
    if (self.newsItem.newsId!=0) {
        [self LoadNewsItem];
    }
    else
    {
        PagerAdsViewController *adsViewController =[[PagerAdsViewController alloc]init];
       // NSLog(@"%@",self.parentViewController.navigationItem.rightBarButtonItems);
        [self addChildViewController:adsViewController];
        adsViewController.view.frame=CGRectMake(self.view.frame.origin.x,-40, self.view.frame.size.width,  self.view.frame.size.height+40);;
        [self.view addSubview:adsViewController.view];
        [adsViewController didMoveToParentViewController:self];
    }
    
    self.tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView=[self setBannerAdView];
    // lock orientation to portrait only
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isFullScreen=NO;
    [appDelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:appDelegate.window];
    
    [self loadPostQuareRequest];
    isLoaded = NO;
   // [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    self.articleInfoView.layer.cornerRadius = 5;
    self.articleInfoView.clipsToBounds = YES;
    
    //Add spaces to title label
    [self.newsTitleLabel setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self addBlackOverlayOnArticleImage];
    self.webView.opaque = NO;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.tintColor = [UIColor mainAppYellowColor];
    self.webView.scrollView.bounces = YES;
}

-(void)addMoreBtnOnNavigationBar
{
    _plusButtonsViewNavBar = [LGPlusButtonsView plusButtonsViewWithNumberOfButtons:4
                                                           firstButtonIsPlusButton:NO
                                                                     showAfterInit:NO
                                                                     actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                              {
                                 // NSLog(@"actionHandler | title: %@, description: %@, index: %lu", title, description, (long unsigned)index);
                                  if (plusButtonView.hidden == NO) {
                                      if(index==0) {
                                          [self share:nil];
                                      }
                                      else if(index==1) {
                                          [self refreshArticle:nil];
                                      }
                                      else if(index==2) {
                                          [self changeFontTape:nil];
                                      }
                                      else if(index==3) {
                                          [self changeLightTap:nil];
                                      }
                                  }
                              }];
    
    _plusButtonsViewNavBar.showHideOnScroll = NO;
    _plusButtonsViewNavBar.appearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndPop;
    _plusButtonsViewNavBar.position = LGPlusButtonsViewPositionTopRight;
    
    [_plusButtonsViewNavBar setButtonsImages:@[[UIImage imageNamed:@"share"],[UIImage imageNamed:@"refresh"],[UIImage imageNamed:@"editTxt"],[UIImage imageNamed:@"brightness"]] forState:UIControlStateNormal forOrientation:LGPlusButtonsViewOrientationAll];
    
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
-(UIView*) setBannerAdView
{
    UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0,0, Screenwidth, 270)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(300, 250));
    DFPBannerView * bannerView=[[DFPBannerView alloc]initWithAdSize:customAdSize origin:CGPointMake((Screenwidth-300)/2-10, 0)];
    [footerView setBackgroundColor:[UIColor lightGrayAppColor]];
    bannerView.adUnitID = MeduimRectangle_AD_UNIT_ID;
    bannerView.delegate = self;
    bannerView.adSize=customAdSize;
    bannerView.rootViewController = self;
    DFPRequest *request = [DFPRequest request];
    NSMutableArray * list=[[NSMutableArray alloc]init];
    [list addObjectsFromArray:[self getSectionNamesList]];
    [list addObjectsFromArray:[self getRelatedDate]];
    [list addObjectsFromArray:@[@"Inner",@"Article"]];
    [super setscreenAnalyticsMetricsWithScreenName:[NSString stringWithFormat:@"iOS- News Details with News ID =%i",self.newsItem.newsId ] andKeywords:[list componentsJoinedByString:@","]];
    request.customTargeting = [[NSDictionary alloc]initWithObjects:@[list,@[@"Pos1"]] forKeys:@[@"Keyword",@"Position"]];
    
    [bannerView loadRequest:request];
    [footerView addSubview:bannerView];
    return footerView;
}
-(NSArray*)getRelatedDate{
    NSMutableArray * list=[[NSMutableArray alloc]init];
    for (ChampionShipData * champ in self.newsItem.relatedData.championships) {
        [list addObject:[NSString stringWithFormat:@"بطولة %@",champ.name]];
    }
    for (Player * item in self.newsItem.relatedData.people) {
        [list addObject:[NSString stringWithFormat:@"لاعب %@",item.name]];
    }
    for (MatchCenterDetails * item in self.newsItem.relatedData.matches) {
        [list addObject:[NSString stringWithFormat:@"مباراة %@ و %@",item.homeTeamName,item.awayTeamName]];
    }
    // NSString * outputListStr = [list componentsJoinedByString:@","];
    return [[NSArray alloc]initWithArray:list];
}
-(NSArray*)getSectionNamesList
{
    NSMutableArray * sectionNames=[[NSMutableArray alloc]init];
    for (NewsSectionId * item in self.newsItem.newsSectionId) {
        Section * section =[[Global getInstance]getSectionItemWithSectionID:item.sectionId];
        if(section.sectionName!=nil)
            [sectionNames addObject:[NSString stringWithFormat:@"قسم %@",section.sectionName]];
    }
    return sectionNames;
}
-(void)addBlackOverlayOnArticleImage
{
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, self.TopimageView.frame.size.height)];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [self.TopimageView addSubview:overlay];
}


#pragma mark - Right Navigation Buttons
-(void)setNavigationBtns
{
    // Add rightbar button to refresh match details view
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.bounds = CGRectMake(Screenwidth-20,0,16,18);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentsBtn setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    commentsBtn.bounds = CGRectMake(Screenwidth-70,0,20,20);
    [commentsBtn addTarget:self action:@selector(refreshArticle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * fontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fontBtn setBackgroundImage:[UIImage imageNamed:@"editTxt"] forState:UIControlStateNormal];
    fontBtn.bounds = CGRectMake(Screenwidth-120,0,18,18);
    [fontBtn addTarget:self action:@selector(changeFontTape:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * brightnessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [brightnessBtn setBackgroundImage:[UIImage imageNamed:@"brightness"] forState:UIControlStateNormal];
    brightnessBtn.bounds = CGRectMake(Screenwidth-170,0,28,29);
    [brightnessBtn addTarget:self action:@selector(changeLightTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if(self.parentViewController != nil)
    {
        self.parentViewController.navigationItem.rightBarButtonItems=@[ [[UIBarButtonItem alloc] initWithCustomView:shareButton], [[UIBarButtonItem alloc] initWithCustomView:commentsBtn], [[UIBarButtonItem alloc] initWithCustomView:fontBtn], [[UIBarButtonItem alloc] initWithCustomView:brightnessBtn]];
    }
//    NSLog(@"%@",self.navigationController.viewControllers);
//    NSLog(@"%@",GetAppDelegate().getSelectedNavigationController.viewControllers);
    if([self.navigationController.topViewController isKindOfClass:[NewsDetailsViewController class]])
    {
        self.navigationItem.rightBarButtonItems=@[ [[UIBarButtonItem alloc] initWithCustomView:shareButton], [[UIBarButtonItem alloc] initWithCustomView:commentsBtn], [[UIBarButtonItem alloc] initWithCustomView:fontBtn], [[UIBarButtonItem alloc] initWithCustomView:brightnessBtn]];
    }
    
}

//change font
-(void)changeFont:(UIView *) view{
    for (id View in [view subviews]) {
        if ([View isKindOfClass:[UILabel class]]) {
            UILabel *lbl=(UILabel*)View;
            [lbl setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:lbl.font.pointSize]];
            
            
        }
        if ([View isKindOfClass:[UIButton class]]) {
            UIButton *lbl=(UIButton*)View;
            [lbl.titleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:lbl.titleLabel.font.pointSize]];
            
        }
        if ([View isKindOfClass:[UIView class]]) {
            [self changeFont:View];
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNewsItem:(NewsItem*)newsItem
{
    self = [super init];
    if (self) {
        
        self.newsItem=newsItem;
        
        // Custom initialization
    }
    return self;
}
- (id)initWithNewsItem:(int)index  withNewsList:(NSMutableArray *)newsList
{
    self = [super init];
    if (self) {
        self.orginalNewsList=newsList;
        if(index<newsList.count)
            self.newsItem=[newsList objectAtIndex:index];
        self.currentNewsIndex=index;
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.navigationController.navigationBar lt_reset];
    [[UINavigationBar appearance] setBarTintColor:[UIColor mainAppDarkGrayColor]];
    
    
}
- (void)dealloc {

    [self.webView stopLoading];
}
-(void)viewDidDisappear:(BOOL)animated
{
    
    
}
-(void) setCommentsBtnRoundCorners
{
    self.commentsBtn.layer.cornerRadius = 6.0;
    self.commentsBtn.clipsToBounds = YES;
}
-(void)loadPostQuareRequest
{
    if(self.postQuareUrlStr != nil && ![self.postQuareUrlStr isEqualToString:@""])
    {
        self.postquareWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self.postquareWebView setTag:4444];
        self.postquareWebView.navigationDelegate=self;
        [self.postquareWebView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",self.postQuareUrlStr]]]];
    }
    
}
-(void)getPostSquarePosts
{
    postSquarePosts = [[NSArray alloc]init];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    // pubid=152986&webid=116602&wid=105912&url=http://www.filgoal.com/articles/293709
    [dic setObject:[NSString stringWithFormat:@"%i",152986] forKey:@"pubid"];
    [dic setObject:[NSString stringWithFormat:@"%i",116602] forKey:@"webid"];
    [dic setObject:[NSString stringWithFormat:@"%i",105912] forKey:@"wid"];
    [dic setObject:[NSString stringWithFormat:@"http://www.filgoal.com/articles/%i",self.newsItem.newsId] forKey:@"url"];
    
    [WServicesManager getDataWithURLString:POSTSQUARE_BASE_URL andParameters:dic WithObjectName:nil andAuthenticationType:NoAuth success:^(NSDictionary *newsData){
        PostSquareClass * posts=[[PostSquareClass alloc]initWithDictionary:newsData];
        
        if(posts.recs.count>0)
        {
            NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[posts.recs] forKeys:@[@"محتوي قد يعجبك"]];
            [sectionsList insertObject:dic atIndex:0];
            postSquarePosts = posts.recs;
            
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            self.tableViewHeightConstraint.constant=self.tableView.contentSize.height;
        }
        
        
    } failure:^(NSError *error) {
        IBGLog(@"Postquare  Error  : %@",error);
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        
        NSInteger statusCode = response.statusCode;
        IBGLog(@"StatusCode  Error  : %ld",(long)statusCode);
        
        
        
    }];
}

-(BOOL)compareCurrentTimeWithAPITime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *date1= [NSDate date];
    NSTimeInterval timeDifference = [date1 timeIntervalSinceDate:apiFireDate];
    
    double seconds = timeDifference;
    if(seconds>5)
        return YES;
    
    else
        return NO;
    
}
-(void)loadViewsFromNewsItemWithRelatedList:(int)currentList{
    
    [self.activityIndicator startAnimating];
    
    [self.newsDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.newsDateLabel.font.pointSize]];
    [self.newsWriterTxt setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.newsWriterTxt.font.pointSize]];
    self.currentRelatedList=currentList;
    self.newsTitleLabel.text=[NSString stringWithFormat:@"\u200F%@",self.newsItem.newsTitle];
    if ([self.newsItem.newsWriter isEqualToString:@""]) {
        
        self.writerImageView.hidden=YES;
    }
    else{
        self.writerImageView.hidden=NO;
        // self.newsWriterTxt.text = [NSString stringWithFormat:@"بقلم / %@", self.newsItem.newsWriter];
    }
    self.newsDateLabel.text=self.newsItem.newsDate;
    
    
    self.newsItem.newsDescription=[self.newsItem.newsDescription stringByReplacingOccurrencesOfString:@"\"//www.youtube.com" withString:@"\"http://www.youtube.com"];

    [self loadHtmlStringToWKWebView];
    
    if(self.newsItem.images!=nil&&self.newsItem.images.count>0){
        
        Images *imageItem =[self.newsItem.images objectAtIndex:0];
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:imageItem.large] placeholderImage:[UIImage imageNamed:@"place_holder_main_article_img.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    else if(self.newsItem.smallImage!=nil){
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:self.newsItem.smallImage] placeholderImage:[UIImage imageNamed:@"place_holder_main_article_img.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }

    if(self.newsItem.isRedirect&&self.newsItem.redirectionUrl!=nil)
    {
        [UniversalLinks handleUniversalLinksWithUrlString:self.newsItem.redirectionUrl andIsRedirectedUrl:YES];
    }
}

-(void)loadHtmlStringToWKWebView
{
    NSString *strBody;
    NSString *strCssHead = [NSString stringWithFormat:@"<head>"
                            "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,maximum-scale=0.8\">""<script src=http://platform.twitter.com/widgets.js> </script> <script src=http://platform.instagram.com/en_US/embeds.js></script>"
                            "<link rel=\"stylesheet\" type=\"text/css\" href=\"iPhone.css\">"
                            "<link href=\"http://api.filgoal.com/assets/dist/css/lightslider/css/lightslider.min.css\" rel=\"stylesheet\" />"
                            " <link href=\"http://api.filgoal.com/assets/dist/css/style.min.css\" rel=\"stylesheet\" />"
                            "</head>"];
    if([self.textColor isEqualToString:@"white"])
    {
        strBody= [NSString stringWithFormat:@"<style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #f0a306; }img{width:100%%; height:auto}iFrame{ width : 100%%}</style><body><div id='content' dir='rtl' name='content'>%@</div><script src=\"http://api.filgoal.com/assets/dist/js/custom.min.js\"></script></body>",self.fontSize,self.textColor, @"DINNextLTW23Regular",self.newsItem.newsDescription];

    }
    else
    {
        strBody= [NSString stringWithFormat:@"<style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #f0a306; }img{width:100%%; height:auto}iFrame{ width : 100%%}</style><body><div id='content' dir='rtl' name='content'>%@</div><script src=\"http://api.filgoal.com/assets/dist/js/custom.min.js\"></script></body>",self.fontSize,[UIColor blackColor], @"DINNextLTW23Regular",self.newsItem.newsDescription];
    }
    self.webView.tintColor = [UIColor mainAppYellowColor];
    webViewHeight = 100;
    self.webViewHeightConstraint.constant = 100;
  //  self.webView.frame=CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, Screenwidth-44, webViewHeight) ;
   // self.webView.frame= CGRectMake(0, 0, self.webViewSubView.frame.size.width, webViewHeight);
    [self.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",strCssHead,strBody]
                         baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iPhone" ofType:@"css"]]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.bgcolor=[Global getInstance].bgcolor;
    [self changeFont:self.view];
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    if(self.newsItem.newsId != 0)
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
        if([self.navigationController.topViewController isKindOfClass:[NewsDetailsViewController class]])
        {
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:moreBtn];
        }
        
    }
    else
        self.parentViewController.navigationItem.rightBarButtonItems=nil;
    [self setMainSponsor];
    
}
-(void)addPullToRefresh
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    scrollView.userInteractionEnabled = TRUE;
    scrollView.scrollEnabled = TRUE;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(500, 1000);
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-20, 5, Screenwidth, 20)];
    [self.refreshControl addTarget:self action:@selector(refreshArticle:) forControlEvents:UIControlEventValueChanged];
    [self.scrollContent addSubview:self.refreshControl];
    
}
- (void)refreshArticle:(UIRefreshControl *)refreshControl
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    if([self compareCurrentTimeWithAPITime])
    {
        [self LoadNewsItem];
    }
    else
        [self.refreshControl endRefreshing];
    
    // remove all cached wkwebview
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
    NSError *errors;
    [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    
    [self setGoogleAnalyticsScreens];
    
    
}
-(void) setGoogleAnalyticsScreens
{
    if(self.isFromPushNotification)
    {
        self.isFromPushNotification=NO;
        self.screenName=   [NSString stringWithFormat:@"iOS- Push- News Details with News ID =%i",self.newsItem.newsId ];
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Push- News Details with News ID =%i",self.newsItem.newsId ]
                                         }];
        
        
    }
    else if (self.isFromNewsWidget)
    {
        self.isFromNewsWidget=NO;
        self.screenName=   [NSString stringWithFormat:@"iOS- Widget - News Details with News ID =%i",self.newsItem.newsId ];
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Widget - News Details with News ID =%i",self.newsItem.newsId ]
                                         }];
    }
    else
    {
        self.screenName=   [NSString stringWithFormat:@"iOS- News Details with News ID =%i",self.newsItem.newsId ];
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName:[NSString stringWithFormat:@"iOS- News Details with News ID =%i",self.newsItem.newsId ]
                                         }];
        
    }
    
    
}

-(void) addBannersSliderView
{
    if([Global getInstance].appInfo.specialSection.isActive&&[Global getInstance].appInfo.specialSection.isNewsDetailsBannersActive)
    {
        self.bannersSliderView.hidden=NO;
        BannersSliderViewController * sliderView=[[BannersSliderViewController alloc]init];
        sliderView.isFromHome=NO;
        sliderView.view.frame=CGRectMake(0, 10, self.bannersSliderView.frame.size.width,100);
        [self addChildViewController:sliderView];
        [self.bannersSliderView addSubview:sliderView.view];
        self.bannerSliderHeightConstraint.constant=120;
        [self didMoveToParentViewController:sliderView];
    }
    else
    {
        self.bannerSliderHeightConstraint.constant=0;
        self.bannersSliderView.hidden=YES;
    }
    
}

-(void)clearMemory
{
    [self.webView stopLoading];
    self.webView=nil;
    //  [self.webView loadHTMLString:@"" baseURL:nil];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    
    
    
}


-(void)setCoSponsorScreenSponsor
{
    self.sponser.hidden=YES;
    for (NewsSectionId *nsec in self.newsItem.newsSectionId) {
        if([AppSponsors isSectionCoSponsorActiveUsingId:nsec.sectionId])
        {
            self.sponser.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:nsec.sectionId category: @"News"];
            sponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSectionBannerStripeImagePathUsingSectionId:nsec.sectionId andContentType:@"News"]];
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
    for (NewsSectionId *nsec in self.newsItem.newsSectionId) {
        if([AppSponsors isSectionActiveUsingId:nsec.sectionId])
        {
            mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSpecialSectionBannerImagePathUsingId:nsec.sectionId]];
            [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id: nsec.sectionId  activeCategory: nil];
            return;//break;
        }
    }
    if((mainSponsorUrl==nil||[mainSponsorUrl isEqualToString:@""])&&[AppSponsors isNewsSponsorContentActive])
    {
        if(self.newsItem.newsTypeId==newsType) {
            mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"News"]];
            [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id: nil  activeCategory: @"News"];
        } else if(self.newsItem.newsTypeId==freeOpinionType) {
            mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"FreeOpinions"]];
            [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id: nil  activeCategory: @"FreeOpinions"];
        }
    }
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];

}

-(void)LoadNewsItem{
    // Postquare
    sectionsList = [[NSMutableArray alloc]init];
    self.relatedVideosList = [[NSMutableArray alloc]init];
    self.relatedNewsList = [[NSMutableArray alloc]init];
    
    if(appInfo.isPostquareActive)
        [self getPostSquarePosts];
    
    if(self.canLoadMore==YES){
        NSDictionary *dictionary;
        if(self.refreshControl.isRefreshing)
        {
            dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",self.newsItem.newsId],[NSNumber numberWithBool:YES], nil] forKeys:[NSArray arrayWithObjects:@"id",@"ISREFRESH", nil] ];
            
        }
        else
        {
            dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%i",self.newsItem.newsId],[NSNumber numberWithBool:NO], nil] forKeys:[NSArray arrayWithObjects:@"id",@"ISREFRESH", nil] ];
        }
        if(alertView != nil)
        {
            [self.activityIndicator startAnimating];
            [alertView close];
            alertView = nil;
        }
        self.canLoadMore=NO;
        [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
        [self.activityIndicator startAnimating];
        
        [WServicesManager getDataWithURLString:[NSString stringWithFormat:NewsDetailsAPI,[WServicesManager getApiBaseURL]] andParameters:[[NSMutableDictionary alloc]initWithDictionary:dictionary] WithObjectName:@"NewsItem" andAuthenticationType:CMSAPIs success:^(NewsItem *newsItem)
         {
             if(alertView != nil)
                 [alertView close];
             apiFireDate = [NSDate date];
             if(self.refreshControl.isRefreshing)
             {
                 [self.refreshControl endRefreshing];
             }
             // ///Author
             
             if (newsItem.newsDescription==nil&&(self.newsItem.newsDescription==nil||[self.newsItem.newsDescription isEqualToString:@""])) {
                 
                 UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"لا يوجد محتوي لهذا الموضوع" message:nil delegate:self cancelButtonTitle:@"موافق" otherButtonTitles:nil];
                 [message show];
                 // [self.navigationController popViewControllerAnimated:YES];
                 
                 
             }
             else{
                 [self.relatedVideosList addObjectsFromArray:newsItem.relatedVideos];
                 [self.relatedNewsList addObjectsFromArray: newsItem.relatedNews];
                 if(self.relatedNewsList.count>0)
                 {
                     // [sections setObject:self.relatedNewsList forKey:@"أخبار متعلقة"];
                     NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[self.relatedNewsList] forKeys:@[@"أخبار متعلقة"]];
                     [sectionsList addObject:dic];
                 }
                 if(newsItem.authorRelatedOpinions.count>0)
                 {
                     // [sections setObject:self.relatedNewsList forKey:@"أخبار متعلقة"];
                     NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[newsItem.authorRelatedOpinions] forKeys:@[@"مقالات أخري للكاتب"]];
                     [sectionsList addObject:dic];
                 }
                 if(newsItem.relatedAlbums.count>0)
                 {
                     // [sections setObject:self.relatedNewsList forKey:@"أخبار متعلقة"];
                     NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[newsItem.relatedAlbums] forKeys:@[@"صور متعلقة"]];
                     [sectionsList addObject:dic];
                 }
                 if(self.relatedVideosList.count>0)
                 {
                     // [sections setObject:self.relatedVideosList forKey:@"فيديوهات متعلقة"];
                     NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[self.relatedVideosList] forKeys:@[@"فيديوهات متعلقة"]];
                     [sectionsList addObject:dic];
                 }
                 
                 if(sectionsList.count>0)
                 {
                     [self.tableView reloadData];
                     [self.tableView layoutIfNeeded];
                 }
                 self.canLoadMore=YES;
                 self.tableViewHeightConstraint.constant=self.tableView.contentSize.height;
                 [self.indLoader stopAnimating];
                 [self.indLoader setHidden:YES];
                 [self.tableView setHidden:NO];
                 [self.loadingLabel setHidden:YES];
                 self.newsItem=newsItem;
                 [self setAuthorsLbl];
                 [self setCoSponsorScreenSponsor];
                 [self loadViewsFromNewsItemWithRelatedList:1];
                 [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"News Details with ID = %i ",self.newsItem.newsId] ApiError:@"Success"];
                 
             }
             
         } failure:^(NSError *error) {
             self.canLoadMore=YES;
             [self.indLoader stopAnimating];
             [self.indLoader setHidden:YES];
             self.loadingLabel.text=@"لم يتم العثور علي اخبار";
             IBGLog(@"News Details response : %@",error);
             [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"News Details with ID = %i ",self.newsItem.newsId] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
             [self showDefaultNetworkingErrorMessageForError:error
                                              refreshHandler:^{
                                                  [self LoadNewsItem];
                                              }];
             
             
             
         }];
    }
}

////////////////
#pragma mark - Handle Author Name
-(NSString*)getAuthorsNameString
{
    NSString * authorName=[[NSString alloc]init];;
    for(int i=0;i<self.newsItem.authors.count;i++)
    {
        Author * item = [self.newsItem.authors objectAtIndex:i];
        if(i==self.newsItem.authors.count-1)
        {
            authorName=[authorName stringByAppendingString:item.name];
        }
        else
            authorName=[NSString stringWithFormat:@"%@,",[authorName stringByAppendingString:item.name]];
    }
    return authorName;
}
-(void)setAuthorsLbl
{
    authors = [[self getAuthorsNameString] componentsSeparatedByString:@","];
    self.newsWriterTxt.text = [NSString stringWithFormat:@"بقلم / %@", [self getAuthorsNameString]];
    arrMinMax = [[NSMutableArray alloc] init];
    NSUInteger count = 0;
    for (int i = 0; i <[authors count]; i++) {
        NSString * str =[authors objectAtIndex:i];
        NSUInteger length = count + str.length-1;
        NSMutableDictionary * tempdic = [[NSMutableDictionary alloc]init];
        [tempdic setObject:[NSNumber numberWithUnsignedInteger:count] forKey:@"MinValue"];
        [tempdic setObject:[NSNumber numberWithUnsignedInteger:length] forKey:@"MaxValue"];
        [arrMinMax addObject:tempdic];
        count = length +1;
        
    }
    UITapGestureRecognizer *lblTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapInAuthorLbl:)];
    [self.newsWriterTxt addGestureRecognizer:lblTapRecognizer];
    self.newsWriterTxt.userInteractionEnabled = YES;
    lblTapRecognizer.cancelsTouchesInView = NO;
}

- (void)handleTapInAuthorLbl:(UITapGestureRecognizer *)tapRecognizer
{
    NSUInteger characterIndex;
    NSLayoutManager *layoutManager = _newsWriterTxt.layoutManager;
    CGPoint location = [tapRecognizer locationInView:_newsWriterTxt];
    characterIndex = [layoutManager characterIndexForPoint:location
                                           inTextContainer:_newsWriterTxt.textContainer
                  fractionOfDistanceBetweenInsertionPoints:NULL]-8;
    
    for (int j = 0; j<[arrMinMax count]; j++) {
        if (characterIndex >=[[[arrMinMax objectAtIndex:j] objectForKey:@"MinValue"] integerValue]  && characterIndex <=[[[arrMinMax objectAtIndex:j] objectForKey:@"MaxValue"] integerValue]) {
            Author * authorObj = [self.newsItem.authors objectAtIndex:j];
            if(authorObj.idField != 0)
            {
                AuthorProfileViewController * profileView = [[AuthorProfileViewController alloc]init];
                profileView.author = authorObj;
                [self.navigationController pushViewController:profileView animated:YES];
            }
            //  SelectedProductIndex = j;
        }
    }
    // [self.newsWriterTxt layoutIfNeeded];
    _newsWriterTxt.editable = NO;
}
////////////////////
#pragma mark webView delegate
- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler
{
    if(webView.tag==123456)
    {
        decisionHandler(WKNavigationActionPolicyCancel);
        
    }
    else
    {
        if(navigationAction.navigationType==WKNavigationTypeLinkActivated)
        {
            decisionHandler(WKNavigationActionPolicyAllow);
            NSString * urlToOpen = [NSString stringWithFormat:@"%@",navigationAction.request.URL] ;
            if([urlToOpen rangeOfString:@"/articles"].location  != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"articles/"];
                NewsItem *newsItem=[[NewsItem alloc] init];
                if(elts.count>1)
                    newsItem.newsId=[[elts objectAtIndex:1] intValue];
                newsItem.newsTitle=@"";
                [self.navigationController pushViewController:[[NewsDetailsViewController alloc] initWithNewsItem:newsItem] animated:YES];
                [webView stopLoading];
                
            }
            else if([urlToOpen rangeOfString:@"/videos"].location != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"videos/"];
                VideoItem *videoItem=[[VideoItem alloc] init];
                if(elts.count>1)
                    videoItem.videoId=[[elts objectAtIndex:1] intValue];
                videoItem.videoTitle=@"";
                videoItem.videoUrl=urlToOpen;
                [self.navigationController pushViewController:[[VideoDetailsViewController alloc] initWithVideo:videoItem] animated:YES];
                [webView stopLoading];
                
            }
            else   if([urlToOpen rangeOfString:@"/albums"].location  != NSNotFound){
                Album * albumItem = [[Album alloc]init] ;
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"albums/"];
                if(elts.count>1)
                    albumItem.albumId=[[elts objectAtIndex:1] intValue];
                albumItem.albumTitle=@"";
                GalleryDetailsViewController * viewController=[[GalleryDetailsViewController alloc]init];
                viewController.albumItem = albumItem;
                [self.navigationController pushViewController:viewController animated:YES];
                [webView stopLoading];
            }
            else if([urlToOpen rangeOfString:@"/matches"].location != NSNotFound){
                
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"matches/"];
                MatchCenterDetails *item=[[MatchCenterDetails alloc] init];
                if(elts.count>1)
                    item.idField=[[elts objectAtIndex:1] intValue];
                if(item.idField !=0)
                {
                    MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
                    matchCenter.matchCenterDetails = item;
                    
                    [self.navigationController pushViewController:matchCenter animated:YES];
                    [webView stopLoading];
                }
                else if([urlToOpen rangeOfString:@"matches/?date="].location != NSNotFound){
                    NSArray *elts = [urlToOpen componentsSeparatedByString:@"matches/?date="];
                    if(elts.count>1)
                    {
                        NSString * date= [elts objectAtIndex:1];
                        [self getMatchesByDate:date];
                    }
                    
                    [webView stopLoading];
                    
                }
                
                else
                {
                    if(!self.newsItem.isRedirect)
                    {
                    GlobalViewController * webVieww=[[GlobalViewController alloc]init];
                    webVieww.url=[NSURL URLWithString:urlToOpen];
                    appDelegate.isFullScreen=YES;
                    if(self.navigationController!=nil)
                        [self. navigationController pushViewController:webVieww animated:YES];
                    else
                        [self.parentViewController. navigationController pushViewController:webVieww animated:YES];
                    }
                    else
                    {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlToOpen]];
                    }
                    [webView stopLoading];
                    
                }
                //  [webView stopLoading];
                
                //  decisionHandler(WKNavigationActionPolicyCancel);
                
                
            }
            else if([urlToOpen rangeOfString:@"News.aspx?NewsID"].location  != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"NewsID="];
                NewsItem *newsItem=[[NewsItem alloc] init];
                if(elts.count>1)
                    newsItem.newsId=[[elts objectAtIndex:1] intValue];
                newsItem.newsTitle=@"";
                [self.navigationController pushViewController:[[NewsDetailsViewController alloc] initWithNewsItem:newsItem] animated:YES];
                [webView stopLoading];
                decisionHandler(WKNavigationActionPolicyCancel);
            }
            else if([urlToOpen rangeOfString:@"/VideoView.aspx?AudioVideoID"].location != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"AudioVideoID="];
                VideoItem *videoItem=[[VideoItem alloc] init];
                if(elts.count>1)
                    videoItem.videoId=[[elts objectAtIndex:1] intValue];
                videoItem.videoTitle=@"";
                videoItem.videoUrl=urlToOpen;
                [self.navigationController pushViewController:[[VideoDetailsViewController alloc] initWithVideo:videoItem] animated:YES];
                [webView stopLoading];
                decisionHandler(WKNavigationActionPolicyCancel);
            }
            else
            {
                /*  GlobalViewController * webView=[[GlobalViewController alloc]init];
                 webView.url=[NSURL URLWithString:urlToOpen];
                 appDelegate.isFullScreen=YES;
                 if(self.navigationController!=nil)
                 [self. navigationController pushViewController:webView animated:YES];
                 else
                 [self.parentViewController. navigationController pushViewController:webView animated:YES];*/
                if(!self.newsItem.isRedirect)
                {
                SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress:urlToOpen];
                appDelegate.isFullScreen=YES;
                if(self.navigationController!=nil)
                    [self. navigationController pushViewController:webViewController animated:YES];
                else
                    [self.parentViewController. navigationController pushViewController:webViewController animated:YES];
                }
                else
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlToOpen]];
                }
                [webView stopLoading];
                //  decisionHandler(WKNavigationActionPolicyCancel);
            }
            
            
            
        }
        else
        {
            decisionHandler(WKNavigationActionPolicyAllow);
            
            // WKNavigationTypeOther
            
        }
    }
}
-(void)getMatchesByDate:(NSString*)selectedDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date =[outputFormatter dateFromString: selectedDate];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:date];
    [components setDay:[components day]-1];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSDate * afterDate = [gregorian dateFromComponents:components];
    MatchesByDateViewController * viewController = [[MatchesByDateViewController alloc]init];
    viewController.selectedDateStr = [outputFormatter stringFromDate:date];
    viewController.dayBeforeSelectedDateStr = [outputFormatter stringFromDate:afterDate];
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}
-(IBAction)changeLightTap:(id)sender{
    
    if (isPressed) {
        isPressed=NO;
        self.bgcolor=[UIColor blackColor];
        self.textColor=@"white";
        self.contentView.tag=1;
        [self.contentView setBackgroundColor:self.bgcolor];
        [self.wkWebSubView setBackgroundColor:self.bgcolor];
        [self.webViewSubView setBackgroundColor:self.bgcolor];
        [self.titleView setBackgroundColor:self.bgcolor];
        [self.newsTitleLabel setTextColor:[UIColor whiteColor]];
         [self.newsDateLabel setTextColor:[UIColor whiteColor]];
    }
    else{
        isPressed=YES;
        self.bgcolor=[UIColor whiteColor];
        self.textColor=@"Black";
        self.contentView.tag=0;
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.wkWebSubView setBackgroundColor:self.bgcolor];
        [self.webViewSubView setBackgroundColor:self.bgcolor];
        [self.titleView setBackgroundColor:self.bgcolor];
        [self.newsTitleLabel setTextColor:[UIColor blackColor]];
        [self.newsDateLabel setTextColor:[UIColor greyColor]];
    }
    [Global getInstance].bgcolor=self.bgcolor;
    [Global getInstance].textColor=self.textColor;
    [self loadHtmlStringToWKWebView];
    //    NSString *strCssHead = [NSString stringWithFormat:@"<head>"
    //                            "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,maximum-scale=1\">""<script src=http://platform.twitter.com/widgets.js> </script> <script src=http://platform.instagram.com/en_US/embeds.js></script>"
    //                            "<link rel=\"stylesheet\" type=\"text/css\" href=\"iPhone.css\">"
    //                            "</head>"];
    //
    //    NSString *strBody= [NSString stringWithFormat:@"<style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #172983; }iFrame { width : 100%%}</style><body><div id='content' dir='rtl' name='content'>%@</div></body>",self.fontSize,[UIColor greyColor], @"DINNextLTW23Regular",self.newsItem.newsDescription];
    //
    //    [self.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",strCssHead,strBody]
    //                         baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iPhone" ofType:@"css"]]];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(webView.tag==123456)
    return;
    if(webView.tag == 4444)
    {
        [webView stopLoading];
        return;
    }
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    webViewHeight = [result intValue];
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:NO];
    self.webViewHeightConstraint.constant=webViewHeight;
    [self.activityIndicator stopAnimating];
    webView.frame=self.webView.frame;
    [self.view updateConstraintsIfNeeded];
    [self.tableView updateConstraintsIfNeeded];

    [self addBannersSliderView];
    
}

- (IBAction)commentsBtnAction:(id)sender {
    GlobalViewController * webView=[[GlobalViewController alloc]init];
    webView.url=[NSURL URLWithString:[NSString stringWithFormat:DISQUS_URL,@"article",self.newsItem.newsId]];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)adViewDidReceiveAd:(DFPBannerView *)adView {
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    
}
/// Tells the delegate an ad request failed.
- (void)adView:(DFPBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
}
#pragma mark tableView deleg
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionsList.count;
    
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
    
    if(sectionsList.count>0)
    {
        NSDictionary * dic = [sectionsList objectAtIndex:section];
        [title setText:[dic.allKeys objectAtIndex:0]];
    }
    
    [headerView addSubview:title];
    return headerView;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // return [(NSArray*)[[sections allValues]objectAtIndex:section]count];
    NSDictionary * dic = [sectionsList objectAtIndex:section];
    NSArray * list;
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    return list.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCustomCell *cell;
    NSDictionary * dic = [sectionsList objectAtIndex:indexPath.section];
    NSArray * list;
    if(dic.allValues.count>0)
        list = dic.allValues[0];
    
    if ([[list objectAtIndex:indexPath.row] isKindOfClass:[NewsItem class]]) {
        NewsItem *item=[list objectAtIndex:indexPath.row ];
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
    else if ([[list objectAtIndex:indexPath.row] isKindOfClass:[VideoItem class]]) {
        VideoItem *item=[list objectAtIndex:indexPath.row ];
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
    else if ([[list objectAtIndex:indexPath.row] isKindOfClass:[Album class]]) {
        Album *item=[list objectAtIndex:indexPath.row ];
        NewsCustomCell *cell;
        if (cell == nil)
        {
            cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
            cell.hideDeleteBtn = YES;
            cell.playImg.image = [UIImage imageNamed:@"ic_album"];
            cell.playImg.hidden=NO;
            
        }
        Picture * firstPictureItem;
        if(item.pictures.count>0)
            firstPictureItem=[item.pictures objectAtIndex:0];
        [((NewsCustomCell*)cell).itemLbl setText:item.albumTitle];
        ((NewsCustomCell*)cell).dateLabel.hidden = YES;
        
        [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:firstPictureItem.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [((NewsCustomCell*)cell).activityIndicator stopAnimating];
        }];
        
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
    NSDictionary * dic = [sectionsList objectAtIndex:indexPath.section];
    NSArray * list = dic.allValues[0];
    
    if ([[list objectAtIndex:indexPath.row] isKindOfClass:[Rec class]])
    {
        Rec * postSqureItem=[postSquarePosts objectAtIndex:indexPath.row ];
        if(postSqureItem.postId ==0)
            return 70;
        
    }
    return 112;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = [sectionsList objectAtIndex:indexPath.section];
    NSArray * list = dic.allValues[0];
    
    if ([[list objectAtIndex:indexPath.row] isKindOfClass:[Rec class]])
    {
        Rec * item =[list objectAtIndex:indexPath.row];
        NewsItem * newsItem ;
        VideoItem * videoItem ;
        if(item.postId==0)
        {
        }
        else
        {
            NSString *urlToOpen = [NSString stringWithFormat:@"%@",item.url];
            
            if([urlToOpen rangeOfString:@"/articles"].location  != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"articles/"];
                newsItem=[[NewsItem alloc] init];
                if(elts.count>1)
                    newsItem.newsId=[[elts objectAtIndex:1] intValue];
                newsItem.newsTitle=item.title;
                NewsDetailsViewController * newsDetailsScreenWebView=[[NewsDetailsViewController alloc] initWithNewsItem:newsItem ];
                newsDetailsScreenWebView.postQuareUrlStr = item.clickUrl;
                [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
            }
            else   if([urlToOpen rangeOfString:@"/videos"].location  != NSNotFound){
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"videos/"];
                videoItem=[[VideoItem alloc] init];
                if(elts.count>1)
                    videoItem.videoId=[[elts objectAtIndex:1] intValue];
                videoItem.videoTitle=item.title;
                VideoDetailsViewController * newsDetailsScreenWebView=[[VideoDetailsViewController alloc]initWithVideo:videoItem];
                newsDetailsScreenWebView.postQuareUrlStr = item.clickUrl;
                [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
            }
            else   if([urlToOpen rangeOfString:@"/albums"].location  != NSNotFound){
                Album * albumItem = [[Album alloc]init] ;
                NSArray *elts = [urlToOpen componentsSeparatedByString:@"albums/"];
                if(elts.count>1)
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
    else if (dic.allKeys.count>0 &&[[dic.allKeys objectAtIndex:0] isEqualToString:@"مقالات أخري للكاتب"]&& [[list objectAtIndex:indexPath.row]isKindOfClass:[NewsItem class]])
    {
        NewsItem * item =[list objectAtIndex:indexPath.row];
        NewsDetailsViewController * newsDetailsScreenWebView=[[NewsDetailsViewController alloc] initWithNewsItem:item ];
        [GetAppDelegate().getSelectedNavigationController pushViewController:newsDetailsScreenWebView animated:YES];
    }
    else if (list.count>0 && [[list objectAtIndex:indexPath.row]isKindOfClass:[NewsItem class]]) {
        self.relatedNewscurrentIndex= (int)indexPath.row;
        self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];self.pageController.view.backgroundColor=[UIColor blackColor];
        self.pageController.view.backgroundColor=[UIColor blackColor];
        
        self.pageController.dataSource = self;
        self.pageController.view.frame=self.view.bounds;
        NSArray *viewControllers = [NSArray arrayWithObject:[[NewsDetailsViewController alloc]initWithNewsItem:indexPath.row withNewsList:list]];
        if (viewControllers.count>0) {
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            if(self.parentViewController.navigationController==nil)
            {
                [self.navigationController pushViewController:self.pageController animated:YES];
            }
            else
            {
                [self.parentViewController.navigationController pushViewController:self.pageController animated:YES];
            }
            
        }
    }
    else if([[list objectAtIndex:indexPath.row] isKindOfClass:[Album class]])
    {
        Album *item =[list objectAtIndex:indexPath.row];
        GalleryDetailsViewController * detailsVC = [[GalleryDetailsViewController alloc]init];
        detailsVC.albumItem = item;
        [self.navigationController pushViewController:detailsVC animated:YES];
        
    }
    
    else if (list.count>0 && [[list objectAtIndex:indexPath.row]isKindOfClass:[VideoItem class]]) {
        
        self.relatedVideosCurrentIndex= (int)indexPath.row;
        
        self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];self.pageController.view.backgroundColor=[UIColor blackColor];
        self.pageController.dataSource = self;
        self.pageController.view.frame=self.view.bounds;
        NSArray *viewControllers = [NSArray arrayWithObject:[[VideoDetailsViewController alloc] initWithVideoIndex:self.relatedVideosCurrentIndex withVideosList:list]];
        if (viewControllers.count>0) {
            
            [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
            if(self.parentViewController.navigationController==nil)
            {
                [self.navigationController pushViewController:self.pageController animated:YES];
            }
            else
            {
                [self.parentViewController.navigationController pushViewController:self.pageController animated:YES];
            }
            
        }
        
        
        
    }
    
    
}

- (float) appVersion
{
    return [[[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]floatValue];
}

#pragma mark UIPageViewController dataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (self.currentRelatedList==1) {
        if([Global getInstance].appInfo.adsRepeatCount<=0)
        {
            itemsWithAdsArray=[[NSMutableArray alloc]initWithArray:self.relatedNewsList];
            
        }
        
        int index = [(NewsDetailsViewController *)viewController currentNewsIndex];
        index--;
        
        if (index == NSNotFound||index<0) {
            return nil;
        }
        else{
            NewsDetailsViewController *childViewController = [[NewsDetailsViewController alloc] initWithNewsItem:index withNewsList:itemsWithAdsArray];
            
            
            return childViewController;
        }
        
    }
    
    else{
        int index = [(VideoDetailsViewController *)viewController currentNewsIndex];
        index--;
        
        if (index<0) {
            return nil;
        }
        else{
            VideoDetailsViewController *childViewController = [[VideoDetailsViewController alloc] initWithVideoIndex:index withVideosList:self.relatedVideosList] ;
            
            
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
            NewsDetailsViewController *childViewController = [[NewsDetailsViewController alloc] initWithNewsItem:index withNewsList:self.relatedNewsList];
            return childViewController;
        }
        
    }
    
    else{
        int index = [(VideoDetailsViewController *)viewController currentNewsIndex];
        index++;
        if (index>=self.relatedVideosList.count) {
            return nil;
        }
        else{
            
            VideoDetailsViewController *childViewController = [[VideoDetailsViewController alloc] initWithVideoIndex:index withVideosList:self.relatedVideosList] ;
            return childViewController;
        }
        
    }
    return nil;
}


- (NewsDetailsViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    NewsDetailsViewController *childViewController = [[NewsDetailsViewController alloc] initWithNewsItem:index withNewsList:self.orginalNewsList];
    
    
    return childViewController;
    
}
#pragma Btn Action
-(IBAction)changeFontTape:(id)sender{
    
    
    if (self.fontSize==31) {
        self.fontSize=17;
    }
    else{
        self.fontSize = ( self.fontSize >= 27) ?  self.fontSize -7 :  self.fontSize+7;
    }
    [Global getInstance].fontSize=self.fontSize;
    // [self.newsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:self.fontSize+6]];
    [self loadViewsFromNewsItemWithRelatedList:self.currentRelatedList];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [self.webView stopLoading];
    // Dispose of any resources that can be recreated.
}
-(IBAction)share:(id)sender{
    
    NSString *text =self.newsItem.newsTitle;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.filgoal.com/articles/%i",self.newsItem.newsId]];
    
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





- (BOOL)shouldAutorotate {
    return YES;
    
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if(message.body)
    {
    }
    
}



#pragma mark - Create Custom Dialogue
- (void)showReloadAlert
{
    alertView = [[CustomIOSAlertView alloc] init];
    ReloadViewController * reloadViewController = [[ReloadViewController alloc]init];
    [alertView setContainerView:reloadViewController.view];
    _canLoadMore = YES;
    [reloadViewController.retryBtn addTarget:self action:@selector(LoadNewsItem) forControlEvents:UIControlEventTouchUpInside];
    [alertView setButtonTitles:nil];
    [alertView setUseMotionEffects:true];
    [alertView show];
}
-(void) checkErrorCode :(NSError*) error
{
    if ([[error domain] isEqualToString:NSURLErrorDomain]) {
        switch ([error code]) {
            case NSURLErrorNetworkConnectionLost|NSURLErrorCannotConnectToHost:
            {
                if(failuresCount<3)
                {
                    [self.activityIndicator startAnimating];
                    [self.indLoader startAnimating];
                    [self LoadNewsItem];
                    failuresCount++;
                }
                else
                {
                    if(alertView == nil)
                        [self showReloadAlert];
                }
                IBGLog(@"%@", [NSString stringWithFormat:@"Failure %ld",(long)failuresCount]);
                break;
                
            }
            default:
            {
                if(alertView == nil)
                    [self showReloadAlert];
                
                break;
            }
        }
    }
    
}






@end
