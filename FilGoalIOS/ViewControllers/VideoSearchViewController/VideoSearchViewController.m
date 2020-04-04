//
//  VideosViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "VideoSearchViewController.h"
#import "NewsItem.h"
#import "Images.h"
#import "UIImageView+WebCache.h"
#import "SearchViewController.h"
#import "NewsDetailsViewController.h"
#import "VideoDetailsViewController.h"
#import  "AppInfo.h"
#import "Sponsor.h"
#import "Global.h"
#import "AppDelegate.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#define ExtraPadding 20
@import Firebase;
@interface VideoSearchViewController ()
{
    int pageNum;

}
@end

@implementation VideoSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithKeyWord:(NSString*)keyword
{
    self = [super init];
    if (self) {
        self.keyword=keyword;
        pageNum=0;
        // Custom initialization
    }
    return self;
}
//change font
-(void)changeFont:(UIView *) view{
    for (id View in [view subviews]) {
        if ([View isKindOfClass:[UILabel class]]) {
            UILabel *lbl=(UILabel*)View;
            [lbl setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:lbl.font.pointSize]];
            
            
        }
        if ([View isKindOfClass:[UIButton class]]) {
            UIButton *lbl=(UIButton*)View;
            [lbl.titleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:lbl.titleLabel.font.pointSize]];
            
            
        }
        if ([View isKindOfClass:[UIView class]]) {
            [self changeFont:View];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    //Disable Silde Menu
    [self changeFont:self.view];

}
- (void)viewDidLoad
{
    self.screenName = [NSString stringWithFormat:@"iOS-Video search with KeyWord =%@",self.keyword ];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-Video search with KeyWord =%@",self.keyword ]
                                     }];
    [super viewDidLoad];
    self.VideosList=[[NSMutableArray alloc] init];
    self.canLoadMore=YES;
    
    //Show Loading view
    [self.indLoader startAnimating];
    [self.indLoader setHidden:NO];
    [self.tv setHidden:YES];
    [self.loadingLabel setHidden:NO];
    
    
    [self LoadMoreVideoItems];
    [self.tv setContentOffset:CGPointMake(0, 45) animated:YES];
  //  self.title = @"نتيجة البحث";
    self.keywordLbl.text=self.keyword;

}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setMainSponsor];
  
}

-(void)LoadMoreVideoItems{
    if(self.canLoadMore==YES) {
        NSString *lastDate=@"";
        if ([self.VideosList count]>0) {
            lastDate=((VideoItem*)[self.VideosList objectAtIndex:self.VideosList.count-1]).sourceDate;
        }
        
        NSDictionary *dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"15",[NSString stringWithFormat:@"%i",++pageNum],self.keyword, nil] forKeys:[NSArray arrayWithObjects:@"PageSize",@"PageNumber",@"keyword" ,nil] ];
        self.canLoadMore=NO;
        id tracker = [[GAI sharedInstance] defaultTracker];
        [tracker set:kGAIScreenName
               value:[NSString stringWithFormat:@"iOS-Video search with KeyWord =%@ page %i",self.keyword ,pageNum]];
        [tracker send:[[GAIDictionaryBuilder createAppView] build]];
        
        [WServicesManager getDataWithURLString:[NSString stringWithFormat:FilterVideosAPI,[WServicesManager getApiBaseURL]]andParameters:dictionary WithObjectName:@"VideosList" andAuthenticationType:CMSAPIs success:^(VideosList *newsData)
         {
             [self.VideosList addObjectsFromArray: newsData.videos];
             [self.tv reloadData];
             self.canLoadMore=YES;
             
             //hide Loading View
             [self.indLoader stopAnimating];
             [self.indLoader setHidden:YES];
             [self.tv setHidden:NO];
             [self.loadingLabel setHidden:YES];
             if (self.VideosList.count==0) {
                 [self.loadingLabel setHidden:NO];
                 self.loadingLabel.text=@"لا يوجد نتيجة لهذا البحث";
             }
             
             [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Videos Search Screen" ApiError:@"Success"];
             
         } failure:^(NSError *error) {
             self.canLoadMore=YES;
             [self.indLoader stopAnimating];
             [self.indLoader setHidden:YES];
             IBGLog(@"Video Search List Error : %@",error);
             [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"Videos Search Screen" ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
             
             self.loadingLabel.text=@"لا يوجد نتيجة لهذا البحث";
             [self showDefaultNetworkingErrorMessageForError:error
                                              refreshHandler:^{
                                                  [self LoadMoreVideoItems];
                                              }];
         }];
     }
}
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    if([AppSponsors isVideoSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"Videos"]];
        [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: @"Videos"];
    } else {
        [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: nil];

    }
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];

}
#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.VideosList count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (IS_IPHONE_6_PLUS) {
        return IPHONE_6Plus_Cell_Hieght+ExtraPadding;
    }
    else if (IS_IPHONE_6)
    {
        return IPHONE_6_Cell_Hieght+ExtraPadding;
    }
    else
    {
        return IPHONE_4_5_Cell_Hieght+ExtraPadding;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.VideosList count] - 7 && self.VideosList.count>7 ) {
        [self LoadMoreVideoItems];
    }
    VideoItem *item=[self.VideosList objectAtIndex:indexPath.row ];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
    
    [((StoryCell*)cell)initWithVideoItem:item];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // [self.navigationController pushViewController:  animated:YES];
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = appDelegate.getSelectedNavigationController;
    self.currentVideoIndex = (int)indexPath.row;
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];self.pageController.view.backgroundColor=[UIColor blackColor];
    
    self.pageController.dataSource = self;
    self.pageController.view.frame=self.view.bounds;
    NSArray *viewControllers = [NSArray arrayWithObject: [[VideoDetailsViewController alloc] initWithVideoIndex:self.currentVideoIndex withVideosList:self.VideosList]];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [navigationController pushViewController:self.pageController animated:YES];
//    UIButton *logoView = [[UIButton alloc] initWithFrame:CGRectMake(0,0,85,17)] ;
//    [logoView setBackgroundImage:[UIImage imageNamed:@"filgoal_tab_bar_logo"] forState:UIControlStateNormal];
//    [logoView setUserInteractionEnabled:NO];
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    UIViewController* viewController= [appDelegate.navigationController.viewControllers lastObject];
//    viewController.navigationItem.titleView = logoView;
    
    
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   NSString *keyWord= searchBar.text;
    if (![keyWord isEqualToString:@""]) {
        SearchViewController *searchVC=[[SearchViewController alloc] initWithKeyWord:keyWord andTypeId:0];
        [self.navigationController pushViewController:searchVC animated:YES];

    }
}



#pragma mark UIPageViewController dataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int index = [(VideoDetailsViewController *)viewController currentNewsIndex];
    
    
    index--;
    
    if (index<0) {
        return nil;
    }
    else{
    VideoDetailsViewController *childViewController =  [[VideoDetailsViewController alloc] initWithVideoIndex:index withVideosList:self.VideosList];
    
        return childViewController;
    }
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    int index = [(VideoDetailsViewController *)viewController currentNewsIndex];
    
    
    index++;
    if (index == self.VideosList.count - 7)
        [self LoadMoreVideoItems];
    
    
    if (index>=self.VideosList.count) {
        return nil;
    }
    
    else{
    
    VideoDetailsViewController *childViewController = [[VideoDetailsViewController alloc] initWithVideoIndex:index withVideosList:self.VideosList];
    
    
        return childViewController;
    }
}
-(IBAction)backBtnTaped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
