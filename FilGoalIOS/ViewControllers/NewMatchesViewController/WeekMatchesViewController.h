//
//  WeekMatchesViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/26/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabsViewController.h"
#import "MatchesByDateViewController.h"
#import "CAPSPageMenu.h"
@interface WeekMatchesViewController : GAITrackedViewController<CAPSPageMenuDelegate>
//For Sponsor
@property (assign) NSInteger champs_id;
@property (assign) NSInteger section_id;
@property (strong, nonatomic) NSString *activeCategory;


@property (strong, nonatomic) IBOutlet UIImageView *sponsorImg;
@property (nonatomic,assign) BOOL isFromWidget;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (strong, nonatomic) IBOutlet UIView *tabsView;
@property (strong, nonatomic) NSMutableArray * childViewControllers;
@property (nonatomic,assign) NSInteger selectedTabIndex;

@property (nonatomic) CAPSPageMenu *pageMenu;

@end
