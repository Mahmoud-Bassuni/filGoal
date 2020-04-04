//
//  ImageCollectionViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 4/19/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    self.contentView.layer.cornerRadius = self.contentView.frame.size.width/2;
    self.contentView.clipsToBounds = YES;
   self.contentView.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]CGColor];
    self.contentView.layer.borderWidth = 8;
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2;
    self.imgView.clipsToBounds = YES;

}

@end
