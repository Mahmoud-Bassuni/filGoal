//
//  SegmentButtonsHeader.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/14/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "SegmentButtonsHeader.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@implementation SegmentButtonsHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupTabsView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setupTabsView
{
//{
//    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"أمس", @"اليوم", @"غدا"]];
//    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    segmentedControl.selectedSegmentIndex = 1;
//    segmentedControl.frame = CGRectMake(0, 0, Screenwidth-60, self.frame.size.height);
//    segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleBox;
//    segmentedControl.backgroundColor = [UIColor clearColor];
//    segmentedControl.selectionIndicatorBoxColor = [UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
//    segmentedControl.selectionIndicatorHeight = 0.0;
//
//    segmentedControl.verticalDividerEnabled = NO;
//    segmentedControl.verticalDividerColor = [UIColor clearColor];
//    [segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
//        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//        return attString;
//    }];
//    // [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
//    [self.contentView addSubview:segmentedControl];
}
@end
