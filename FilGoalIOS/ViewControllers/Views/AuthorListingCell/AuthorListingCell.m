//
//  AuthorListingCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/4/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "AuthorListingCell.h"

@implementation AuthorListingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2;
    self.imgView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
