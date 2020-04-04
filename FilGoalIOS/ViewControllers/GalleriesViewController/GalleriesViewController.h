//
//  GalleriesViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 4/19/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"

@interface GalleriesViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,XLPagerTabStripChildItem>
@property (strong, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (assign, nonatomic) int teamId;
@property (assign,nonatomic)  int  playerId;
@property (assign,nonatomic)  int  sectionId;
@property (strong, nonatomic) NSString * teamName;
@property (strong, nonatomic) NSString * sectionName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomSpaceConstraint;
@property (assign,nonatomic) int champId;
@property (strong, nonatomic) NSString * champName;

@end
