//
//  MatchEventTabViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/14/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchEventTabViewController.h"
#import "MatchActionCellLoader.h"
#import "MatchEventsWithStatusHistory.h"
#import "MatchEvent.h"
@import Firebase;
@interface MatchEventTabViewController ()
{
}
@end

@implementation MatchEventTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = [NSString stringWithFormat:@"iOS-Match center-Events with match ID = %li",(long)self.matchItem.idField ];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-Match center-Events with match ID = %li",(long)self.matchItem.idField ]
                                     }];
    if(self.matchEventsList.count==0)
    {
        self.loadingLbl.hidden=NO;
        [self.loadingLbl setText:@"لا يوجد محتوي لهذه المباراة"];
       // self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner"] andPosition:@[@"Pos1"]];

    }
    else
    {
        self.loadingLbl.hidden=YES;
        [self getEventsWithMatchStatusHistory];
        //self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner"] andPosition:@[@"Pos1"]];


    }
    self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner",@"Match",[NSString stringWithFormat:@"فريق %@",self.matchItem.homeTeamName],[NSString stringWithFormat:@"فريق %@",self.matchItem.awayTeamName],[NSString stringWithFormat:@"بطولة %@",self.matchItem.championshipName],[NSString stringWithFormat:@"مباراة %@ و%@",self.matchItem.homeTeamName,self.matchItem.awayTeamName]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS-Match center-Events with match ID = %li",(long)self.matchItem.idField ]];

    if([Global getInstance].appInfo.isSignalREnabled)
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadEvents:) name:RELOAD_MATCH_EVENTS object:nil];


}

-(void)reloadEvents:(NSNotification*)note
{
    [[NSNotificationCenter defaultCenter]removeObserver:RELOAD_MATCH_EVENTS];
    self.matchEventsGroupedByStatuesList=[note object];
    if(self.matchEventsGroupedByStatuesList.count>0)
    {
        self.loadingLbl.hidden=YES;
        [self.tableView reloadData];

    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.frame=CGRectMake(0, 20, Screenwidth, self.tableView.frame.size.height);
    
    [self.loadingLbl setFrame: CGRectMake(40, 0, Screenwidth-80, self.loadingLbl.frame.size.height)];
    
   // self.matchEventsGroupedByStatuesList=[[NSMutableArray alloc]init];
 
}
#pragma mark - Load Events 
-(void)getEventsWithMatchStatusHistory
{
   // self.matchEventsList=[[NSArray alloc]initWithArray:self.matchEvents];
//    MatchEventsWithStatusHistory * matchEvents=[[MatchEventsWithStatusHistory alloc]initWithMatchEvents:self.matchEventsList andMatchStatusHistory:self.matchStatusHistory andIsAfterMatch:NO];
    self.matchEventsGroupedByStatuesList=self.matchEventsWithStatusHistory.matchEventsGroupedByStatuesList;
    NSMutableDictionary * goalsDic = [[NSMutableDictionary alloc]init];
    [goalsDic setObject:self.matchEventsWithStatusHistory.goalsList forKey:@"الأهداف"];
    if(self.matchEventsWithStatusHistory.goalsList.count>0)
        [self.matchEventsGroupedByStatuesList insertObject:goalsDic atIndex:0];

    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray*)[[(NSDictionary*)[self.matchEventsGroupedByStatuesList objectAtIndex:section]allValues]objectAtIndex:0] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return self.matchEvents.count;
    //  return self.matchStatusHistory.count;
  
    return self.matchEventsGroupedByStatuesList.count;
    
}
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView=[[UIView alloc]init];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(8, -1, Screenwidth-15, 25)];
    [title setBackgroundColor:[UIColor clearColor]];
    UIImageView *img=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matche_event_title"]];
    [img setFrame:CGRectMake((Screenwidth-90)/2, 1, 90, 20)];
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:10]];
    [title setTextColor:[UIColor colorWithRed:88.0/255.0 green:88.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setFrame:CGRectMake((Screenwidth-90)/2, -1, 90, 20)];
    [title setText:[[(NSDictionary*)[self.matchEventsGroupedByStatuesList objectAtIndex:section]allKeys]objectAtIndex:0]];
    if(self.matchEventsGroupedByStatuesList.count==0){
        title.text=@"لا يوجد احداث للمباراة";
        title.textAlignment=NSTextAlignmentCenter;
        [title setFrame:CGRectMake(0, 5, Screenwidth, 20)];
        [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:15]];
    }
    else{
        [headerView addSubview:img];
    }
   // [headerView addSubview:img];

    [headerView addSubview:title];
    return headerView;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchEvent * matchEvent=[[[(NSDictionary*)[self.matchEventsGroupedByStatuesList objectAtIndex:indexPath.section]allValues]objectAtIndex:0] objectAtIndex:indexPath.row];
        return   [MatchActionCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withMatchAction:matchEvent clubone:(int)self.matchItem.homeTeamId clubtwo:(int)self.matchItem.awayTeamId];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MatchEvent * matchEvent=[[[(NSDictionary*)[self.matchEventsGroupedByStatuesList objectAtIndex:indexPath.section]allValues]objectAtIndex:0] objectAtIndex:indexPath.row];

    return   [self getHeightForMatchRow:matchEvent];
}

-(int)getHeightForMatchRow:(MatchEvent*)item{
    int leftHeight=30;
    int rigthHeight=30;
    //for(MatchEvent *action in item){
        if(item.playerAId&&item.playerBId!=0&&item.teamId==_matchItem.homeTeamId)
        {
            leftHeight+=44;
        }
        else  if(item.playerAId&&item.playerBId!=0&&item.teamId==_matchItem.awayTeamId)
        {
            rigthHeight+=44;
        }
        else if (item.teamId==_matchItem.homeTeamId) {
            leftHeight+=22;
        }
        else if (item.teamId== _matchItem.awayTeamId) {
            rigthHeight+=22;
        }
   // }
    return leftHeight>rigthHeight?leftHeight:rigthHeight;
    
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}
//Scrolling
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y > 0){
        BOOL scroll= true;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"scrollUpNotification"
         object:userInfo];
        self.tableView.frame= CGRectMake(0, 20, Screenwidth,self.tableView.frame.size.height);
        
    }
    if (velocity.y < 0){
        BOOL scroll= false;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
        if(scrollView.contentOffset.y<=0)
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"scrollDownNotification"
         object:userInfo];
        self.tableView.frame= CGRectMake(0, 20, Screenwidth,self.tableView.frame.size.height);
        
    }
}
#pragma mark GADBanner Delegate implementation
- (void)adView:(DFPBannerView *)banner didFailToReceiveAdWithError:(GADRequestError *)error
{
    //  [self.errorLbl setText:[NSString stringWithFormat:@"%@",error]];
    
}
- (void)adViewDidReceiveAd:(DFPBannerView *)bannerView
{
    
}

@end
