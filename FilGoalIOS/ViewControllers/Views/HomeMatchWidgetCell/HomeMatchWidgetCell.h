//
//  HomeMatchWidgetCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMatchWidgetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *homeTeamBtn;
@property (strong, nonatomic) IBOutlet UIButton *championshipNameBtn;
@property (strong, nonatomic) IBOutlet UIButton *awayTeamBtn;
@property (strong, nonatomic) IBOutlet UILabel *homeTeamNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *awayTeamNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;
@property (strong, nonatomic) IBOutlet UIImageView *homeTeamImgView;
@property (strong, nonatomic) IBOutlet UIImageView *awayTeamImgView;
@property (strong, nonatomic) IBOutlet UILabel *homePlentyScoreLbl;
@property (strong, nonatomic) IBOutlet UILabel *awayPlentyScoreLbl;
@property (strong, nonatomic) IBOutlet UILabel *awayScoreLbl;
@property (strong, nonatomic) IBOutlet UILabel *matchstatusLbl;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *homeActivityIndicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *awayActivityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *homeScoreLbl;
@property (strong, nonatomic) IBOutlet UILabel *matchStatusIndicator;
@property (strong, nonatomic) IBOutlet UIView *homeLogoView;
@property (strong, nonatomic) IBOutlet UIView *awayLogoView;
@property (weak, nonatomic) IBOutlet UIButton *channelsLbl;
@property (weak, nonatomic) IBOutlet UIButton *predictBtn;
@property (weak, nonatomic) IBOutlet UIButton *statisticsBtn;

- (IBAction)homeTeamBtnPressed:(id)sender;
- (IBAction)awayTeamBtnPressed:(id)sender;
- (IBAction)championshipBtnPressed:(id)sender;
-(void)initCellWithMatchItem:(MatchCenterDetails*)item;


@end
