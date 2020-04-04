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

@interface SectionsViewController : ParentViewController<UITableViewDelegate>

@property(nonatomic,strong) IBOutlet UITableView *tv;
@property(nonatomic,retain) NSMutableArray * sections;
@property(nonatomic,retain) IBOutlet UIImageView *sponser;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeightConstraint;

@end
