//
//  WebViewViewController.h
//  MediationExample
//
//  Created by Nada Gamal Mohamed on 10/10/18.
//  Copyright © 2018 Google, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface AdWebViewViewController : UIViewController<UIWebViewDelegate,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) NSDictionary * parameters;
@property (strong,nonatomic) NSString * URL;
@property (assign,nonatomic) BOOL isFullScreen;
@property (assign,nonatomic) BOOL isTransparent;

@end

