//
//  SMSViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/28/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "SMSViewController.h"
#import "MBProgressHUD.h"
@import Firebase;
@interface SMSViewController ()
{
    NSURLRequest *request;
    

}
@end

@implementation SMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    request = [[NSURLRequest alloc]init];


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSURL *url = [NSURL URLWithString:@"http://www.filgoal.com/home/smsapp"];
   // request = [NSURLRequest requestWithURL:url];
    request = [NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60]; // timeoutInterval is in seconds

    [self.webView loadRequest:request];
    self.screenName=@"iOS - SMS Screen";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS - SMS Screen"
                                     }];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
  //  self.title = @"خدمة الرسائل القصيرة";
    [super setUpBannerUnderNav:self.view anotherTopView:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.webView stopLoading];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

#pragma mark UIWebView Delegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // [self setScreenState:NO];
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

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
