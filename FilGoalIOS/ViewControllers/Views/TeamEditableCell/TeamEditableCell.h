//
//  TeamEditableCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/7/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamEditableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIView *roundedView;
@property (strong, nonatomic) IBOutlet UILabel *teamNameLbl;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)editBtnAction:(id)sender;
- (IBAction)deleteBtnAction:(id)sender;

@end
