//
//  PagerAdsViewController.m
//  Reyada
//
//  Created by Ali Adam on 10/4/15.
//  Copyright (c) 2015 Sarmady. All rights reserved.
//
//@import GoogleMobileAds;
#import <GoogleMobileAds/GoogleMobileAds.h>

#import "PagerAdsViewController.h"
#include <stdlib.h>
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "GAITrackedViewController.h"
#import "VungleAdNetworkExtras.h"
//#import "EmTracker.h"

@interface PagerAdsViewController () <GADInterstitialDelegate, UIAlertViewDelegate,UIWebViewDelegate>

/// The interstitial ad.
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation PagerAdsViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    //[[EmTracker sharedInstance] trackDefault];

    if([[Global getInstance]appInfo].isBannerAdsEnabled)
    {
    self.bannerView.hidden=NO;

    [self createMeduimRectangleBanners];
    }
    else
    {
        self.bannerView.hidden=YES;
        [self createAndLoadInterstitial];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    self.parentViewController.navigationItem.rightBarButtonItems=nil;
//    self.navigationItem.rightBarButtonItems=nil;
//       GetAppDelegate().getSelectedNavigationController.topViewController.parentViewController.navigationItem.rightBarButtonItems=nil;
//    NSLog(@"%@",self.parentViewController);
//    NSLog(@"%@",self.parentViewController.navigationItem.rightBarButtonItems);
//    NSLog(@"%@",self.navigationItem.rightBarButtonItems);
//    self.parentViewController.navigationItem.rightBarButtonItems=nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)createMeduimRectangleBanners
{
    GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(300, 250));

    self.bannerView.adUnitID = MeduimRectangle_AD_UNIT_ID;
    self.bannerView.delegate=self;
    self.bannerView.adSize=customAdSize;
    self.bannerView.rootViewController = self;
    // Initiate a generic request to load it with an ad.
    [self.bannerView loadRequest:[GADRequest request]];
}
- (void)createAndLoadInterstitial {
    
    self.interstitial =[[GADInterstitial alloc] initWithAdUnitID:Pager_AD_UNIT_ID];
   // self.interstitial =[[GADInterstitial alloc] initWithAdUnitID:Test_AD_UNIT_ID];

    // /2023622/Reyada-app-interstitial
    self.interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    VungleAdNetworkExtras *extras = [[VungleAdNetworkExtras alloc] init];
    extras.allPlacements = @[@"DEFAULT04352"];
    [request registerAdNetworkExtras:extras];
    [self.interstitial loadRequest:request];
}

#pragma mark UIAlertViewDelegate implementation
- (void)adView:(DFPBannerView *)banner didFailToReceiveAdWithError:(GADRequestError *)error
{
    //  [self.errorLbl setText:[NSString stringWithFormat:@"%@",error]];
    
}
- (void)adViewDidReceiveAd:(DFPBannerView *)bannerView
{
    
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad

{
    NSLog(@"adNetworkClassName %@",ad.adNetworkClassName);
    UIViewController *gadInterstitialViewController=(UIViewController *)[ad valueForKey:@"_viewController"] ;
    UIView  *adView=[gadInterstitialViewController valueForKey:@"_adView"];

    gadInterstitialViewController.view.backgroundColor = [UIColor whiteColor];
    gadInterstitialViewController.view.frame=CGRectMake(0,0, Screenwidth, Screenheight);
    adView=[gadInterstitialViewController valueForKey:@"_adView"];
    UIButton *closeBtn=[gadInterstitialViewController valueForKey:@"_closeButton"];
    closeBtn.hidden=true;
    adView.frame=CGRectMake(0,0, self.view.frame.size.width,  Screenheight);
    adView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:adView];
    
    [UIView transitionWithView:adView
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        adView.alpha = 1.0;
                    }
                    completion:^(BOOL finished){
                    }];

    
}

-(void)viewSlideInFromRightToLeft:(UIView *)views
{
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.2;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromRight;
    transition.delegate = self;
    [views.layer addAnimation:transition forKey:nil];
}

-(void)viewSlideInFromLeftToRight:(UIView *)views
{
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.2;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromLeft;
    //transition.delegate = self;
    [views.layer addAnimation:transition forKey:nil];
}

-(void)viewSlideInFromTopToBottom:(UIView *)views
{
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.2;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromBottom ;
    //transition.delegate = self;
    [views.layer addAnimation:transition forKey:nil];
}

-(void)viewSlideInFromBottomToTop:(UIView *)views
{
    CATransition *transition = nil;
    transition = [CATransition animation];
    transition.duration = 0.2;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromTop ;
   // transition.delegate = self;
    [views.layer addAnimation:transition forKey:nil];
}
#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
    [self createAndLoadInterstitial];
}
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad
{
    
}
-(IBAction)backBtnTaped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UIWebView Delegate Methods
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
 
}
-(void) webViewDidFinishLoad:(UIWebView *)webView {
    if(webView.tag==123456)
        return;
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}




@end
