//
//  NewScorersViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/7/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScorersList.h"
#import "ScorerCell.h"
#import "ScorerHeaderViewCell.h"
#import "Scorer.h"
#import "PlayerProfileViewController.h"
#import "TappableSponsorImageView.h"

@interface NewScorersViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,XLPagerTabStripChildItem>
@property (strong, nonatomic) NSString* teamName;
@property (strong, nonatomic) NSArray * championships;
@property (strong, nonatomic) NSArray * scorers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (assign, nonatomic) int teamId;
@property (assign, nonatomic) int champId;
@property (assign, nonatomic) BOOL isFromChampionshipSection;
@property (strong, nonatomic) IBOutlet UIButton *dropdownBtn;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgViewv;
@property (strong, nonatomic) NSString * champName;

@property (weak, nonatomic) IBOutlet UIButton *selectChampionshipBtn;
- (IBAction)championshipsBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *dropDownHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewConstraint;


@end
