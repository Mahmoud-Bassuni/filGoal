//
//  RamdanVideoCustomCell.m
//  Reyada
//
//  Created by Nada Gamal on 5/4/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "RamdanVideoCustomCell.h"

@implementation RamdanVideoCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowOffset = CGSizeMake(0, 0.2f);
    [self.layer setCornerRadius:7.0f];
    //[self.layer setMasksToBounds:YES];
    [self.layer setBorderWidth:0.0f];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
