//
//  HomeHeaderView.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/12/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"

@interface HomeHeaderView : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *moreBtn;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorWidthConstraint;

@end
