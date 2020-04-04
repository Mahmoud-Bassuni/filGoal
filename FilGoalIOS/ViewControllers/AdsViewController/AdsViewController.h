//
//  AdsViewController.h
//  AkhbarakMobileApp
//
//  Created by Nada Gamal on 2/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@interface AdsViewController : UIViewController<GADInterstitialDelegate>
@property (strong, nonatomic) IBOutlet UIView *adsView;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) id item;
@property (strong,nonatomic) GADInterstitial * interstitialAd;
@property  NSUInteger pageIndex;

@end
