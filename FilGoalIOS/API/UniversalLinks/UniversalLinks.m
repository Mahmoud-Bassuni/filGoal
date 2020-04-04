//
//  UniversalLinks.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/12/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "UniversalLinks.h"
#import "MatchesByDateViewController.h"
#import "SVModalWebViewController.h"

@implementation UniversalLinks
+(NSInteger)getPageIndexWithURL:(NSString*)url{
    if([url containsString:@"standings"]){
        return 1;
    }
    else if([url containsString:@"matches"]){
        return 2;
    }
    else if([url containsString:@"articles"]){
        return 3;
    }
    else if([url containsString:@"videos"]){
        return 4;
    }
    else if([url containsString:@"albums"]){
        return 5;
    }
    else if([url containsString:@"scorers"]){
        return 7;
    }
    return 0;
}
+(NSInteger)getSectionPageIndexWithURL:(NSString*)url{
     if([url containsString:@"matches"]){
        return 2;
    }
     else  if([url containsString:@"standings"]){
         return 3;
     }
    else if([url containsString:@"articles"]){
        return 4;
    }
    else if([url containsString:@"videos"]){
        return 5;
    }
    else if([url containsString:@"albums"]){
        return 6;
    }
    else if([url containsString:@"scorers"]){
        return 8;
    }
    return 0;
}
+(void)handleUniversalLinksWithUrlString:(NSString*)url andIsRedirectedUrl:(BOOL)isRedirect
{

    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSRange   searchedRange = NSMakeRange(0, [url length]);
    NSError  *error = nil;
    NSString *pattern = @"(\\/[a-z]+)\\/(\\d+)?";
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:url options:0 range: searchedRange];
    
    NSString *sectionType = @"";
    NSString *Id = @"";
    
    for (NSTextCheckingResult* match in matches) {
        NSString* matchText = [url substringWithRange:[match range]];
        NSLog(@"match: %@", matchText);
        NSRange group1 = [match rangeAtIndex:1];
       
        
        sectionType = [url substringWithRange:group1];
        if ([match rangeAtIndex:2].length >1){
        NSRange group2 = [match rangeAtIndex:2];
        Id = [url substringWithRange:group2] ;
        }
        NSLog(@"group1: %@", [url substringWithRange:group1]);
        //NSLog(@"group2: %@", [url substringWithRange:group2]);
    }
    

//    ((void (^)(void))@{
//        @"championships" : ^{
//                       if([Global getInstance].metaData.champions.count>0)
//                       {
//                           Champion * champ=[[Global getInstance]getChampById:[Id intValue]];
//                           if(champ != nil && champ.champId != 0)
//                           {
//                               ChampionShipData * champion = [[ChampionShipData alloc]init];
//                               champion.idField = champ.champId;
//                               champion.name = champ.champName;
//                               ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
//                               detailsScreen.champion = champion;
//                               detailsScreen.selectedTabIndex = (int)[self getPageIndexWithURL:Id];
//                               [appDelegate.getSelectedNavigationController pushViewController:detailsScreen animated:YES];
//                           }
//                       }
//
//                   else
//                   {
//                       [appDelegate.tabbarController setSelectedIndex:0];
//                       [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
//                       ChampionsViewController * viewController = [[ChampionsViewController alloc]init];
//                       [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
//                   }
//        },
//        @"section" : ^{
//                Section * section = [[Global getInstance] getSectionItemWithSectionID:[Id intValue]];
//        if([Id intValue] != 0)
//        {
//                MainSectionViewController* mainSection=[[MainSectionViewController alloc]initWithSection:section];
//                mainSection.section=section;
//                mainSection.selectedTabIndex = (int)[self getSectionPageIndexWithURL:Id];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [appDelegate.getSelectedNavigationController pushViewController:mainSection animated:YES];
//                });
//        }
//        else{
//            HomeViewController * viewController=[[HomeViewController alloc]init];
//                       [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
//        }
//
//        },
//        @"articles" : ^{
//           NewsItem * newsItem=[[NewsItem alloc] init];
//            if([Id intValue] != 0)
//            {
//                if ([Id rangeOfString:@"/"].location != NSNotFound) {
//                newsItem.newsId=[Id intValue];
//                newsItem.newsTitle=@"";
//                NewsDetailsViewControllerWithWKWebView * viewController =[[NewsDetailsViewControllerWithWKWebView alloc]initWithNewsItem:newsItem];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
//                });
//                }
//                else{
//                    newsItem.newsId=[Id intValue];
//                    newsItem.newsTitle=@"";
//                    NewsDetailsViewControllerWithWKWebView * viewController =[[NewsDetailsViewControllerWithWKWebView alloc]initWithNewsItem:newsItem];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
//                    });
//                }
//            }
//            else
//            {
//                [appDelegate.tabbarController setSelectedIndex:3];
//                [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
//            }
//        },
//        @"videos" : ^{
//        if([Id intValue] != 0)
//        {
//               VideoItem * videoItem=[[VideoItem alloc] init];
//                videoItem.videoId=[Id intValue];
//                videoItem.videoTitle=@"";
//                videoItem.videoUrl=url;
//                VideoDetailsViewController * videoDetailsScreen=[[VideoDetailsViewController alloc] initWithVideo:videoItem];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [appDelegate.getSelectedNavigationController pushViewController:videoDetailsScreen animated:YES];
//                });
//        }
//        else{
//                        [appDelegate.tabbarController setSelectedIndex:1];
//                        [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
//        }
//        },
//        @"albums" : ^{
//             if([Id intValue] != 0)
//                  {
//                Album * albumItem = [[Album alloc]init] ;
//                albumItem.albumId=[Id intValue];
//                albumItem.albumTitle=@"";
//                GalleryDetailsViewController * viewController=[[GalleryDetailsViewController alloc]init];
//                viewController.albumItem = albumItem;
//                [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
//                  }
//             else{
//                         [appDelegate.tabbarController setSelectedIndex:0];
//                         [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
//                         GalleriesViewController * viewController = [[GalleriesViewController alloc]init];
//                         [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
//
//             }
//        },
//        @"teams" : ^{
//            int teamId=[Id intValue];
//            TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
//            teamProfile.teamId = teamId;
//            [appDelegate.getSelectedNavigationController pushViewController:teamProfile animated:YES];
//        },
//        @"players" : ^{
//            int playerId=[Id intValue];
//            Player * item = [[Player alloc]init];
//            item.playerId=playerId;
//            PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
//            playerProfileVC.player = item;
//            [appDelegate.getSelectedNavigationController pushViewController:playerProfileVC animated:YES];
//        },
//        @"matches" : ^{
//            NSArray *elts = [url componentsSeparatedByString:@"matches/"];
//            MatchCenterDetails *item=[[MatchCenterDetails alloc] init];
//            item.idField=[Id intValue];
//            if(item.idField !=0)
//            {
//                MatchCenterDetails *item=[[MatchCenterDetails alloc] init];
//                if(elts.count>1)
//                {
//                    item.idField=[Id intValue];
//                    MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
//                    matchCenter.matchCenterDetails = item;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [appDelegate.getSelectedNavigationController pushViewController:matchCenter animated:YES];
//                    });
//                }
//            }
//            else if([url rangeOfString:@"matches/?date="].location != NSNotFound){
//                NSArray *elts = [url componentsSeparatedByString:@"matches/?date="];
//                if(elts.count>1)
//                {
//                    NSString * date= Id;
//                    [self pushMatchesViewWithDate:date];
//                }
//
//            }
//            else
//            {
//                [appDelegate.tabbarController setSelectedIndex:2];
//                [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
//            }
//        },
//    }[sectionType] ?: ^{
//        if ([appDelegate.getSelectedNavigationController.topViewController isKindOfClass:[HomeViewController class]]){
//
//        }
//        else{
//            HomeViewController * viewController=[[HomeViewController alloc]init];
//            [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
//        }
//    })();

  
     if ([url rangeOfString:@"/championships"].location!=NSNotFound)
    {
        NSArray *elts = [url componentsSeparatedByString:@"championships/"];
        if(elts.count>1)
        {
            if([Global getInstance].metaData.champions.count>0)
            {
                Champion * champ=[[Global getInstance]getChampById:[Id intValue]];
                if(champ != nil && champ.champId != 0)
                {
                    ChampionShipData * champion = [[ChampionShipData alloc]init];
                    champion.idField = champ.champId;
                    champion.name = champ.champName;
                    ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
                    detailsScreen.champion = champion;
                    detailsScreen.selectedTabIndex = (int)[self getPageIndexWithURL:elts[1]];
                    [appDelegate.getSelectedNavigationController pushViewController:detailsScreen animated:YES];
                }
            }
        }
        else
        {
            [appDelegate.tabbarController setSelectedIndex:0];
            [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
            ChampionsViewController * viewController = [[ChampionsViewController alloc]init];
            [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
        }
        
    }
    else if ([url rangeOfString:@"/section"].location!=NSNotFound)
    {
        NSArray *elts = [url componentsSeparatedByString:@"section/"];
        if(elts.count>1)
        {
            Section * section = [[Global getInstance] getSectionItemWithSectionID:[Id intValue]];
            MainSectionViewController* mainSection=[[MainSectionViewController alloc]initWithSection:section];
            mainSection.section=section;
            mainSection.selectedTabIndex = (int)[self getSectionPageIndexWithURL:elts[1]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [appDelegate.getSelectedNavigationController pushViewController:mainSection animated:YES];
            });
        }
        else
        {
            [appDelegate.tabbarController setSelectedIndex:0];
            [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
            SectionsViewController * viewController = [[SectionsViewController alloc]init];
            dispatch_async(dispatch_get_main_queue(), ^{
                [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
            });

        }
        
        
    }
    
   else if([url rangeOfString:@"/articles"].location  != NSNotFound){
        NSArray *elts = [url componentsSeparatedByString:@"articles/"];
        NewsItem * newsItem=[[NewsItem alloc] init];
        if(Id.length>0)
        {
            if ([Id rangeOfString:@"/"].location != NSNotFound) {
            NSArray *idUndDescriptionURL = [url componentsSeparatedByString:@"/"];https://www.linkedin.com/jobs/?trk=consumer_jobs_global_fallback
            newsItem.newsId=[Id intValue];
            newsItem.newsTitle=@"";
            NewsDetailsViewControllerWithWKWebView * viewController =[[NewsDetailsViewControllerWithWKWebView alloc]initWithNewsItem:newsItem];
            dispatch_async(dispatch_get_main_queue(), ^{
                [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
            });
            }
            else{
                newsItem.newsId=[Id intValue];
                newsItem.newsTitle=@"";
                NewsDetailsViewControllerWithWKWebView * viewController =[[NewsDetailsViewControllerWithWKWebView alloc]initWithNewsItem:newsItem];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
                });
            }
        }
        else
        {
            [appDelegate.tabbarController setSelectedIndex:3];
            [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
        }
    }
    
    else if ([url rangeOfString:@"/videos"].location!=NSNotFound)
    {
        NSArray *elts = [url componentsSeparatedByString:@"videos/"];
        VideoItem * videoItem=[[VideoItem alloc] init];
        if(Id.length>0)
        {
            videoItem.videoId=[Id intValue];
            videoItem.videoTitle=@"";
            videoItem.videoUrl=url;
            VideoDetailsViewController * videoDetailsScreen=[[VideoDetailsViewController alloc] initWithVideo:videoItem];
            dispatch_async(dispatch_get_main_queue(), ^{
                [appDelegate.getSelectedNavigationController pushViewController:videoDetailsScreen animated:YES];
            });

        }
        else
        {
            [appDelegate.tabbarController setSelectedIndex:1];
            [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
        }
        
    }
    
    else if([url rangeOfString:@"/matches"].location != NSNotFound){
        NSArray *elts = [url componentsSeparatedByString:@"matches/"];
        MatchCenterDetails *item=[[MatchCenterDetails alloc] init];
         if(Id.length>0)
            item.idField=[Id intValue];
        if(item.idField !=0)
        {

            MatchCenterDetails *item=[[MatchCenterDetails alloc] init];
            if(elts.count>1)
            {
                item.idField=[Id intValue];
                MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
                matchCenter.matchCenterDetails = item;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [appDelegate.getSelectedNavigationController pushViewController:matchCenter animated:YES];
                });
            }
        }
        else if([url rangeOfString:@"matches/?date="].location != NSNotFound){
            NSArray *elts = [url componentsSeparatedByString:@"matches/?date="];
             if(Id.length>0)
            {
                NSString * date= Id;
                [self pushMatchesViewWithDate:date];
            }

        }
        else
        {
            [appDelegate.tabbarController setSelectedIndex:2];
            [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
        }
    }

    else if([url rangeOfString:@"/albums"].location  != NSNotFound){
        Album * albumItem = [[Album alloc]init] ;
        NSArray *elts = [url componentsSeparatedByString:@"albums/"];
        if(Id.length>0)
        {
            albumItem.albumId=[Id intValue];
            albumItem.albumTitle=@"";
            GalleryDetailsViewController * viewController=[[GalleryDetailsViewController alloc]init];
            viewController.albumItem = albumItem;
            [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
        }
        else
        {
            [appDelegate.tabbarController setSelectedIndex:0];
            [appDelegate.getSelectedNavigationController popToRootViewControllerAnimated:YES];
            GalleriesViewController * viewController = [[GalleriesViewController alloc]init];
            [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
        }
        
    }
    else if([url rangeOfString:@"/teams"].location  != NSNotFound){
        NSArray *elts = [url componentsSeparatedByString:@"teams/"];
            int teamId=[Id intValue];
            TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
            teamProfile.teamId = teamId;
            [appDelegate.getSelectedNavigationController pushViewController:teamProfile animated:YES];
    }
    else if([url rangeOfString:@"players/"].location  != NSNotFound){
        NSArray *elts = [url componentsSeparatedByString:@"players/"];
        int playerId=[Id intValue];
        Player * item = [[Player alloc]init];
        item.playerId=playerId;
        PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
        playerProfileVC.player = item;
        [appDelegate.getSelectedNavigationController pushViewController:playerProfileVC animated:YES];
    }
    else
    {
        if(!isRedirect)
        {
        if([url isEqualToString:@"https://www.filgoal.com/"])
        {
            if ([appDelegate.getSelectedNavigationController.topViewController isKindOfClass:[HomeViewController class]]){

            }
            else{
                HomeViewController * viewController=[[HomeViewController alloc]init];
                [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
            }

        }
        else{
      //  GlobalViewController * webView=[[GlobalViewController alloc]init];
//        SVModalWebViewController * viewController=[[SVModalWebViewController alloc]initWithURL:[NSURL URLWithString:url]];
//       // webView.url=[NSURL URLWithString:url];
//        [appDelegate.getSelectedNavigationController presentViewController:viewController animated:YES completion:nil ];
//        //[appDelegate.getSelectedNavigationController pushViewController:webView animated:YES];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

        }
        }
        else
        {
            
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
            {
            NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url] options:options completionHandler:^(BOOL success) {
                
            }];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            }
        }
    }
}

+(void)pushMatchesViewWithDate:(NSString*)selectedDate
{
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date =[outputFormatter dateFromString: selectedDate];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:date];
    [components setDay:[components day]-1];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSDate * afterDate = [gregorian dateFromComponents:components];
    MatchesByDateViewController * viewController = [[MatchesByDateViewController alloc]init];
    viewController.selectedDateStr = [outputFormatter stringFromDate:date];
    viewController.dayBeforeSelectedDateStr = [outputFormatter stringFromDate:afterDate];
    [appDelegate.getSelectedNavigationController pushViewController:viewController animated:YES];
    
    
}

@end
