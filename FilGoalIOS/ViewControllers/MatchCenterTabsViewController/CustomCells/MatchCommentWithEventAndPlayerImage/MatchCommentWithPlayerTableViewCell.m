//
//  MatchCommentWithPlayerTableViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCommentWithPlayerTableViewCell.h"

@implementation MatchCommentWithPlayerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.playerImg.layer.cornerRadius = self.playerImg.frame.size.width/2;
    self.playerImg.clipsToBounds = YES;
    self.minuteLbl.layer.cornerRadius = self.minuteLbl.frame.size.width/2;
    self.minuteLbl.clipsToBounds = YES;
    self.minuteLbl.layer.borderWidth = 1.0f;
    self.minuteLbl.layer.borderColor = [[UIColor orangeColor] CGColor];
    
    self.eventView.layer.cornerRadius = self.eventView.frame.size.width/2;
    self.eventView.clipsToBounds = YES;
    self.eventView.layer.borderWidth = 1.0f;
    self.eventView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.commentTxt.textContainer.maximumNumberOfLines = 2000;
    self.commentTxt.textContainer.lineBreakMode = NSLineBreakByClipping;
    
    // shadow
    self.commentView. layer.shadowColor = [[UIColor blackColor] CGColor];
    self.commentView.layer.shadowOpacity = 0.1f;
    self.commentView.layer.shadowOffset = CGSizeMake(0, 2);
    [self.commentView.layer setCornerRadius:3.0f];
    //[self.layer setMasksToBounds:YES];
    [self.commentView.layer setBorderWidth:0.0f];
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end