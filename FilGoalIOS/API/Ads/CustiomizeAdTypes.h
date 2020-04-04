//
//  CustiomizeAdTypes.h
//  SarmadyAds
//
//  Created by Nada Gamal on 12/10/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
typedef NS_ENUM(NSInteger, AdType)
{
    KADTypeSmallBanner,
    KADTypeMeduimRectangleBanner,
    KADTypeIntersitial,
};
typedef NS_ENUM(NSInteger, AdSize)
{
    KADSizeSmallBanner, // Ad size is 320 * 50
    KADSizeMeduimRectangleBanner, // Ad size is 300 * 250
    KADSizeInterstitial, // Ad size is 320 * 480
};


@interface CustiomizeAdTypes : NSObject
//////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties
#pragma mark -
/////////////////////////////////////////////////////////////

@property (strong,nonatomic) NSArray  * adTargetingKeywords;
@property (strong,nonatomic) NSString * adTargetingLocation;
@property (strong,nonatomic) NSString * adTargetingBirthday;
@property (strong,nonatomic) NSArray  * adTargetingDevices;
@property (strong,nonatomic) GADBannerView *bannerView;
@property (strong,nonatomic) GADInterstitial * interstitialAd;

//////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
#pragma mark -
/////////////////////////////////////////////////////////////
-(NSMutableArray*)initalizeBannerAdsWithUnitID :(NSString*) unitID andItemsList :(NSArray*)items andAdSize:(GADAdSize) adSize andRepeatCount : (NSInteger) repeatCount andViewController:(UIViewController*) viewController andKeywords:(NSArray*) keywords;
//This method will create items list with interstitial ads and the ad will be a view
-(NSMutableArray*)initializeIntersitialCustomAdsWithUnitID :(NSString*) unitID andItemsList :(NSArray*)items andRepeatCount : (NSInteger) repeatCount andViewController:(UIViewController*) viewController;
-(GADInterstitial*)requestInterstitialAd:(NSString *)unitID andViewController:(UIViewController*) viewController;
@end
