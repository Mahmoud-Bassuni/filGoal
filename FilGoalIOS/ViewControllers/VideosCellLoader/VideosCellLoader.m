//
//  NewsCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "VideosCellLoader.h"

#import  "Images.h"
#import  "UIImageView+WebCache.h"

@implementation VideosCellLoader

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withVideoItem:(VideoItem *)item
{
    static NSString *CellIdentifier = @"VideosListCustomCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"VideosListCustomCell";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    UILabel *VideosTitleLabel = (UILabel *)[cell viewWithTag:1000];
    UILabel *VideosDateLabel = (UILabel *)[cell viewWithTag:1001];
    UILabel *VideosWriterLabel = (UILabel *)[cell viewWithTag:1002];
    UIImageView *VideosImageView = (UIImageView *)[cell viewWithTag:3000];
    [VideosTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:VideosTitleLabel.font.pointSize]];
    [VideosDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:VideosDateLabel.font.pointSize]];
    [VideosWriterLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:VideosWriterLabel.font.pointSize]];
    
    
    
    VideosTitleLabel.text=[NSString stringWithFormat:@"\u200F%@",item.videoTitle];
    VideosDateLabel.text=item.videoDate;
    VideosWriterLabel.text=[NSString stringWithFormat:@"%d",item.videoNumofviews];
    
    
    
    UIActivityIndicatorView *ind = (UIActivityIndicatorView *)[cell viewWithTag:4000];
    [ind startAnimating];
    [ind setHidden:NO];
    
    //[VideosImageView setImageWithURL:[NSURL URLWithString:item.videoPreviewImage] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                       //    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           //    [ind stopAnimating];
                           //    [ind setHidden:YES];
                               
                         //  }];
    
    [VideosImageView sd_setImageWithURL:[NSURL URLWithString:item.videoPreviewImage] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [ind stopAnimating];
        [ind setHidden:YES];
    }];
    
    


    
    
    return cell;

}
@end
