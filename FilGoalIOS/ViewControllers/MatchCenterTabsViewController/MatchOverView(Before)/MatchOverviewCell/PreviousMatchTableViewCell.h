//
//  PreviousMatchTableViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/24/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviousMatchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamImgView;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamImgView;
@property (weak, nonatomic) IBOutlet UILabel *homeScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *champNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *homeTeamBtn;
@property (weak, nonatomic) IBOutlet UIButton *awayTeamBtn;
-(void) initWithMatchItem :(MatchCenterDetails*) item;

@end
