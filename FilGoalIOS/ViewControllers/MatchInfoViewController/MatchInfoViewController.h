//
//  MatchInfoViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 5/13/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * items;
@property (strong, nonatomic) NSArray * itemsIcons;
- (IBAction)cancelBtnPressed:(id)sender;


@end
