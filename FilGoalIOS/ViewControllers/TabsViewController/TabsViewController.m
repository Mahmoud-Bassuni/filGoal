//
//  TabsViewController.m
//  Reyada
//
//  Created by Nada Gamal on 8/13/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import "TabsViewController.h"
//#import "EmTracker.h"
#import "Constants.h"
@interface TabsViewController ()

@end

@implementation TabsViewController

- (void)viewDidLoad {
    super.isFromChampSection=self.isFromChampSection;
    [super viewDidLoad];
    self.isProgressiveIndicator = NO;
    //[[EmTracker sharedInstance] trackDefault];
    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor mainAppYellowColor]];
    [self.buttonBarView registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:[NSBundle bundleForClass:[self class]]]  forCellWithReuseIdentifier:@"Cell"];
    [self.buttonBarView setBackgroundColor:[UIColor whiteColor]];
    self.buttonBarView.contentSize = CGSizeMake(2000, 45);
    [self.buttonBarView setShouldCellsFillAvailableWidth:YES];
    
    // to solve the invisible cells at uicollectionview because cell return nil at iOS 10 only
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
        [self.buttonBarView setPrefetchingEnabled:NO];
    
    self.delegate=self;
    if(self.isFromChampSection)
        [self.buttonBarView moveToIndex:self.childViewControllers.count-4 animated:YES swipeDirection:XLPagerTabStripDirectionRight pagerScroll:XLPagerScrollOnlyIfOutOfScreen];
    else if(self.isFromMatchesList)
    {
        [self.buttonBarView moveToIndex:4 animated:YES swipeDirection:XLPagerTabStripDirectionRight pagerScroll:XLPagerScrollOnlyIfOutOfScreen];
        
    }
    else
        [self.buttonBarView moveToIndex:self.childViewControllers.count-1 animated:YES swipeDirection:XLPagerTabStripDirectionRight pagerScroll:XLPagerScrollOnlyIfOutOfScreen];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(void)viewDidDisappear:(BOOL)animated
{
    self.isFromChampSection=NO;
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    super.isFromChampSection=self.isFromChampSection;
    [self.buttonBarView layoutIfNeeded];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.buttonBarView.frame=CGRectMake(0, self.buttonBarView.frame.origin.y, Screenwidth, 35);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - XLPagerTabStripViewControllerDelegate
//
//-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
//          updateIndicatorFromIndex:(NSInteger)fromIndex
//                           toIndex:(NSInteger)toIndex
//{
//    
//    XLPagerTabStripDirection direction = XLPagerTabStripDirectionLeft;
//    if (toIndex < fromIndex){
//        direction = XLPagerTabStripDirectionRight;
//    }
//    [self.buttonBarView moveToIndex:toIndex animated:YES swipeDirection:direction pagerScroll:XLPagerScrollYES];
//    if (self.changeCurrentIndexBlock) {
//        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
//        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
//        self.changeCurrentIndexBlock(oldCell, newCell, YES);
//    }
//    
//    // [[Global getInstance]setCurrentTabIndex:self.currentIndex];
//    //  [self.buttonBarView moveToIndex:self.currentIndex animated:YES swipeDirection:direction pagerScroll:XLPagerScrollYES];
//    UIViewController * standingsViewController=[_childViewControllers objectAtIndex:toIndex];
//    
//    if (self.isFromDetails)
//    {
//        if ([standingsViewController isKindOfClass:[ChampGStandingsViewController class]]||[standingsViewController isKindOfClass:[ChampStandingsViewController class]])
//        {
//            
//            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            appDelegate.isFullScreen=YES;
//            
//        }
//        
//        else
//        {
//            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            appDelegate.isFullScreen=NO;
//        }
//        
//    }
//    // [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection::];
//    XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
//    XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
//    if(!self.isSelected)
//    {
//        newCell.backgroundColor=[UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
//        //newCell.label.textColor=[UIColor whiteColor];
//        oldCell.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0];
//    }
//    else
//        self.isSelected=NO;
//    
//    
//    
//    // oldCell.label.textColor=[UIColor whiteColor];
//    
//    
//    
//}
//
//-(void)pagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
//          updateIndicatorFromIndex:(NSInteger)fromIndex
//                           toIndex:(NSInteger)toIndex
//            withProgressPercentage:(CGFloat)progressPercentage
//                   indexWasChanged:(BOOL)indexWasChanged
//{
//    
//    
//    XLPagerTabStripDirection direction = XLPagerTabStripDirectionLeft;
//    if (toIndex < fromIndex){
//        direction = XLPagerTabStripDirectionRight;
//    }
//    [self.buttonBarView moveToIndex:toIndex animated:YES swipeDirection:direction pagerScroll:XLPagerScrollYES];
//    if (self.changeCurrentIndexBlock) {
//        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
//        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
//        self.changeCurrentIndexBlock(oldCell, newCell, YES);
//    }
//    UIViewController * standingsViewController=[_childViewControllers objectAtIndex:toIndex];
//    
//    if (self.isFromDetails)
//    {
//        if ([standingsViewController isKindOfClass:[ChampGStandingsViewController class]]||[standingsViewController isKindOfClass:[ChampStandingsViewController class]])
//        {
//            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            appDelegate.isFullScreen=YES;
//            
//        }
//        
//        else
//        {
//            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            appDelegate.isFullScreen=NO;
//        }
//        
//        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
//        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
//        if(!self.isSelected)
//        {
//            newCell.backgroundColor=[UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
//            oldCell.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0];
//        }
//        else
//            self.isSelected=NO;
//        
//    }
//    
//    
//    
//}
#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    // create child view controllers that will be managed by XLPagerTabStripViewController
    
    
    return self.childViewControllers;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (BOOL)shouldAutorotate {
    return NO;
    
    
}


@end
