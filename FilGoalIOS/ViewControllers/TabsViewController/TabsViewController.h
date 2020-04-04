//
//  TabsViewController.h
//  Reyada
//
//  Created by Nada Gamal on 8/13/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "XLButtonBarPagerTabStripViewController.h"
@interface TabsViewController:  XLButtonBarPagerTabStripViewController<XLPagerTabStripViewControllerDelegate>
@property (nonatomic,strong) NSArray * tabsTitles;
@property (nonatomic,strong) UIColor * indicatorColor;
@property (nonatomic,strong) NSMutableArray * childViewControllers;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,assign) BOOL isFromHome;
@property(nonatomic,assign) BOOL isFromDetails;
@property(nonatomic,assign) BOOL isFromDetailsHasOneChamp;
@property(nonatomic,assign) BOOL isFromMatches;
@property(nonatomic,retain) NSString *championLogoUrl;
@property (weak, nonatomic) IBOutlet UIView *champLogoView;
@property (weak, nonatomic) IBOutlet UIImageView *champLogoImgView;
@property(nonatomic,assign) BOOL isFromMatchesSection;
@property(nonatomic,assign) BOOL showRotationIcon;

@end
