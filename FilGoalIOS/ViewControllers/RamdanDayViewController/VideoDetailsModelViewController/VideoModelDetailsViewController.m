//
//  VideoModelDetailsViewController.m
//  Reyada
//
//  Created by Nada Gamal on 5/11/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "VideoModelDetailsViewController.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "NewsVideoWebViewController.h"
#import "UIImageView+WebCache.h"

@interface VideoModelDetailsViewController ()

@end

@implementation VideoModelDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName=[NSString stringWithFormat:@"iOS-SpecialSection-%@-VideoComponent-%@",self.title,_componetTitleStr];
    
    [self.detailsTxtView setText:self.detailsTxtViewStr];
    // [self.componetTitle setText:self.componetTitleStr];
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
- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma Btn Play Btn
- (IBAction)playBtnPressed:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * youtubeVideoUrl = nil;
    // self.videoEmbdedUrl=@"https://www.youtube.com/embed/0ekX3QAZfKY";
    NSRange start = [self.videoEmbdedUrl rangeOfString:@"://www.youtube.com/embed/"];
    NSRange youtubeStart=[self.videoEmbdedUrl rangeOfString:@"://www.youtube.com/watch?v="];
    
    if (start.location != NSNotFound)
    {
        youtubeVideoUrl = [self.videoEmbdedUrl substringFromIndex:start.location + start.length];
        XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:youtubeVideoUrl];
        appDelegate.isFullScreen=YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer];
        [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
        
    }
    else    if (youtubeStart.location != NSNotFound)
    {
        youtubeVideoUrl = [self.videoEmbdedUrl substringFromIndex:youtubeStart.location + youtubeStart.length];
        XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:youtubeVideoUrl];
        appDelegate.isFullScreen=YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer];
        [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
        
    }
    
    else
    {
        NewsVideoWebViewController *newsVideoWebViewController = [[NewsVideoWebViewController alloc] initWithNibName:@"NewsVideoWebViewController" bundle:nil];
        newsVideoWebViewController.url=self.videoEmbdedUrl;
        appDelegate.isFullScreen=YES;
        UINavigationController*NavigationController  = [[UINavigationController alloc]initWithRootViewController:newsVideoWebViewController];
        [self presentViewController:NavigationController animated:YES completion:nil];
        
        //  [appDelegate.navigationController pushViewController:newsVideoWebViewController animated:YES];
    }
    
}

- (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:notification.object];
    MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    if (finishReason == MPMovieFinishReasonPlaybackError)
    {
        
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView.tag==123456)
        return;
    
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

@end
