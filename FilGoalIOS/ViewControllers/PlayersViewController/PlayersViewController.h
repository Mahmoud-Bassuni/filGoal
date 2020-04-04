//
//  PlayersViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 7/30/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersViewController : ParentViewController <XLPagerTabStripChildItem,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSArray * championships;
@property (strong, nonatomic) NSArray * championshipsTitles;
@property (strong, nonatomic) NSArray * players;
@property (strong, nonatomic) NSString * teamName;
//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;
@property (assign, nonatomic) int teamId;
@property (weak, nonatomic) IBOutlet UIButton *selectChampionshipBtn;
@property (nonatomic, strong) DOPDropDownMenu *menu;
- (IBAction)championshipsBtnPressed:(id)sender;

@end
