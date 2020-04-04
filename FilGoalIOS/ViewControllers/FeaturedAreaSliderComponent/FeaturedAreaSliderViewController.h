//
//  FeaturedAreaSliderViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 2/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FeaturedAreaSliderViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *newsImgView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *newstitleLbl;
@property (strong, nonatomic) IBOutlet UIView *specialView;
@property (strong, nonatomic) IBOutlet UILabel *specialLbl;
@property (strong,nonatomic) NSArray * topNewsItems;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic , strong) NSTimer * scrollTimer;
@property (strong, nonatomic) IBOutlet UIView *carouselView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *featuredView;
@property (strong, nonatomic) IBOutlet UIView *gradientView;
@property (strong, nonatomic) IBOutlet UIView *pagerOuterView;

@end
