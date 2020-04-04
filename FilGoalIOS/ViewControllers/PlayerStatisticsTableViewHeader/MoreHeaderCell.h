//
//  MoreHeaderCell.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 7/27/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreHeaderCell : UIView
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
- (IBAction)moreBtnPressed:(id)sender;

@end
