//
//  SMSViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/28/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSViewController : ParentViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
