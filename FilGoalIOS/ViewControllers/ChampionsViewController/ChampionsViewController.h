//
//  HomeViewController.h
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "ParentViewController.h"
@interface ChampionsViewController : ParentViewController<UITableViewDelegate,UIWebViewDelegate>
@property(nonatomic,strong) IBOutlet UITableView * tableView;
@property(nonatomic,retain) NSMutableArray * ChamList;
@property(nonatomic,retain) IBOutlet UIImageView *sponser;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgConstraintHeight;

@end
