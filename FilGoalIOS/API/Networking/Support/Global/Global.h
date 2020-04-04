//
//  Global.h

//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>
#import "MetaData.h"
#import "AppInfo.h"
#import "Champion.h"
#import "Section.h"
#import "Country.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface Global : NSObject
{

    
    
}
@property(nonatomic,retain) NSString * timeZone;
@property(nonatomic,strong) Country * country;
@property(nonatomic,assign) int fontSize;

@property (nonatomic,assign) int screenViewsCount;
@property NSDate *lastTimeIncrementedViewsCount;

@property (nonatomic,assign) int selectedIntersitialIndex;
@property(nonatomic,retain) NSString * textColor;
@property(strong,nonatomic) UIColor *bgcolor;
@property(nonatomic,assign) NSInteger viewsCount;
@property(nonatomic,assign) int freqIndex;
@property(nonatomic,assign) NSInteger currentIntersistialFreq;
@property(nonatomic,assign) float timeOffset;
@property(nonatomic,assign) double longtitude;
@property(nonatomic,assign) double laittude;
@property(nonatomic,strong) NSString * areaCode;
@property(nonatomic,retain) MetaData *metaData;
@property(nonatomic,retain) AppInfo *appInfo;
@property (nonatomic,assign) BOOL isAdsEnabledAtApp;
@property (nonatomic,assign) BOOL isPagerAdsEnabledAtApp;
@property (nonatomic, strong) NSArray * activePredictionchampions;
@property(nonatomic,strong) GADInterstitial * interstitialAd;
@property(nonatomic, assign, getter=isCounterToastDisplayed) BOOL counterToastDisplayed;


-(BOOL)isActiveChampion:(int)champId andRoundId:(int)roundId;
-(Champion*)getChampById:(int)champId;
-(Section*)getSectionItemWithSectionID:(NSInteger)sectionID;
+(Global *)getInstance;


@end
