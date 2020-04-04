//
//  NewsDetails3DtouchViewViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/1/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "NewsDetails3DtouchViewViewController.h"

@interface NewsDetails3DtouchViewViewController ()

@end

@implementation NewsDetails3DtouchViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"3DTouch"     // Event category (required)
                                                          action:@"iOS-3DTouch-News"  // Event action (required)
                                                           label:[NSString stringWithFormat:@"News item with ID = %i ",self.newsDetailsObject.newsId]
                                                           value:nil] build]];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateUI
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"3DTouch"     // Event category (required)
                                                          action:@"iOS-3DTouch-News"  // Event action (required)
                                                           label:[NSString stringWithFormat:@"News item with ID = %i ",self.newsDetailsObject.newsId]
                                                           value:nil] build]];
    
    self.newsDetailsWebView.opaque = NO;
    self.newsDetailsWebView.backgroundColor = [UIColor clearColor];
    [self.newsDetailsWebView setMediaPlaybackRequiresUserAction:NO];
    [self.newsDetailsWebView setAllowsInlineMediaPlayback:YES];
    self.newsDetailsWebView.delegate=self;
    self.newsDetailsWebView.scrollView.scrollEnabled = NO;
    self.newsDetailsWebView.scrollView.bounces = NO;
    self.newsDetailsObject.newsDescription=[self.newsDetailsObject.newsDescription stringByReplacingOccurrencesOfString:@"\"//www.youtube.com" withString:@"\"http://www.youtube.com"];
    NSString *newsDetailsText=[NSString stringWithFormat:
                               @"<html><head><style>body { background-color: trasparent; text-align: %@; font-size:%ipx; color: %@; margin:0; font-family:\"%@\" } a { color: #172983; } img{width:100%%; height:auto} #content > iFrame { width : 100%%} </style></head><body><div id='content' name='content'>%@</div></body></html>",
                               @"right",
                               14,[UIColor blackColor],@"DINNextLTW23Regular",self.newsDetailsObject.newsDescription];
    [self.newsDetailsWebView loadHTMLString:newsDetailsText baseURL:nil];
    
    [self.newsTitleLbl setText:self.newsTitle];
    if(self.newsDetailsObject.images!=nil&&self.newsDetailsObject.images.count>0){
        
        Images *imageItem =[self.newsDetailsObject.images objectAtIndex:0];
        [self.newsImgView sd_setImageWithURL:[NSURL URLWithString:imageItem.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       
                                   }];
    }
    
    
}
#pragma mark - Preview Actions

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    NSString *text =self.newsTitle;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.filgoal.com/articles/%li",(long)self.newsID]];
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url]
     applicationActivities:nil];
    
    UIPreviewAction *shareAction =
    [UIPreviewAction actionWithTitle:@"شارك"
                               style:UIPreviewActionStyleDefault
                             handler:^(UIPreviewAction *action,
                                       UIViewController *previewViewController){
                                 
                                 
                                 
                                 
                                 controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                                                      UIActivityTypeMessage,
                                                                      UIActivityTypeMail,
                                                                      UIActivityTypePrint,
                                                                      UIActivityTypeCopyToPasteboard,
                                                                      UIActivityTypeAssignToContact,
                                                                      UIActivityTypeSaveToCameraRoll,
                                                                      UIActivityTypeAddToReadingList,
                                                                      UIActivityTypePostToFlickr,
                                                                      UIActivityTypePostToVimeo,
                                                                      UIActivityTypePostToTencentWeibo,
                                                                      UIActivityTypeAirDrop];
                                 [[NSNotificationCenter defaultCenter]postNotificationName:@"ShareNewsDetails" object:self.newsDetailsObject];
                                 // [self.navigationController presentViewController:controller animated:YES completion:nil];
                             }];
    
    
    UIPreviewAction * readMoreAboutArticle =
    [UIPreviewAction actionWithTitle:@"اقرا المزيد عن الخبر"
                               style:UIPreviewActionStyleDefault
                             handler:^(UIPreviewAction *action,
                                       UIViewController *previewViewController){
                                 
                                 
                                 
                                 
                                 [[NSNotificationCenter defaultCenter]postNotificationName:@"ReadMoreAboutArticle" object:[NSString stringWithFormat:@"%li",(long)self.newsIndex]];
                                 // [self.navigationController presentViewController:controller animated:YES completion:nil];
                             }];
    
    
    return @[shareAction,readMoreAboutArticle];
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
