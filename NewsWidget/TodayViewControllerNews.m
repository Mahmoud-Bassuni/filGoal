//
//  TodayViewController.m
//  NewsWidget
//
//  Created by Yomna Ahmed on 7/2/15.
//  Copyright (c) 2015 Mohamed Mansour. All rights reserved.
//

#import "TodayViewControllerNews.h"
#import "NewsItemCell.h"
#import "AsyncImageView.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import <NotificationCenter/NotificationCenter.h>
#import "GAI.h"
@interface TodayViewControllerNews () <NCWidgetProviding>

{
  //  UIActivityIndicatorView* spinner;
   // MBProgressHUD *HUD;
}
@end

@implementation TodayViewControllerNews
@synthesize newsList;
- (void)viewDidLoad {
    self.screenName=@"iOS-News Widget screen";
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    self.newsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    //production  --  UA-697331-9
    //Development  --  UA-51739634-1
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-697331-9"];
    
    [super viewDidLoad];
    CGRect  screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
       screenWidth=414;
    self.noNewsView = [[UILabel alloc] init];
    self.noNewsView.frame = CGRectMake(screenWidth/2-80, 50,180, 10);
    [self.noNewsView setBackgroundColor:[UIColor clearColor]];
    [self.noNewsView setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0  blue:255.0/255.0  alpha:1.0]];
    [self.noNewsView setTextAlignment:NSTextAlignmentCenter];
    [self.noNewsView setFont:[UIFont boldSystemFontOfSize:14.0f]];
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        self.newsList=[self readNewsFromUserDefaults:@"newsList" ];
        if (self.newsList.count>0) {
            [self updateTableData];
        }
        else
        {
            [self.newsTableView setHidden:YES];
            [self.refreshBtn setHidden:YES];
            self.noNewsView.hidden=false;
            self.preferredContentSize = CGSizeMake(screenWidth,100);
            [self.noNewsView setText:@"لا يوجد اتصال بالانترنت"];
            [self.view addSubview:self.noNewsView];
        }
    }
    else
    {
        [self widgetPerformUpdateWithCompletionHandler:^(NCUpdateResult result) {
            if (result==NCUpdateResultNewData) {
            }
            else
            {
                self.newsList=[self readNewsFromUserDefaults:@"newsList" ];
                if (self.newsList.count>0) {
                    [self updateTableData];
                }
                else
                {
                    [self.newsTableView setHidden:YES];
                    [self.refreshBtn setHidden:YES];
                    self.noNewsView.hidden=false;
                    self.preferredContentSize = CGSizeMake(screenWidth,100);
                    [self.noNewsView setText:@"لا يوجد اتصال بالانترنت"];
                    [self.view addSubview:self.noNewsView];
                }
            }
        }];

    }
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
   [self.extensionContext setWidgetLargestAvailableDisplayMode:NCWidgetDisplayModeExpanded];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
    
    self.refreshBtn.layer.cornerRadius=15.0;
    self.refreshBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    self.refreshBtn.layer.borderWidth=0.8;

    CGRect  screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        screenWidth=414;
    self.noNewsView = [[UILabel alloc] init];
    self.noNewsView.frame = CGRectMake(screenWidth/2-80, 50,180, 10);
    [self.noNewsView setBackgroundColor:[UIColor clearColor]];
    [self.noNewsView setTextColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0  blue:255.0/255.0  alpha:1.0]];
    [self.noNewsView setTextAlignment:NSTextAlignmentCenter];
    [self.noNewsView setFont:[UIFont boldSystemFontOfSize:14.0f]];
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        self.newsList=[self readNewsFromUserDefaults:@"newsList" ];
        if (self.newsList.count>0) {
            [self updateTableData];
        }
        else
        {
        [self.newsTableView setHidden:YES];
        [self.refreshBtn setHidden:YES];
        self.noNewsView.hidden=false;
         self.preferredContentSize = CGSizeMake(screenWidth,100);
        [self.noNewsView setText:@"لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noNewsView];
        }
    }

}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
 //  self.preferredContentSize = self.newsTableView.contentSize;
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        self.newsList=[self readNewsFromUserDefaults:@"newsList" ];
        if (self.newsList.count>0) {
            //self.preferredContentSize = CGSizeMake(0.0, 100.0);

            [self updateTableData];
        }
        else
        {
            [self.newsTableView setHidden:YES];
            [self.refreshBtn setHidden:YES];
            self.noNewsView.hidden=false;
            CGRect  screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenWidth = screenRect.size.width;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                screenWidth=414;
            self.preferredContentSize = CGSizeMake(screenWidth,100);
            [self.noNewsView setText:@"لا يوجد اتصال بالانترنت"];
            [self.view addSubview:self.noNewsView];
        }
    }
    else
    {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:[NSString stringWithFormat:@"https://api.filgoal.com/news/HomeSectionNews"] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            if ([(NSArray*)[responseObject objectForKey:@"HomeParts"]count]>0)
            {
                self.newsList=[[[[responseObject objectForKey:@"HomeParts"]objectAtIndex:0]objectForKey:@"items"]objectForKey:@"part_news"];
            }
            [self writeNewsToUserDefaults:@"newsList" withArray:newsList];
            [self updateTableData];
            completionHandler(NCUpdateResultNewData);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.newsList=[self readNewsFromUserDefaults:@"newsList" ];
            if(self.newsList.count>0) {
                [self updateTableData];
            }
            else
            {
                [self.newsTableView setHidden:YES];
                [self.refreshBtn setHidden:YES];
                self.noNewsView.hidden=false;
                CGRect  screenRect = [[UIScreen mainScreen] bounds];
                CGFloat screenWidth = screenRect.size.width;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    screenWidth=414;
                self.preferredContentSize = CGSizeMake(screenWidth,100);
                [self.noNewsView setText:@"لا يوجد اتصال بالانترنت"];
                [self.view addSubview:self.noNewsView];
            }
            
            completionHandler(NCUpdateResultFailed);
            
            
        }];
        
        

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return newsList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 100.0;
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsZero;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellIdentifier= @"NewsItemCell";
    NewsItemCell *cell;
   
   if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)  {
       cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[NewsItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
}
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
    //cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NewsItemCell" owner:self options:nil];
    cell = [topLevelObjects objectAtIndex:0];
    }

    if(newsList.count>0)
    {
    if([(NSArray*)[[newsList objectAtIndex:indexPath.row]objectForKey:@"images"]count]>0)
    {
    [cell.newsImg setImageURL:[NSURL URLWithString:[[[[newsList objectAtIndex:indexPath.row]objectForKey:@"images"]objectAtIndex:0]objectForKey:@"small"]]];
    }

    cell.newsTitle.text=[[newsList objectAtIndex:indexPath.row ]objectForKey:@"news_title"];
    
    
   // cell.Resources.text=NewsWidgetModelObj.resources;;
   // cell.duration.text=NewsWidgetModelObj.pubDate;
    cell.tag=(long)[[newsList objectAtIndex:indexPath.row ]objectForKey:@"news_id"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable)
    {
        
    }
    else
    {
        NSURL *url = [NSURL URLWithString:@"FilgoalWidget://com.sarmady.NewsWidget"];
        [self.extensionContext openURL:url completionHandler:nil];
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
        [defaults setInteger:[[[newsList objectAtIndex:indexPath.row ]objectForKey:@"news_id"]integerValue] forKey:@"news_id"];
       // [defaults setObject:@"87776522" forKey:@"news_id"];
        [defaults setObject:[[newsList objectAtIndex:indexPath.row ]objectForKey:@"news_title"] forKey:@"news_title"];
        [defaults setObject:[[newsList objectAtIndex:indexPath.row ]objectForKey:@"news_description"] forKey:@"news_description"];
        [defaults setBool:YES forKey:@"IsFromNewsWidget"];
        [defaults synchronize];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(void) updateTableData
{
    //[HUD hide:true];
    if (newsList.count==0) {
        [self.noNewsView setText:@" لا يوجد اخبار "];
        [self.newsTableView setHidden:YES];
        [self.refreshBtn setHidden:YES];
        self.noNewsView.hidden=false;
      //  self.view.translatesAutoresizingMaskIntoConstraints = NO;
      //  self.preferredContentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width,100);
        [self.view addSubview:self.noNewsView];
        
       
    }
    else
    {
        
      /*  self.newsTableView.hidden=false;
        self.refreshBtn.hidden=false;
        self.noNewsView.hidden=true;
      //  self.view.translatesAutoresizingMaskIntoConstraints = NO;
       // self.preferredContentSize =CGSizeMake([[UIScreen mainScreen]bounds].size.width, 380);
        newsList =[self getRandomElemnetsFromArray:FullnewsList];
        [self.newsTableView reloadData];*/
       
        [self.newsTableView reloadData];
    }
 
}
- (IBAction)refreshBtnAction:(id)sender {
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
//        self.newsList=[self readNewsFromUserDefaults:@"newsList" ];
//        MBProgressHUD *HUD2 = [[MBProgressHUD alloc] initWithView:self.view];
//        
//        [self.view addSubview:HUD2];
//        [self.view bringSubviewToFront:HUD2];
//        HUD2.delegate = self;
//        HUD2.labelText = @"لا يوجد اتصال بالانترنت";
//        HUD2.square = YES;
//        [HUD2 show:YES];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [spinner stopAnimating];
//            [spinner removeFromSuperview];
//            [HUD2 hide:YES];
//        });
        
    
    }
    else
    {
        [self widgetPerformUpdateWithCompletionHandler:^(NCUpdateResult result) {
            if (result==NCUpdateResultNewData) {
                [self updateTableData];
            }
            else
            {
//                MBProgressHUD *HUD2 = [[MBProgressHUD alloc] initWithView:self.view];
//                [self.view addSubview:HUD2];
//                [self.view bringSubviewToFront:HUD2];
//                HUD2.delegate = self;
//                HUD2.labelText = @"لا يوجد اتصال بالانترنت";
//                HUD2.square = YES;
//                [HUD2 show:YES];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [spinner stopAnimating];
//                    [spinner removeFromSuperview];
//                    [HUD2 hide:YES];
//                });
            }
        }];
     
    }

    
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        self.preferredContentSize = CGSizeMake(0.0, 600.0);
    } else if (activeDisplayMode == NCWidgetDisplayModeCompact) {
       // self.preferredContentSize = maxSize;
        //self.preferredContentSize = maxSize;
        self.preferredContentSize = maxSize;


    }
}
//// Cash Data
-(void)writeNewsToUserDefaults:(NSString *)keyName withArray:(NSArray *)myArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}
//Get cached data
-(NSArray *)readNewsFromUserDefaults:(NSString*)keyName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    return myArray;
}

@end
