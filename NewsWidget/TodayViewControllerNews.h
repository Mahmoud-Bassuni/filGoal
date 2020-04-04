//
//  TodayViewController.h
//  NewsWidget
//
//  Created by Yomna Ahmed on 7/2/15.
//  Copyright (c) 2015 Mohamed Mansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "GAITrackedViewController.h"
@interface TodayViewControllerNews :GAITrackedViewController<UITableViewDataSource,UITableViewDelegate> //

@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UIButton *prevBtn;
@property (weak, nonatomic) IBOutlet UITableView * newsTableView;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, strong) NSArray *fullNewsList;
@property (strong, nonatomic)  UILabel *noNewsView;
- (IBAction)refreshBtnAction:(id)sender;
@end
