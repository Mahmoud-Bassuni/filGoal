//
//  UserTeamsListViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/7/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTeamsListViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
