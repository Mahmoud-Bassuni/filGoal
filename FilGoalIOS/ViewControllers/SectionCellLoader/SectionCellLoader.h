//
//  NewsCellLoader.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Section.h"

@interface SectionCellLoader : NSObject
+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withChamItem:(Section *)item;
@end
