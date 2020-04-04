//
//  BookmarkPushNotificationsViewController.m
//  Reyada
//
//  Created by Nada Gamal on 12/24/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import "BookmarkPushNotificationsViewController.h"
#import "NewsCustomCell.h"
#import "NewsDetailsViewController.h"
#import "VideoDetailsViewController.h"
#import "UIImageView+WebCache.h"
@import Firebase;
@interface BookmarkPushNotificationsViewController ()<SwipeableCellDelegate>
{
    NSMutableArray * notifications;
    UIButton * rightBarButton;
    NSManagedObjectContext *managedObjectContext;
    UILabel * notificationCountLbl;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *background;
@end

@implementation BookmarkPushNotificationsViewController
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName=@"iOS- Bookmark Notifications";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- Bookmark Notifications"
                                     }];
    // Do any additional setup after loading the view from its nib.
    
    managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"NotificationItem"];
    notifications = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    notifications =notifications.reverseObjectEnumerator.allObjects;
    [self.tableView reloadData];
    notificationCountLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 60)];
    [notificationCountLbl setTextColor:[UIColor darkGrayColor]];
    [notificationCountLbl setFont:[UIFont fontWithName:@"NotoKufiArabic" size:13.0]];
    [notificationCountLbl setTextAlignment:NSTextAlignmentCenter];
    //[notificationCountLbl setText:[NSString stringWithFormat:@"  اشعاز %lu لديك",(unsigned long)notifications.count]];
    [notificationCountLbl setText:[NSString stringWithFormat:@"لديك %lu اشعار",(unsigned long)notifications.count]];
    
    self.tableView.tableFooterView=notificationCountLbl;
    
    if(notifications.count == 0){
        [self.tableView setHidden:YES];
        //     UIImageView *tutorialView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 40)];
        if(IS_IPHONE_4){
            [_background setImage:[UIImage imageNamed:@"notifIphone4.jpg"]];
        }
        else if (IS_IPHONE_5){
            [_background setImage:[UIImage imageNamed:@"notifIphone5.jpg"]];
        }
        else if (IS_IPHONE_6){
            [_background setImage:[UIImage imageNamed:@"notifIphone6.jpg"]];
        }
        else if (IS_IPHONE_6_PLUS){
            [_background setImage:[UIImage imageNamed:@"notifIphone6plus.jpg"]];
        }
        
        [self.view addSubview:_background];
    }
    else{
        [_background setHidden:YES];
        [self.tableView setHidden:NO];
    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   // self.title = @"الإشعارات المحفوظة";
    [super setUpBannerUnderNav:self.view anotherTopView:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return notifications.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCustomCell";
    NewsCustomCell *cell;
    
    if (cell == nil)
    {
        cell=  [[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil]objectAtIndex:0];
        
    }
    cell.delegate=self;
    NSManagedObject * notificationItem = [notifications objectAtIndex:indexPath.row];
    [( (NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:[notificationItem valueForKey:@"itemImgUrl"]]placeholderImage:[UIImage imageNamed:@"place_holder"]];
    [( (NewsCustomCell*)cell).itemLbl setText:[notificationItem valueForKey:@"itemTxt"]];
    [( (NewsCustomCell*)cell).dateLabel setText:[notificationItem valueForKey:@"itemDate"]];
    cell.playImg.hidden=TRUE;
    if([[notificationItem valueForKey:@"itemType"]isEqualToString:@"2"])
    {
        cell.playImg.hidden=false;
    }
    
    return cell;
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    if(notifications.count==0)
    {
        self.background.hidden=NO;
        self.tableView.hidden=YES;
    }
    else
    {
        self.background.hidden=YES;
        self.tableView.hidden=NO;
    }
}
#pragma mark - SwipeableCellDelegate
- (void)deleteAction:(UITableViewCell*)cell
{
    
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    
    [managedObjectContext deleteObject:[notifications objectAtIndex:indexPath.row]];
    
    // Save context to write to store
    [managedObjectContext save:nil];
    
    [notifications removeObjectAtIndex:indexPath.row];
    [notificationCountLbl setText:[NSString stringWithFormat:@"لديك %lu اشعار",(unsigned long)notifications.count]];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
}

- (void)setAsReadAction:(UITableViewCell *)cell
{
    
    managedObjectContext = [self managedObjectContext];
    NSManagedObject * notificationItem = [notifications objectAtIndex:[self.tableView indexPathForCell:cell].row];
    [notificationItem setValue:@TRUE forKey:@"markAsRead"];
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
    }
    
}
- (void)cellDidClose:(UITableViewCell *)cell
{
}
- (void)cellDidOpen:(UITableViewCell *)cell{
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSManagedObject * notificationItem = [notifications objectAtIndex:indexPath.row];
    [notificationItem setValue:@TRUE forKey:@"markAsRead"]; // Ali write this
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
    }
    
    if([[notificationItem valueForKey:@"itemType"]isEqualToString:@"1"])
    {
        NewsItem * newsItem=[[NewsItem alloc] init];
        
        newsItem.newsId=[[notificationItem valueForKey:@"itemID"]intValue];
        
        newsItem.newsTitle=[notificationItem valueForKey:@"itemTxt"];
        
        NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:newsItem ];
        NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:newsItem ];
        
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
            [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
        else
            [self.navigationController pushViewController:newsDetailsScreen animated:YES];
    }
    else if([[notificationItem valueForKey:@"itemType"]isEqualToString:@"2"])
    {
        VideoItem * videoItem=[[VideoItem alloc] init];
        
        videoItem.videoId=[[notificationItem valueForKey:@"itemID"]intValue];
        
        videoItem.videoTitle=[notificationItem valueForKey:@"itemTxt"];
        VideoDetailsViewController * videoDetailsScreen=[[VideoDetailsViewController alloc] initWithVideo:videoItem ];
        
        [self.navigationController pushViewController:videoDetailsScreen animated:YES];
    }
    
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
