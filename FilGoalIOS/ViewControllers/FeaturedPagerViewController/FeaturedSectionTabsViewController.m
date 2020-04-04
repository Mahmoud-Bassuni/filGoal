//
//  FeaturedSectionTabsViewController.m
//  Reyada
//
//  Created by Ahmed Kotb on 5/4/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "FeaturedSectionTabsViewController.h"
#import "RamdanDayViewController.h"

@interface FeaturedSectionTabsViewController ()

@end

@implementation FeaturedSectionTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.buttonBarView.backgroundColor = [UIColor whiteColor];
    self.buttonBarView.isFromFeaturedSeaction=YES;
    self.indicatorColor=[UIColor clearColor] ;
    if(IS_IPHONE_6_PLUS&&self.childViewControllers.count>2)
    {
        self.buttonBarView.frame = CGRectMake(0, self.buttonBarView.frame.origin.y, Screenwidth-80, 44);

    }
    else   if(IS_IPHONE_6_PLUS&&self.childViewControllers.count<3)
    {
        self.buttonBarView.frame = CGRectMake(0, self.buttonBarView.frame.origin.y, Screenwidth, 44);

    }
    else if(IS_IPHONE_6)
    {
    self.buttonBarView.frame = CGRectMake(0, self.buttonBarView.frame.origin.y, Screenwidth, 44);
    }
    else{
        self.buttonBarView.frame = CGRectMake(0, self.buttonBarView.frame.origin.y, Screenwidth, 44);

    }
    self.containerView.frame = CGRectMake(0,self.buttonBarView.frame.origin.y+self.buttonBarView.frame.size.height, Screenwidth, self.containerView.frame.size.height);
 //   [self moveToViewControllerAtIndex:self.childViewControllers.count - 1 animated:YES];
   // NSNumber *index = [NSNumber numberWithLong:self.childViewControllers.count];
    if(_selectedDate!=nil)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TabIndex" object:[NSString stringWithFormat:@"%ld",(long)self.selectedTabIndex ]];

    }
    else
        
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TabIndex" object:@0 ];
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell* oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL indexWasChanged, BOOL fromCellRowAtIndex)
    {
        if(indexWasChanged){
        
            
        
        }
    };
    [self.buttonBarView.selectedBar setBackgroundColor:self.indicatorColor];
    // [self.buttonBarView.selectedBar setBackgroundColor:[UIColor redColor]];
    self.navigationController.navigationItem.rightBarButtonItem=nil;
    [self.buttonBarView registerNib:[UINib nibWithNibName:@"ButtonCell" bundle:[NSBundle bundleForClass:[self class]]]  forCellWithReuseIdentifier:@"Cell"];
    self.isFromFeaturedSection=YES;
     //super.isFromFeaturedSeaction=YES;
     super.isFromFeaturedSection=self.isFromFeaturedSection;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.buttonBarView.isFromFeaturedSeaction=YES;
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
    // [self.buttonBarView moveToIndex:toIndex animated:YES swipeDirection:direction pagerScroll:XLPagerScrollYES];
    if (self.changeCurrentIndexBlock) {
        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
        self.changeCurrentIndexBlock(oldCell, newCell, YES);
    }
    
    //[[Global getInstance]setCurrentTabIndex:self.currentIndex];
    [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection:direction pagerScroll:XLPagerScrollYES];
    // [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection::];

     if (self.isFromFeaturedSection)
    {
    
        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];

        
        if(!self.isSelected)
        {
            newCell.backgroundColor=[UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
            //newCell.label.textColor=[UIColor whiteColor];
            oldCell.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0];
        }
        else
            self.isSelected=NO;
//        [oldCell.label setTextColor:[UIColor blackColor]];
//        [newCell.label setTextColor:[UIColor colorWithRed:0.714 green:0.145 blue:0.161 alpha:1]];
      //  [newCell.label setBackgroundColor:[UIColor greenColor]];

        
    }
    
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
    // [self.buttonBarView moveToIndex:toIndex animated:YES swipeDirection:direction pagerScroll:XLPagerScrollYES];
    if (self.changeCurrentIndexBlock) {
        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
        self.changeCurrentIndexBlock(oldCell, newCell, YES);
    }
    
    [self.buttonBarView moveToIndex:self.currentIndex animated:NO swipeDirection:direction pagerScroll:XLPagerScrollYES];

 if (self.isFromFeaturedSection)
    {

        
        XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
        XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
        if(!self.isSelected)
        {
            newCell.backgroundColor=[UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
            oldCell.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0  blue:0.0/255.0  alpha:1.0];
        }
        else
            self.isSelected=NO;

    }
    
    
    
}

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

@end
