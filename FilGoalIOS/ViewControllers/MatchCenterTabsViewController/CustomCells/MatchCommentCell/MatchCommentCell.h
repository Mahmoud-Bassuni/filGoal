//
//  MatchCommentCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *minuteLbl;
@property (weak, nonatomic) IBOutlet UIImageView *eventImg;
@property (weak, nonatomic) IBOutlet UITextView *commentTxt;
@property (weak, nonatomic) IBOutlet UIView *eventView;

@end
