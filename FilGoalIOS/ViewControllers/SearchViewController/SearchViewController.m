//
//  SearchViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/14/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "SearchViewController.h"
#import "NewsItem.h"
#import "Images.h"
#import "UIImageView+WebCache.h"
#import "WServicesManager.h"
#import "NewsDetailsViewController.h"
#import "NewsCellLoader2.h"
#import  "AppInfo.h"
#import "Sponsor.h"
#import "Global.h"
#import "AppDelegate.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
@import Firebase;
@interface SearchViewController ()
{
    int pageNum;
    int typeId;
}
@end
#define ExtraPadding 20

@implementation SearchViewController
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
//    AppInfo *appInfo= [Global getInstance].appInfo;
//
//    if (appInfo.sponsor.isActive==1) {
//        NSString *url=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
//        if (IS_IPHONE_6_PLUS) {
//            url=[NSString stringWithFormat:@"%@/MainSponsor/header6plus@3x.png",appInfo.sponsor.imgsBaseUrl];
//        }
//        else if (IS_IPHONE_6)
//        {
//            url=[NSString stringWithFormat:@"%@/MainSponsor/header6@2x.png",appInfo.sponsor.imgsBaseUrl];
//        }
//        else
//        {
//            url=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
//        }
//
//
//
//        [self.sponser sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            self.sponser.contentMode=UIViewContentModeScaleToFill;
//        }];
//    }
//    else{
//        self.tv.frame=CGRectMake(self.tv.frame.origin.x, self.tv.frame.origin.y-26, self.tv.frame.size.width,  self.tv.frame.size.height+26);
//
//    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithKeyWord:(NSString*)keyword andTypeId:(int)type
{
    self = [super init];
    if (self) {
        self.keyword=keyword;
        pageNum=0;
        typeId = type;
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    if(!_isFromSpotLightSearch)
    {
        if(typeId == freeOpinionType){
            self.screenName = [NSString stringWithFormat:@"iOS-Free Opinions search with KeyWord =%@",self.keyword ];
            [FIRAnalytics logEventWithName:kFIREventViewItem
                                parameters:@{
                                             kFIRParameterItemName: [NSString stringWithFormat:@"iOS-Free Opinions search with KeyWord =%@",self.keyword ]
                                             }];
        }
        else{
            self.screenName = [NSString stringWithFormat:@"iOS-News search with KeyWord =%@",self.keyword ];
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName: [NSString stringWithFormat:@"iOS-News search with KeyWord =%@",self.keyword ]
                                         }];
        }
    }
    else
    {
        self.isFromSpotLightSearch=NO;
        self.screenName = [NSString stringWithFormat:@"iOS- SpotLight Search - with KeyWord =%@",self.keyword ];
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName: [NSString stringWithFormat:@"iOS- SpotLight Search - with KeyWord =%@",self.keyword ]
                                         }];
        
    }
    [super viewDidLoad];
    self.NewsList=[[NSMutableArray alloc] init];
    self.canLoadMore=YES;
    
    //Show Loading view
    [self.indLoader startAnimating];
    [self.indLoader setHidden:NO];
    [self.tv setHidden:YES];
    [self.loadingLabel setHidden:NO];
    [self LoadMoreNewsItem];
    
    
    //  [self.navigationItem setTitle:self.selectedCategory.category_name];
    // Do any additional setup after loading the view from its nib.
   // self.title = @"نتيجة البحث";
    self.keywordLbl.text=self.keyword;

}
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    if([AppSponsors isNewsSponsorContentActive])
    {
        mainSponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType:@"News"]];
        [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: @"News"];
    } else {
        [super setNavigationBarBackgroundImage:mainSponsorUrl champs_id:nil section_id:nil activeCategory: nil];
    }
    //[super setNavigationBarBackgroundImage:mainSponsorUrl];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if(self.isFromForceTouch)
//    {
//        self.topView.hidden=true;
//        //self.tv.frame=CGRectMake(0, 25, self.tv.frame.size.width, Screenheight-90); // 90 sponsor height +navigation bar height
//        
//    }
    [self setMainSponsor];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}


#pragma mark- UIWebviewDelegate ....

-(void)LoadMoreNewsItem{
    if(self.canLoadMore==YES){
        NSString *lastDate=@"";
        if ([self.NewsList count]>0) {
            lastDate=((NewsItem*)[self.NewsList objectAtIndex:self.NewsList.count-1]).sourceDate;
            
        }
        NSDictionary *dictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"15",[NSString stringWithFormat:@"%i",++pageNum],self.keyword, nil] forKeys:[NSArray arrayWithObjects:@"PageSize",@"PageNumber",@"keyword", nil] ];
        self.canLoadMore=NO;
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:NewsListAPI,[WServicesManager getApiBaseURL]]andParameters:dictionary WithObjectName:@"NewsList" andAuthenticationType:CMSAPIs success:^(NewsList *newsData)
             {
            [self.NewsList addObjectsFromArray: newsData.news];
            [self.tv reloadData];
            self.canLoadMore=YES;
            //hide Loading View
            [self.indLoader stopAnimating];
            [self.indLoader setHidden:YES];
            [self.tv setHidden:NO];
            [self.loadingLabel setHidden:YES];
            if (self.NewsList.count==0) {
                pageNum=0;
                [self.indLoader stopAnimating];
                [self.indLoader setHidden:YES];
                [self.loadingLabel setHidden:NO];
                self.loadingLabel.text=@"لا يوجد نتيجة لهذا البحث";
            }
            [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"News Search Screen" ApiError:@"Success"];

        } failure:^(NSError *error) {
            self.canLoadMore=YES;
            [self.indLoader stopAnimating];
            [self.indLoader setHidden:YES];
            IBGLog(@"Search News Error : %@",error);
            [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:@"News Search Screen" ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];

            self.loadingLabel.text=@"لا يوجد نتيجة لهذا البحث";
            [self showDefaultNetworkingErrorMessageForError:error
                                             refreshHandler:^{
                                                 [self LoadMoreNewsItem];
                                             }];
        }];
    }
}
#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.NewsList count];
    
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
    if (indexPath.row == [self.NewsList count] - 7)
        [self LoadMoreNewsItem];
    NewsItem *item=[self.NewsList objectAtIndex:indexPath.row ];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"StoryCell" owner:self options:nil]objectAtIndex:0];
    
    [((StoryCell*)cell)initWithNewsItem:item];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *viewControllers;
    self.currentNewsIndex = (int)indexPath.row;
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    UINavigationController * navigationController = appDelegate.getSelectedNavigationController;
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];self.pageController.view.backgroundColor=[UIColor blackColor];
    
    self.pageController.dataSource = self;
    self.pageController.view.frame=self.view.bounds;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    {
        viewControllers = [NSArray arrayWithObject:[[NewsDetailsViewControllerWithWKWebView alloc]initWithNewsItem:self.currentNewsIndex withNewsList:self.NewsList]];
        
    }
    else
        viewControllers = [NSArray arrayWithObject:[[NewsDetailsViewController alloc]initWithNewsItem:self.currentNewsIndex withNewsList:self.NewsList]];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [navigationController pushViewController:self.pageController animated:YES];
    
    
    
}
#pragma mark UIPageViewController dataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int index = [(NewsDetailsViewController *)viewController currentNewsIndex];
    
    
    index--;
    
    if (index<0) {
        return nil;
    }
    else{
        UIViewController *childViewController;
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
            childViewController = [[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:index withNewsList:self.NewsList];
        else
            childViewController = [[NewsDetailsViewController alloc] initWithNewsItem:index withNewsList:self.NewsList];
        
        
        return childViewController;
    }
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    int index = [(NewsDetailsViewController *)viewController currentNewsIndex];
    
    
    index++;
    if (index == self.NewsList.count - 7)
        [self LoadMoreNewsItem];
    
    
    if (index>=self.NewsList.count) {
        return nil;
    }
    
    else{
        UIViewController *childViewController;
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
            childViewController = [[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:index withNewsList:self.NewsList];
        else
            childViewController = [[NewsDetailsViewController alloc] initWithNewsItem:index withNewsList:self.NewsList];
        
        
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
