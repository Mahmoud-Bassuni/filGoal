//
//  CustiomizeAdTypes.m
//  SarmadyAds
//
//  Created by Nada Gamal on 12/10/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//
#import "CustiomizeAdTypes.h"
#define Screenwidth  [UIScreen mainScreen].bounds.size.width
@implementation CustiomizeAdTypes
-(void)requestBannerAdsWithUnitID : (NSString *)unitID andAdType :(GADAdSize) adSize andViewController:(UIViewController*) viewController andKeywords:(NSDictionary*)targetingDic
{
    self.bannerView=[[GADBannerView alloc]initWithAdSize:adSize origin:CGPointMake((Screenwidth-300)/2, 10)];
    self.bannerView.adUnitID=unitID;
    self.bannerView.rootViewController=viewController;
    DFPRequest * request = [DFPRequest request];
    //setTargeting('Keyword', ['Home', 'Inner']).setTargeting('Position', ['Pos1'])
    request.customTargeting = targetingDic;
    [self.bannerView loadRequest:request];
    
}
-(GADInterstitial*)requestInterstitialAd:(NSString *)unitID andViewController:(id) viewController
{
    self.interstitialAd=[[GADInterstitial alloc] initWithAdUnitID:unitID];
    self.interstitialAd.delegate=viewController;
    GADRequest *request = [GADRequest request];
    [self.interstitialAd loadRequest:request];
    return self.interstitialAd;
}
-(NSMutableArray*)initalizeBannerAdsWithUnitID :(NSString*) unitID andItemsList :(NSArray*)items andAdSize:(GADAdSize) adSize andRepeatCount : (NSInteger) repeatCount andViewController:(UIViewController*) viewController andKeywords:(NSArray*) keywords
{
    NSMutableArray * itemsList=[[NSMutableArray alloc]initWithArray:items];
    int numOfAdsOnPager = (repeatCount>0) ? (int)itemsList.count/repeatCount : 0;
    NSDictionary * dic ;
    for (int i=0; i<numOfAdsOnPager; i++) {
        if(i==0)
        {
            dic = [[NSDictionary alloc]initWithObjects:@[keywords,@[@"Pos1"]] forKeys:@[@"Keyword",@"Position"]];
            [self requestBannerAdsWithUnitID:unitID andAdType:adSize andViewController:viewController andKeywords:dic];
        }
        else if(i == (repeatCount*2)+1)
        {
            dic = [[NSDictionary alloc]initWithObjects:@[keywords,@[@"Pos2"]] forKeys:@[@"Keyword",@"Position"]];
            [self requestBannerAdsWithUnitID:unitID andAdType:adSize andViewController:viewController andKeywords:dic];
        }
        else
        {
            dic = [[NSDictionary alloc]initWithObjects:@[keywords,@[]] forKeys:@[@"Keyword",@"Position"]];
            [self requestBannerAdsWithUnitID:MeduimRectangle_Admob_AdUnit andAdType:adSize andViewController:viewController andKeywords:dic];
        }
        [itemsList insertObject:self.bannerView atIndex:i+repeatCount+repeatCount*i];
    }
    
    return itemsList;
}
-(NSMutableArray*)initializeIntersitialCustomAdsWithUnitID :(NSString*) unitID andItemsList :(NSArray*)items andRepeatCount : (NSInteger) repeatCount andViewController:(UIViewController*) viewController
{
    NSMutableArray * itemsList=[[NSMutableArray alloc]initWithArray:items];
    int numOfAdsOnPager = (repeatCount>0) ? (int)itemsList.count/repeatCount : 0;
    for (int i=0; i<numOfAdsOnPager; i++) {
        self.interstitialAd=[[GADInterstitial alloc] initWithAdUnitID:unitID];
        [itemsList insertObject:self.interstitialAd atIndex:i+repeatCount+repeatCount*i];
    }
    
    return itemsList;
}

@end
