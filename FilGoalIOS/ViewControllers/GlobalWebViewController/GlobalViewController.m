//
//  GlobalViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/27/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import "GlobalViewController.h"
#import "AppDelegate.h"
#import "SVWebViewControllerActivityChrome.h"
#import "SVWebViewControllerActivitySafari.h"
#import <WebKit/WebKit.h>
@interface GlobalViewController ()
{
    NSURLRequest *request;
    UIButton * leftBarButton;
    AppDelegate*  delegate;
    
    
}
@end

@implementation GlobalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.forwardBtn setEnabled:NO];
    [self.backBtn setEnabled:NO];
    // Do any additional setup after loading the view from its nib.
    [self.webview addSubview: self.activityIndicator];
    [self.webview bringSubviewToFront:self.activityIndicator];
    self.webview.navigationDelegate = self;
    self.webview.UIDelegate = self;

    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.hidden = NO;
//    self.webview.navigationDelegate =self;
//    request = [NSURLRequest requestWithURL:self.url];
 //   self.title = @"التعليقات";
    // [webview loadRequest:request];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];

    
}
-(void)clearMemory
{
    self.webview=nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.webview stopLoading];
    
    
}
- (id)initWithUrl:(NSString*)url
{
    self = [super init];
    if (self) {
        self.url=[NSURL URLWithString:url];
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:NO animated:animated];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.navigationController setToolbarHidden:YES animated:animated];
    }
    
    self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, self.view.frame.size.height)];
    self.webview.navigationDelegate = self;
    self.webview.translatesAutoresizingMaskIntoConstraints = NO;
    NSURLRequest * request2 =[[NSURLRequest alloc]initWithURL:self.url];
    [self.webview loadRequest:request2];
    [self.view addSubview:self.webview];
    
    NSLayoutConstraint *newTopConstraint = [NSLayoutConstraint constraintWithItem:self.webview
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1.0
                                                                         constant:0];
    NSLayoutConstraint *newBottomConstraint = [NSLayoutConstraint constraintWithItem:self.webview
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0
                                                                            constant:0];
    NSLayoutConstraint *TrailingConstraint = [NSLayoutConstraint constraintWithItem: self.webview
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1.0
                                                                           constant:0];
    NSLayoutConstraint *LeadingConstraint = [NSLayoutConstraint constraintWithItem:self.webview
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeLeading
                                                                        multiplier:1.0
                                                                          constant:0];
    
    [self.view addConstraints: @[newTopConstraint, newBottomConstraint, TrailingConstraint, LeadingConstraint]];
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UIWebView Delegate Methods
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
    
    // [self setScreenState:NO];
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //    UIAlertView * alertview=[[UIAlertView alloc]initWithTitle:@"" message:@"No Internet Connection"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //    [alertview show];
}
-(void) webViewDidFinishLoad:(UIWebView *)webView {
    if(webView.tag==123456)
        return;
    [self.activityIndicator stopAnimating];
    
    
    //[self setScreenState:YES];
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:animated];
    
    [self updateToolbarItems];
    [super setUpBannerUnderNav:self.view anotherTopView:nil];
    
}
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
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
- (IBAction)backPressed:(id)sender {
    //  request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    //[webview loadRequest:request];
    [self.activityIndicator startAnimating];
    
    if(![self.webview canGoBack])
    {
        [self.backBtn setEnabled:NO];
        
    }
    else
    {
        [self.backBtn setEnabled:YES];
        [self.webview goBack];
        
        
    }
}

- (IBAction)nextPressed:(id)sender {
    //  [self.webview loadRequest:request];
    [self.activityIndicator startAnimating];
    
    if(![self.webview canGoForward])
    {
        [self.forwardBtn setEnabled:NO];
        
    }
    else
    {
        [self.forwardBtn setEnabled:YES];
        [self.webview goForward];
        
        
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:YES animated:animated];
    }

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.webview stopLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    if(IS_IPHONE_4)
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
//    else if(IS_IPHONE_5)
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
//    else if (IS_IPHONE_6)
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
//    
//    else
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor mainAppDarkGrayColor]];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:YES animated:animated];
    }


    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isFullScreen=NO;
    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}
- (IBAction)reloadWebView:(id)sender {
    [self.activityIndicator startAnimating];
    
    [self.webview reload];
}
#pragma mark - Toolbar
- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewController.bundle/SVWebViewControllerBack"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(goBackTapped:)];
        _backBarButtonItem.width = 18.0f;
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    if (!_forwardBarButtonItem) {
        _forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SVWebViewController.bundle/SVWebViewControllerNext"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(goForwardTapped:)];
        _forwardBarButtonItem.width = 18.0f;
    }
    return _forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    if (!_refreshBarButtonItem) {
        _refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTapped:)];
    }
    return _refreshBarButtonItem;
}

- (UIBarButtonItem *)stopBarButtonItem {
    if (!_stopBarButtonItem) {
        _stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopTapped:)];
    }
    return _stopBarButtonItem;
}

- (UIBarButtonItem *)actionBarButtonItem {
    if (!_actionBarButtonItem) {
        _actionBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonTapped:)];
    }
    return _actionBarButtonItem;
}
- (void)actionButtonTapped:(id)sender {
    NSURL *url = self.webview.URL ? self.webview.URL : request.URL;
    if (url != nil) {
        NSArray *activities = @[[SVWebViewControllerActivitySafari new], [SVWebViewControllerActivityChrome new]];
        
        if ([[url absoluteString] hasPrefix:@"file:///"]) {
            UIDocumentInteractionController *dc = [UIDocumentInteractionController interactionControllerWithURL:url];
            [dc presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
        } else {
            UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:activities];
            
#ifdef __IPHONE_8_0
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1 &&
                UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                UIPopoverPresentationController *ctrl = activityController.popoverPresentationController;
                ctrl.sourceView = self.view;
                ctrl.barButtonItem = sender;
            }
#endif
            
            [self presentViewController:activityController animated:YES completion:nil];
        }
    }
}
- (void)updateToolbarItems {
    self.backBarButtonItem.enabled = self.webview.canGoBack;
    self.forwardBarButtonItem.enabled = self.webview.canGoForward;
    
    UIBarButtonItem *refreshStopBarButtonItem = self.webview.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGFloat toolbarWidth = 250.0f;
        fixedSpace.width = 35.0f;
        
        NSArray *items = [NSArray arrayWithObjects:
                          fixedSpace,
                          refreshStopBarButtonItem,
                          fixedSpace,
                          self.backBarButtonItem,
                          fixedSpace,
                          self.forwardBarButtonItem,
                          fixedSpace,
                          self.actionBarButtonItem,
                          nil];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, toolbarWidth, 44.0f)];
        toolbar.items = items;
        toolbar.barStyle = UIBarStyleBlack;
        toolbar.tintColor = [UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0];
        self.navigationItem.rightBarButtonItems = items.reverseObjectEnumerator.allObjects;
    }
    
    else {
        NSArray *items = [NSArray arrayWithObjects:
                          fixedSpace,
                          self.backBarButtonItem,
                          flexibleSpace,
                          self.forwardBarButtonItem,
                          flexibleSpace,
                          refreshStopBarButtonItem,
                          flexibleSpace,
                          self.actionBarButtonItem,
                          fixedSpace,
                          nil];
        
        self.navigationController.toolbar.barStyle = UIBarStyleBlack;
        self.navigationController.toolbar.tintColor = [UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0];
        self.toolbarItems = items;
    }
}

#pragma mark - Target actions

- (void)goBackTapped:(UIBarButtonItem *)sender {
    [self.webview goBack];
}

- (void)goForwardTapped:(UIBarButtonItem *)sender {
    [self.webview goForward];
}

- (void)reloadTapped:(UIBarButtonItem *)sender {
    [self.webview reload];
}

- (void)stopTapped:(UIBarButtonItem *)sender {
    [self.webview stopLoading];
    [self updateToolbarItems];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self.webview setFrame:CGRectMake(0, 0, Screenwidth, self.view.frame.size.height)];

        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0]];
        UIButton *logoView = [[UIButton alloc] initWithFrame:CGRectMake(0,0,85,17)] ;
        [logoView setBackgroundImage:[UIImage imageNamed:@"filgoal_tab_bar_logo"] forState:UIControlStateNormal];
        [logoView setUserInteractionEnabled:NO];
        self.navigationItem.titleView = logoView;
    }
    else{
        
        
        [self.webview setFrame:CGRectMake(0, 0, Screenwidth, self.view.frame.size.height)];


        
    }
    
}
#pragma mark webView delegate
- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler
{

    decisionHandler(WKNavigationActionPolicyAllow);

}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}
- (void)webView:(WKWebView *)aWebView didFinishNavigation:(WKNavigation *)aNavigation
{
    
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}
- (BOOL)shouldAutorotate {
    return YES;
}
@end
