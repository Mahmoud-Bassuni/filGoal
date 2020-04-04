//
//  TeamCell.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamCell.h"

@implementation TeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)initWithTeam:(Team*)item
{
    [self.titleLbl setText:item.teamName];
    [self.teamImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.teamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   [self.activityIndicator stopAnimating];
                                   
                               }];
    
    self.roundView.layer.cornerRadius = self.roundView.frame.size.width/2;
    self.roundView.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
