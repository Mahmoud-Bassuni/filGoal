//
//  NewsCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "SectionCellLoader.h"
#import "NewsItem.h"
#import  "Images.h"
#import  "UIImageView+WebCache.h"

@implementation SectionCellLoader

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withChamItem:(Section *)item
{
    static NSString *CellIdentifier = @"SectionCellLoader";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"SectionCellLoader";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    
    
    UILabel *NewsTitleLabel = (UILabel *)[cell viewWithTag:1000];
    
    
    [NewsTitleLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:NewsTitleLabel.font.pointSize]];

    NewsTitleLabel.text=[NSString stringWithFormat:@"%@",item.sectionName];

    return cell;

}
@end
