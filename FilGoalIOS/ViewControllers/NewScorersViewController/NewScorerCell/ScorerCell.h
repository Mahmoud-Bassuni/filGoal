//
//  ScorerCell.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/7/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scorer.h"
@interface ScorerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scorerNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *scorerImgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *nOfGoalsLbl;
@property (weak, nonatomic) IBOutlet UILabel *nOfPlayedLbl;
@property (weak, nonatomic) IBOutlet UIView *percentageView;
-(void)initWithCell:(Scorer*)scorer;
@end
