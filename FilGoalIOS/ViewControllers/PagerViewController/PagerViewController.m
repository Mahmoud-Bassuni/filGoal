//
//  PagerViewController.m
//  AkhbarakMobileApp
//
//  Created by Nada Gamal on 2/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "PagerViewController.h"

@interface PagerViewController ()
{
    
}
@end

@implementation PagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource=self;

    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (self.selectedAlbum != nil) {
        self.currentIndex = [self.storiesListWithAds indexOfObject:_selectedAlbum]+1;
    } else if (self.selectedNewsItem != nil) {
        self.currentIndex = [self.storiesListWithAds indexOfObject:_selectedNewsItem]+1;
    } else if (self.selectedVideoItem != nil) {
        self.currentIndex = [self.storiesListWithAds indexOfObject:_selectedVideoItem]+1;
    }
    [self setViewControllersObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setViewControllersObjects
{
    self.viewControllersList = [[NSMutableArray alloc]init];
    for(int i=0; i < self.storiesListWithAds.count; i++)
    {
        id  item = [self.storiesListWithAds objectAtIndex:i];
        if([item isKindOfClass:[Album class]])
        {
            GalleryDetailsViewController * viewController= [[GalleryDetailsViewController alloc]init];
            viewController.pageIndex = i;
            viewController.albumItem = item;
            [self.viewControllersList addObject:viewController];
            
        }
        else if([item isKindOfClass:[NewsItem class]])
        {
            if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
            {
                NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:item ];
                newsDetailsScreenWebView.pageIndex = i;
                [self.viewControllersList addObject:newsDetailsScreenWebView];
                
            }
            else
            {
                NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:item];
                newsDetailsScreen.pageIndex = i;
                [self.viewControllersList addObject:newsDetailsScreen];
            }
        }
        else if([item isKindOfClass:[VideoItem class]])
        {
            VideoDetailsViewController * videoDetailsScreen=[[VideoDetailsViewController alloc] initWithVideo:item];
            videoDetailsScreen.pageIndex = i;
            [self.viewControllersList addObject:videoDetailsScreen];
        }
        else
        {
            AdsViewController * viewController= [[AdsViewController alloc]init];
            viewController.pageIndex = i;
            viewController.item=item;
            [self.viewControllersList addObject:viewController];
            
        }
        
    }
    
#ifdef DEBUG
    NSLog(@"newsVC --- pageIndex: ");
    for (id VC in self.viewControllersList) {
        if ([VC isKindOfClass:[NewsDetailsViewControllerWithWKWebView class]]) {
            NewsDetailsViewControllerWithWKWebView *newsVC = (NewsDetailsViewControllerWithWKWebView*)VC;
            
            //NSLog(@"newsVC --- title: %@, section_id: %ld,champs_id: %ld, pageIndex: %ld", newsVC.title, (long)newsVC.section_id, (long)newsVC.champs_id, (long)newsVC.pageIndex);
            NSLog(@"newsVC --- pageIndex: %ld, \tnewsId: %ld, \tnewsTitle: %@", (long)newsVC.pageIndex, (long)newsVC.newsItem.newsId, newsVC.newsItem.newsTitle);
            
            
        }
    }
    NSLog(@"newsVC --- pageIndex: ");
#endif

}
-(void)loadMoreStoriesItems
{
    
    NSDictionary * paramDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%li",++self.pageNum]] forKeys:@[@"page"]];
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:Albums_API_Url,[WServicesManager getApiBaseURL]] andParameters:paramDic WithObjectName:@"Albums" andAuthenticationType:CMSAPIs success:^(id success)
     {
         Albums * response = success;
         [self.stories addObjectsFromArray: response.albums];
         [self.storiesListWithAds addObjectsFromArray: [[CustiomizeAdTypes alloc]initializeIntersitialCustomAdsWithUnitID:Intersitial_AD_UNIT_ID andItemsList: response.albums andRepeatCount:[Global getInstance].appInfo.adsRepeatCount andViewController:self]];
         
         [self setViewControllersObjects];
         
         
         
     }failure:^(NSError *error) {
         
         
     }];
}

//Swipe right - to go to the previous
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index;
    if([viewController isKindOfClass:[GalleryDetailsViewController class]])
        index = ((GalleryDetailsViewController*)viewController).pageIndex;
    else  if([viewController isKindOfClass:[VideoDetailsViewController class]])
        index = ((VideoDetailsViewController*)viewController).pageIndex;
    else  if([viewController isKindOfClass:[NewsDetailsViewController class]])
        index = ((NewsDetailsViewController*)viewController).pageIndex;
    else  if([viewController isKindOfClass:[NewsDetailsViewControllerWithWKWebView class]])
        index = ((NewsDetailsViewControllerWithWKWebView*)viewController).pageIndex;
    else
        index = ((AdsViewController*)viewController).pageIndex;
    
    
    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }
    
    
    index--;
    
#ifdef DEBUG
    //TESTING
    /*if ([[self.viewControllersList objectAtIndex:self.currentIndex] isKindOfClass: [NewsDetailsViewControllerWithWKWebView class]]) {
        NewsDetailsViewControllerWithWKWebView *oldNewsVC = (NewsDetailsViewControllerWithWKWebView*)[self.viewControllersList objectAtIndex:self.currentIndex];
        NSLog(@"Old newsVC --- pageIndex: %ld, \tnewsId: %ld, \tnewsTitle: %@", (long)oldNewsVC.pageIndex, (long)oldNewsVC.newsItem.newsId, oldNewsVC.newsItem.newsTitle);
    } else {
        NSLog(@"Old not newsVC --- pageIndex: %@", [self.viewControllersList objectAtIndex:self.currentIndex]);
    }
    if ([[self.viewControllersList objectAtIndex:index] isKindOfClass: [NewsDetailsViewControllerWithWKWebView class]]) {
        NewsDetailsViewControllerWithWKWebView *newNewsVC = (NewsDetailsViewControllerWithWKWebView*)[self.viewControllersList objectAtIndex:index];
        NSLog(@"New newsVC --- pageIndex: %ld, \tnewsId: %ld, \tnewsTitle: %@ \n", (long)newNewsVC.pageIndex, (long)newNewsVC.newsItem.newsId, newNewsVC.newsItem.newsTitle);
    } else {
        NSLog(@"New not newsVC --- pageIndex: %@", [self.viewControllersList objectAtIndex:index]);
    }*/
#endif
    
    return [self.viewControllersList objectAtIndex:index];
}

//Swipe left - to go to the next
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index;
    if([viewController isKindOfClass:[GalleryDetailsViewController class]])
        index = ((GalleryDetailsViewController*)viewController).pageIndex;
    else  if([viewController isKindOfClass:[VideoDetailsViewController class]])
        index = ((VideoDetailsViewController*)viewController).pageIndex;
    else  if([viewController isKindOfClass:[NewsDetailsViewController class]])
        index = ((NewsDetailsViewController*)viewController).pageIndex;
    else  if([viewController isKindOfClass:[NewsDetailsViewControllerWithWKWebView class]])
        index = ((NewsDetailsViewControllerWithWKWebView*)viewController).pageIndex;
    else
        index = ((AdsViewController*)viewController).pageIndex;
    
    if (index == [self.storiesListWithAds count]-5 && self.selectedAlbum
        != nil)
    {
        [self loadMoreStoriesItems];
    }
    
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [self.viewControllersList count]) {
        return nil;
    } else {
        
#ifdef DEBUG
        //TESTING
        if ([[self.viewControllersList objectAtIndex:self.currentIndex] isKindOfClass: [NewsDetailsViewControllerWithWKWebView class]]) {
            NewsDetailsViewControllerWithWKWebView *oldNewsVC = (NewsDetailsViewControllerWithWKWebView*)[self.viewControllersList objectAtIndex:self.currentIndex];
            NSLog(@"Old newsVC --- pageIndex: %ld, \tnewsId: %ld, \tnewsTitle: %@", (long)oldNewsVC.pageIndex, (long)oldNewsVC.newsItem.newsId, oldNewsVC.newsItem.newsTitle);
        } else {
            NSLog(@"Old not newsVC --- pageIndex: %@", [self.viewControllersList objectAtIndex:self.currentIndex]);
        }
        if ([[self.viewControllersList objectAtIndex:index] isKindOfClass: [NewsDetailsViewControllerWithWKWebView class]]) {
            NewsDetailsViewControllerWithWKWebView *newNewsVC = (NewsDetailsViewControllerWithWKWebView*)[self.viewControllersList objectAtIndex:index];
            NSLog(@"New newsVC --- pageIndex: %ld, \tnewsId: %ld, \tnewsTitle: %@ \n", (long)newNewsVC.pageIndex, (long)newNewsVC.newsItem.newsId, newNewsVC.newsItem.newsTitle);
        }else {
            NSLog(@"New not newsVC --- pageIndex: %@", [self.viewControllersList objectAtIndex:index]);
        }
#endif

    }    

    
    return [self.viewControllersList objectAtIndex:index];
}

@end
