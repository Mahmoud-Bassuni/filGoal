//
//  PlayerHeaderViewCell.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/6/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "PlayerHeaderViewCell.h"

@implementation PlayerHeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 6.0;
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
