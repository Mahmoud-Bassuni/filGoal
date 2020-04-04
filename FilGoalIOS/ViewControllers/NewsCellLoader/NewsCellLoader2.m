//
//  NewsCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "NewsCellLoader2.h"
#import "NewsItem.h"
#import  "Images.h"
#import  "UIImageView+WebCache.h"

@implementation NewsCellLoader2

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withNewItem:(NewsItem *)item
{
    static NSString *CellIdentifier = @"NewsListCustomCell2";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"NewsListCustomCell2";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    UILabel *NewsTitleLabel = (UILabel *)[cell viewWithTag:1000];
    UILabel *NewsDateLabel = (UILabel *)[cell viewWithTag:1001];
    UILabel *NewsWriterLabel = (UILabel *)[cell viewWithTag:1002];
    UIImageView *NewsImageView = (UIImageView *)[cell viewWithTag:3000];
    UIImageView * albumImg = (UIImageView *)[cell viewWithTag:100];
    albumImg.hidden = YES;
    [NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];
    [NewsDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsDateLabel.font.pointSize]];
    [NewsWriterLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsWriterLabel.font.pointSize]];
    
   
    
    //[NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];
    NewsTitleLabel.text=[NSString stringWithFormat:@"\u200F%@",item.newsTitle];
    NewsDateLabel.text=item.newsDate;
    NewsWriterLabel.text=item.newsWriter;
    
    
    
    UIActivityIndicatorView *ind = (UIActivityIndicatorView *)[cell viewWithTag:4000];
    [ind startAnimating];
    [ind setHidden:NO];
    if(item.images!=nil&&item.images.count>0){
        
        Images *imageItem =[item.images objectAtIndex:0];
        [NewsImageView sd_setImageWithURL:[NSURL URLWithString:imageItem.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [ind stopAnimating];
                                 [ind setHidden:YES];
                             }];
    }
    else if(item.smallImage!=nil){
        [NewsImageView sd_setImageWithURL:[NSURL URLWithString:item.smallImage] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] 
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [ind stopAnimating];
                                 [ind setHidden:YES];
                             }];
    }

    
    
    return cell;

}
+(UITableViewCell*)loadAlbumCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withNewItem:(Album *)item
{
    static NSString *CellIdentifier = @"NewsListCustomCell2";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"NewsListCustomCell2";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    

    UIImageView * albumImg = (UIImageView *)[cell viewWithTag:100];
    albumImg.hidden = NO;
    UILabel *NewsTitleLabel = (UILabel *)[cell viewWithTag:1000];
    UILabel *NewsDateLabel = (UILabel *)[cell viewWithTag:1001];
    UILabel *NewsWriterLabel = (UILabel *)[cell viewWithTag:1002];
    UIImageView *NewsImageView = (UIImageView *)[cell viewWithTag:3000];
    [NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];
    [NewsDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsDateLabel.font.pointSize]];
    [NewsWriterLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsWriterLabel.font.pointSize]];
    
    
    
    //[NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];
    NewsTitleLabel.text=[NSString stringWithFormat:@"\u200F%@",item.albumTitle];
    NewsDateLabel.text=item.albumDate;
    
    UIActivityIndicatorView *ind = (UIActivityIndicatorView *)[cell viewWithTag:4000];
    [ind startAnimating];
    [ind setHidden:NO];
    Picture * firstPictureItem;
    if(item.pictures.count>0)
        firstPictureItem=[item.pictures objectAtIndex:0];
    [NewsImageView  sd_setImageWithURL:[NSURL URLWithString:firstPictureItem.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [ind stopAnimating];
        [ind setHidden:YES];
        
    }];
    
    
    
    return cell;
}

@end
