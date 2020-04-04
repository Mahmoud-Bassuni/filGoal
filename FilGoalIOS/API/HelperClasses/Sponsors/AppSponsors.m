//
//  AppSponsors.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 2/15/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import "AppSponsors.h"
#import "SpecialSponsorUrl.h"

//static const NSString * baseUrl=@"https://api.filgoal.com/MobileAppResources/ios/";
@implementation AppSponsors
+(NSString*)baseUrl
{
    return [self getCountrySponsorship].sponsorPath;
}
+(Sponsorship*)getCountrySponsorship
{
    NSString * countryCode=[[NSUserDefaults standardUserDefaults]objectForKey:@"SponsorCountryCode"];
    if(countryCode==nil)
    {
        countryCode=@"EG";
    }
    for (Sponsorship * item in [Global getInstance].appInfo.sponsorship) {
        if([item.sponsorCountryCode isEqualToString:countryCode])
        {
            return item;
        }
    }
    return [[Sponsorship alloc]init];
}
+(BOOL)isSplashSponsorActive
{
    return [self getCountrySponsorship].mainSponsor.appSponsor.isSplashActive;
}
+(BOOL)isNewsSponsorContentActive
{
    return [self getCountrySponsorship].mainSponsor.perContentTypeSponsor.isNewsActive;
}
+(BOOL)isAlbumsSponsorContentActive
{
    return [self getCountrySponsorship].mainSponsor.perContentTypeSponsor.isAlbumsActive;
}
+(BOOL)isMatchSponsorContentActive
{
    return [self getCountrySponsorship].mainSponsor.perContentTypeSponsor.isMatchesActive;
}
+(BOOL)isVideoSponsorContentActive
{
    return [self getCountrySponsorship].mainSponsor.perContentTypeSponsor.isVideosActive;
}
+(BOOL)isFreeOpinionsSponsorContentActive
{
    return [self getCountrySponsorship].mainSponsor.perContentTypeSponsor.isFreeOpinionsActive;
}
+(NSString*)getChampionDefaultBackground
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"Default@%.0fx.png", scale];
    return [NSString stringWithFormat:@"%@mainSponsor/appSponsor/champ/expanded/%@",[self baseUrl],imageName];
}
+(NSString*)getSectionDefaultBackground
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"Default@%.0fx.png", scale];
    return [NSString stringWithFormat:@"%@mainSponsor/appSponsor/section/expanded/%@",[self baseUrl],imageName];
}
+(NSString *)getSplashSponsorImagePath
{
   CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"Splash@%.0fx.png", scale];
    return [NSString stringWithFormat:@"%@mainSponsor/appSponsor/Splash/%@",[self baseUrl],imageName];
}
+(BOOL)isAppNavigationbarSponsorActive
{
    return [self getCountrySponsorship].mainSponsor.appSponsor.isAppBarActive;
}
+(NSString*)getAppNavigationbarSponsorImagePath
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName;
    if(scale==3.0)
    imageName = [NSString stringWithFormat:@"%i@%.0fx.png",(int)(Screenwidth*3),scale];
    else
    imageName = [NSString stringWithFormat:@"%i@%.0fx.png",(int)(Screenwidth*2),scale];
    return [NSString stringWithFormat:@"%@mainSponsor/appSponsor/AppNavigationBar/%@",[self baseUrl],imageName];
}
+(NSString*)getNavigationbarChampionSponsorImagePath:(NSInteger)champId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName;
    if(scale==3.0)
        imageName = [NSString stringWithFormat:@"%i-%i@%.0fx.png",(int)(Screenwidth*3),(int)champId,scale];
    else
        imageName = [NSString stringWithFormat:@"%i-%i@%.0fx.png",(int)(Screenwidth*2),(int)champId,scale];
    NSLog(@"%@",[NSString stringWithFormat:@"%@mainSponsor/appSponsor/champ/collpased/%@",[self baseUrl],imageName]);
    return [NSString stringWithFormat:@"%@mainSponsor/appSponsor/champ/collpased/%@",[self baseUrl],imageName];
}
+(NSString*)getNavigationbarSectionSponsorImagePath:(NSInteger)sectionId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName;
    if(scale==3.0)
        imageName = [NSString stringWithFormat:@"%i-%i@%.0fx.png",(int)(Screenwidth*3),(int)sectionId,scale];
    else
        imageName = [NSString stringWithFormat:@"%i-%i@%.0fx.png",(int)(Screenwidth*2),(int)sectionId,scale];
    return [NSString stringWithFormat:@"%@mainSponsor/appSponsor/section/collpased/%@",[self baseUrl],imageName];
}
+(NSString*)getNavigationBarMainSponsorPerContentType:(NSString*)contentType
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName;
    if(scale==3.0)
        imageName = [NSString stringWithFormat:@"%i@%.0fx.png",(int)(Screenwidth*3),scale];
    else
        imageName = [NSString stringWithFormat:@"%i@%.0fx.png",(int)(Screenwidth*2), scale];
    return [NSString stringWithFormat:@"%@mainSponsor/perContentTypeSponsor/%@/%@",[self baseUrl],contentType,imageName];
}
+(BOOL)isSectionActiveUsingId:(NSInteger)sectionId
{
    for (id secId in [self getCountrySponsorship].mainSponsor.specialSponsor.sectionIds) {
        if([secId integerValue]==sectionId)
            return YES;
    }
    return NO;
}
+(BOOL)isSectionCoSponsorActiveUsingId:(NSInteger)sectionId
{
    for (id secId in [self getCountrySponsorship].coSponsor.sectionIds) {
        if([secId integerValue]==sectionId)
            return YES;
    }
    return NO;
}

///Will return nil if it couldn't find the sectionId
+(NSString*)activeSectionCoSponsorTapUrlUsingId:(NSInteger)sectionId category:(NSString*)category {
    for (SpecialSponsorUrl *sponsorUrl in [self getCountrySponsorship].coSponsor.sectionUrl) {
        if (sponsorUrl.idField == sectionId && [sponsorUrl.category.lowercaseString containsString:category.lowercaseString]) {
            return sponsorUrl.url;
        }
    }
    return nil;
}

+(NSString*)getSpecialSectionImagePathUsingId:(NSInteger)sectionId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)sectionId,scale];
    return [NSString stringWithFormat:@"%@mainSponsor/specialSponsor/section/expanded/%@",[self baseUrl],imageName];
}
+(NSString*)getSpecialSectionBannerImagePathUsingId:(NSInteger)sectionId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName;
    if(scale==3.0)
        imageName = [NSString stringWithFormat:@"%i-%i@%.0fx.png",(int)(Screenwidth*3),(int)sectionId,scale];
    else
        imageName = [NSString stringWithFormat:@"%i-%i@%.0fx.png",(int)(Screenwidth*2),(int)sectionId,scale];
    return [NSString stringWithFormat:@"%@mainSponsor/specialSponsor/section/collpased/%@",[self baseUrl],imageName];
}
+(NSString*)getSpecialChampionshipBannerImagePathUsingId:(NSInteger)champId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName;
    if(scale==3.0)
        imageName = [NSString stringWithFormat:@"%i-%i@%.0fx.png",(int)(Screenwidth*3),(int)champId,scale];
    else
        imageName = [NSString stringWithFormat:@"%i-%i@%.0fx.png",(int)(Screenwidth*2),(int)champId,scale];
    return [NSString stringWithFormat:@"%@mainSponsor/specialSponsor/champ/collpased/%@",[self baseUrl],imageName];
}
+(BOOL)isChampionActiveUsingId:(NSInteger)champId
{
    for (id champID in [self getCountrySponsorship].mainSponsor.specialSponsor.champsIds) {
        if([champID integerValue]==champId)
            return YES;
    }
    return NO;
}

+(BOOL)isChampionCoSponsorActiveUsingId:(NSInteger)champId
{    for (id champID in [self getCountrySponsorship].coSponsor.champsIds) {
        if([champID integerValue]==champId)
            return YES;
    }
    return NO;
}
///Will return nil if it couldn't find the sectionId
+(NSString*)activeChampionCoSponsorTapUrlUsingId:(NSInteger)champId category:(NSString*)category {
    for (SpecialSponsorUrl *sponsorUrl in [self getCountrySponsorship].coSponsor.champsUrl) {
        if (sponsorUrl.idField == champId && [sponsorUrl.category.lowercaseString containsString: category.lowercaseString]) {
            return sponsorUrl.url;
        }
    }
    return nil;
}
+(NSString*)getSpecialChampionImagePathUsingId:(NSInteger)champId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    return [NSString stringWithFormat:@"%@mainSponsor/specialSponsor/champ/expanded/%@",[self baseUrl],imageName];
}
+(NSString*)getListingSponsorImagePathUsingChampionId:(NSInteger)champId andContentType:(NSString*)contentType
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    return [NSString stringWithFormat:@"%@coSponsor/%@/champ/stripBanner/%@",[self baseUrl],contentType,imageName];
}
+(NSString*)getMatchDetailsHeaderSponsorImagePathUsingChampionId:(NSInteger)champId{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    
    return [NSString stringWithFormat:@"%@coSponsor/Matches/champ/matchDetailsHeader/%@",[self baseUrl],imageName];
}
+(NSString*)getMatchDetailsPlaygroundSponsorImagePathUsingChampionId:(NSInteger)champId{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    
    return [NSString stringWithFormat:@"%@coSponsor/Matches/champ/matchFormation/%@",[self baseUrl],imageName];
}
+(NSString*)getMatchDetailsTabsSponsorImagePathUsingChampionId:(NSInteger)champId{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    
    return [NSString stringWithFormat:@"%@coSponsor/Matches/champ/matchDetailsTabs/%@",[self baseUrl],imageName];
}

+(NSString*)getHomeWidgetsSponsorImagePathUsingSectionId:(NSInteger)secId andContentType:(NSString*)contentType
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)secId,scale];
    return [NSString stringWithFormat:@"%@coSponsor/%@/section/related/%@",[self baseUrl],contentType,imageName];
}
+(NSString*)getSectionBannerStripeImagePathUsingSectionId:(NSInteger)secId andContentType:(NSString*)contentType
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)secId,scale];
    return [NSString stringWithFormat:@"%@coSponsor/%@/section/stripBanner/%@",[self baseUrl],contentType,imageName];
}
+(NSString*)getMatchesWidgetSponsorImagePathUsingChampionId:(NSInteger)champId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    return [NSString stringWithFormat:@"%@coSponsor/Matches/champ/overviewMatchWidget/%@",[self baseUrl],imageName];
}
+(NSString*)getMatchesListSponsorImagePathUsingChampionId:(NSInteger)champId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    return [NSString stringWithFormat:@"%@coSponsor/Matches/champ/matchesList/%@",[self baseUrl],imageName];
}
+(NSString*)getMatchDetailsSponsorImagePathUsingChampionId:(NSInteger)champId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    
    return [NSString stringWithFormat:@"%@coSponsor/Matches/champ/matchDetails/%@",[self baseUrl],imageName];
}
+(NSString*)getChampionshipSponsorStripImagePathUsingChampionId:(NSInteger)champId
{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];

    return [NSString stringWithFormat:@"%@coSponsor/Matches/champ/stripBanner/%@",[self baseUrl],imageName];
}
+(BOOL)isPredictionChampionActiveUsingId:(NSInteger)champId{
    for (id champID in [self getCountrySponsorship].mainSponsor.predictSponsor.champsIds) {
        if([champID integerValue]==champId)
            return YES;
    }
    return NO;
}
+(NSString*)getPredictionMatchDetailsSponsorImagePathUsingChampionId:(NSInteger)champId{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    return [NSString stringWithFormat:@"%@perdictSponsor/matchDetails/%@",[self baseUrl],imageName];
}
+(NSString*)getPredictionMatchStatisticsSponsorImagePathUsingChampionId:(NSInteger)champId{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"%li@%.0fx.png",(long)champId,scale];
    return [NSString stringWithFormat:@"%@perdictSponsor/matchStatistics/%@",[self baseUrl],imageName];
}

// Landing Screen
+(BOOL)isLandingScreenActive{
    Sponsorship * sponsor = [self getCountrySponsorship];
    if(sponsor != nil)
    return sponsor.landingScreenWithVerticalButtons.isActive;
return  false;
}
+(NSString*)getSectionBtnImageURL{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"landingSponsor/buttonSectionImg/default@%.0fx.png",scale];
    
    return [NSString stringWithFormat:@"%@%@",[self baseUrl],imageName];
    
}
+(NSString*)getLandingBgImageURL{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"landingSponsor/backgroundImg/default@%.0fx.png",scale];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[self baseUrl],imageName]);
    return [NSString stringWithFormat:@"%@%@",[self baseUrl],imageName];
}
+(NSString*)getHomeBtnImageURL{
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *imageName = [NSString stringWithFormat:@"landingSponsor/buttonHomeImg/default@%.0fx.png",scale];

    return [NSString stringWithFormat:@"%@%@",[self baseUrl],imageName];
    
}
+(LandingScreenWithVerticalButton*)getLandingItem{
    Sponsorship * sponsor = [self getCountrySponsorship];
    if (sponsor != nil)
    return sponsor.landingScreenWithVerticalButtons;
    
    return [[LandingScreenWithVerticalButton alloc]init];
}
@end
