//
//  ScorerCell.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/7/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ScorerCell.h"
#import "UIImageView+WebCache.h"
#import "PNChart.h"
@implementation ScorerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initWithCell:(Scorer*)scorer
{
    self.scorerNameLbl.text = scorer.name;
    self.nOfGoalsLbl.text = [NSString stringWithFormat:@"%li",(long)scorer.goals];
    self.nOfPlayedLbl.text = [NSString stringWithFormat:@"%li",(long)scorer.played];
    self.scorerImgView.layer.cornerRadius = self.scorerImgView.frame.size.width/2;
    self.scorerImgView.clipsToBounds = YES;
    [self.scorerImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)scorer.idField]] placeholderImage:[UIImage imageNamed:@"Player-Image-Placeholder"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                     [self.activityIndicator stopAnimating];
                                     
                                 }];
    
    
    PNCircleChart * chart = [[PNCircleChart alloc] initWithFrame:CGRectMake(self.percentageView.frame.origin.x,self.percentageView.frame.origin.y-10, self.percentageView.frame.size.width,self.percentageView.frame.size.height)
                                                                        total:@100
                                                                      current:@(scorer.goalscoringPercentage*100)
                                                                    clockwise:YES];
    chart.backgroundColor = [UIColor clearColor];
    [chart setStrokeColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [chart setLineWidth:[NSNumber numberWithFloat:3.0]];
    [chart strokeChart];
    [self.percentageView addSubview:chart];
}
@end
