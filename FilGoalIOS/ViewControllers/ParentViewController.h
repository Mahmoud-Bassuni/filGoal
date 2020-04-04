//
//  ParentViewController.h
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 9/11/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "Global.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <WebKit/WebKit.h>
//@import GoogleMobileAds;
//@import GoogleInteractiveMediaAds;

@interface ParentViewController : GAITrackedViewController <UIWebViewDelegate,NSURLConnectionDataDelegate,WKNavigationDelegate,GADInterstitialDelegate,GADBannerViewDelegate>{
    BOOL isEffectiveMeasurementLoadedOnce;
}
//For Sponsor
@property (assign) NSInteger champs_id;
@property (assign) NSInteger section_id;
@property (strong, nonatomic) NSString *activeCategory;

@property(nonatomic,strong) DFPBannerView  *bannerView;
@property(nonatomic,strong) WKWebView *effectiveMeasurementWebView;
@property (strong,nonatomic) GADInterstitial * interstitialAd;
@property (nonatomic) CGFloat previousScrollViewYOffset;
-(UIView*)setBannerViewFooter :(NSArray*)keywords andPosition:(NSArray*)postions andScreenName:(NSString*)screenName;
- (void)sendAppSpeedTimeIntervalWithTime:(NSTimeInterval)loadTime AndScreenName:(NSString*)screenName ApiError:(NSString *)apiStatus;
-(void)setscreenAnalyticsMetricsWithScreenName:(NSString*)screenName andKeywords:(NSString*)keywords;
- (NSString *) appVersion;
- (NSTimeInterval)stopMeasuring;
-(void)setNavigationBarBackgroundImage;
-(void)setTransparentUINavigationBar;
-(void)setFilGoalNavigationBar;
-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl champs_id:(NSInteger)champs_id section_id:(NSInteger)section_id activeCategory:(NSString*)activeCategory;
-(void)setNavigationBarBackgroundFromChildViewControllerImageStr:(NSString*)mainSponsorUrl champs_id:(NSInteger)champs_id section_id:(NSInteger)section_id activeCategory:(NSString*)activeCategory;

-(void)hideSponsorBanner:(UIView*)fullView;
-(void)setUpBannerUnderNav:(UIView*)fullView anotherTopView:(nullable UIView*)anotherTopView;
//-(void)setUpBannerUnderNavInPlace:(UIView*)fullView newPlaceView:(UIView*)newPlaceView;
//-(void)setUpBannerUnderNavBetween:(UIView*)fullView firstV:(UIView*)firstV secondV:(UIView*)secondV;
@end
