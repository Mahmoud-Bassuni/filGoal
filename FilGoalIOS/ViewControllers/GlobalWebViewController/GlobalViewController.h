//
//  GlobalViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/27/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface GlobalViewController : ParentViewController<NSURLConnectionDelegate,WKNavigationDelegate,WKUIDelegate>
- (IBAction)backPressed:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (id)initWithUrl:(NSString*)url;
@property (strong,nonatomic) NSString * urlstr;
@property (strong,nonatomic) NSURL * url;
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *stopBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *actionBarButtonItem;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicator;
- (IBAction)reloadWebView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *forwardBtn;
@property (nonatomic, strong)WKWebView * webview;

@end
