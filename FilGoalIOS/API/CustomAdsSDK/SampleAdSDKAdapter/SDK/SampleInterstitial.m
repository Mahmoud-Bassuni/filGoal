//
// Copyright (C) 2015 Google, Inc.
//
// SampleInterstitial.m
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
//#import "ViewController.h"
#import "WKWebViewViewController.h"
#import "SampleInterstitial.h"
#import <SafariServices/SafariServices.h>
#import <STPopup/STPopup.h>
#import "AppDelegate.h"
#import "AdWebViewViewController.h"
@import Foundation;
@import UIKit;

@interface SampleInterstitial () <UIAlertViewDelegate>
@end

@implementation SampleInterstitial

- (void)fetchAd:(SampleAdRequest *)request {
  // If the publisher didn't set an ad unit, return a bad request.
  if (!self.adUnit) {
    [self.delegate interstitial:self didFailToLoadAdWithErrorCode:SampleErrorCodeBadRequest];
    return;
  }

  int randomValue = arc4random_uniform(100);
  if (randomValue < 85) {
    self.interstitialLoaded = YES;
    [self.delegate interstitialDidLoad:self];
  } else if (randomValue < 90) {
    [self.delegate interstitial:self didFailToLoadAdWithErrorCode:SampleErrorCodeUnknown];
  } else if (randomValue < 95) {
    [self.delegate interstitial:self didFailToLoadAdWithErrorCode:SampleErrorCodeNetworkError];
  } else {
    [self.delegate interstitial:self didFailToLoadAdWithErrorCode:SampleErrorCodeNoInventory];
  }
}

- (void)show {
  [self.delegate interstitialWillPresentScreen:self];
    NSData *data = [_adUnit dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    AdWebViewViewController* webViewVC = [[AdWebViewViewController alloc]init];
    webViewVC.parameters = json;
    webViewVC.view.backgroundColor = [UIColor clearColor];

    [self.delegate interstitialWillLeaveApplication:self];
    UIViewController * viewController = GetAppDelegate().getSelectedNavigationController.topViewController;
    webViewVC.view.backgroundColor = [UIColor clearColor];
    //  webViewVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self.delegate interstitialWillLeaveApplication:self];
    webViewVC.view.frame = CGRectMake(0,[UIScreen mainScreen].bounds.size.height-300 , [UIScreen mainScreen].bounds.size.width, 200);
    [UIView transitionWithView:webViewVC.view duration:0.5
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ {                        
                        [viewController addChildViewController:webViewVC];
                        [viewController.view addSubview:webViewVC.view];
                        [webViewVC didMoveToParentViewController:viewController];
                    }
                    completion:nil];

 self.interstitialLoaded = NO;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
  [self.delegate interstitialWillDismissScreen:self];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {


  }
  [self.delegate interstitialDidDismissScreen:self];
}

@end
