//
//  SettingsViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 6/1/15.
//  Copyright (c) 2015 MohamedMansour . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentViewController.h"
#import "GAITrackedViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "CountriesViewController.h"
@interface SettingsViewController :ParentViewController<UITableViewDataSource,UITableViewDelegate,CountryPickerDelegate>
@property (weak, nonatomic) IBOutlet UISwitch * notificationSwitch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL  isShowed;

//@property (weak, nonatomic) IBOutlet CountryPicker *pickerView;
//@property (strong, nonatomic) IBOutlet UIView *pickerSubView;
@end
