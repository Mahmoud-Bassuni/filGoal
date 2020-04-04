//
//  Constants.h
//  Safley
//
//  Created by Nada Gamal on 9/30/14.
//  Copyright (c) 2014 Nada Gamal. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SMBInternetConnectionIndicator.h"

#ifndef Safley_Constants_h
#define Safley_Constants_h
static NSString *  kCrednitialIdentifier=@"FilGoal";
static NSString *  kCairoTimeOffset=@"2";

#define SHOW_ALERT(title,msg){ UIAlertController *noDataFoundAlert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}]; [noDataFoundAlert addAction:okAction]; [self presentViewController:noDataFoundAlert animated:YES completion:nil];}
#define ShowInternetIndicator CGRect screenRect = [[UIScreen mainScreen] bounds]; SMBInternetConnectionIndicator * internetConnectionIndicator=[[SMBInternetConnectionIndicator alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, 0, screenRect.size.width, 30)]; [self.view addSubview:internetConnectionIndicator];

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define NO_INTERNET_CONNECTION @"connectionFailed"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


#define SET_BORDER(view){[view.layer setCornerRadius:10.0f];[view.layer setBorderColor:[UIColor clearColor].CGColor];[view.layer setBorderWidth:1.0f];[view.layer setShadowColor:[UIColor blackColor].CGColor];[view.layer setShadowOpacity:0.8];[view.layer setShadowRadius:3.0];[view.layer setShadowOffset:CGSizeMake(2.0, 2.0)];};
#define USERAUTHTOKEN @"AuthToken"
#define STUDENT_USER_ID @"StudentUserID"
#define USERID @"UserId"
#define IsFromFacebook @"Facebook"

#define ProfileImgUrl @"Url"

#define USERTYPE @"UserType"
/*#define Screenheight  (IOS_VERSION_LOWER_THAN_8 ? (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width) : [[UIScreen mainScreen] bounds].size.height)
 #define Screenwidth  (IOS_VERSION_LOWER_THAN_8 ? (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height) : [[UIScreen mainScreen] bounds].size.width)*/
#define IOS_VERSION_LOWER_THAN_8 (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
#define IOS_VERSION_GREATER_THAN_8 (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_8_3)
#define IOS_VERSION_GREATER_EQUAL_8 (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0)

#define Screenheight  [UIScreen mainScreen].bounds.size.height
#define Screenwidth  [UIScreen mainScreen].bounds.size.width
#define Screenheightwidget  [UIScreen mainScreen].bounds.size.height
#define Screenwidthwidget  [UIScreen mainScreen].bounds.size.width
#define IPHONE_6Plus_Cell_Hieght             280
#define IPHONE_6_Cell_Hieght                 250
#define IPHONE_4_5_Cell_Hieght               215
#define USERNAME @"username"
#define PASSWORD @"password"
#define TIME_OFFSET @"TimeOffset"
#define LONGTITUDE @"longtitude"
#define LATITUDE @"latitude"
#define COUNTRY @"country"
#define AREACODE @"areaCode"
#define RELOAD_MATCH_EVENTS @"ReloadMatchEvents"
#define RELOAD_MATCH_COMMENTS @"ReloadMatchComments"
#define TIME_OFFSET @"TimeOffset"
#define COUNTRY_FLAG @"Flag"
#define LONGTITUDE @"longtitude"
#define LATITUDE @"latitude"
#define COUNTRY @"country"
#define AREACODE @"areaCode"
#define SHARE_MATCH_COMMENT @"ShareMatchComment"
#define TEADS_PID @"65806"
#define CONTENT_SIZE @"ContentSize"
#define Intersitial_AD_UNIT_ID @"/7524/FilGoal.com2.0/Application/FG-App-FullScreen"
#define Test_AD_UNIT_ID @"/7524/Test-Mobile-App/Test-02"
#define Pager_AD_UNIT_ID @"/7524/FilGoal.com2.0/Application/FG-App-Pager"
#define MeduimRectangle_AD_UNIT_ID @"/7524/FilGoal.com2.0/Application/FG-App-MR-Premium"
#define MeduimRectangle_AD_UNIT_ID_Test @"/7524/Test-Mobile-App/Test-03"
#define MeduimRectangle_Admob_AdUnit @"ca-mb-app-pub-0868719255119470/3327708625"

#define RELOADAGAIN @"Reload"
#define RELOADTABLEVIEW @"ReloadTableView"
#define SELECTED_DATE @"CalendarSelectedDate"
#define ScrollViewHeight @"ScrollViewHeight"
#define IS_FROM_SPECIAL_SECTION @"isFromSpecialSection"
#define EVENTS_BASE_URL @"http://semedia.filgoal.com/Photos/Event/"
#define PERSON_IMAGES_BASE_URL @"http://semedia.filgoal.com/Photos/Person/Medium/"
#define TEAM_IMAGES_BASE_URL @"http://semedia.filgoal.com/Photos/Team/Medium/"
#define CHAMP_IMAGES_BASE_URL @"http://semedia.filgoal.com/Photos/Championship/Medium/"
#define TEAM_BASE_URL @"http://semedia.filgoal.com/Photos/TeamSquad/"
#define TSHHIRT_BASE_URL @"http://semedia.sarmady.net/Photos/TeamTShirt/"
#define Main_Sponsor_Championship_BASE_URL @"https://semedia.filgoal.com/Photos/ChampionshipCover/5/Medium/"

#define NEW_UPDATE_STORED_DATE @"storedDate"
#define ALBUM_IMAGES_BASE_URL @"http://media.filgoal.com/news/verylarge/"
#define Effective_Measure_URL @"http://api.filgoal.com/mobileappresources/effectivemeasure.html?screen=%@"
#define FilGoal_Statging_Url  @"http://sg.filgoalapi.sarmady.net"
#define SportesEngine_Statging_Url  @"http://sg.seapi.sarmady.net/"
#define HMAC_APP_ID  @"3C89EECF-AF32-41E5-BBEC-0FE30D6CE4E3"
#define HMAC_API_KEY @"LL2dz09h2qpdPKbkuggkWGJcsCvqEwMkPFzdDnUJcPU="
#define SponsorImagePathKey @"MainAppSponsor"

#define MatchNotStartedIndicatorID 1
#define MatchLiveIndicatorID 2
#define MatchEndIndicatorID 3
#define ChampionshipTypeDawery 1

#define POSTSQUARE_BASE_URL @"http://recs.engageya.com/rec-api/getrecs.json"
static NSString * DISQUS_URL= @"https://www.filgoal.com/home/views?name=comments&type=%@&id=%i";
static NSString * AppInfo_URL = @"https://api.filgoal.com/MobileAppResources/ios/appinfo.json"; //Original
//static NSString * AppInfo_URL = @"https://aws-api.filgoal.com/MobileAppResources/ios/appinfo.json"; //Amazon Testing
//static NSString * AppInfo_URL = @"https://api.filgoal.com/MobileAppResources/AppInfoTesting.json";  //Testing
static NSString * MetaData_URL = @"https://api.filgoal.com/MobileAppResources/MetaData.json";
static NSString * MatchesListAPI_Url = @"%@api/matches";
static NSString * Albums_API_Url = @"%@/albums/list";
static NSString * Albums_Details_API_Url = @"%@/albums/details/%i";
static NSString * Matches_Widget_API_Url = @"%@/matches/widget?apiversion=1";
static NSString * HomeTestingAPI = @"https://api.myjson.com/bins/mrllp";
static NSString * HomeSectionNewsAPI = @"%@/news/homesectionnews";
static NSString * HomeFeaturedMatches = @"%@api/matches/featured";
static NSString * PlayerProfileAPI = @"%@api/persons/%i";
static NSString * TeamProfileAPI = @"%@api/teams";
static NSString * CompareMatchesAPI = @"%@api/matches/%@/compare-teams";
static NSString * PlayerStatisticsAPI = @"%@api/persons/%i/statistics";
static NSString * HomeDataAPI = @"%@/news/HomeSectionNews";
static NSString * HomeStoriesAPI = @"https://api.filgoal.com/MobileAppResources/HomeAPI.json";
static NSString * PlayerDetailsAPI = @"%@/players/details/%i";
static NSString * NewsListAPI = @"%@/news/NewsSection";
static NSString * VideosAPI = @"%@/videos/AllVideos";
static NSString * ChampionshipsAPI = @"%@api/championships";
static NSString * ChampionshipDetailsAPI = @"%@api/championships/%i";
static NSString * ChampionshipScorersAPI = @"%@api/championships/%i/scorers";
static NSString * TeamStandingsAPI = @"%@api/teams-standings";
static NSString * MetaDataAPI = @"%@/news/metadata";
static NSString * NewsDetailsAPI = @"%@/news/details";
static NSString * VideoDetailsAPI = @"%@/videos/details";
static NSString * MatchCommentsAPI = @"%@api/match-comments";
static NSString * MatchEventsAPI = @"%@api/match-events";
static NSString * AfterNewsMatchesAPI =@"%@/news/aftermatchnews";
static NSString * AfterVideosMatchesAPI = @"%@/videos/aftermatchvideos";
static NSString * AfterAlbumsMatchesAPI = @"%@/albums/aftermatchalbums";
static NSString * ServerTimeAPI = @"http://api.filgoal.com/time/getservertime";
static NSString * MatchDetailsAPI = @"%@api/matches/%ld";
static NSString * PlayerNewsAPI = @"%@/players/news";
static NSString * PlayerVideosAPI = @"%@/players/videos";
static NSString * PlayerAlbumsAPI = @"%@/players/albums/%i";
static NSString * AggregatedEventsAPI = @"%@api/championships/%i/aggregated-events";
static NSString  *kGetAreaDetails = @"https://ip2location.sarmady.net/api/GeoIP?&client=C1DA4262-4AD1-4399-A039-5184897BCA13";
static NSString  *kGetCountriesList = @"http://ip2location.sarmady.net/api/countries";
static NSString  *kFlagImageUrl = @"http://ip2location.sarmady.net/Flags/%@/%@.png";
static NSString * TeamNewsAPI = @"%@/teams/news";
static NSString * TeamVideosAPI = @"%@/teams/videos";
static NSString * TeamAlbumsAPI = @"%@/teams/albums/%i";
static NSString * ChampionshipNewsAPI = @"%@/champ/news";
static NSString * ChampionshipVideosAPI = @"%@/champ/videos";
static NSString * ChampionshipAlbumsAPI = @"%@/champ/albums/%i";
static NSString * AuthorsListAPI = @"%@/authors/list";
static NSString * AuthorsDetailsAPI = @"%@/authors/details/%i";
static NSString * FilterVideosAPI = @"%@/videos/FilterVideos";
static NSString * TeamsListAPI = @"%@api/championships/%i/teams?$select=TeamId,TeamName&$orderby=TeamName";
static int freeOpinionType = 2;
static int newsType = 1;
static int ROUND_GROUPS_ID= 10;

// Team's Preferences Types with IDs
static int  ID_TEAM_PREFERENCE_MATCH_STATUS= 1;
static int ID_TEAM_PREFERENCE_MATCH_EVENTS= 2;
static int ID_TEAM_PREFERENCE_MATCH_FINAL_SCORE= 3;
static int ID_TEAM_PREFERENCE_MATCH_SQUAD= 4;
static NSString * kMatchStatusStr = @"حالات المباراة";
static NSString * kMatchSquadStr = @"التشكيل";
static NSString * kMatchScoreStr = @"نتيجة المباراة";
static NSString * kMatchEventsStr = @"أحداث المباراة";

#endif

