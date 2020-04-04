//
//  StoryCell.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/10/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "StoryCell.h"
#import "UIImageView+WebCache.h"
@implementation StoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shadwoView.backgroundColor=[UIColor whiteColor];
    //[self.shadwoView.layer setCornerRadius:5.0f];
   // [self.shadwoView.layer setBorderColor:[UIColor whiteColor].CGColor];
   // [self.shadwoView.layer setBorderWidth:0.2f];
    //[self.shadwoView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
    //[self.shadwoView.layer setShadowOpacity:1.0];
   // [self.shadwoView.layer setShadowRadius:5.0];
   // [self.shadwoView.layer setShadowOffset:CGSizeMake(5.0f, 5.0f)];
   // [self.imgView.layer setCornerRadius:5.0f];

    self.selectionStyle=UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)initWithNewsItem:(NewsItem*)item
{
    self.titleLbl.text = item.newsTitle;
    if(item.images!=nil&&item.images.count>0){
        
        Images *imageItem =[item.images objectAtIndex:0];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageItem.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   [self.activityIndicator stopAnimating];
                               }];
    }
}

-(void)initWithVideoItem:(VideoItem*)item
{
    self.titleLbl.text = item.videoTitle;
    self.iconImgView.hidden = NO;
   // self.iconImgHeightConstraint.constant = 41;

    if(item.videoPreviewImage!=nil){
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:item.videoPreviewImage] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.activityIndicator stopAnimating];
        }];
    }
}
-(void)initWithAlbumItem:(Album *)item
{
    Picture * picItem;
    self.iconImgView.hidden = NO;
    [self.iconImgView setImage:[UIImage imageNamed:@"photo"]];
    if(item.pictures.count>0)
        picItem=[item.pictures objectAtIndex:0];
    [self.titleLbl setText:item.albumTitle];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:picItem.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.activityIndicator stopAnimating];

    }];
   // self.iconImgHeightConstraint.constant = 30;
  //  [self updateConstraints];

}
@end
