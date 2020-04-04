//
//  VideosCellLoader.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoItem.h"
#import "MatchEvent.h"
#import "PlayerProfileViewController.h"
@interface MatchActionCellLoader : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *secPlayerBtn;
@property (strong, nonatomic) IBOutlet UIButton *firstPlayerBtn;
+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withMatchAction:(MatchEvent *)item clubone:(int) clubone clubtwo:(int)clubtwo;
@end
