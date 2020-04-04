//
//  VideosCellLoader.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoItem.h"

@interface VideosCellLoader : NSObject
+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withVideoItem:(VideoItem *)item;
@end
