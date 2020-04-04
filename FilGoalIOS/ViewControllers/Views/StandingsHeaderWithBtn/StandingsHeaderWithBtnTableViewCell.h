//
//  StandingsHeaderWithBtnTableViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandingsHeaderWithBtnTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cellTitleLbl;
@property (strong, nonatomic) IBOutlet UIButton *cellBtn;
- (IBAction)buttonAction:(id)sender;

@end
