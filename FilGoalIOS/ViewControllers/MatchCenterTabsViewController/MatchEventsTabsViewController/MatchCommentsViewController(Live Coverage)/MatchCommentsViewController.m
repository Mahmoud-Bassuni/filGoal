//
//  MatchCommentsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/14/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCommentsViewController.h"
#import "WServicesManager.h"
#import "MatchComment.h"
#import "MatchCommentsWithEvents.h"
#import  "UIImageView+WebCache.h"
#import "MatchCommentsWithTwoPlayersTableViewCell.h"
#import "MatchCommentsWithWebViewCell.h"
#import "CommentWebViewWithOneEventCell.h"
#import "MatchCommentSignalR.h"
#import "SVWebViewController.h"
#import "MatchCommentsWithCellTxtView.h"
#import "MatchCommentsWithTwoPlayersTableViewCellTxtView.h"
#import "CommentWebViewWithOneEventCellTxtView.h"
#import "GlobalViewController.h"
#define PADDING 50.0f
#define CONTENTHEIGHT 200.0f
#define TWITTERIMAGECONTENTHEIGHT 250.0f
#define PLAYER_VIEW_HEIGHT 90.0f
#define PLAYERS_VIEW_HEIGHT 180.0f
@import Firebase;
@interface MatchCommentsViewController ()

@end

@implementation MatchCommentsViewController
#define kLabelFrameMaxSize CGSizeMake(230, CGFLOAT_MAX)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName = [NSString stringWithFormat:@"iOS-Match center-Minute by Minute with match ID = %li",(long)self.matchItem.idField ];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-Match center-Minute by Minute with match ID = %li",(long)self.matchItem.idField ]
                                     }];
    self.loadingLbl.hidden=NO;
    [self.activityIndicator startAnimating];
    self.matchComments=[[NSMutableArray alloc]init];
    [self getMatchCommentsAndEvents];
    if([Global getInstance].appInfo.isSignalREnabled)
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCommentSignalR:) name:RELOAD_MATCH_COMMENTS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];

    
}
-(void)clearMemory
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    //[self.webView stopLoading];
    
    
}


-(void)updateCommentSignalR:(NSNotification*)note
{
    self.matchCommentsSignalR =[[NSMutableArray alloc]initWithArray:self.matchComments];
    [[NSNotificationCenter defaultCenter]removeObserver:RELOAD_MATCH_COMMENTS];
    NSMutableDictionary * commentsDic=[note object];
    self.matchEvents=[commentsDic objectForKey:@"MatchEvents"];
    self.matchStatusHistoryList=[commentsDic objectForKey:@"MatchStatusHistory"];
    MatchComment * item = [commentsDic objectForKey:@"Comment"];
    [self.matchCommentsSignalR addObject:item];
    MatchCommentsWithEvents * matchComentsEvents=[[MatchCommentsWithEvents alloc]initWithMatchComments:self.matchCommentsSignalR andEvents:self.matchEvents andMatchStatusHistory:self.matchStatusHistoryList];
    self.matchComments=matchComentsEvents.matchComments;
    if(self.matchComments.count>0)
    {
        self.loadingLbl.hidden=YES;
        [self.tableView reloadData];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //self.loadingLbl.hidden=NO;
    //[self.activityIndicator startAnimating];
    [self.activityIndicator setFrame: CGRectMake((Screenwidth/2)-20, 10, _activityIndicator.frame.size.width, _activityIndicator.frame.size.height)];
    self.tableView.frame=CGRectMake(0, 20, Screenwidth, self.tableView.frame.size.height);
    [self.loadingLbl setFrame: CGRectMake(40, 0, Screenwidth-80, self.loadingLbl.frame.size.height)];

    NSLog(@"%f",Screenwidth);
    NSLog(@"%f",Screenheight);
    float screenWidth;
    if(IS_IPHONE_4||IS_IPHONE_5)
        screenWidth=320;
    else if (IS_IPHONE_6)
        screenWidth=375;
    else if (IS_IPHONE_6_PLUS)
        screenWidth=414;
    
    
    
}
-(void)shareMatchCommentPressed:(NSNotification*)note
{
    MatchComment * item=[note object];
    NSLog(@"%@",item);
}
- (void)shareCommentBtnPressed:(UIButton*)sender {
  //  NSInteger rowIndex=[sender tag];
    UIView *aSuperview = [sender superview];
    while (![aSuperview isKindOfClass:[UITableViewCell class]]) {
        aSuperview = [aSuperview superview];
    }
    UITableViewCell *cell2 = (id) aSuperview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell2];
    MatchComment * item=[self.matchComments objectAtIndex:indexPath.section];
    NSString *text =item.content;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.filgoal.com/matches/%li/coverage",(long)item.matchId]];
    //UIImage *image = [UIImage imageNamed:@"roadfire-icon-square-200"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url]
     applicationActivities:nil];
    
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)getMatchCommentsAndEvents
{
    /// NSInteger matchID=19026;
    self.matchComments=[[NSMutableArray alloc]init];
    NSDictionary * parameters = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"MatchId eq %li",(long)self.matchItem.idField],@"Order desc,matchStatusId desc,time desc,Id desc" ]forKeys:@[@"$filter",@"$orderby"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchCommentsAPI,[WServicesManager getSportsEngineApiBaseURL]] andParameters:parameters WithObjectName:@"MatchComments" andAuthenticationType:SportesEngineAPIs success:^(MatchComments* matchComments)
     {
         self.matchComments=matchComments.matchComments;
     
         self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner",@"Match",[NSString stringWithFormat:@"فريق %@",self.matchItem.homeTeamName],[NSString stringWithFormat:@"فريق %@",self.matchItem.awayTeamName],[NSString stringWithFormat:@"بطولة %@",self.matchItem.championshipName],[NSString stringWithFormat:@"مباراة %@ و%@",self.matchItem.homeTeamName,self.matchItem.awayTeamName]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"iOS-Match center-Minute by Minute with match ID = %li",(long)self.matchItem.idField ]];
         if(matchComments.matchComments.count==0)
         {
             self.loadingLbl.hidden=NO;
             [self.activityIndicator stopAnimating];
             [self.loadingLbl setText:@"لا يوجد محتوي لهذه المباراة"];
            // self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner"] andPosition:@[@"Pos1"]];

             
         }
         else
         {
             
             MatchCommentsWithEvents * matchComentsEvents=[[MatchCommentsWithEvents alloc]initWithMatchComments:self.matchComments andEvents:self.matchEvents andMatchStatusHistory:self.matchStatusHistoryList];
             self.matchComments=matchComentsEvents.matchComments;
            // self.tableView.tableFooterView=[super setBannerViewFooter:@[@"Inner"] andPosition:@[@"Pos1"]];
//             NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"order"
//                                                                         ascending: NO];
//             self.matchComments = [[NSMutableArray alloc]initWithArray:[matchComments.matchComments sortedArrayUsingDescriptors:@[sortOrder]]];
//
             self.loadingLbl.hidden=YES;
             [self.activityIndicator stopAnimating];
             [self.tableView reloadData];
         }
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Comments with ID = %li ",(long)self.matchItem.idField]  ApiError:@"Success"];

     }
                        failure:^(NSError *error) {
                            IBGLog(@"Match Comments Error  : %@",error);
                            [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Match Comments with ID = %li ",(long)self.matchItem.idField]  ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
                            [self showDefaultNetworkingErrorMessageForError:error
                                                             refreshHandler:^{
                                                                 [self getMatchCommentsAndEvents];
                                                             }];

                            
                        }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}
#pragma mark - UITableView DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger  twiterImgHeight=0;
    MatchComment * item=[self.matchComments objectAtIndex:indexPath.section];
    NSString *theText=[NSString stringWithFormat:@"%@",item.content];
    CGSize labelSize = [theText sizeWithFont:[UIFont fontWithName: @"DINNextLTW23Regular" size: 14.0f] constrainedToSize:kLabelFrameMaxSize lineBreakMode:UILineBreakModeWordWrap];
    
    if(item.contentUrl!=nil && [item.contentUrl rangeOfString:@"pic.twitter"].location!=NSNotFound )
    {
        twiterImgHeight=TWITTERIMAGECONTENTHEIGHT;
    }
    else if(item.contentUrl!=nil && ([item.contentUrl rangeOfString:@"facebook"].location!=NSNotFound || [item.contentUrl containsString:@"embed"]))
    {
        twiterImgHeight = 150;
    }
    if(item.matchEvent==nil&&item.contentUrl!=nil&&![item.contentUrl isEqualToString: @""])
        return PADDING+labelSize.height+CONTENTHEIGHT+20+twiterImgHeight;
    else  if(item.matchEvent==nil&&(item.contentUrl==nil||[item.contentUrl isEqualToString: @""]))
        return PADDING+labelSize.height;
    else if(item.matchEvent.playerAId&&item.matchEvent.playerBId!=0&&item.contentUrl!=nil&&![item.contentUrl isEqualToString: @""])
        return PADDING+labelSize.height+PLAYERS_VIEW_HEIGHT+CONTENTHEIGHT-20+twiterImgHeight;
    else if(item.matchEvent.playerAId&&item.matchEvent.playerBId!=0&&(item.contentUrl==nil||[item.contentUrl isEqualToString: @""]))
        return PADDING+labelSize.height+PLAYERS_VIEW_HEIGHT+20;
    else if((((item.matchEvent.playerAId!=0&&item.matchEvent.playerBId==0))||(item.matchEvent.playerAId==0&&item.matchEvent.playerBId!=0))&&item.contentUrl!=nil&&![item.contentUrl isEqualToString: @""])
        return PADDING+labelSize.height+PLAYER_VIEW_HEIGHT+CONTENTHEIGHT+twiterImgHeight;
    else if(((item.matchEvent!=nil&&(item.matchEvent.playerAId!=0&&item.matchEvent.playerBId==0))||(item.matchEvent.playerAId==0&&item.matchEvent.playerBId!=0))&&(item.contentUrl==nil||[item.contentUrl isEqualToString: @""]))
        return PADDING+labelSize.height+PLAYER_VIEW_HEIGHT+20;
    else
        return 300;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString * cellIdentifier ;
    
    UITableViewCell *cell ;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
    }
    
    MatchComment * item=[self.matchComments objectAtIndex:indexPath.section];
    // CGFloat  commentTextViewHeight = [self setCommentTextHeight:item];
    // In case comment had event and only one player
    
    if((item.matchEvent!=nil&&(item.matchEvent.playerAId!=0&&item.matchEvent.playerBId==0))||(item.matchEvent.playerAId==0&&item.matchEvent.playerBId!=0))
    {
        
        if(item.contentUrl!=nil&&![item.contentUrl isEqualToString:@""])
        {
            cell= [CommentWebViewWithOneEventCell loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
            [((CommentWebViewWithOneEventCell*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            //  [((CommentWebViewWithOneEventCell*)cell).shareBtn setTag:indexPath.row];
            ((CommentWebViewWithOneEventCell*)cell).contentWebView.delegate=self;
        }
        else
        {
//            cell= [CommentWebViewWithOneEventCellTxtView loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
//            [((CommentWebViewWithOneEventCellTxtView*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            cell= [CommentWebViewWithOneEventCell loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
            [((CommentWebViewWithOneEventCell*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            //  [((CommentWebViewWithOneEventCell*)cell).shareBtn setTag:indexPath.row];
            ((CommentWebViewWithOneEventCell*)cell).contentWebView.delegate=self;
        }
        return cell;
        
        
    }
    else if(item.matchEvent.playerAId&&item.matchEvent.playerBId!=0)
    {
        if(item.contentUrl!=nil&&![item.contentUrl isEqualToString:@""])
        {
            // in this event which represent Playerers changed , I put the values of player b at first player because the first event is the out of player and the sec event is entering the player
            cell=  [MatchCommentsWithTwoPlayersTableViewCell loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
            // [((MatchCommentsWithTwoPlayersTableViewCell*)cell).shareBtn setTag:indexPath.row];
            [((MatchCommentsWithTwoPlayersTableViewCell*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            ((MatchCommentsWithTwoPlayersTableViewCell*)cell).contentWebView.delegate=self;
        }
        else
        {
//            cell=  [MatchCommentsWithTwoPlayersTableViewCellTxtView loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
//            // [((MatchCommentsWithTwoPlayersTableViewCell*)cell).shareBtn setTag:indexPath.row];
//            [((MatchCommentsWithTwoPlayersTableViewCellTxtView*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            cell=  [MatchCommentsWithTwoPlayersTableViewCell loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
            // [((MatchCommentsWithTwoPlayersTableViewCell*)cell).shareBtn setTag:indexPath.row];
            [((MatchCommentsWithTwoPlayersTableViewCell*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            ((MatchCommentsWithTwoPlayersTableViewCell*)cell).contentWebView.delegate=self;
        }
        return cell;
    }
    else
    {
        if(item.contentUrl!=nil&&![item.contentUrl isEqualToString:@""])
        {
            cell=[MatchCommentsWithWebViewCell loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
            [((MatchCommentsWithWebViewCell*)cell).shareBtn setTag:indexPath.section];
            [((MatchCommentsWithWebViewCell*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            ((MatchCommentsWithWebViewCell*)cell).contentWebView.delegate=self;
        }
        else
        {
//            cell=[MatchCommentsWithCellTxtView loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
//            [((MatchCommentsWithCellTxtView*)cell).shareBtn setTag:indexPath.section];
//            [((MatchCommentsWithCellTxtView*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            cell=[MatchCommentsWithWebViewCell loadCommentContentWithtableView:self.tableView cellForRowAtIndexPath:indexPath andCommentMinObj:item];
            [((MatchCommentsWithWebViewCell*)cell).shareBtn setTag:indexPath.section];
            [((MatchCommentsWithWebViewCell*)cell).shareBtn addTarget:self action:@selector(shareCommentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            ((MatchCommentsWithWebViewCell*)cell).contentWebView.delegate=self;
            
        }
        return cell;
    }
    // cell.textLabel.text=item.content;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.matchComments.count;
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
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    CGRect newBounds = webView.bounds;
//    newBounds.size.height = webView.scrollView.contentSize.height;
//    webView.bounds = newBounds;
  //  [webView sizeToFit];
    
}
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        GlobalViewController * webView=[[GlobalViewController alloc]init];
        webView.url=request.URL;
        [self.navigationController pushViewController:webView animated:YES];
    return NO;
    }
    if (navigationType == UIWebViewNavigationTypeOther&&![[NSString stringWithFormat:@"%@",request.URL]isEqualToString:@"about:blank"]&&[[NSString stringWithFormat:@"%@",request.URL] rangeOfString:@"applewebdata://"].location==NSNotFound)
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AddScrollingObserver" object:nil];
    return YES;
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
