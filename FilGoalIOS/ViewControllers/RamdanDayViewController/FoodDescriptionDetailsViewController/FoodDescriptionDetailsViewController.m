//
//  FoodDescriptionDetailsViewController.m
//  Reyada
//
//  Created by Nada Gamal on 5/11/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "FoodDescriptionDetailsViewController.h"
#import "AppDelegate.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "UIImageView+WebCache.h"

@interface FoodDescriptionDetailsViewController ()

@end

@implementation FoodDescriptionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName=[NSString stringWithFormat:@"iOS-SpecialSection-%@-ImageWithTextComponent-%@",self.title,_componetTitleStr];

    [self.componetTitle setText:self.componetTitleStr];
    [self.titleLblTxt setText:self.titleLblTxtStr];
    if(self.topImagUrl!=nil)
        [self.topImgView sd_setImageWithURL:[NSURL URLWithString:self.topImagUrl] placeholderImage:[UIImage imageNamed:@"place_holder_main_article_img.jpg"]];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    [self.webView setAllowsInlineMediaPlayback:YES];
    self.webView.delegate=self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    [self.webView loadHTMLString:self.detailsTxtViewStr baseURL:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView.tag==123456)
        return;
    
    //NSString *result = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = self.webView.frame;
    frame.size.height = 1;
    self.webView.frame = frame;
    CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    self.webView.frame = frame;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.titleLblTxt.frame.size.height+self.webView.frame.size.height+self.topImgView.frame.origin.y+self.topImgView.frame.size.height)];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
