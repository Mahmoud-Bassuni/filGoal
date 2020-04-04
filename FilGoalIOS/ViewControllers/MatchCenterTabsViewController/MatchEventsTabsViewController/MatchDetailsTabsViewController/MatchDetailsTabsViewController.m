//
//  MatchDetailsTabsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/6/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchDetailsTabsViewController.h"
#import "AfterMatchViewController.h"
#import "MatchTabsViewController.h"
#import "MatchOverviewViewController.h"
@interface MatchDetailsTabsViewController ()

@end

@implementation MatchDetailsTabsViewController

- (void)viewDidLoad {
    self.matchStatus=((MatchStatusHistory*)[self.matchCenterItem.matchStatusHistory objectAtIndex:0]).currentMatchStatus;
    self.isFromMatchDetails=YES;
    [super viewDidLoad];
    [self.buttonBarView setBackgroundColor:[UIColor colorWithRed:241.0f/255.0f green:241.0f/255.0f blue:241.0f/255.0f alpha:1.0]];

    self.buttonBarView.frame=CGRectMake(0, self.buttonBarView.frame.origin.y, Screenwidth,  self.buttonBarView.frame.size.height);

    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor colorWithRed:0.913 green:0.565 blue:0.038 alpha:1.000]];
    [self.buttonBarView registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:[NSBundle bundleForClass:[self class]]]  forCellWithReuseIdentifier:@"Cell"];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(scrollNotification:)
//                                                 name:@"scrollUpNotification"
//                                               object:nil];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
-(void)viewDidDisappear:(BOOL)animated
{
    self.isFromMatchDetails=NO;
}
-(void)viewDidAppear:(BOOL)animated
{

}

-(void)viewWillAppear:(BOOL)animated
{
    self.matchStatus=((MatchStatusHistory*)[self.matchCenterItem.matchStatusHistory objectAtIndex:0]).currentMatchStatus;
   // super.isFromMatchDetails=self.isFromMatchDetails;
    self.isFromMatchDetails=YES;
    [super viewWillAppear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - XLPagerTabStripViewControllerDelegate

-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
          updateIndicatorFromIndex:(NSInteger)fromIndex
                           toIndex:(NSInteger)toIndex
{
    [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection:XLPagerTabStripDirectionNone pagerScroll:XLPagerScrollNO];
    XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
    XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    [oldCell.label setTextColor:[UIColor colorWithWhite:0.665 alpha:1.000]];
    [newCell.label setTextColor:[UIColor blackColor]];
    newCell.backgroundColor=[UIColor whiteColor];
    oldCell.label.backgroundColor=[UIColor clearColor];
    oldCell.backgroundColor=[UIColor colorWithWhite:0.960 alpha:1.000];
    
}

-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
          updateIndicatorFromIndex:(NSInteger)fromIndex
                           toIndex:(NSInteger)toIndex
            withProgressPercentage:(CGFloat)progressPercentage
                   indexWasChanged:(BOOL)indexWasChanged
{
    
    [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection:XLPagerTabStripDirectionNone pagerScroll:XLPagerScrollNO];
    XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
    XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    [oldCell.label setTextColor:[UIColor colorWithWhite:0.665 alpha:1.000]];
    [newCell.label setTextColor:[UIColor blackColor]];
    newCell.backgroundColor=[UIColor whiteColor];
    oldCell.backgroundColor=[UIColor colorWithWhite:0.960 alpha:1.000];
    
}
#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    

    return self.childViewControllers;
}
// scrolling animation
//- (void) scrollNotification:(NSNotification *) notification
//{
//    BOOL scrollUp= [[notification.object objectForKey:@"scroll"] boolValue];
//    if (scrollUp)
//    {
//        [UIView animateWithDuration:0.3
//                         animations:^{
//
//                             [self.containerView setFrame:CGRectMake(0, self.containerView.frame.origin.y, Screenwidth,self.containerView.frame.size.height+self.containerView.frame.origin.y)];
//                         }];
//
//        CGPoint bottomOffset = CGPointMake(0,self.containerView.frame.origin.y);
//        [self.containerView setContentOffset:bottomOffset animated:YES];
//
//
//
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(scrollNotification:)
//                                                     name:@"scrollDownNotification"
//                                                   object:nil];
//
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"scrollUpNotification" object:nil];
//
//    }
//    else
//    {
//        CGPoint bottomOffset = CGPointMake(0,0);
//        [self.containerView setContentOffset:bottomOffset animated:YES];
//        [UIView animateWithDuration:0.6
//                         animations:^{
//
//                             [self.containerView setFrame:CGRectMake(0, self.containerView.frame.origin.y, Screenwidth,self.containerView.frame.size.height-self.containerView.frame.origin.y)];
//                         }];
//
//
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"scrollDownNotification" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(scrollNotification:)
//                                                     name:@"scrollUpNotification"
//                                                   object:nil];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
