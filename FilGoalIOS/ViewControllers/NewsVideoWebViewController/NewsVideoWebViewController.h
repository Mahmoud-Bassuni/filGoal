//
//  MovieTrailer.h
//  FilBalad
//
//  Created by Yomna Ahmed on 4/19/12.
//  Copyright (c) 2012 Sarmady, a Vodafone company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoItem.h"
#import "ParentViewController.h"

@interface NewsVideoWebViewController : ParentViewController<UIWebViewDelegate>{

    NSString                   *videoUrl;

}
@property (nonatomic,retain)  NSString * url;
@property (nonatomic,retain)  IBOutlet UIWebView         *videoItemWebView;
@property (nonatomic,retain)  UINavigationItem  *navItem;
@property (nonatomic,retain)  UINavigationBar   *navBar;
@property (nonatomic,retain)  VideoItem   *videoItem;
@property (nonatomic,retain)  UIActivityIndicatorView   *activityIndicator;

@property (nonatomic,retain)  IBOutlet UIView *navBarView;
@property (nonatomic,retain)  IBOutlet UIImageView *navBarlogo;
@property (nonatomic,retain)  IBOutlet UIButton *backButton;

//@property (nonatomic, strong) IBOutlet LBYouTubeView* youTubeView;
- (NewsVideoWebViewController *)initWithVideo:(VideoItem *)videoItem  ;//andVideoIndex:(int)videoIndex;
- (IBAction)back:(id)sender;

@end
