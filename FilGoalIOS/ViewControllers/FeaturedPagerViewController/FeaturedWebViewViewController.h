//
//  FeaturedWebViewViewController.h
//  Reyada
//
//  Created by Ahmed Kotb on 5/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "ParentViewController.h"
#import "XLPagerTabStripViewController.h"

@interface FeaturedWebViewViewController : ParentViewController <XLPagerTabStripChildItem,UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *itemDate;
@property (strong, nonatomic) NSString *url;
@property (nonatomic, strong) NSString *sponserUrl;
@property (weak, nonatomic) IBOutlet UIImageView *sponsorImg;
@property (strong, nonatomic) NSString * pageTitle;
@property(nonatomic,assign) BOOL isFromMenu;

@end
