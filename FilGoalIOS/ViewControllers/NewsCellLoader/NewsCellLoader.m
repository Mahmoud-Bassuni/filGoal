//
//  NewsCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "NewsCellLoader.h"
#import "NewsItem.h"
#import  "Images.h"
#import  "UIImageView+WebCache.h"

@implementation NewsCellLoader

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withNewItem:(NewsItem *)item
{
    static NSString *CellIdentifier = @"NewsListCustomCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"NewsListCustomCell";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    else{  cell.contentView.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
    }
    
    
    UILabel *NewsTitleLabel = (UILabel *)[cell viewWithTag:1000];
    UILabel *NewsDateLabel = (UILabel *)[cell viewWithTag:1001];
    UILabel *NewsWriterLabel = (UILabel *)[cell viewWithTag:1002];
    UIImageView *NewsImageView = (UIImageView *)[cell viewWithTag:3000];
    [NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];
    [NewsDateLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsDateLabel.font.pointSize]];
    [NewsWriterLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsWriterLabel.font.pointSize]];
    
   
    
    //[NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];
    NewsTitleLabel.text=[NSString stringWithFormat:@"\u200F%@",item.newsTitle];
    NewsDateLabel.text=item.newsDate;
    NewsWriterLabel.text=item.newsWriter;
    if ([item.newsWriter isEqualToString:@""]) {
         UIImageView *writeByImageView = (UIImageView *)[cell viewWithTag:3001];
        writeByImageView.hidden=YES;
    }
    
    
    
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


@end
