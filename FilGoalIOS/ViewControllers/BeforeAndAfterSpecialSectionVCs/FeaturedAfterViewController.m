//
//  FeaturedAfterViewController.m
//  Reyada
//
//  Created by Ahmed Kotb on 5/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "FeaturedAfterViewController.h"

@interface FeaturedAfterViewController ()

@end

@implementation FeaturedAfterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName=[NSString stringWithFormat:@"iOS-SpecialSection-After-%@",self.title];

}
-(void)viewWillAppear:(BOOL)animated
{
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.isFullScreen=NO;
//    AppInfo *appInfo= [Global getInstance].appInfo;
//    if (appInfo.sponsor.isActive==1) {
//        if ([self.sponserUrl length] == 0)
//        {
//            NSString *url=[NSString stringWithFormat:@"%@/MainSponsor/HomeStrip.png",appInfo.sponsor.imgsBaseUrl];
//            
//            
//            [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                // self.sponserImageView.contentMode=UIViewContentModeScaleAspectFit;
//                
//            }];
//        }
//        else
//        {
//            [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:self.sponserUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                
//                
//            }];
//        }
//    }
//    else{
////        self.tableView.frame=CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y-25, self.tableView.frame.size.width,  self.tableView.frame.size.height+25);
//        
//    }
    

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
