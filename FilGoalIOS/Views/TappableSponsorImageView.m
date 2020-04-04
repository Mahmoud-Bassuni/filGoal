//
//  TappableSponsorImageView.m
//  FilGoalIOS
//
//  Created by Sarmady on 4/3/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

#import "TappableSponsorImageView.h"

@interface TappableSponsorImageView ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation TappableSponsorImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    //Set ImageView
    self.userInteractionEnabled = YES;
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnImageView:)];
    [self addGestureRecognizer:self.tapGesture];
    self.backgroundColor = [UIColor clearColor];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //Testing Purpose
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor orangeColor];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 222, 40);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.hidden = NO;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.hidden = NO;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 15 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.hidden = NO;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 20 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.hidden = NO;
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.hidden = NO;
    });*/
}

-(void) didTapOnImageView:(UITapGestureRecognizer*)gesture {
    if (self.tapURL != nil) {
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: self.tapURL] ];
    }
}


@end
