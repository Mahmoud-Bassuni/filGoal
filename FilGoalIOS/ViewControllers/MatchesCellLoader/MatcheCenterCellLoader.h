//
//  VideosCellLoader.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchCenterDetails.h"
@interface MatcheCenterCellLoader : UITableViewCell


+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withMatchItem:(MatchCenterDetails *)item;
@property (weak, nonatomic) IBOutlet UIImageView *fClubImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sClubImageView;
- (IBAction)homeTeamBtnPressed:(id)sender;
- (IBAction)awayTeamBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *homeTeamBtn;
@property (weak, nonatomic) IBOutlet UIButton *awayTeamBtn;
@property (weak, nonatomic) IBOutlet UIView *homeClubView;
@property (weak, nonatomic) IBOutlet UIView *awayClubView;
@property (weak, nonatomic) IBOutlet UILabel *champNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *predictMatchBtn;
@property (weak, nonatomic) IBOutlet UIButton *statisticsBtn;
- (IBAction)statisticalBtnAction:(id)sender;


@end
