//
//  FeaturedWebViewViewController.m
//  Reyada
//
//  Created by Nada Gamal on 5/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "FeaturedWebViewViewController.h"
#import "MBProgressHUD.h"
@import Firebase;
@interface FeaturedWebViewViewController ()
{
    UIButton * rightBarButton;
}
@end

@implementation FeaturedWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName=[NSString stringWithFormat:@"iOS-SpecialSection-%@",self.title];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.webView.delegate=self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if(self.url != nil){
        
        NSURLRequest * request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]];
        [_webView setScalesPageToFit:YES];
        [self.webView loadRequest:request];
    }

    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS-SpecialSection-%@",self.title]
                                     }];


}

-(void)viewWillAppear:(BOOL)animated{

        

    

}
#pragma mark UIWebView Delegate Methods
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    

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
