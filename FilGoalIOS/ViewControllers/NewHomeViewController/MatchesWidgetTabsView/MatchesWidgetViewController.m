//
//  MatchesWidgetViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "MatchesWidgetViewController.h"
#import "WeekMatchesViewController.h"
#import "UsersStatisticsViewController.h"
@interface MatchesWidgetViewController ()
{
    NSInteger selectedTabIndex;
    HMSegmentedControl *segmentedControl1;
}
@end

@implementation MatchesWidgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.matches = [self.matchesDic objectForKey:@"today"];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    selectedTabIndex=1;
    if(self.matches.count>10)
    {
        NSArray *items = [self.matches subarrayWithRange: NSMakeRange( 0, 10 )];
        NSMutableArray * list = [NSMutableArray arrayWithArray:items];
        self.matches =list;
    }
    self.moreMatchesBtn.layer.cornerRadius = 15;
    self.moreMatchesBtn.clipsToBounds = YES;
    self.moreMatchesBtn.layer.borderWidth = 1.0;
    self.moreMatchesBtn.layer.borderColor = [[UIColor colorWithRed:0.20 green:0.23 blue:0.16 alpha:1.0]CGColor];
    [self setupTabsView];
    if(self.matches.count == 0)
    {
        self.noMatchesLbl.hidden = NO;
        self.tableView.hidden = YES;
    }
    else
    {
        self.noMatchesLbl.hidden = YES;
        self.tableView.hidden = NO;

    }
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView = [[UIView alloc]init];
    [self setScreenSponsor];
    if(segmentedControl1 != nil){
    [self segmentedControlChangedValue:segmentedControl1];
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupTabsView
{
    segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles: @[@"غدا",@"اليوم",@"أمس"]];
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    segmentedControl1.frame = CGRectMake(0, 0, self.tabsView.frame.size.width, self.tabsView.frame.size.height);
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segmentedControl1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    segmentedControl1.selectionIndicatorBoxColor = [UIColor mainAppYellowColor];
    [segmentedControl1 setSelectionIndicatorBoxOpacity:1.0];
    segmentedControl1.selectionIndicatorHeight = 0.0;
    segmentedControl1.selectedSegmentIndex = 1;
    //segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl1.verticalDividerEnabled = YES;
    segmentedControl1.verticalDividerColor = [UIColor fa_brownishGreyColor];
  //  segmentedControl1.verticalDividerWidth = 1.0f;
    [segmentedControl1 setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString;
        if(!selected)
        {
       attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor fa_brownishGreyColor],NSFontAttributeName:[UIFont defaultMeduimFontOfSize:16.0]}];
        }
        else
            attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont defaultMeduimFontOfSize:16.0]}];

        return attString;
    }];
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    _tabsView.layer.cornerRadius = 17;
    _tabsView.layer.borderWidth = 0.5;
    segmentedControl1.layer.cornerRadius=17;
    segmentedControl1.clipsToBounds=YES;
    _tabsView.clipsToBounds=YES;
    _tabsView.layer.borderColor = [[UIColor fa_brownishGreyColor]CGColor];
    [_tabsView addSubview:segmentedControl1];
}
-(void)setScreenSponsor
{
        self.sponsorImg.hidden=YES;
        if([AppSponsors isSectionCoSponsorActiveUsingId:self.sectionId])
        {
//          NSString *  sponsorUrl=[NSString stringWithFormat:@"%@",[AppSponsors getSpecialSectionImagePathUsingId:self.sectionId]];
            NSString *sponsorUrl=[NSString stringWithFormat:@"%@", [AppSponsors getMatchesWidgetSponsorImagePathUsingChampionId:self.championId]];
            self.sponsorImg.tapURL = [AppSponsors activeSectionCoSponsorTapUrlUsingId:self.championId category:@"Matches"];
            [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(error)
                {
                    self.sponsorImg.hidden=YES;
                }
                else
                {
                    self.sponsorImg.hidden=NO;
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"ReloadMatchesWidget" object:nil userInfo:[[NSDictionary alloc]initWithObjects:@[@(self.tableView.contentSize.height+image.size.height)] forKeys:@[@"height"]]];
                }
            }];
        }
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    if(segmentedControl.selectedSegmentIndex == 2)
    {
        self.matches = [self.matchesDic objectForKey:@"yesterday"];
    }
    else if(segmentedControl.selectedSegmentIndex == 1)
    {
        self.matches = [self.matchesDic objectForKey:@"today"];
 
    }
    else if(segmentedControl.selectedSegmentIndex == 0)
    {
        self.matches = [self.matchesDic objectForKey:@"tomorrow"];

    }
    if(self.matches.count>10)
    {
        NSArray *items = [self.matches subarrayWithRange: NSMakeRange( 0, 10 )];
        NSMutableArray * list = [NSMutableArray arrayWithArray:items];
        self.matches =list;
    }
    
    if(self.matches.count>0)
    {
    self.noMatchesLbl.hidden = YES;
    self.tableView.hidden = NO;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
        
        if([AppSponsors isSectionCoSponsorActiveUsingId:self.sectionId])
        {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ReloadMatchesWidget" object:nil userInfo:[[NSDictionary alloc]initWithObjects:@[@(self.tableView.contentSize.height+self.sponsorImg.frame.size.height)] forKeys:@[@"height"]]];
        }
       else
       [[NSNotificationCenter defaultCenter]postNotificationName:@"ReloadMatchesWidget" object:nil userInfo:[[NSDictionary alloc]initWithObjects:@[@(self.tableView.contentSize.height)] forKeys:@[@"height"]]];

    }
    else
    {
        self.noMatchesLbl.hidden = NO;
        self.tableView.hidden = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ReloadMatchesWidget" object:nil userInfo:[[NSDictionary alloc]initWithObjects:@[@(100+self.sponsorImg.frame.size.height)] forKeys:@[@"height"]]];
    }
    selectedTabIndex=segmentedControl.selectedSegmentIndex;
}

#pragma mark - TableView Datasource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier ;
    cellIdentifier =@"HomeMatchWidgetCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
    }
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil]objectAtIndex:0];
    if(self.matches.count>0)
    {
    MatchCenterDetails * item=[self.matches objectAtIndex:indexPath.row];
    [((HomeMatchWidgetCell*)cell) initCellWithMatchItem:item];
    [((HomeMatchWidgetCell*)cell).predictBtn addTarget:self action:@selector(predictBtnAction:) forControlEvents:UIControlEventTouchUpInside];
   [((HomeMatchWidgetCell*)cell).statisticsBtn addTarget:self action:@selector(statisticsBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchCenterDetails * item=[self.matches objectAtIndex:indexPath.row];
    if ([[Global getInstance]isActiveChampion:(int)item.championshipId andRoundId:(int)item.roundId]&&item.matchStatusHistory.count>0&&[[item.matchStatusHistory objectAtIndex:0] matchStatusIndicatorId] == MatchNotStartedIndicatorID){
        return 170;
    }
    else{
        return 141;
       // return 170;

    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.matches.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MatchCenterDetails * item = self.matches[indexPath.row];
    MatchCenterTabsViewController * matchCenter=[[MatchCenterTabsViewController alloc]init];
    matchCenter.matchCenterDetails = item;
    UINavigationController * navigationContoller = [delegate getSelectedNavigationController];
    [navigationContoller pushViewController:matchCenter animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)moreMatchesBtnPressed:(id)sender {
    if(self.sectionId == 0)
    {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    WeekMatchesViewController * matchesVC = [[WeekMatchesViewController alloc]initWithNibName:@"WeekMatchesViewController" bundle:nil];
//   // matchesVC.selectedTabIndex=selectedTabIndex;
//   // matchesVC.isFromWidget = true;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SetTabIndex" object:nil userInfo:@{@"isFrom":@(true),@"selectedIndex":@(selectedTabIndex)}];

    [delegate.tabbarController setSelectedIndex:2];

//    UINavigationController * navigationContoller = [delegate getSelectedNavigationController];
//    [navigationContoller pushViewController:matchesVC animated:YES];
    }
    else
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"TabIndex" object:[NSString stringWithFormat:@"%i",4 ]];
    }
}

#pragma mark - Handle Prediction Action
- (IBAction)predictBtnAction:(UIButton*)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(HomeMatchWidgetCell*)sender.superview.superview];
    MatchCenterDetails * item=[self.matches objectAtIndex:indexPath.row];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"FilGoalPredictions://"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"FilGoalPredictions://https://predictnwin.filgoal.com/prediction/Predict?champId=%li&MatchId=%li",(long)item.championshipId,(long)item.idField]]];
    }
    else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://predictnwin.filgoal.com/prediction/Predict?champId=%li&MatchId=%li",(long)item.championshipId,(long)item.idField]]];
    }
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Predictions"
                                                          action:@"Predict-Button"
                                                           label:[NSString stringWithFormat:@"Match ID = %i ",item.idField]
                                                           value:nil] build]];
}
- (IBAction)statisticsBtnPressed:(UIButton*)sender {
#pragma mark - Handle UserStatistics Action
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(HomeMatchWidgetCell*)sender.superview.superview];
    UsersStatisticsViewController * viewController = [[UsersStatisticsViewController alloc]init];
    MatchCenterDetails * item=[self.matches objectAtIndex:indexPath.row];
    viewController.matchItem = item;
    // viewController.delegate = self;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:viewController];
    popupController.style = STPopupStyleFormSheet;
    [popupController presentInViewController:GetAppDelegate().getSelectedNavigationController.topViewController];
}

@end
