//
//  AuthorProfileViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/5/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Author.h"
@interface AuthorProfileViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIImageView *bgImgView;
@property (strong, nonatomic) Author * author;
@end
