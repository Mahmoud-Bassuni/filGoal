//
//  NewsCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "ChampionCellLoader.h"
#import "NewsItem.h"
#import  "Images.h"
#import  "UIImageView+WebCache.h"

@implementation ChampionCellLoader

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withChamItem:(Champion *)item
{
    static NSString *CellIdentifier = @"ChampionCellLoader";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"ChampionCellLoader";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    
    if (indexPath.row%2==0) {
           cell.contentView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    else{  cell.contentView.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
            
    }
//
    
    UILabel *NewsTitleLabel = (UILabel *)[cell viewWithTag:1000];
    UIImageView *NewsImageView = (UIImageView *)[cell viewWithTag:3000];
    
    [NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];

    
   
    
    //[NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];
    NewsTitleLabel.text=[NSString stringWithFormat:@"%@",item.champName];
  
    
    
    
    UIActivityIndicatorView *ind = (UIActivityIndicatorView *)[cell viewWithTag:4000];
    [ind startAnimating];
    [ind setHidden:NO];
   if(item.champLogo!=nil){
        [NewsImageView sd_setImageWithURL:[NSURL URLWithString:item.champLogo] placeholderImage:[UIImage imageNamed:@"Champion_list_holder.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [ind stopAnimating];
                                 [ind setHidden:YES];
                             }];
    }
  
    
    
    return cell;

}
@end
