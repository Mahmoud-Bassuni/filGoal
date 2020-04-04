//
//  TeamProfileTabsViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/12/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamProfileTabsViewController.h"
#import "PlayersViewController.h"
#import "NewScorersViewController.h"
@interface TeamProfileTabsViewController ()

@end

@implementation TeamProfileTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.buttonBarView registerNib:[UINib nibWithNibName:@"TeamProfileButtonCell" bundle:[NSBundle bundleForClass:[self class]]]  forCellWithReuseIdentifier:@"Cell"];
    self.isFromTeamProfile = YES;
    [self moveToViewControllerAtIndex:self.childViewControllers.count-1 animated:NO];
    [self setupTabsButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.isFromTeamProfile = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    self.isFromTeamProfile = NO;
}
-(void) setupTabsButtons
{
    self.isProgressiveIndicator = NO;
    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor mainAppYellowColor]];
    self.buttonBarView.selectedBarHeight = 3.0;
    [self.buttonBarView setBackgroundColor:[UIColor whiteColor]];
    [self.buttonBarView registerNib:[UINib nibWithNibName:@"TeamProfileButtonCell" bundle:[NSBundle bundleForClass:[self class]]]  forCellWithReuseIdentifier:@"Cell"];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    {
        self.view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        
    }
    self.delegate=self;
    // to solve the invisible cells at uicollectionview because cell return nil at iOS 10 only
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0"))
        [self.buttonBarView setPrefetchingEnabled:NO];
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
    
    XLButtonBarViewCell *oldCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex != fromIndex ? fromIndex : toIndex inSection:0]];
    XLButtonBarViewCell *newCell = (XLButtonBarViewCell*)[self.buttonBarView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    if(!self.isSelected)
    {
        newCell.label.backgroundColor=[UIColor whiteColor];;
        newCell.label.textColor=[UIColor blackColor];
        oldCell.label.backgroundColor=[UIColor whiteColor];
        oldCell.label.textColor=[UIColor secondGrayColor];
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
        newCell.label.backgroundColor=[UIColor whiteColor];;
        newCell.label.textColor=[UIColor blackColor];
        oldCell.label.backgroundColor=[UIColor whiteColor];
        oldCell.label.textColor=[UIColor secondGrayColor];
    }
    else
        self.isSelected=NO;
    
}
#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{

    TeamProfileDetailsViewController * teamProfileDetailsViewController = [[TeamProfileDetailsViewController alloc]init];
    teamProfileDetailsViewController.teamId = self.teamId;
    teamProfileDetailsViewController.title = @"نظرة عامة";
    teamProfileDetailsViewController.championships = self.championships;
    NewsHomeViewController* newsListScreen=[[NewsHomeViewController alloc]init];
    newsListScreen.title=@"أخبار";
    newsListScreen.teamId = self.teamId;
    VideosViewController* videosListScreen=[[VideosViewController alloc]init];
    videosListScreen.title=@"فيديوهات";
    videosListScreen.teamId = self.teamId;
    TeamMatchesViewController * matchesVC = [[TeamMatchesViewController alloc]init];
    matchesVC.title=@"المباريات";
    matchesVC.teamId = self.teamId;
    GalleriesViewController * galleriesViewController = [[GalleriesViewController alloc]init];
    galleriesViewController.title = @"الصور";
    galleriesViewController.teamId = self.teamId;
    PlayersViewController * playersVC = [[PlayersViewController alloc]init];
    playersVC.title = @"اللاعبون";
    playersVC.championships = self.championships;
    playersVC.teamId = self.teamId;
    NewScorersViewController * scorersVC = [[NewScorersViewController alloc]init];
    scorersVC.title =@"الهدافون";
    scorersVC.championships = self.championships;
    scorersVC.teamId = self.teamId;
    TeamStandingsViewController * standingsVC = [[TeamStandingsViewController alloc]init];
    standingsVC.title = @"الإنجازات";
    standingsVC.championships = self.championships;
    standingsVC.teamId = self.teamId;
    
    self.childViewControllers = [NSMutableArray arrayWithObjects:standingsVC,scorersVC,playersVC,galleriesViewController,videosListScreen,newsListScreen,matchesVC,teamProfileDetailsViewController, nil];
    
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
