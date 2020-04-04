//
//  VideosCellLoader.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoItem.h"

@interface MenuItemCellLoader : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectedBarLbl;

@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withItem:(NSString *)item withurl:(NSString *)url withSelectionState:(BOOL)isSelected;

@end
