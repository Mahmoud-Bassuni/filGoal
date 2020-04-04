//
//  PlayerCellTableViewCell.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/6/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CareerData.h"
#import "PlayerProfileViewController.h"
@interface PlayerCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *playerNumLbl;
@property (weak, nonatomic) IBOutlet UIImageView *playerImgView;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *playerPositionLbl;
@property (strong, nonatomic) IBOutlet UIButton *playerProfileBtn;
@property (weak, nonatomic) IBOutlet UILabel *playerNationalityLbl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)playerProfileBtnPressed:(id)sender;
-(void) initWithPlayer:(Player*)item;
@end
