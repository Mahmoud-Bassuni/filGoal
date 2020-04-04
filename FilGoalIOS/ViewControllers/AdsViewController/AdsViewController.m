//
//  AdsViewController.m
//  AkhbarakMobileApp
//
//  Created by Nada Gamal on 2/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "AdsViewController.h"

@interface AdsViewController ()

@end

@implementation AdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if([self.item isKindOfClass:[GADInterstitial class]])
    {
     self.interstitialAd = [[CustiomizeAdTypes alloc] requestInterstitialAd:Intersitial_AD_UNIT_ID andViewController:self];
        self.interstitialAd.delegate =  self;
        [self.adsView setBackgroundColor:[UIColor whiteColor]];
    }
    else
    {
        [self.adsView setBackgroundColor:[UIColor darkGrayColor]];
    }
    self.navigationItem.rightBarButtonItems=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark GADIntersitial Ad Delegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    UIViewController *gadInterstitialViewController=(UIViewController *)[ad valueForKey:@"_viewController"] ;
    gadInterstitialViewController.view.frame=CGRectMake(0,0, self.view.frame.size.width,self.adsView.frame.size.height);
    UIButton *closeBtn=[gadInterstitialViewController valueForKey:@"_closeButton"];
    closeBtn.hidden=true;
    UIView  *adView=[gadInterstitialViewController valueForKey:@"_adView"];
    adView.frame=CGRectMake(0,0, self.view.frame.size.width,self.adsView.frame.size.height);
    [self.adsView addSubview:adView];
}
-(void)requestInterstitialAd:(NSString *)unitID andViewController:(id) viewController
{
    self.interstitialAd=[[GADInterstitial alloc] initWithAdUnitID:unitID];
    self.interstitialAd.delegate=self;
    GADRequest *request = [GADRequest request];
    [self.interstitialAd loadRequest:request];
    
}
- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
