//
//  WebViewViewController.m
//  MediationExample
//
//  Created by Nada Gamal Mohamed on 10/10/18.
//  Copyright © 2018 Google, Inc. All rights reserved.
//

#import "AdWebViewViewController.h"
@interface AdWebViewViewController ()

@end

@implementation AdWebViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView.delegate = self;
    self.view.backgroundColor = [UIColor clearColor];
    self.webView.backgroundColor = [UIColor clearColor];
    if(self.URL != nil){
        [self.webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString: self.URL]]];;
    }
    else{
        [self removeView];
    }
    [self.webView setOpaque:NO];

}


-(void)removeView{
    [UIView transitionWithView:self.view duration:0.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ {
                        [self willMoveToParentViewController:nil];
                        [self.view removeFromSuperview];
                        [self removeFromParentViewController];
                        
                    }
                    completion:nil];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if([request.URL.absoluteString isEqualToString:@"order://close"]){
       // [self removeView];
        [self dismissViewControllerAnimated:true completion:nil];
        return NO;
    }
    else if( ([request.URL.absoluteString containsString:@"http"]||[request.URL.absoluteString containsString:@"https"])&& navigationType == UIWebViewNavigationTypeLinkClicked){
        // footer
        [[UIApplication sharedApplication]openURL:webView.request.URL];
        return NO;
    }
    return YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    int height = [result intValue];
    if(self.isFullScreen == NO){
    if (height != 0){
    self.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-height, [UIScreen mainScreen].bounds.size.width, height);
    }
    }
    if([self.parameters objectForKey:@"duration"]!= nil && self.isFullScreen == NO){
    [self performSelector:@selector(removeView)
               withObject:nil
               afterDelay:[[self.parameters objectForKey:@"duration"]floatValue]];
    }else if(self.isFullScreen == NO){
        [self performSelector:@selector(removeView)
                   withObject:nil
                   afterDelay:10.0];
    }
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}



@end
