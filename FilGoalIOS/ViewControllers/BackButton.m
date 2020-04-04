//
//  BackButton.m
//  FilBalad
//
//  Created by Hesham Abd-Elmegid on 8/4/12.
//  Copyright (c) 2012 Sarmady, a Vodafone company. All rights reserved.
//

#import "BackButton.h"


@implementation BackButton

+ (id)buttonWithText:(NSString *)text {
    UIButton *button;
    button = [BackButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"back_btn_selected.png"] forState:UIControlStateHighlighted];
//    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor colorWithRed:237.0f/255.0f green:255.0/255.f blue:209.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];

    return button;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	UILabel *titleLabel = [self titleLabel];
	CGRect fr = [titleLabel frame];
	fr.origin.x = 13;
	fr.origin.y = 7;
	//[[self titleLabel] setFrame:mirrorRect(fr, 54)];
}

@end
