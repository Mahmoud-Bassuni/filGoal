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
@interface TodayViewController : GAITrackedViewController

@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UIButton *prevBtn;
@property (weak, nonatomic) IBOutlet UITableView *NesListTable;
@property (nonatomic, strong) NSArray *NewsList;
@property (nonatomic, strong) NSArray *FullNewsList;
@property (strong, nonatomic)  UILabel *noNewsView;
- (IBAction)refreshBtnAction:(id)sender;
@end
