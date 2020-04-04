//
//  WebViewViewController.m
//  Khwater
//
//  Created by Nada Gamal on 1/5/15.
//  Copyright (c) 2015 Nada Gamal. All rights reserved.
//

#import "WebViewViewController.h"
#import "AppDelegate.h"

@interface WebViewViewController ()
{
    NSURLRequest *request;
    UIButton * leftBarButton;
    AppDelegate*  delegate;
    
}
@end

@implementation WebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    NSURL *url = [NSURL URLWithString:@"http:api.filgoal.com/MobileAppResources/android/about.html"];
    request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
-(void)viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UIWebView Delegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView {
   // [self setScreenState:NO];
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView * alertview=[[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertview show];
}
-(void) webViewDidFinishLoad:(UIWebView *)webView {
    //[self setScreenState:YES];
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)dismissViewPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    // [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
