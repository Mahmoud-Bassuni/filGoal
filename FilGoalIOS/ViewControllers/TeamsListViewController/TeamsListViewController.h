//
//  TeamsListViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TappableSponsorImageView.h"


@interface TeamsListViewController : GAITrackedViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic) int champId;
@property (weak, nonatomic) IBOutlet TappableSponsorImageView *sponsorImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgHeight;

@end
