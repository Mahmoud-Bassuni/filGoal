//
//  MatchesByDateViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 4/18/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@interface MatchesByDateViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,XLPagerTabStripChildItem>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) NSString * selectedDateStr;
@property (strong, nonatomic) NSString * dayBeforeSelectedDateStr;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property (strong, nonatomic) IBOutlet UIImageView *sponsorImgView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;
@property(nonatomic,assign) int index;
@property(nonatomic,assign) BOOL isFromMatchesView; // From MatchesList from Menu to remove sponsor and date label

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *dateLblHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topSpaceHeightConstraint;


@end
