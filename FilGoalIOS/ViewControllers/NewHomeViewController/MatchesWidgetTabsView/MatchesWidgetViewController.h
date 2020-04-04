//
//  MatchesWidgetViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "HomeMatchWidgetCell.h"
#import "TappableSponsorImageView.h"

@interface MatchesWidgetViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *tabsView;
@property (strong,nonatomic) NSDictionary * matchesDic;
@property (strong,nonatomic) NSArray * matches;
@property (assign,nonatomic) int sectionId;
@property (assign,nonatomic) int championId;

@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImg;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *noMatchesLbl;
@property (strong, nonatomic) IBOutlet UIButton *moreMatchesBtn;
- (IBAction)moreMatchesBtnPressed:(id)sender;

@end
