//
//  TodayViewController.m
//  NewsWidget
//
//  Created by Yomna Ahmed on 7/2/15.
//  Copyright (c) 2015 Mohamed Mansour. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "NewsItemCell.h"
#import "newSWidgetData.h"
#import "AsyncImageView.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "GAI.h"
@interface TodayViewController () <NCWidgetProviding>

{
    UIActivityIndicatorView* spinner;
    MBProgressHUD *HUD;
}
@end

@implementation TodayViewController
@synthesize NewsList;
- (void)viewDidLoad {
    self.screenName=@"iOS-Akhbarak-News-Widget";

    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-2072328-5"];
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
        self.NewsList=[self readNewsFromUserDefaults:@"NewsList" ];
        if (self.NewsList.count>0) {
            [self updateTableData];
        }
        else
        {
            [self.NesListTable setHidden:YES];
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
                self.NewsList=[self readNewsFromUserDefaults:@"NewsList" ];
                if (self.NewsList.count>0) {
                    [self updateTableData];
                }
                else
                {
                    [self.NesListTable setHidden:YES];
                    [self.refreshBtn setHidden:YES];
                    self.noNewsView.hidden=false;
                    self.preferredContentSize = CGSizeMake(screenWidth,100);
                    [self.noNewsView setText:@"لا يوجد اتصال بالانترنت"];
                    [self.view addSubview:self.noNewsView];
                }
            }
        }];

    }

  
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
   
    /// add spinner to refresh Btn
     spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    CGRect spinnerFrame = spinner.frame;
    if (self.refreshBtn.frame.size.width < spinnerFrame.size.width + self.refreshBtn.bounds.size.height / 2. ) {
        spinnerFrame = self.refreshBtn.bounds;
    } else {
        spinnerFrame.origin = CGPointMake(self.refreshBtn.bounds.size.width - spinnerFrame.size.width - self.refreshBtn.bounds.size.height / 4, (self.refreshBtn.bounds.size.height - spinnerFrame.size.height) / 2.);
    }
    spinner.frame = spinnerFrame;
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
        self.NewsList=[self readNewsFromUserDefaults:@"NewsList" ];
        if (self.NewsList.count>0) {
            [self updateTableData];
        }
        else
        {
        [self.NesListTable setHidden:YES];
        [self.refreshBtn setHidden:YES];
        self.noNewsView.hidden=false;
         self.preferredContentSize = CGSizeMake(screenWidth,100);
        [self.noNewsView setText:@"لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noNewsView];
        }
    }
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"جاري التحديث";
    HUD.square = YES;
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

   /* if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        [self.NesListTable setHidden:YES];
        [self.refreshBtn setHidden:YES];
        self.noNewsView.hidden=false;
        self.preferredContentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width,100);
        [self.noNewsView setText:@"888لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noNewsView];
        
    }
    else
    {
        [HUD show:true];
    [newSWidgetData  getWidgetNewsData:[NSURL URLWithString:@"http://www.akhbarak.net/api/app_top_news/egypt/10.json"] success:^(NSArray *newsList) {
        
        self.FullNewsList=newsList;
        [self updateTableData];
    } failure:^(NSError *error) {
        [HUD hide:true];
        [self.NesListTable setHidden:YES];
        [self.refreshBtn setHidden:YES];
        self.noNewsView.hidden=false;
        self.preferredContentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width,100);
        [self.noNewsView setText:@"888لا يوجد اتصال بالانترنت"];
        [self.view addSubview:self.noNewsView];
          }];
   // self.view.translatesAutoresizingMaskIntoConstraints = NO;
   
    }*/
}
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
 //  self.preferredContentSize = self.NesListTable.contentSize;
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
        self.NewsList=[self readNewsFromUserDefaults:@"NewsList" ];
        if (self.NewsList.count>0) {
            
            [self updateTableData];
        }
        else
        {
            [self.NesListTable setHidden:YES];
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
         [HUD show:true];
    [newSWidgetData  getWidgetNewsData:[NSURL URLWithString:@"http://www.akhbarak.net/api/app_top_news/egypt/3/by_date.json"] success:^(NSArray *newsList) {
        
        self.NewsList=newsList;
        
        [self writeNewsToUserDefaults:@"NewsList" withArray:NewsList];
        [self updateTableData];
       completionHandler(NCUpdateResultNewData);
    } failure:^(NSError *error) {
        [HUD hide:true];
        self.NewsList=[self readNewsFromUserDefaults:@"NewsList" ];
        if(self.NewsList.count>0) {
            [self updateTableData];
        }
        else
        {
            [self.NesListTable setHidden:YES];
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
     // completionHandler(NCUpdateResultNoData);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return NewsList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE_6)
    {
        return 130.0;
    }
    else if (IS_IPHONE_6_PLUS)
    {
    return 150.0;
    }
    
    else
    {
        return 106.0;
    }
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
    NewsWidgetModel * NewsWidgetModelObj=[[NewsWidgetModel alloc ]init];
    NewsWidgetModelObj =NewsList[indexPath.row];
    
    [cell.newsImg sd_setImageWithURL:[NSURL URLWithString:NewsWidgetModelObj.thumbnail]];

    cell.newsTitle.text=NewsWidgetModelObj.article_title;
    
      
    cell.Resources.text=NewsWidgetModelObj.resources;;
    cell.duration.text=NewsWidgetModelObj.pubDate;
    cell.tag=(long)NewsWidgetModelObj.article_id;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable)
    {
        
       MBProgressHUD *HUD2 = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD2];
        HUD2.delegate = self;
        HUD2.labelText = @"لا يوجد اتصال بالانترنت";
        HUD2.square = YES;
        [HUD2 show:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HUD2 hide:YES];
        });
        

        
    }
    else
    {
        NSURL *url = [NSURL URLWithString:@"NewsWidget://com.linkdev.Akhbarak.NewsWidget"];
        // NSURL *url = [NSURL URLWithString:@" Akhbarak.net://com.linkdev.Akhbarak"];
                [self.extensionContext openURL:url completionHandler:nil];
        NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.linkdev.AkhbarakIOS"];
        NewsWidgetModel * NewsWidgetModelObj=[[NewsWidgetModel alloc ]init];
        NewsWidgetModelObj =NewsList[indexPath.row];
        [defaults setObject:NewsWidgetModelObj.article_id forKey:@"article_id"];
        [defaults synchronize];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
-(NSArray*) getRandomElemnetsFromArray:(NSArray *) list
{
    if (list.count >3) {
        
    
    uint32_t rnd =  arc4random_uniform([list count]);
    uint32_t rnd2 = arc4random_uniform([list count]);
    while (rnd==rnd2) {
        rnd2 = arc4random_uniform([list count]);
    }
    uint32_t rnd3 = arc4random_uniform([list count]);
    while (rnd3==rnd||rnd3==rnd2) {
       rnd3 = arc4random_uniform([list count]);
    }
   // uint32_t rnd4 = arc4random_uniform([list count]);
   // while (rnd4==rnd||rnd4==rnd2||rnd4==rnd) {
   //     rnd4 = arc4random_uniform([list count]);
  //  }
    NSArray *result =[[NSArray alloc]initWithObjects:list[rnd],list[rnd2],list[rnd3],nil];
    return result;
        }
    else
        return list;
}
-(void) updateTableData
{
    [HUD hide:true];
    if (NewsList.count==0) {
        [self.noNewsView setText:@" لا يوجد اخبار "];
        [self.NesListTable setHidden:YES];
        [self.refreshBtn setHidden:YES];
        self.noNewsView.hidden=false;
      //  self.view.translatesAutoresizingMaskIntoConstraints = NO;
      //  self.preferredContentSize = CGSizeMake([[UIScreen mainScreen]bounds].size.width,100);
        [self.view addSubview:self.noNewsView];
        
       
    }
    else
    {
        
      /*  self.NesListTable.hidden=false;
        self.refreshBtn.hidden=false;
        self.noNewsView.hidden=true;
      //  self.view.translatesAutoresizingMaskIntoConstraints = NO;
       // self.preferredContentSize =CGSizeMake([[UIScreen mainScreen]bounds].size.width, 380);
        NewsList =[self getRandomElemnetsFromArray:FullNewsList];
        [self.NesListTable reloadData];*/
       
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            self.preferredContentSize = CGSizeMake(320,400);
        }
        [self.NesListTable reloadData];
    }
 
}
- (IBAction)refreshBtnAction:(id)sender {
    
    [self.refreshBtn addSubview:spinner];
    [spinner startAnimating];
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus==NotReachable) {
//        self.NewsList=[self readNewsFromUserDefaults:@"NewsList" ];
        MBProgressHUD *HUD2 = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:HUD2];
        [self.view bringSubviewToFront:HUD2];
        HUD2.delegate = self;
        HUD2.labelText = @"لا يوجد اتصال بالانترنت";
        HUD2.square = YES;
        [HUD2 show:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [spinner removeFromSuperview];
            [HUD2 hide:YES];
        });
        
    
    }
    else
    {
        [self widgetPerformUpdateWithCompletionHandler:^(NCUpdateResult result) {
            if (result==NCUpdateResultNewData) {
                [self updateTableData];
            }
            else
            {
                MBProgressHUD *HUD2 = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:HUD2];
                [self.view bringSubviewToFront:HUD2];
                HUD2.delegate = self;
                HUD2.labelText = @"لا يوجد اتصال بالانترنت";
                HUD2.square = YES;
                [HUD2 show:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [spinner stopAnimating];
                    [spinner removeFromSuperview];
                    [HUD2 hide:YES];
                });
            }
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            [spinner removeFromSuperview];
        });
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
