//
//  BookmarkPushNotificationsViewController.h
//  Reyada
//
//  Created by Nada Gamal on 12/24/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentViewController.h"

@interface BookmarkPushNotificationsViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
