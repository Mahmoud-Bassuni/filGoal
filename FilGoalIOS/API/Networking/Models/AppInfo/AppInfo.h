//
//	AppInfo.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "LandingScreen.h"
#import "SpecialSection.h"
#import "AdsEnabledPerVersion.h"
#import "App.h"
#import "FeaturedMenuItem.h"
#import "Message.h"
#import "Sponsor.h"
#import "Sponsorship.h"
#import "LandingScreenWithVerticalButton.h"
@interface AppInfo : NSObject

@property (nonatomic, assign) BOOL isBannerAdsEnabled;
@property (nonatomic, assign) BOOL isSignalREnabled;
@property (nonatomic, strong) LandingScreen * landingScreen;
@property (nonatomic, strong) NSString * oldAPIsBaseUrl;
@property (nonatomic, strong) NSString * sSOBaseUrl;
@property (nonatomic, strong) SpecialSection * specialSection;
@property (nonatomic, strong) NSString * sportesEngineBaseUrl;
@property (nonatomic, strong) NSArray * adsEnabledPerVersion;
@property (nonatomic, assign) NSInteger adsNewsListingFrequencey;
@property (nonatomic, assign) NSInteger adsNumOfViews;
@property (nonatomic, assign) NSInteger adsRepeatCount;
@property (nonatomic, assign) NSInteger adsVideoListingFrequencey;
@property (nonatomic, strong) App * app;
@property (nonatomic, strong) FeaturedMenuItem * featuredMenuItem;
@property (nonatomic, strong) NSString * hMacAppId;
@property (nonatomic, strong) NSString * hMacAppKey;
@property (nonatomic, strong) NSArray * interstatialAdsPattern;
@property (nonatomic, assign) NSInteger isPostquareActive;
@property (nonatomic, strong) Message * message;
@property (nonatomic, assign) NSInteger serverId;
@property (nonatomic, strong) Sponsor * sponsor;
@property (nonatomic, strong) NSArray * sponsorship;
@property (nonatomic, strong) NSArray * tags;
@property (nonatomic, assign) NSInteger timeoff;
@property (nonatomic, strong) NSString * predictBaseURL;
@property (nonatomic, assign) BOOL isChampActive;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
