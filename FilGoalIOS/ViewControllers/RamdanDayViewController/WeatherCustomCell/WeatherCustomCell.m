//
//  WeatherCustomCell.m
//  Reyada
//
//  Created by Nada Gamal on 5/11/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "WeatherCustomCell.h"

@implementation WeatherCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    for(int i=0;i<_celuisDegreeLbl.count;i++)
    {
        [ (UILabel*)[_celuisDegreeLbl objectAtIndex:i]setText:[NSString stringWithFormat:@"\u2103"]];
    }
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.1f;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    [self.layer setCornerRadius:3.0f];
    //[self.layer setMasksToBounds:YES];
    [self.layer setBorderWidth:0.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
