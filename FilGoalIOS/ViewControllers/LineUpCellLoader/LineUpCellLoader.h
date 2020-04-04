//
//  VideosCellLoader.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineUpCellLoader : NSObject

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withline1:(MatchTeamsSquad *)item1 withline2:(MatchTeamsSquad *)item2;
@end
