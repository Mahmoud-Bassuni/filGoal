//
//  AlbumCustomCellTableViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "AlbumCustomCellTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation AlbumCustomCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.shadowView.backgroundColor=[UIColor whiteColor];
    //[self.shadowView.layer setCornerRadius:5.0f];
    [self.shadowView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.shadowView.layer setBorderWidth:0.2f];
    [self.shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
    [self.shadowView.layer setShadowOpacity:1.0];
    //[self.shadowView.layer setShadowRadius:5.0];
    [self.shadowView.layer setShadowOffset:CGSizeMake(5.0f, 5.0f)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initWithAlbumItem:(Album *)item
{
    Picture * firstPictureItem;
    if(item.pictures.count>0)
        firstPictureItem=[item.pictures objectAtIndex:0];
    [self.albumTitleLbl setText:item.albumTitle];
    [self.albumDateLbl setText:item.albumDate];
    [self.albumImg sd_setImageWithURL:[NSURL URLWithString:firstPictureItem.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // [ind stopAnimating];
        //[ind setHidden:YES];
    }];
}

@end
