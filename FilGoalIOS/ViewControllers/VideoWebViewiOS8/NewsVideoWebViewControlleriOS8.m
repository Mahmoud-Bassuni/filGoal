//
//  MovieTrailer.m
//  FilBalad
//
//  Created by Yomna Ahmed on 4/19/12.
//  Copyright (c) 2012 Sarmady, a Vodafone company. All rights reserved.
//
#import "FilGoalIOS-Swift.h"

#import "NewsVideoWebViewControlleriOS8.h"
#import "AppDelegate.h"
@import Firebase;


@interface NewsVideoWebViewControlleriOS8 ()

@end

@implementation NewsVideoWebViewControlleriOS8


- (NewsVideoWebViewControlleriOS8 *)initWithVideo:(VideoItem *)videoItem //andVideoIndex:(int)videoIndex
{
    self =[super init];
    
    if (self) {
        self.videoItem=videoItem;
    }
 
    return self;
}



- (id) init
{
    self = [super init];
    if (self) {
           
    }
    return self;
}



- (void)viewDidLoad
{
    self.screenName=[NSString stringWithFormat:@"iOS-NewsVideoWeb-%i",self.videoItem.videoId];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-NewsVideoWeb-%i",self.videoItem.videoId]
                                     }];
    [super viewDidLoad];
    NSString *urlString;
    if(self.videoItem!=nil)
    {
 urlString = [NSString stringWithFormat:@"http://www.filgoal.com/Arabic/APIVideoView.aspx?AudioVideoID=%i",self.videoItem.videoId]  ;
//       NSString *customUrl = urlString = [NSString stringWithFormat:@" https://www.filgoal.com/videos/%i",self.videoItem.videoId] ;
//      urlString = [customUrl stringByAppendingString :@"/apivideo/video-title"];
//        NSLog(@"%@", urlString);
      //  http://www.filgoal.com/videos/%i/apivideo/video-title,self.videoItem.videoId
    }
    else
    {
        urlString =self.url ;

    }
   // NSString *urlString = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=3LFVCf5zA1A"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    self.activityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(screenWidth /2-25, screenHeight/2-50, 100, 50) ];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.activityIndicator startAnimating];
     self.navBarView.frame=CGRectMake(-20, 0 ,screenWidth+20, 47);
    [self setWantsFullScreenLayout:YES];
    self.navBarlogo.frame=CGRectMake(screenWidth/2-45, 50/2-10, 90, 17);
    [self.navigationController setNavigationBarHidden:NO];
    
    self.webView=[[WKWebView alloc]initWithFrame:CGRectMake(-20, 47 ,screenWidth+20, screenHeight-47)];
    [self.webView setOpaque:NO];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}

- (void)viewDidUnload
{
 [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated{
    //[super viewDidAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;

}

#pragma  mark - UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    if (webView.tag!=123456) {
        [self.activityIndicator startAnimating];
        return YES ;
    }
    else
        return NO;
}

#pragma mark UIWebView Delegate Methods
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}


#pragma mark -Back

-(IBAction)back:(id)sender{
    self.webView.navigationDelegate=nil;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        [self.webView setFrame:CGRectMake(0, 0, Screenwidth, self.view.frame.size.height)];
        
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0]];
        UIButton *logoView = [[UIButton alloc] initWithFrame:CGRectMake(0,0,85,17)] ;
        [logoView setBackgroundImage:[UIImage imageNamed:@"filgoal_tab_bar_logo"] forState:UIControlStateNormal];
        [logoView setUserInteractionEnabled:NO];
        self.navigationItem.titleView = logoView;
    }
    else{
        
        
        [self.webView setFrame:CGRectMake(0, 0, Screenwidth, self.view.frame.size.height)];
        
        
    }

}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isFullScreen=NO;
    if(IS_IPHONE_4) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
    } else if(IS_IPHONE_5) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
    } else if (IS_IPHONE_6) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
    
    } else if (IS_IPHONE_6_PLUS) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
    } else {
        //UIImage *image = [[UIImage imageNamed:@"Nav6+"] resizeImageScaledToWidthWithWidth: [UIScreen mainScreen].bounds.size.width];
        CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                 ([UIApplication sharedApplication].statusBarFrame.size.height +(self.navigationController.navigationBar.frame.size.height ?: 0.0)));
        UIImage *image = [[UIImage imageNamed:@"NavX"] resizeImageWithTargetSize:size];  
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }

    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
}
- (void)webView:(WKWebView *)aWebView didFinishNavigation:(WKNavigation *)aNavigation
{
    if(aWebView.tag==123456)
        return;
}
- (BOOL)shouldAutorotate {
    return YES;
    
    
}

@end
