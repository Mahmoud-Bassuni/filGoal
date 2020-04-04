//
//  FeaturedAreaSliderViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 2/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "FeaturedAreaSliderViewController.h"
#import "Images.h"
#import "UIImageView+WebCache.h"

@interface FeaturedAreaSliderViewController ()
{
    BOOL  pageControlBeingUsed;
}
@property (weak, nonatomic) IBOutlet UIView *pageControlContainerV;
@end

@implementation FeaturedAreaSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    pageControlBeingUsed = NO;
    [super viewDidAppear:YES];
    self.pageControl.numberOfPages=self.topNewsItems.count;
    self.pageControl.currentPage=self.topNewsItems.count-1;
    self.scrollView.delegate = self;
    self.scrollTimer=[NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(scrollPages) userInfo:nil repeats:YES];
    [self addFeaturedNewsSlider];
}
-(void)viewDidAppear:(BOOL)animated
{
    CGPoint point=self.scrollView.contentOffset;
    point.x=((self.topNewsItems.count-1)*Screenwidth);
    [self.scrollView setContentOffset:point animated:YES];
    [self.scrollView setContentSize:CGSizeMake(Screenwidth*self.topNewsItems.count,self.scrollView.frame.size.height)];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.scrollTimer invalidate];
    self.scrollView = nil;
}
-(void)addFeaturedNewsSlider
{
    for (int i = 0; i < self.topNewsItems.count; i++) {
        CGRect frame;
        NewsItem *newsItem= [self.topNewsItems objectAtIndex:i];
        frame.origin.x = Screenwidth * i;
        frame.origin.y = 0;
        frame.size = CGSizeMake(Screenwidth, 230);
        UIImageView * newsImgView = [[UIImageView alloc]initWithFrame:frame];;
        UILabel * newsTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-80, Screenwidth-20, 50)];;
        CGSize labelSize = [newsItem.status sizeWithFont:[UIFont fontWithName: @"DINNextLTW23Regular" size: 14.0f] constrainedToSize:CGSizeMake(87, 40) lineBreakMode:UILineBreakModeWordWrap];
        UILabel * featuredLbl = [[UILabel alloc]initWithFrame:CGRectMake(newsTitleLbl.frame.size.width-labelSize.width-10, newsTitleLbl.frame.origin.y-labelSize.height, labelSize.width+10,labelSize.height)];;
        UIImageView * featuredImage = [[UIImageView alloc]initWithFrame:CGRectMake(( newsTitleLbl.frame.origin.x+ newsTitleLbl.frame.size.width - 75), newsImgView.bounds.size.height/2 - 8 , 75,50)];;
        featuredLbl.font = [UIFont fontWithName:@"DINNextLTW23Regular" size:14];
        featuredLbl.backgroundColor = [UIColor redColor];
        featuredLbl.textColor = [UIColor whiteColor];
        featuredLbl.textAlignment = NSTextAlignmentRight;
        if(![newsItem.status isEqualToString:@""])
        {
            featuredLbl.hidden = YES;
            //featuredLbl.text=[NSString stringWithFormat:@"  %@",newsItem.status];
            //NSLog(@"%d", newsItem.status_id);
            NSString *urlofImage = [@"https://semedia.filgoal.com/Photos/Icons/NewsStatus/" stringByAppendingFormat:@"%d", [newsItem.status_id integerValue]] ;
            
            [featuredImage sd_setImageWithURL:[NSURL URLWithString:[urlofImage stringByAppendingString:@".png"]]];
            NSLog(@"%@", urlofImage);
            
            
        }
        else
        {
            featuredLbl.hidden=YES;
        }
        
        Images *imageItem;
        if(newsItem.images.count>0)
            imageItem =[newsItem.images objectAtIndex:0];
        
        [newsImgView sd_setImageWithURL:[NSURL URLWithString:imageItem.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  
                                  [self.activityIndicator stopAnimating];
                                  [self.activityIndicator setHidden:YES];
                              }];
        newsTitleLbl.text = [NSString stringWithFormat: @"%@",newsItem.newsTitle];
        newsTitleLbl.backgroundColor = [UIColor clearColor];;
        newsTitleLbl.textColor = [UIColor whiteColor];
        newsTitleLbl.textAlignment = NSTextAlignmentRight;
        newsTitleLbl.font = [UIFont fontWithName:@"DINNextLTW23Regular" size:16];
        newsTitleLbl.numberOfLines = 2;
        newsImgView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topNewsClicked:)];
        gesture.numberOfTapsRequired = 1;
        newsImgView.tag = i;
        newsImgView.userInteractionEnabled = YES;
        [newsImgView addGestureRecognizer:gesture];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = newsImgView.bounds;
        gradient.colors = @[(id)[UIColor clearColor].CGColor,
                            (id)[UIColor blackColor].CGColor];
        [newsImgView.layer addSublayer:gradient];
        [newsImgView addSubview:featuredLbl];
        [newsImgView addSubview:newsTitleLbl];
        [newsImgView addSubview:featuredImage];
        [self.scrollView addSubview:newsImgView];
        
    }
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.delegate = self;
    self.pageControl.currentPage = self.topNewsItems.count-1;
    self.pageControl.numberOfPages = self.topNewsItems.count;
    //Old
    self.pageControl.clipsToBounds = YES;
    //self.pageControl.layer.cornerRadius = 10;
    //  self.pageControl.backgroundColor = [UIColor darkGrayColor];
    //self.pageControl.layer.borderColor = [[UIColor greyColor]CGColor];
    //self.pageControl.layer.borderWidth = 1.0;

    //New
    self.pageControlContainerV.clipsToBounds = YES;
    self.pageControlContainerV.layer.cornerRadius = 10;
    self.pageControlContainerV.layer.borderColor = [[UIColor greyColor]CGColor];
    self.pageControlContainerV.layer.borderWidth = 1.0;
    
}

-(void)scrollPages{
    CGPoint point=self.scrollView.contentOffset;
    
    
    if (point.x==0) {
        point.x=((self.topNewsItems.count-1)*Screenwidth);
        
    }
    else if (point.x<0)  // sometimes x value is below to zero
    {
        point.x=0;
        
    }
    else {
        point.x=point.x-Screenwidth;
    }
    [self.scrollView setContentOffset:point animated:YES];
    // add gradient layer on uiimage
    
}

- (IBAction)updatePage:(UIPageControl *)pageControl
{
    // [self.carousel scrollToItemAtIndex:pageControl.currentPage * self.topNewsItems.count duration:0.5];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (pageControlBeingUsed)
        return;
    
    CGFloat pageWidth = sender.frame.size.width;
    int page=1;
    if(sender.contentOffset.x<0){
        return;
    }
    else if(sender.contentOffset.x==0)
        page=0;
    else
        page =  sender.contentOffset.x  / pageWidth;
    
    self.pageControl.currentPage = page;
}


-(void)topNewsClicked:(UITapGestureRecognizer*)sender
{
    NewsItem *newsItem= [self.topNewsItems objectAtIndex:(int)sender.view.tag];
    
    if (newsItem.isRedirect && newsItem.redirectionUrl!=nil)
    {
        [UniversalLinks handleUniversalLinksWithUrlString:newsItem.redirectionUrl andIsRedirectedUrl:YES];
        
        NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:newsItem];
        newsDetailsScreenWebView.pageIndex=(int)sender.view.tag;
        [self addViewControllerToPagerView:newsDetailsScreenWebView withList:self.topNewsItems andSelectedItem:newsItem andCurrentIndex:(int)sender.view.tag];

    }
    else
    {
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
        {
            NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:newsItem];
            newsDetailsScreenWebView.pageIndex=(int)sender.view.tag;
            [self addViewControllerToPagerView:newsDetailsScreenWebView withList:self.topNewsItems andSelectedItem:newsItem andCurrentIndex:(int)sender.view.tag];
        }
        else
        {
            NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:newsItem];
            newsDetailsScreen.pageIndex=(int)sender.view.tag;
            [self addViewControllerToPagerView:newsDetailsScreen withList:self.topNewsItems andSelectedItem:newsItem andCurrentIndex:(int)sender.view.tag];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addViewControllerToPagerView:(UIViewController*) viewController withList:(NSArray*)list andSelectedItem:(id)selectedItem andCurrentIndex:(int) currentIndex
{
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    PagerViewController * pagerViewController = [[PagerViewController alloc]init];
    pagerViewController = [[PagerViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pagerViewController.storiesListWithAds = [[NSMutableArray alloc]initWithArray:list];
    pagerViewController.stories = [[NSMutableArray alloc]initWithArray:list];
    pagerViewController.selectedNewsItem = selectedItem;
    pagerViewController.currentIndex = currentIndex;
    pagerViewController.pageNum = 0;
    [pagerViewController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:pagerViewController animated:YES];
}


@end
