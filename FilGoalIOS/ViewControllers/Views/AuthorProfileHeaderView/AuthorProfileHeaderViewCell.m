//
//  AuthorProfileHeaderViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/5/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "AuthorProfileHeaderViewCell.h"
@implementation AuthorProfileHeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2;
    self.imgView.clipsToBounds = YES;
   // self.imgView.layer.borderColor = [[UIColor whiteColor]CGColor];
   // self.imgView.layer.borderWidth = 0.1f;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}
-(void)initWithAuthorCell:(Author*)item
{
    [self.activityIndicator startAnimating];
    self.nOfArticalsLbl.text = [NSString stringWithFormat:@"%li مقالات",(long)item.numberOfOpinions];
    self.nOfReadsLbl.text = [NSString stringWithFormat:@"%li قراءه",(long)item.numberOfViews];
    self.authorName.text = item.name;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:[UIImage imageNamed:@"Player-Image-Placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.activityIndicator stopAnimating];
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
