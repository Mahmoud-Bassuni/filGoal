//
//  AppSponsors.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 2/15/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sponsorship.h"
#import "LandingScreenWithVerticalButton.h"
@interface AppSponsors : NSObject
//// Main Sponsors

+(BOOL)isSplashSponsorActive;
+(NSString*)getSplashSponsorImagePath;
+(BOOL)isAppNavigationbarSponsorActive;
+(NSString*)getAppNavigationbarSponsorImagePath;
+(NSString*)getChampionDefaultBackground;
+(NSString*)getSectionDefaultBackground;
+(NSString*)getNavigationbarSectionSponsorImagePath:(NSInteger)sectionId;
+(NSString*)getNavigationbarChampionSponsorImagePath:(NSInteger)champId;
+(NSString*)getNavigationBarMainSponsorPerContentType:(NSString*)contentType;
+(BOOL)isSectionActiveUsingId:(NSInteger)sectionId;
+(NSString*)getSpecialSectionImagePathUsingId:(NSInteger)sectionId;
+(BOOL)isChampionActiveUsingId:(NSInteger)champId;
+(NSString*)getSpecialChampionImagePathUsingId:(NSInteger)champId;
+(NSString*)getSpecialSectionBannerImagePathUsingId:(NSInteger)sectionId;
+(NSString*)getSpecialChampionshipBannerImagePathUsingId:(NSInteger)champId;
// Sponsors per Content type
+(BOOL)isNewsSponsorContentActive;
+(BOOL)isAlbumsSponsorContentActive;
+(BOOL)isMatchSponsorContentActive;
+(BOOL)isVideoSponsorContentActive;
+(BOOL)isFreeOpinionsSponsorContentActive;

///Co-Sponsors
+(NSString*)getListingSponsorImagePathUsingChampionId:(NSInteger)champId andContentType:(NSString*)contentType; // Listings Screens
+(NSString*)getHomeWidgetsSponsorImagePathUsingSectionId:(NSInteger)secId andContentType:(NSString*)contentType; // Section Home Screen
+(NSString*)getSectionBannerStripeImagePathUsingSectionId:(NSInteger)secId andContentType:(NSString*)contentType; // Listings, Details screens

// Matches - Co-Sponsors
+(NSString*)getMatchesWidgetSponsorImagePathUsingChampionId:(NSInteger)champId; //Section Matches Home Widget
+(NSString*)getMatchesListSponsorImagePathUsingChampionId:(NSInteger)champId; // Weekly matches list sponsor per championship
+(NSString*)getMatchDetailsSponsorImagePathUsingChampionId:(NSInteger)champId; // Match Center Details Sponsor
+(NSString*)getChampionshipSponsorStripImagePathUsingChampionId:(NSInteger)champId; //Other championship screens like (Scorers, Standings,Teams,Matches)
+(NSString*)getMatchDetailsHeaderSponsorImagePathUsingChampionId:(NSInteger)champId; // Match Center Details Sponsor
+(NSString*)getMatchDetailsPlaygroundSponsorImagePathUsingChampionId:(NSInteger)champId; // Match Center Details Sponsor
+(NSString*)getMatchDetailsTabsSponsorImagePathUsingChampionId:(NSInteger)champId; // Match Center Details Sponsor

+(BOOL)isChampionCoSponsorActiveUsingId:(NSInteger)champId;
+(NSString*)activeChampionCoSponsorTapUrlUsingId:(NSInteger)champId category:(NSString*)category;
+(BOOL)isSectionCoSponsorActiveUsingId:(NSInteger)sectionId;
+(NSString*)activeSectionCoSponsorTapUrlUsingId:(NSInteger)sectionId category:(NSString*)category;


// Prediction
+(BOOL)isPredictionChampionActiveUsingId:(NSInteger)champId;
+(NSString*)getPredictionMatchDetailsSponsorImagePathUsingChampionId:(NSInteger)champId;
+(NSString*)getPredictionMatchStatisticsSponsorImagePathUsingChampionId:(NSInteger)champId;

//LandingScreen
+(BOOL)isLandingScreenActive;
+(NSString*)getSectionBtnImageURL;
+(NSString*)getLandingBgImageURL;
+(NSString*)getHomeBtnImageURL;
+(LandingScreenWithVerticalButton*)getLandingItem;


@end
