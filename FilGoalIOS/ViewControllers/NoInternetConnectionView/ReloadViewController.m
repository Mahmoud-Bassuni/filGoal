//
//  ReloadViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 6/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ReloadViewController.h"

@interface ReloadViewController ()

@end

@implementation ReloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _retryBtn.layer.cornerRadius = 10;
    _retryBtn.clipsToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
