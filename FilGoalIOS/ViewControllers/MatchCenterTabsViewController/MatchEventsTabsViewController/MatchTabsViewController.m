//
//  MatchTabsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchTabsViewController.h"
#import "TabsViewController.h"
#import "MatchFormulationTabViewController.h"
#import "MatchCommentsViewController.h"
#import "MatchEventTabViewController.h"
//#import "EmTracker.h"
#import "MatchComment.h"
#import "MatchEvents.h"
@interface MatchTabsViewController ()

@end

@implementation MatchTabsViewController

- (void)viewDidLoad {
    self.isFromEventsTabs=YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isProgressiveIndicator = NO;
    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor clearColor]];
    
    [self.buttonBarView setBackgroundColor:[UIColor clearColor]];
    [self.buttonBarView registerNib:[UINib nibWithNibName:@"EventButtonCell" bundle:[NSBundle bundleForClass:[self class]]]  forCellWithReuseIdentifier:@"Cell"];
    self.delegate=self;
    self.matchEvents=nil;
    [self setscreenSponsor];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    if(!self.isViewDidAppearCalledBefore)
    {
        [self moveToViewControllerAtIndex:1 animated:NO];
        
        self.isFromEventsTabs=YES;
    }
    else
        self.isFromEventsTabs=NO;
    
    
    self.isViewDidAppearCalledBefore=YES;
    [super viewDidAppear:YES];
    
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{

}
#pragma mark - Set Screen sponsers
-(void)setscreenSponsor{
    if(self.matchItem.championshipId !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.matchItem.championshipId])
    {
        NSString * sponsorUrl=[AppSponsors getMatchDetailsTabsSponsorImagePathUsingChampionId:self.matchItem.championshipId];
        self.sponsorImgView.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.matchItem.championshipId category:@"Matches"];
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgViewHeightConstraint.constant=image.size.height;
            
        }];
    }
    else
    {
        self.sponsorImgViewHeightConstraint.constant=0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark XLPagerTabStripChildItem
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}

#pragma mark - XLPagerTabStripViewControllerDelegate

-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
          updateIndicatorFromIndex:(NSInteger)fromIndex
                           toIndex:(NSInteger)toIndex
{
    
    XLPagerTabStripDirection direction = XLPagerTabStripDirectionLeft;
    if (toIndex < fromIndex){
        direction = XLPagerTabStripDirectionRight;
    }
    [self.buttonBarView moveToIndex:toIndex animated:YES swipeDirection:direction pagerScroll:XLPagerScrollYES];
    if (self.changeCurrentIndexBlock) {
        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
        self.changeCurrentIndexBlock(oldCell, newCell, YES);
    }
    
    
    if (toIndex==1)
    {
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.isFullScreen=YES;
        
    }
    
    else
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.isFullScreen=NO;
    }
    
    
    // [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection::];
    XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
    XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    if(!self.isSelected)
    {
        newCell.label.backgroundColor=[UIColor darkGrayColor];
        newCell.label.textColor=[UIColor lightGrayColor];
        oldCell.label.backgroundColor=[UIColor whiteColor];
        oldCell.label.textColor=[UIColor lightGrayColor];
    }
    else
        self.isSelected=NO;
    
    
    
}

-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
          updateIndicatorFromIndex:(NSInteger)fromIndex
                           toIndex:(NSInteger)toIndex
            withProgressPercentage:(CGFloat)progressPercentage
                   indexWasChanged:(BOOL)indexWasChanged
{
    
    
    XLPagerTabStripDirection direction = XLPagerTabStripDirectionLeft;
    if (toIndex < fromIndex){
        direction = XLPagerTabStripDirectionRight;
    }
    [self.buttonBarView moveToIndex:toIndex animated:YES swipeDirection:direction pagerScroll:XLPagerScrollYES];
    if (self.changeCurrentIndexBlock) {
        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
        self.changeCurrentIndexBlock(oldCell, newCell, YES);
    }
    
    XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
    XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    if(!self.isSelected)
    {
        newCell.label.backgroundColor=[UIColor darkGrayColor];
        newCell.label.textColor=[UIColor lightGrayColor];
        oldCell.label.backgroundColor=[UIColor whiteColor];
        oldCell.label.textColor=[UIColor lightGrayColor];
    }
    else
        self.isSelected=NO;
    
    
    
    
    
}
#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    
    MatchCommentsViewController * matchCommentsView=[[MatchCommentsViewController alloc]init];
    matchCommentsView.title=@"دقيقة بدقيقة";
    matchCommentsView.matchItem=self.matchItem;
    matchCommentsView.matchStatusHistoryList=self.matchStatusHistoryList;
    matchCommentsView.matchEvents=self.matchEventsList;
    //matchCommentsView.matchComments=matchCommentsList;
    //matchCommentsView.matchEvents=matchEventsList;
    MatchEventTabViewController * matchEventsView=[[MatchEventTabViewController alloc]init];
    matchEventsView.title=@"احداث المباراة";
    matchEventsView.matchItem=self.matchItem;
    matchEventsView.matchEventsWithStatusHistory=self.matchEventsWithStatusHistory;
    matchEventsView.matchEventsList=self.matchEventsList;
    matchEventsView.matchStatusHistory=self.matchStatusHistoryList;
    // matchEventsView.matchEvents=matchEventsList;
    MatchFormulationTabViewController * matchForumlationView =[[MatchFormulationTabViewController alloc]init];
    matchForumlationView.matchTeamsSquads=self.matchTeamsSquads;
    matchForumlationView.matchEvents=self.matchEventsList;
    matchForumlationView.title=@"التشكيل";
    matchForumlationView.matchDetails=self.matchDetails;
    // self.matchEventsList=nil;
    self.childViewControllers = [NSMutableArray arrayWithObjects:matchForumlationView,matchEventsView,matchCommentsView, nil];
    
    return self.childViewControllers;
}


@end
