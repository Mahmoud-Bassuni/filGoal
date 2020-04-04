//
//  TeamCell.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teamImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *roundView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
-(void)initWithTeam:(Team*)item;
@end
