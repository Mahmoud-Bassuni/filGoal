//
//  MultiSelectionViewController.m
//  STPopupExample
//
//  Created by Kevin Lin on 11/10/15.
//  Copyright © 2015 Sth4Me. All rights reserved.
//

#import "MultiSelectionViewController.h"
#import <STPopup/STPopup.h>

@implementation MultiSelectionViewController
{
    NSMutableSet *_mutableSelections;
}
-(void)viewDidLoad
{
    self.contentSizeInPopup = CGSizeMake(Screenwidth, self.view.frame.size.height);
    self.title = @"الإشعارات";
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.items = @[kMatchSquadStr,kMatchStatusStr,kMatchEventsStr,kMatchScoreStr];
    // Navigationbar
    [self.popupController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.popupController.navigationBar.tintColor = [UIColor whiteColor];
    self.popupController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.popupController.navigationBar setBarTintColor:[UIColor mainAppDarkGrayColor]];
    [self.popupController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    self.doneBtn.layer.cornerRadius = 20;
    self.doneBtn.clipsToBounds = YES;
  //  [self.tableView setTransform:CGAffineTransformMakeScale(-1, 1)];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)done:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(multiSelectionViewController:didFinishWithSelections:)]) {
        [self.delegate multiSelectionViewController:self didFinishWithSelections:_mutableSelections.allObjects];
    }
    [self.popupController dismiss];
}
- (IBAction)Cancel:(id)sender
{
    [self.popupController dismiss];
}

- (void)setDefaultSelections:(NSArray *)defaultSelections
{
    _defaultSelections = defaultSelections;
    _mutableSelections = [NSMutableSet setWithArray:defaultSelections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"Multi-Selection Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSString *item = self.items[indexPath.row];
    [cell.textLabel setTextAlignment:NSTextAlignmentRight];
    cell.textLabel.font =[UIFont defaultMeduimFontOfSize:14];
    cell.textLabel.text = item;
    cell.imageView.image = [_mutableSelections containsObject:item] ? [UIImage imageNamed:@"mark"] : [UIImage imageNamed:@""];
//    cell.accessoryType = [_mutableSelections containsObject:item] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_mutableSelections) {
        _mutableSelections = [NSMutableSet new];
    }
    
    NSString *item = self.items[indexPath.row];
    if (![_mutableSelections containsObject:item]) {
        [_mutableSelections addObject:item];
    }
    else {
        [_mutableSelections removeObject:item];
    }
    [tableView reloadData];
}

@end
