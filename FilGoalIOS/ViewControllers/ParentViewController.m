//
//  ParentViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/11/14.
//  Copyright (c) 2014 Sarmady . All rights reserved.
//
#import "FilGoalIOS-Swift.h"
#import <objc/runtime.h>

#import "ParentViewController.h"
#import  "AppDelegate.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "SVWebViewController.h"
#import "SplashViewController/SplashViewController.h"
#import "MatchesViewController.h"
#import "featuredPagerViewController.h"
#import "RamdanDayViewController.h"
#import "VideoDetailsViewController.h"
#import "NewsDetailsViewController.h"
#import "FeaturedWebViewViewController.h"
#import "MainSectionViewController.h"
#import "GalleriesViewController.h"
#import "VungleAdNetworkExtras.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationController+Transparency.h"
#import "MatchOverviewViewController.h"
#import "AuthorsViewController.h"
#import "WeekMatchesViewController.h"
#import <Toast/Toast.h>
#import <Masonry/Masonry.h>
#import "SpecialSponsorUrl.h"


@interface ParentViewController ()

//MARK: Sponsor Banner
@property BOOL hideSponsorBanner;

//View
@property (strong, nonatomic) UIView *testView;

//ImageView
@property (strong, nonatomic) UIImageView *testViewImageV;
@property (strong, nonatomic) UIImage *testViewImage;

@end

@implementation ParentViewController {
    BOOL isSideMenuOpen;
    int isAdsEnabled ;
    AppDelegate *appDelegate;
    NSDate * startDate;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.effectiveMeasurementWebView stopLoading];
    self.effectiveMeasurementWebView = nil;
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [self.effectiveMeasurementWebView stopLoading];
    self.effectiveMeasurementWebView = nil;
    self.interstitialAd.delegate = self;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //Testing adding the sponsor banner
    if ([self.parentViewController isKindOfClass: [UINavigationController class]]) {
        [self setUpBannerUnderNav:self.view anotherTopView: nil];
    }
    
    NSLog(@"the navigationBar height: %f", ([UIApplication sharedApplication].statusBarFrame.size.height +
                (self.navigationController.navigationBar.frame.size.height ?: 0.0)) );
    
    isEffectiveMeasurementLoadedOnce=0;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.effectiveMeasurementWebView setDelegate:self];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[EmTracker sharedInstance] trackDefault];
    
    //Interstitial Ad
   
    if ([Global getInstance].lastTimeIncrementedViewsCount == nil) {
        [Global getInstance].lastTimeIncrementedViewsCount = [[NSDate alloc] init];
    }
    NSTimeInterval secondsBetween = [[[NSDate alloc] init] timeIntervalSinceDate: [Global getInstance].lastTimeIncrementedViewsCount ];
    
    if([Global getInstance].isAdsEnabledAtApp && secondsBetween >= 2) {
        [Global getInstance].lastTimeIncrementedViewsCount = [[NSDate alloc] init];
        
        //if ([Global getInstance].screenViewsCount == 0) {
        if ([Global getInstance].screenViewsCount <= 3 && [Global getInstance].interstitialAd == nil) { //Just Load the Ad but DON'T! show it
            [self createAndLoadInterstitial];
        }
        
        if ([Global getInstance].screenViewsCount != 0) {  //Decrease by one
            [self decrementScreenViews];
        }
    }

    if ([Global getInstance].interstitialAd != nil && [Global getInstance].screenViewsCount == 0) { //&& [Global getInstance].interstitialAd.isReady

        if (![Global getInstance].isCounterToastDisplayed) {
            
            //1s way
            //ShowToast
          /*CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
            style.messageColor = [UIColor orangeColor];
            [Global getInstance].counterToastDisplayed = YES;
            [self.view.window makeToast:@"Ad will show after 3 seconds"
                               duration:3.0
                               position: CSToastPositionCenter //CSToastPositionBottom
                                  title:@"Ad will show after 3 seconds"
                                  image:nil
                                  style:style
                             completion:^(BOOL didTap) { //didTap will be `YES` if the view was dismissed from a tap.
                                //The completionBlock
                                //ourCompletionWhenReachZero();
           
                             }];
            */
            [Global getInstance].counterToastDisplayed = YES;

            //2nd way
            //Block
            void (^ourCompletionWhenReachZero)(void) = ^void() {
                if ([Global getInstance].interstitialAd.isReady) {
                    //Show
                    [[Global getInstance].interstitialAd presentFromRootViewController:GetAppDelegate().getSelectedNavigationController];
                    //Turn it to nil
                    [Global getInstance].interstitialAd = nil;
                    //Count
                    [Global getInstance].selectedIntersitialIndex++;
                    if ([Global getInstance].selectedIntersitialIndex < [Global getInstance].appInfo.interstatialAdsPattern.count) {
                        [Global getInstance].screenViewsCount = [[Global getInstance].appInfo.interstatialAdsPattern [[Global getInstance].selectedIntersitialIndex]intValue];
                        
                    } else {    //Reset start from the beginning of the array
                        [Global getInstance].selectedIntersitialIndex = 0;
                        [Global getInstance].screenViewsCount = [[Global getInstance].appInfo.interstatialAdsPattern[0]intValue];
                    }
                    //Toast no longer displayed
                    [Global getInstance].counterToastDisplayed = NO;
                } else {
                    [Global getInstance].counterToastDisplayed = NO;
                }
            };
            
            //Create our views, timer, the text, add them to the window
            CGSize size = CGSizeMake(220, 70); //CGSizeMake(140, 44);
            int xPosition = (self.view.window.frame.size.width / 2) - (size.width / 2); //self.navigationController.view.frame.size.width
            int yPostion = self.view.window.frame.size.height - 140; //self.navigationController.view.frame.size.height
            
            
            UILabel *countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPosition, yPostion, size.width, size.height)];
            countDownLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.89];
            countDownLabel.textAlignment = NSTextAlignmentCenter;
            countDownLabel.numberOfLines = 0;
            countDownLabel.textColor = [UIColor orangeColor]; //[UIColor orangeColor]; //[UIColor whiteColor];
            countDownLabel.layer.cornerRadius = size.height / 2;
            countDownLabel.clipsToBounds = YES;
            
            [self.view.window addSubview:countDownLabel];
            [self.view.window bringSubviewToFront:countDownLabel];
            
            //Text
            __block NSUInteger countdown = 3;
            NSString *arabic  = [NSString stringWithFormat:@"إعلان بعد %lu ثانية", (unsigned long)countdown];
            NSString *english = [NSString stringWithFormat:@"\nAd after %lu seconds", (unsigned long)countdown];
            NSString *wholeText = [arabic stringByAppendingString:english];
            NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
            style.alignment = NSTextAlignmentCenter;
            //style.minimumLineHeight = 26.f; //style.maximumLineHeight = 26.f;
            style.lineSpacing = 8.f;
            NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style, };
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:wholeText
                                                                            attributes:attributtes];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, arabic.length)];
            //[attributedString addAttribute:NSFontAttributeName value:<#(nonnull id)#> range:<#(NSRange)#>];
            countDownLabel.attributedText = attributedString;
            //[countDownLabel sizeToFit];
            //countDownLabel.text = wholeText;
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
                countdown -= 1;
                
                if (countdown <= 0) {
                    ourCompletionWhenReachZero();
                    
                    [timer invalidate];
                    [countDownLabel removeFromSuperview];
                }
                NSString *arabic  = [NSString stringWithFormat:@"إعلان بعد %lu ثانية", (unsigned long)countdown];
                NSString *english = [NSString stringWithFormat:@"\nAd after %lu seconds", (unsigned long)countdown];
                NSString *wholeText = [arabic stringByAppendingString:english];
                NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
                style.alignment = NSTextAlignmentCenter;
                //style.minimumLineHeight = 26.f; //style.maximumLineHeight = 26.f;
                style.lineSpacing = 8.f;
                
                NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style,};
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:wholeText
                                                                                                     attributes:attributtes];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, arabic.length)];
                //[attributedString addAttribute:NSFontAttributeName value:<#(nonnull id)#> range:<#(NSRange)#>];
                countDownLabel.attributedText = attributedString;
                //[countDownLabel sizeToFit];
                //countDownLabel.text = wholeText;
            }];
        }
    }
    
    if(![self isKindOfClass:[SplashViewController class]])
    {
        ShowInternetIndicator;
    }
    
    //[self setSponsors];
    
}

//now called inside setUpBannerUnderNav before was called inside viewDidAppear
-(void)setSponsors {
    if( (appDelegate.getSelectedNavigationController.viewControllers.count == 1 && ![self isKindOfClass:[NewsDetailsViewControllerWithWKWebView class]]&&![self isKindOfClass:[NewsDetailsViewController class]]&&![self isKindOfClass:[VideoDetailsViewController class]]&&![self isKindOfClass:[GalleryDetailsViewController class]] && ![self isKindOfClass:[NewsHomeViewController class]] && ![self isKindOfClass:[VideosViewController class]] && ![self isKindOfClass:[WeekMatchesViewController class]])
       || [self isKindOfClass:[SectionsViewController class]] || [self isKindOfClass:[PlayerProfileViewController class]] )
    {
        [self setNavigationBarBackgroundImage];
    } else {
        [self setNavigationBarBackgroundImage];
    }
}

/*
//Not Using Still Under Development
-(void)setUpBannerUnderNavInPlace:(UIView*)fullView newPlaceView:(UIView*)newPlaceView {
    UIView *testView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 15)];
    testView.backgroundColor = [UIColor orangeColor];
    newPlaceView = testView;
}
//Not Using Still Under Development
-(void)setUpBannerUnderNavBetween:(UIView*)fullView firstV:(UIView*)firstV secondV:(UIView*)secondV  {
    UIView *testView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 15)];
    testView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:testView];

    for (int i = 0; i < fullView.constraints.count; i++){
        NSLayoutConstraint *constraint = [fullView.constraints objectAtIndex:i];
        
        NSLog(@"----------------\n\nconstraint.secondItem == %@ |||\nconstraint.firstItem == %@ ||| \nconstraint == %@\n\n \n------------------------------------------------------------------------------------------------------------------------",  constraint.secondItem, constraint.firstItem, constraint);
        if ( (constraint.secondItem == firstV && constraint.firstItem == secondV) ||
             (constraint.firstItem == firstV && constraint.secondItem == secondV) ) {
            NSLog(@"-------- Result Constraint: %@ \n", constraint);

            [fullView removeConstraint:constraint];
            
            NSLayoutConstraint *newTopConstraint = [NSLayoutConstraint
                                                    constraintWithItem:testView
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:firstV
                                                    attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                    constant:0];
            NSLayoutConstraint *newBottomConstraint = [NSLayoutConstraint
                                                       constraintWithItem:testView
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                       toItem:secondV
                                                       attribute:NSLayoutAttributeTop
                                                       multiplier:1.0
                                                       constant:0];
            
            [fullView addConstraints: @[newTopConstraint, newBottomConstraint]];
            [fullView layoutIfNeeded];
        }
    }
    
}*/
//Using 1st Case
-(void)changeSponsorImage:(UIImage*)image   {
    if (self.testView != nil && self.testViewImageV != nil) {
        //UIImage *newImage = [UIImage imageNamed:@"Nav6+"];//[image resizeImageScaledToWidthWithWidth:self.view.frame.size.width];
        
        UIImage *newImage = image.size.width != self.view.frame.size.width ?
                            [image resizeImageScaledToWidthWithWidth:self.view.frame.size.width] : image;
        /*[self.testView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(newImage.size.height);
            make.width.mas_equalTo(newImage.size.width);
        }];*/
        
        MASViewAttribute *topAttri = self.testView.mas_top;
        MASViewAttribute *bottomAttri = self.testView.mas_bottom;
        
        [self.testView removeConstraints:self.testView.constraints];
        [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topAttri);
            make.bottom.equalTo(bottomAttri);
            make.size.mas_equalTo(newImage.size);
        }];
        
#ifdef DEBUG
        self.testViewImageV.image = newImage;
#else
        self.testViewImageV.image = newImage;
#endif
        [self.view layoutIfNeeded];
        [self.view sendSubviewToBack:self.testView];
        
     /* Method method = class_getInstanceMethod([ParentViewController class], @selector(changeSponsorImage));
        IMP imp = method_getImplementation(method);
        ((void (*)(id, SEL, UIImage*))imp)(self, @selector(changeSponsorImage), image); |> cast the function to the correct signature */
    }
}
///When this function gets called from child viewcontroller it will prevent the sponsor from appearing
-(void)hideSponsorBanner:(UIView*)fullView {
    self.hideSponsorBanner = YES;
    // Fixed Height
    if (self.testViewImageV != nil && self.testView.constraints.firstObject != nil) {
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
        [fullView addConstraint:heightConstraint];
        [fullView layoutIfNeeded];
    }
}

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]3
//theBottomView is the view that you specify that you want to change the constraint that connects it with the fullView..... fullView---Constraint---theBottomView
-(void)setUpBannerUnderNav:(UIView*)fullView anotherTopView:(nullable UIView*)theBottomView {
    //[self.testViewImage resizeImageScaledToWidthWithWidth:100];
    
    if (self.testView == nil && self.testViewImageV == nil && self.hideSponsorBanner != YES) {
        
        //Constants
        int height = 0; //self.testViewImage.size.height; //60;
        int width = self.view.frame.size.width;
        
        //The View
        self.testView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
        self.testView.translatesAutoresizingMaskIntoConstraints = NO;
        self.testView.backgroundColor = [UIColor colorWithWhite:0.12 alpha:0.95];//[UIColor blackColor]; //[UIColor orangeColor];
        self.testView.layer.masksToBounds = NO;
        self.testView.layer.shadowOffset = CGSizeMake(.0f,3.0f); //2.5f
        self.testView.layer.shadowRadius = 1.5f; //1.5f;
        self.testView.layer.shadowOpacity = .9f; //.9f;
        self.testView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.testView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.testView.bounds].CGPath;
        self.testView.userInteractionEnabled = YES;

        //The ImageView
        self.testViewImageV = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
        self.testViewImageV.translatesAutoresizingMaskIntoConstraints = NO;
        self.testViewImageV.userInteractionEnabled = YES;
        self.testViewImageV.clipsToBounds = YES;
        //self.testViewImageV.backgroundColor = UIColorFromRGB(0x232323); //[UIColor mainAppDarkGrayColor]; // 232323//
        self.testViewImageV.backgroundColor = [UIColor clearColor];//[UIColor colorWithWhite:0.19 alpha:0.85];
        //[UIColor colorWithWhite:0.19 alpha:0.85];
        //[UIColor colorWithWhite:0.15 alpha:0.85]; status bar color

        //The Tap Gesture
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sponsorButtonTapped:)];
        [self.testViewImageV addGestureRecognizer:tapGesture];
        
        //Functions
        [self setNavigationBarBackgroundImage]; //[self setSponsors]; //Get The Image
        [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
        
        //Add
        [self.testView addSubview: self.testViewImageV];
        [fullView addSubview: self.testView];//[self.view addSubview: self.testView];
        
        //The ImageView Constraint
        /*NSLayoutConstraint *TopConstraint = [NSLayoutConstraint constraintWithItem:self.testViewImageV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.testView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *BottomConstraint = [NSLayoutConstraint constraintWithItem:self.testViewImageV attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.testView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *TrailingConstraint = [NSLayoutConstraint constraintWithItem: self.testViewImageV attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.testView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
        NSLayoutConstraint *LeadingConstraint = [NSLayoutConstraint constraintWithItem:self.testViewImageV attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.testView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
        [fullView addConstraints: @[TopConstraint, BottomConstraint, TrailingConstraint, LeadingConstraint]];
        */
        [self.testViewImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.testView);
        }];

        [fullView layoutIfNeeded];

        //NSLog(@"self.navigationController.navigationBar.constraints: ========================");
        //NSLog(@"self.navigationController.navigationBar.constraints: %@", self.navigationController.navigationBar.constraints);
        //NSLog(@"fullView.constraints: ========================");
        //NSLog(@"fullView.constraints: %@", fullView.constraints);
        
        //1st Case
        //send the viewcontroller view
        //search for the x view that have top constraint to that viewcontroller view
        //change that x view to top constraint to be connected to testView
        
        //2nd Case
        //send the viewcontroller view and another view that we want to stick to it
        //search for the x view that have top constraint to that another view
        //change that x view to top constraint to be connected to testView
        
        //Read Only
        /*for (NSLayoutConstraint *constraint in fullView.constraints) {
         NSLog(@"---- constraint: %@ \n", constraint);
         if ([self isTopConstraint:constraint topView:fullView]) {
         NSLog(@"-------- Result Constraint: %@ \n", constraint);
         if (constraint.firstItem == fullView) {
         constraint.firstItem = testView;
         } else if (constraint.secondItem == fullView) {
         constraint.secondItem = testView;
         }
         }
         }*/
        /*
        //Give self.testView constraints (incase/sometimes) for loop fails
        // Fixed width
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem: self.testView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1.0
                                                                            constant:width];
        // Fixed Height
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.testView
                                                                            attribute:NSLayoutAttributeHeight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:nil
                                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                                           multiplier:1.0
                                                                             constant:height];
        [fullView addConstraints: @[widthConstraint, heightConstraint]];
        [fullView layoutIfNeeded];
        */
        
        if (theBottomView == nil) { //1st case - WORKING
            //for (int i = 0; i < fullView.constraints.count; i++){ NSLayoutConstraint *constraint = [fullView.constraints objectAtIndex:i];
            for (NSLayoutConstraint *constraint in fullView.constraints) {
                //NSLog(@"---- constraint: %@ \n", constraint);
                if ([self isTopConstraint:constraint topView:fullView]) {
                    //NSLog(@"-------- Result Constraint: %@ \n", constraint);
                    
                    //NSLayoutConstraint *newConstraint;
                    if (constraint.firstItem == fullView) {
                        //newConstraint.firstItem = testView;
                        [fullView removeConstraint:constraint];
                        
                        /*newConstraint = [NSLayoutConstraint constraintWithItem:constraint.secondItem attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:testView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
                         [fullView addConstraint:newConstraint];*/
                        /*NSLayoutConstraint *newTopConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:constraint.firstItem attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];//NSLayoutAttributeBottom
                        NSLayoutConstraint *newBottomConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:constraint.secondItem attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
                        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem: self.testView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
                        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
                        [fullView addConstraints: @[newTopConstraint, newBottomConstraint, widthConstraint, heightConstraint]];*/
                        [self.testView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo([(UIView*)constraint.firstItem mas_top]);//mas_bottom
                            make.bottom.equalTo([(UIView*)constraint.secondItem mas_top]);
                            
                            //make.height.mas_equalTo(self.testViewImage == nil ? height : self.testViewImage.size.height);
                            //make.width.mas_equalTo(width);
                            make.size.mas_equalTo(CGSizeMake(width, self.testViewImage == nil ? height : self.testViewImage.size.height));
                        }];
                        //break;
                    } else if (constraint.secondItem == fullView) {
                        //newConstraint.secondItem = testView;
                        [fullView removeConstraint:constraint];
                        
                        /*newConstraint = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:constraint.firstItem attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
                         [fullView addConstraint:newConstraint];*/
                        /*NSLayoutConstraint *newTopConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:constraint.secondItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]; //NSLayoutAttributeTop
                        NSLayoutConstraint *newBottomConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:constraint.firstItem attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
                        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
                        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
                        [fullView addConstraints: @[newTopConstraint, newBottomConstraint, widthConstraint, heightConstraint]];*/
                        
                        [self.testView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo([(UIView*)constraint.secondItem mas_top]);
                            make.bottom.equalTo([(UIView*)constraint.firstItem mas_top]);
                            
                            make.size.mas_equalTo(CGSizeMake(width, self.testViewImage == nil ? height : self.testViewImage.size.height));
                        }];
                        break;
                    }
                }
            }
        } else { //2nd case - NOT WORKING
            
            for (int i = 0; i < fullView.constraints.count; i++){
                NSLayoutConstraint *constraint = [fullView.constraints objectAtIndex:i];
                
                //NSLog(@"---- constraint: %@ \n", constraint);
                if ([self isTopConstraint:constraint topView:fullView]) {
                    //NSLog(@"-------- Result Constraint: %@ \n", constraint);
                    
                    NSLayoutConstraint *newConstraint; //= constraint;
                    if (constraint.firstItem == theBottomView) {
                        //newConstraint.firstItem = testView;
                        [fullView removeConstraint:constraint];

                        
                        /*newConstraint = [NSLayoutConstraint constraintWithItem:constraint.firstItem attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.testView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
                        newConstraint.identifier = @"OurNewConstraint";
                        [fullView addConstraint:newConstraint];*/
                        [self.testView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo([fullView mas_top]);
                            make.bottom.equalTo([theBottomView mas_top]);
                            
                            //make.height.mas_equalTo(self.testViewImage == nil ? height : self.testViewImage.size.height);
                            //make.width.mas_equalTo(width);
                            make.size.mas_equalTo(CGSizeMake(width, self.testViewImage == nil ? height : self.testViewImage.size.height));
                        }];
                         break;
                    } else if (constraint.secondItem == theBottomView) {
                        //newConstraint.secondItem = testView;
                        [fullView removeConstraint:constraint];

                        
                        /*newConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:constraint.secondItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
                        newConstraint.identifier = @"OurNewConstraint";
                        [fullView addConstraint:newConstraint];*/
                        [self.testView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo([fullView mas_top]);
                            make.bottom.equalTo([theBottomView mas_top]);
                            
                            //make.height.mas_equalTo(self.testViewImage == nil ? height : self.testViewImage.size.height);
                            //make.width.mas_equalTo(width);
                            make.size.mas_equalTo(CGSizeMake(width, self.testViewImage == nil ? height : self.testViewImage.size.height));
                        }];
                         break;
                    }
                }
            }
            
        }
        
        [fullView layoutIfNeeded];
        [fullView sendSubviewToBack:self.testView];

    } else {
        //[self setNavigationBarBackgroundImage];//[self setSponsors];
    }
}
/// Test


- (NSLayoutConstraint*)findTopConstraint:(UIView*)fullView {
//    if (fullView == nil) {
//        NSLog(@"nill 1");
//    }
//    if (fullView.constraints == nil) {
//        NSLog(@"nill 2");
//    }
    /*for (NSLayoutConstraint *constraint in fullView.constraints) { //top.superview.constraints
        //if ([self isTopConstraint:constraint]) {
        if ([self isTopConstraint:constraint topView:fullView]) {
            return constraint;
        }
    }*/
    return nil;
}

- (BOOL)isTopConstraint:(NSLayoutConstraint *)constraint topView:(UIView*)topView
{
    //return  [self firstItemMatchesTopConstraint:constraint] ||
    //[self secondItemMatchesTopConstraint:constraint];
    return [self firstItemMatchesTopConstraint:constraint topView:topView] || [self secondItemMatchesTopConstraint:constraint topView:topView];
}

- (BOOL)firstItemMatchesTopConstraint:(NSLayoutConstraint *)constraint topView:(UIView*)topView
{
    return constraint.firstItem == topView && constraint.firstAttribute == NSLayoutAttributeTop;
}

- (BOOL)secondItemMatchesTopConstraint:(NSLayoutConstraint *)constraint topView:(UIView*)topView
{
    return constraint.secondItem == topView && constraint.secondAttribute == NSLayoutAttributeTop;
}

-(void)sponsorButtonTapped:(UITapGestureRecognizer*)sender {
    //Testing Purpose
    //self.champs_id = 815;
    //self.section_id = 44;
    //self.activeCategory = @"album";
    
    //Start
    NSString *urlWillOpen;     //Will set it inside that cases
    Sponsorship *sponsorShip = [Global getInstance].appInfo.sponsorship.firstObject;
    
    //Check special_sponsor - Check if the current championship has sponsor
    if (self.champs_id != nil) {
        NSArray *filteredArray = [sponsorShip.mainSponsor.specialSponsor.champsUrl filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            if ([(SpecialSponsorUrl*)evaluatedObject idField] == self.champs_id) {
                return YES; //Same Id, then this is the one
            }
            return NO;  //Not the same id, then ignore it
        }] ];
        
        if (filteredArray.firstObject != nil) {
            urlWillOpen = [(SpecialSponsorUrl*)filteredArray.firstObject url];
        }
    }
    //Check special_sponsor - Check if the current section has sponsor
    else if (self.section_id != nil) {
        NSArray *filteredArray = [sponsorShip.mainSponsor.specialSponsor.sectionUrl filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            if ([(SpecialSponsorUrl*)evaluatedObject idField] == self.section_id) {
                return YES; //Same Id, then this is the one
            }
            return NO;  //Not the same id, then ignore it
        }] ];
        
        if (filteredArray.firstObject != nil) {
            urlWillOpen = [(SpecialSponsorUrl*)filteredArray.firstObject url];
        }
    }
    //Check Category - Matches, Albums, News, Videos
    else if ( [[self.activeCategory lowercaseString] containsString: @"album"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.albumsUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"match"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.matchesUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"new"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.newsUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"video"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.videosUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"free"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.freeOpinionsUrl;
        
    }
    //Check app_sponsor - The General Case and its the last
    if ( urlWillOpen == nil) {
        //Open App Global Sponsor
        urlWillOpen = sponsorShip.mainSponsor.appSponsor.appBarUrl;
    }
    
    
    //Open The URL
    if (urlWillOpen != nil) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlWillOpen]];
    }
}
///

-(void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self startMeasuring];
    if(appDelegate.getSelectedNavigationController != nil)
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    else
        self.parentViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    

    [self addEffectiveMeasureWebView];
    
    appDelegate.getSelectedNavigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (NSString *) appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}
- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    self.interstitialAd.delegate = nil;
    
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self setNeedsStatusBarAppearanceUpdate];
    
}

-(void)decrementScreenViews
{
    if([Global getInstance].selectedIntersitialIndex >= [Global getInstance].appInfo.interstatialAdsPattern.count)
    {
        [Global getInstance].selectedIntersitialIndex = 0;
    }
    if([Global getInstance].screenViewsCount>0)
    {
        if(![self isKindOfClass:[VideoDetailsViewController class]]&&
           ![self isKindOfClass:[NewsDetailsViewController class]]&&
           ![self isKindOfClass:[NewsDetailsViewControllerWithWKWebView class]]&&
           ![self isKindOfClass:[GalleryDetailsViewController class]]&&
           ![self isKindOfClass:[MainSectionViewController class]]&&
           ![self isKindOfClass:[SplashViewController class]]&&
           ![self isKindOfClass:[MatchCenterTabsViewController class]])
        {
            
            [Global getInstance].screenViewsCount --;
            
        }
    }
}
#pragma mark- UIWebviewDelegate ....

-(void)addEffectiveMeasureWebView
{
    self.effectiveMeasurementWebView=[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [self.effectiveMeasurementWebView setTag:123456];
    self.effectiveMeasurementWebView.navigationDelegate=self;
    NSString *urlString = [NSString stringWithFormat:Effective_Measure_URL,[NSString stringWithFormat:@"iOS-%@",NSStringFromClass([self class])]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.effectiveMeasurementWebView loadRequest:request];
    [self.effectiveMeasurementWebView setHidden:YES];
}


- (void)webView:(WKWebView *)aWebView didFinishNavigation:(WKNavigation *)aNavigation
{
    
}

-(void)setscreenAnalyticsMetricsWithScreenName:(NSString*)screenName andKeywords:(NSString*)keywords{
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[[[GAIDictionaryBuilder createAppView] set:screenName  forKey:kGAIScreenName] set:keywords forKey:[GAIFields customDimensionForIndex:3]] build]];
}
-(UIView*)setBannerViewFooter :(NSArray*)keywords andPosition:(NSArray*)postions andScreenName:(NSString*)screenName
{
    UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0,0, Screenwidth, 270)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(300, 250));
    self.bannerView=[[DFPBannerView alloc]initWithAdSize:customAdSize origin:CGPointMake((Screenwidth-300)/2-10, 0)];
    if(postions.count>0)
        self.bannerView.adUnitID = MeduimRectangle_AD_UNIT_ID;
    else
        self.bannerView.adUnitID = MeduimRectangle_Admob_AdUnit;
    self.bannerView.delegate = self;
    self.bannerView.adSize=customAdSize;
    self.bannerView.rootViewController = self;
    DFPRequest *request = [DFPRequest request];
    request.keywords = keywords;
    request.customTargeting = [[NSDictionary alloc]initWithObjects:@[keywords,postions] forKeys:@[@"Keyword",@"Position"]];
    // Initiate a generic request to load it with an ad.
    [self.bannerView loadRequest:request];
    [footerView addSubview:self.bannerView];
    [self setscreenAnalyticsMetricsWithScreenName:screenName andKeywords:[keywords componentsJoinedByString:@"," ]];
    
    return footerView;
}
- (void)dealloc {
    
}

#pragma mark - setNavigationBar Image
-(void)setTransparentUINavigationBar
{
    self.title = @"";
    [appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [appDelegate.getSelectedNavigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [appDelegate.getSelectedNavigationController.navigationBar setShadowImage:[UIImage new]];
    appDelegate.getSelectedNavigationController.navigationBar.translucent = YES;
}
//This Sets The New Sponsor Banner
-(void)setFilGoalNavigationBar
{
    [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    if (IS_IPHONE_4) {
        //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
        //Using New SponsorBanner
        //self.testViewImage = [UIImage imageNamed:@"Nav4"];
        //[self changeSponsorImage:[UIImage imageNamed:@"Nav4"]];
    } else if(IS_IPHONE_5) {
        //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
        //Using New SponsorBanner
        //self.testViewImage = [UIImage imageNamed:@"Nav5"];
        //[self changeSponsorImage:[UIImage imageNamed:@"Nav5"]];
    } else if (IS_IPHONE_6) {
        //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
        //Using New SponsorBanner
        //self.testViewImage = [UIImage imageNamed:@"Nav6"];
        //[self changeSponsorImage:[UIImage imageNamed:@"Nav6"]];
    } else {
        //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
        //Using New SponsorBanner
        //self.testViewImage = [UIImage imageNamed:@"Nav6+"] ;
        //[self changeSponsorImage:[UIImage imageNamed:@"Nav6+"]];
    }
}
//This Sets The New Sponsor Banner
-(void)setNavigationBarBackgroundImage {
    [self setFilGoalNavigationBar];
    //if(YES == NO) 
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //Using NavigationBar
                //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];.
                //Using New SponsorBanner
                self.testViewImage = image;
                [self changeSponsorImage:image];

            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (image && finished) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //Commented beacuse this line was somehow decreassing the image quality when it was getting retrived
                            //[[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                            
                            //Using NavigationBar
                            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                            //Using New SponsorBanner
                            self.testViewImage = image;
                            [self changeSponsorImage:image];
                         });
                    }
                }];
            });
        }
    }
}
//This Sets The New Sponsor Banner - must get called from the the viewcontroller that subview from parentViewController usefull incase there was sponsor for a certain championship
//-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl    {
-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl champs_id:(NSInteger)champs_id section_id:(NSInteger)section_id activeCategory:(NSString*)activeCategory {
    self.champs_id = champs_id;
    self.section_id = section_id;
    self.activeCategory = activeCategory;
    
    [self setFilGoalNavigationBar];
    UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:mainSponsorUrl];
    if(image!=nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //Using NavigationBar
            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
            //Using New SponsorBanner
            self.testViewImage = image;
            [self changeSponsorImage:image];

        });
    
    } else {
        if(mainSponsorUrl!=nil&&![mainSponsorUrl isEqualToString:@""]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:mainSponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (image && finished) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[SDImageCache sharedImageCache] storeImage:image forKey:mainSponsorUrl toDisk:YES];
                            //Using NavigationBar
                            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                            //Using New SponsorBanner
                            self.testViewImage = image;
                            [self changeSponsorImage:image];
                        });
                        
                    }
                }];
            });
        
        } else {
            [self setNavigationBarBackgroundImage];
        }
    }
}

//Similar to above - BUT GETS CALLED ONLY FROM CHILD VIEWCONTROLLERS - HAD A PROBLEM WHEN:
//childVC --calls--> super setNavigationBarBackgroundImage --and method calls--> self setFilGoalNavigationBar & self setNavigationBarBackgroundImage
//at that time both setFilGoalNavigationBar & setNavigationBarBackgroundImage they don't get called
//-(void)setNavigationBarBackgroundFromChildViewControllerImageStr:(NSString*)mainSponsorUrl   {
-(void)setNavigationBarBackgroundFromChildViewControllerImageStr:(NSString*)mainSponsorUrl champs_id:(NSInteger)champs_id section_id:(NSInteger)section_id activeCategory:(NSString*)activeCategory{
    self.champs_id = champs_id;
    self.section_id = section_id;
    self.activeCategory = activeCategory;

    //Mark:------ Calls = [self setFilGoalNavigationBar];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    if (IS_IPHONE_4) {
        //self.testViewImage = [UIImage imageNamed:@"Nav4"];
        //[self changeSponsorImage:[UIImage imageNamed:@"Nav4"]];
    } else if(IS_IPHONE_5) {
        //self.testViewImage = [UIImage imageNamed:@"Nav5"];
        //[self changeSponsorImage:[UIImage imageNamed:@"Nav5"]];
    } else if (IS_IPHONE_6) {
        //self.testViewImage = [UIImage imageNamed:@"Nav6"];
        //[self changeSponsorImage:[UIImage imageNamed:@"Nav6"]];
    } else {
        //self.testViewImage = [UIImage imageNamed:@"Nav6+"] ;
        //[self changeSponsorImage:[UIImage imageNamed:@"Nav6+"]];
    }
    
    
    //Mark:------ Calls = [self setNavigationBarBackgroundFromChildImageStr: url];
    UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:mainSponsorUrl];
    if(image!=nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //Using NavigationBar
            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
            //Using New SponsorBanner
            self.testViewImage = image;
            [self changeSponsorImage:image];
        });
        
    } else {
        if(mainSponsorUrl!=nil&&![mainSponsorUrl isEqualToString:@""]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:mainSponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (image && finished) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[SDImageCache sharedImageCache] storeImage:image forKey:mainSponsorUrl toDisk:YES];
                            //Using NavigationBar
                            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                            //Using New SponsorBanner
                            self.testViewImage = image;
                            [self changeSponsorImage:image];
                        });
                        
                    }
                }];
            });
            
        } else {
            
            //Mark:------ Calls = [self setNavigationBarBackgroundImage];
            if([AppSponsors isAppNavigationbarSponsorActive]) {
                UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
                if(image!=nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //Using NavigationBar
                        //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];.
                        //Using New SponsorBanner
                        self.testViewImage = image;
                        [self changeSponsorImage:image];
                    });
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                            if (image && finished) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    //Commented beacuse this line was somehow decreassing the image quality when it was getting retrived
                                    //[[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                                    
                                    
                                    //Using NavigationBar
                                    //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                                    //Using New SponsorBanner
                                    self.testViewImage = image;
                                    [self changeSponsorImage:image];
                                });
                            }
                        }];
                    });
                    
                }
            }

        }
    }
}
#pragma mark - Ads Methods
-(void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSLog(@"Banner adNetworkClassName %@",bannerView.adNetworkClassName);
    
}
-(void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    IBGLog(@"Banner Error : %@",error.description);
}
#pragma mark interstitial ads

-(void)createAndLoadInterstitial{
    [Global getInstance].interstitialAd=[[GADInterstitial alloc] initWithAdUnitID:Intersitial_AD_UNIT_ID];
    [Global getInstance].interstitialAd.delegate=self;
    GADRequest *request = [GADRequest request];
    VungleAdNetworkExtras *extras = [[VungleAdNetworkExtras alloc] init];
    extras.allPlacements = @[@"DEFAULT04352"];
    extras.playingPlacement =@"DEFAULT04352";
    extras.userId = @"vungle_test_david";
    [request registerAdNetworkExtras:extras];
    [[Global getInstance].interstitialAd loadRequest:request];
    
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    //    [Global getInstance].selectedIntersitialIndex++;
    //    if([Global getInstance].selectedIntersitialIndex<[Global getInstance].appInfo.interstatialAdsPattern.count)
    //        [Global getInstance].screenViewsCount = [[Global getInstance].appInfo.interstatialAdsPattern[[Global getInstance].selectedIntersitialIndex]intValue];
    //    else
    //    {
    //        [Global getInstance].selectedIntersitialIndex = 0;
    //        [Global getInstance].screenViewsCount = [[Global getInstance].appInfo.interstatialAdsPattern[0]intValue];
    //    }
    //    if(![self isKindOfClass:[VideoDetailsViewController class]]&&![self isKindOfClass:[NewsDetailsViewController class]]&&![self isKindOfClass:[NewsDetailsViewControllerWithWKWebView class]]&&![self isKindOfClass:[GalleryDetailsViewController class]])
    //    {
    //        // UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:self];
    //        NSLog(@"adNetworkClassName %@",self.interstitialAd.adNetworkClassName);
    //        [self.interstitialAd presentFromRootViewController:appDelegate.getSelectedNavigationController.topViewController ];
    //    }
    //
}

/*- (void)adsManager:(IMAAdsManager *)adsManager didReceiveAdEvent:(IMAAdEvent *)event {
    
}*/

- (void)webOpenerWillOpenInAppBrowser:(NSObject *)webOpener
{
    
}
- (void)interstitialWillLeaveApplication:(DFPInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}


#pragma mark - GA Functions

- (void)sendAppSpeedTimeIntervalWithTime:(NSTimeInterval)loadTime AndScreenName:(NSString*)screenName ApiError:(NSString *)apiStatus {
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createTimingWithCategory:@"iOS"
                                                         interval:@((NSUInteger)(loadTime * 1000))
                                                             name:screenName
                                                            label:apiStatus] build]];
}

- (void)startMeasuring {
    startDate = [NSDate date];
}

- (NSTimeInterval)stopMeasuring {
    return ABS([startDate timeIntervalSinceNow]);
    
}

@end
