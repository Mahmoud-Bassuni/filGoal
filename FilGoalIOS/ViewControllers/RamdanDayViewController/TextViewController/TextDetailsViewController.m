//
//  TextDetailsViewController.m
//  Reyada
//
//  Created by Nada Gamal on 5/11/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "TextDetailsViewController.h"

@interface TextDetailsViewController ()

@end

@implementation TextDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.detailsTxtView setText:self.detailsTxtViewStr];
    self.screenName=[NSString stringWithFormat:@"iOS-SpecialSection-%@-TextOnlyComponent-%@",self.title,_componetTitleStr];
    
    [self.componetTitle setText:self.componetTitleStr];
    [self.titleLblTxt setText:self.titleLblTxtStr];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    [self.webView setAllowsInlineMediaPlayback:YES];
    self.webView.delegate=self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    NSString *newsDetailsText=[NSString stringWithFormat:
                               @"<html><head><style>body { background-color: trasparent; text-align: %@; font-size:%ipx; color: %@; margin:0; font-family:\"%@\" } a { color: #172983; } img{width:100%%; height:auto} #content > iFrame { width : 100%%} </style></head><body><div id='content' name='content'>%@</div></body></html>",
                               @"right"
                               ,15,[UIColor blackColor],@"Hacen Tunisia",self.detailsTxtViewStr];
    [self.webView loadHTMLString:newsDetailsText baseURL:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView.tag==123456)
        return;
        
    CGRect frame = self.webView.frame;
    frame.size.height = 1;
    self.webView.frame = frame;
    CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    self.webView.frame = frame;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.titleLblTxt.frame.size.height+self.webView.frame.size.height)];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    
}
- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
