//
//  NewsCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "MenuchampCellLoader.h"
#import  "UIImageView+WebCache.h"


@implementation MenuchampCellLoader

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withItem:(NSString *)item withurl:(NSString *)url andWithSelectionState:(BOOL)isSelected
{
    
    UITableViewCell *cell =nil;
 
   NSString *nibname=@"MenuchampCellLoader";
    cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1000];
     UIImageView *imageView = (UIImageView *)[cell viewWithTag:3000];
    
   
    [titleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:titleLabel.font.pointSize]];
    titleLabel.text=[NSString stringWithFormat:@"%@",item];
    if (isSelected==YES) {
    [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:184.0/255.0 blue:8.0/255.0 alpha:1.0]];
    titleLabel.textColor=[UIColor blackColor];
    }
    else{
        
    [cell setBackgroundView:[[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"menu_bg.png"]]];
    titleLabel.textColor=[UIColor colorWithRed:156.0/255.0 green:156.0/255.0  blue:156.0/255.0  alpha:1.0];
    }
    if (![url isEqualToString:@""]) {
   
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Champion_list_holder.png"]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                               //[ind stopAnimating];
                               //[ind setHidden:YES];
                               
                           }];
    }
    return cell;

}
@end
