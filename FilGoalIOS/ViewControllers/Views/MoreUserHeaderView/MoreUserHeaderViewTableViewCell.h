//
//  MoreUserHeaderViewTableViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/15/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreUserHeaderViewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIView *userRoundedView;
@property (strong, nonatomic) IBOutlet UIImageView *userImgView;
@property (strong, nonatomic) IBOutlet UILabel *welcomeTitleLbl;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
- (IBAction)loginBtnPressed:(id)sender;
- (IBAction)registerBtnPressed:(id)sender;
- (IBAction)editBtnPressed:(id)sender;
@end
