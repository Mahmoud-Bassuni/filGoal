//
//  BannersSliderViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/14/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@interface BannersSliderViewController : UIViewController <iCarouselDelegate>
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic , strong) NSTimer * scrollTimer;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,assign) BOOL isFromHome;
@property(nonatomic,retain) NSTimer *top10Timer;
@property (strong, nonatomic) IBOutlet UIImageView *bannerImgView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end
