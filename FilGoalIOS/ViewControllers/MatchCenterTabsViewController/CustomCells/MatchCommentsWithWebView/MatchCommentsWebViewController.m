//
//  MatchCommentsWebViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCommentsWebViewController.h"

@interface MatchCommentsWebViewController ()

@end

@implementation MatchCommentsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView.scrollView setScrollEnabled:NO];
    NSString * commentDetails=[NSString stringWithFormat:
                               @"<html><head><style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #172983; } img{width:100%%; height:auto} #content > iFrame { width : 100%%} </style></head><body><div id='content' dir='rtl' name='content'>%@</div><div id='content' dir='rtl' name='content'>%@</div></body></html>",
                               14,[UIColor blackColor],@"DINNextLTW23Regular",[NSString stringWithFormat:@"%@",self.matchComment.content],[NSString stringWithFormat:@"%@",self.matchComment.contentUrl]];
    
    self.webView.delegate=self;
    self.webView.opaque=NO;
    [self.webView loadHTMLString:commentDetails baseURL:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {

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
