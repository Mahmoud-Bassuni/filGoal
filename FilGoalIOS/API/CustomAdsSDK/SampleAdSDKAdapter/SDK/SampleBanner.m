//
// Copyright (C) 2015 Google, Inc.
//
// SampleBannner.m
// Sample Ad Network SDK
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "SampleBanner.h"
#import "AdWebViewViewController.h"
@implementation SampleBanner
{
    AdWebViewViewController* webViewVC;
}
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
      self =
      [[NSBundle mainBundle] loadNibNamed:@"BannerView" owner:nil options:nil]
      .firstObject;
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    
  }
  return self;
}


- (void)fetchAd:(SampleAdRequest *)request {
  NSLog(@"Fetching ad");

  if (!self.adUnit) {
    [self.delegate banner:self didFailToLoadAdWithErrorCode:SampleErrorCodeBadRequest];
    return;
  }
    NSData *data = [_adUnit dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if([json objectForKey:@"footer"] != nil){
    [self showFooterAd];
    }
  // Randomly decide whether to succeed or fail.
  int randomValue = arc4random_uniform(100);
  NSLog(@"Random int: %d", randomValue);

  NSString *options = @"";

  if (randomValue < 85) {
    if (request.testMode) {
      options = @"in test mode ";
    }
    if (request.keywords) {
      options = [options stringByAppendingString:@"with keywords: "];
      options = [options stringByAppendingString:[request.keywords componentsJoinedByString:@", "]];
    }

//    self.text = [@"Sample Text Ad " stringByAppendingString:options];
    self.userInteractionEnabled = YES;
    [self.delegate bannerDidLoad:self];
    
  } else if (randomValue < 90) {
    [self.delegate banner:self didFailToLoadAdWithErrorCode:SampleErrorCodeUnknown];
  } else if (randomValue < 95) {
    [self.delegate banner:self didFailToLoadAdWithErrorCode:SampleErrorCodeNetworkError];
  } else {
    [self.delegate banner:self didFailToLoadAdWithErrorCode:SampleErrorCodeNoInventory];
  }
  NSLog(@"Done fetching ad");
}
- (void)showFooterAd {
    NSData *data = [_adUnit dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    AdWebViewViewController* webViewVC = [[AdWebViewViewController alloc]init];
    webViewVC.URL = [json objectForKey:@"footer"];
    webViewVC.isTransparent = YES;
    webViewVC.parameters = json;
    webViewVC.view.backgroundColor = [UIColor clearColor];
    webViewVC.isFullScreen = NO;
    UIViewController *viewController = GetAppDelegate().getSelectedNavigationController.topViewController;
    webViewVC.view.backgroundColor = [UIColor clearColor];
    //  webViewVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    int height = 200;
    if([json objectForKey:@"height"] != nil){
    height = [UIScreen mainScreen].bounds.size.height*[[json objectForKey:@"height"]intValue]/100;
    }
    webViewVC.view.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-height-100, [UIScreen mainScreen].bounds.size.width, height);
    [UIView transitionWithView:webViewVC.view duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ {
                        [viewController addChildViewController:webViewVC];
                        [viewController.view addSubview:webViewVC.view];
                        [webViewVC didMoveToParentViewController:viewController];
                    }
                    completion:nil];
    
}
#pragma mark - Show Intersitial Ad
- (void)showIntersitial {
    NSData *data = [_adUnit dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    webViewVC = [[AdWebViewViewController alloc]init];
    webViewVC.URL = [json objectForKey:@"fullscreen"];
    webViewVC.isFullScreen = YES;
    webViewVC.isTransparent = YES;
    webViewVC.parameters = json;
    webViewVC.view.backgroundColor = [UIColor clearColor];
    UIViewController *viewController = GetAppDelegate().getSelectedNavigationController.topViewController;
    webViewVC.view.backgroundColor = [UIColor clearColor];
    webViewVC.view.frame = CGRectMake(0,0 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [viewController presentViewController:webViewVC animated:YES completion:nil];
    
}
#pragma mark SampleBannerAdDelegate implementation
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSData *data = [_adUnit dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if([request.URL.absoluteString isEqualToString:@"order://fullscreen"] && [json objectForKey:@"fullscreen"] != nil){
        if(![webViewVC presentedViewController]){
            webViewVC.isFullScreen = YES;
        [self showIntersitial];
        }
        return NO;
    }else if( [request.URL.absoluteString containsString:@"http"]&& navigationType == UIWebViewNavigationTypeLinkClicked){
        // footer
        [[UIApplication sharedApplication]openURL:webView.request.URL];
        return NO;
    }
    return YES;
}

@end
