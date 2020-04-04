//
//  NewsCellLoader.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"
#import "Album.h"
@interface NewsCellLoader2 : NSObject
+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withNewItem:(NewsItem *)item;
+(UITableViewCell*)loadAlbumCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withNewItem:(Album *)item;

@end