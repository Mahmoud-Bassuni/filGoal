//
//  TeamEditableCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/7/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamEditableCell.h"

@implementation TeamEditableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.roundedView.layer.cornerRadius = self.roundedView.frame.size.width/2;
    self.roundedView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editBtnAction:(id)sender {
}

- (IBAction)deleteBtnAction:(id)sender {
}
@end
