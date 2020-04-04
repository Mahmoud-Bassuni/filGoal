//
//  BannersListViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/14/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannersListViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,XLPagerTabStripChildItem>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *loadingLbl;
@property(nonatomic,assign) int index;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
