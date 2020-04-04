//
//  TeamProfileInfoCell.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/11/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSKStretchyHeaderView/GSKStretchyHeaderView.h"
@interface TeamProfileInfoCell : GSKStretchyHeaderView
@property (strong, nonatomic)  UIView *tabsView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *teamLogoActivityIndicator;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *largeActivityIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *teamImgActivityIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *coachImgActivityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *teamImgView;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLbl;

@property (weak, nonatomic) IBOutlet UIImageView *tshirtImgView;
@property (weak, nonatomic) IBOutlet UILabel *playgroundNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *coachImgView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *foundationDateLbl;
@property (weak, nonatomic) IBOutlet UIButton *hyperlinkBtn;
- (IBAction)followBtnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *teamLogoView;
@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImgView;
-(void)initWithCell:(TeamProfile*)teamProfile;
@end
