//
//  BannersListViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/14/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "BannersListViewController.h"
#import "UIImageView+WebCache.h"
#import "SVWebViewController.h"
#import "BannerTableViewCell.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "GlobalViewController.h"
@interface BannersListViewController ()
{
    NSMutableArray * banners;
    AppInfo * appInfo;
    AppDelegate * appDelegate;
}
@end

@implementation BannersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:[NSString stringWithFormat:@"iOS- Interactive with Section ID =%li",(long)appInfo.specialSection.sectionID]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    // Do any additional setup after loading the view from its nib.
    banners=[[NSMutableArray alloc]init];
    appInfo=[Global getInstance].appInfo;
    //banners=appInfo.specialSection.banners;
    for(Banner * item in appInfo.specialSection.banners)
    {
    if([item.pageUrl rangeOfString:@"http://"].location!=NSNotFound)
    {
        [banners addObject:item];
    }
    }
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];

    self.title=@"محتوي تفاعلي";

}
-(void)viewWillAppear:(BOOL)animated
{

}

-(void)viewDidAppear:(BOOL)animated
{
  //  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   // appDelegate.isFullScreen=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return banners.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"BannerTableViewCell";
    Banner * item=[banners objectAtIndex:indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]placeholderImage:[UIImage imageNamed:@"place_holder_main_article_img"]];
    if (cell == nil) {
        cell =  [[[NSBundle mainBundle]loadNibNamed:simpleTableIdentifier owner:self options:nil]lastObject];
    }
    [((BannerTableViewCell*)cell).bannerImg sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]];
   // [((BannerTableViewCell*)cell).bannerLbl setText:item.title];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Banner * item =[banners objectAtIndex:indexPath.section];

    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:[NSString stringWithFormat:@"iOS - %@",item.title ]
                                                          action: [NSString stringWithFormat:@"iOS - %@",item.title ]
                                                           label: [NSString stringWithFormat:@"iOS - %@",item.title ]
                                                           value:nil] build]];
//
//    GlobalViewController * webView=[[GlobalViewController alloc]init];
//    appDelegate.isFullScreen=YES;
//    webView.url=[NSURL URLWithString:item.pageUrl];
//    [GetAppDelegate().getSelectedNavigationController pushViewController:webView animated:YES];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:item.pageUrl]];

}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
//        if (targetContentOffset->y > 0){
//            //NSLog(@"up");
//            self.tableView.scrollEnabled=YES;
//        }
//        else if (targetContentOffset->y == 0){
//            self.tableView.scrollEnabled=NO;
//        }
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
