//
//  AuthorsViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/3/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorsViewController : ParentViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *recentFilterBtn;
@property (strong, nonatomic) IBOutlet UIButton *timeFilterBtn;
- (IBAction)recentFilterAction:(id)sender;
- (IBAction)timeFilterAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;

@end
