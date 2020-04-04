//
//  AuthorProfileViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/5/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "AuthorProfileViewController.h"
#import "AuthorProfileHeaderViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationController+Transparency.h"
#import "AuthorProfileListingCell.h"
@import Firebase;
@interface AuthorProfileViewController ()
{
    int page ;
    NSMutableArray * opinions;
}
@end

@implementation AuthorProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName = @"iOS - Authors Details Screen";
    opinions=[[NSMutableArray alloc]init];
    [self getAuthorDetailsAPI: 0];
    [self addBottomPullToRefresh];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    page = 1;
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS - Authors Details Screen"
                                     }];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [super hideSponsorBanner:self.view];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    //Old Before New Sponsor Banner
    //self.title = @"";
    //AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    //[appDelegate.getSelectedNavigationController gsk_setNavigationBarTransparent:YES animated:NO];
    //appDelegate.getSelectedNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    //appDelegate.getSelectedNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    //[appDelegate.getSelectedNavigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}
-(void)viewWillDisappear:(BOOL)animated
{
        [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addBottomPullToRefresh
{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor blackColor];
    refreshControl.triggerVerticalOffset = 80.;
    [refreshControl addTarget:self action:@selector(refreshBottom) forControlEvents:UIControlEventValueChanged];
    self.tableView.bottomRefreshControl=refreshControl;
}
-(void)refreshBottom
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self getAuthorDetailsAPI: 0];
        [self.tableView.bottomRefreshControl endRefreshing];
    });
}
-(void)getAuthorDetailsAPI:(NSInteger)numberOfTries
{
    NSDictionary* paramDic = [[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"%i",page],@"10"] forKeys:@[@"page",@"pageSize"]];
    
    [WServicesManager getDataWithURLString: [NSString stringWithFormat: AuthorsDetailsAPI, [WServicesManager getApiBaseURL], self.author.idField]
                             andParameters: paramDic
                            WithObjectName: @"Author"
                     andAuthenticationType: CMSAPIs
                                   success:^(Author * author) {
        if (author.opinions.firstObject != nil) {   //Not Empty - have articles
            page += 1;
             [self.activityIndicator stopAnimating];
             self.author = author;
             [opinions addObjectsFromArray:author.opinions];
             [self.tableView reloadData];
             [self.tableView layoutIfNeeded];
             self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
             [self.view updateConstraints];
        } else {    //Empty - no articles
            [self.activityIndicator stopAnimating];
            self.author = author;
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
            [self.view updateConstraints];
        }
     } failure:^(NSError *error) {
         [self.activityIndicator startAnimating];
         if (numberOfTries >= 3) {
             [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getAuthorDetailsAPI: numberOfTries + 1];
                                          }];
         } else {
             [self getAuthorDetailsAPI: numberOfTries + 1];
         }
     }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    } else {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.author.opinions.count>0) {
        return 2;
    } else {
        return 1;
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AuthorCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AuthorProfileHeaderViewCell" owner:self options:nil]objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [((AuthorProfileHeaderViewCell*)cell)initWithAuthorCell:self.author];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AuthorProfileListingCell"];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AuthorProfileListingCell" owner:self options:nil]objectAtIndex:0];
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        NewsItem *item =[opinions objectAtIndex:indexPath.row];
        ((AuthorProfileListingCell*)cell).articalDateLbl.text = item.newsDate;
        ((AuthorProfileListingCell*)cell).articleTitleLbl.text = item.newsTitle;
        
        
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 1;
    } else {
        return opinions.count;
    }
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"DINNextLTW23Regular" size:14],
//                                 NSForegroundColorAttributeName: [UIColor blackColor]};
//    NSAttributedString * attributesStr = [[NSAttributedString alloc] initWithString:@"أراء الكاتب" attributes:attributes];
//    if(section == 1)
//        return attributesStr.string ;
//    else
//    return @"";
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]init];
    
    if(section == 1)
    {
    [headerView setBackgroundColor:[UIColor lightGrayAppColor]];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(8, 5, self.tableView.frame.size.width-20, 25)];
    [title setFont:[UIFont defaultMeduimFontOfSize:14]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentRight];
    title.text = @"أراء الكاتب";
    [title setBackgroundColor:[UIColor lightGrayAppColor]];
    [headerView addSubview:title];
    return headerView;
    }
    return nil;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 185;
    else
        return 93;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(opinions.count>0)
    {
    NewsItem *item =[opinions objectAtIndex:indexPath.row];
    NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:item ];
    NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:item ];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
        [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
    else
        [self.navigationController pushViewController:newsDetailsScreen animated:YES];
    }
}



@end
