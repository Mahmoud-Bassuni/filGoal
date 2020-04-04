//
//  TeamProfileViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 7/27/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamProfileDetailsViewController.h"
#import "GalleriesViewController.h"
#import "XLButtonBarPagerTabStripViewController.h"
#import "TeamProfile.h"
#import "Championship.h"
#import "CAPSPageMenu.h"
#import "TeamStandingsViewController.h"
#import "TeamMatchesViewController.h"
#import "TeamProfileTabsViewController.h"
#import "MultiSelectionViewController.h"

@interface TeamProfileViewController : UIViewController<MultiSelectionViewControllerDelegate,CAPSPageMenuDelegate> //
@property (nonatomic,strong) CAPSPageMenu *pageMenu;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) NSMutableArray * childViewControllers;
@property(nonatomic,strong) NSArray * championships;
@property (strong, nonatomic) TeamProfile * teamProfile;
@property (strong, nonatomic) TeamProfileTabsViewController * teamProfileTabs;
@property (strong, nonatomic) IBOutlet UIView *tabsView;
@property (assign, nonatomic) int teamId;
@property (assign, nonatomic) int isEditMode;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *infoHeightConstraint;

@property (strong, nonatomic) NSString * teamName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *teamLogoActivityIndicator;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *largeActivityIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *teamImgActivityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *teamImgView;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *playgroundNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *coachImgView;
@property (weak, nonatomic) IBOutlet UILabel *foundationDateLbl;
@property (weak, nonatomic) IBOutlet UIButton *hyperlinkBtn;
@property (weak, nonatomic) IBOutlet UIView *teamLogoView;
@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImgView;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topScrollViewConstraint;


@end
