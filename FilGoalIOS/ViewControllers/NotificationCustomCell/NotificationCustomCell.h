//
//  NotificationCustomCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 5/18/15.
//  Copyright (c) 2015 Nada Gamal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch * notificationSwitch;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@end
