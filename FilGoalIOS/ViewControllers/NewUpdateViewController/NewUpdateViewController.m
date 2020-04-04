//
//  NewUpdateViewController.m
//  Reyada
//
//  Created by Nada Gamal on 6/22/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "NewUpdateViewController.h"
#import "Global.h"
#import "AppInfo.h"
#import "App.h"
@interface NewUpdateViewController ()

@end

@implementation NewUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _updateNowBtn.layer.cornerRadius = 5;
    _updateNowBtn.clipsToBounds = YES;
    _appIconImgView.layer.cornerRadius =_appIconImgView.frame.size.height/2;
    _appIconImgView.clipsToBounds = YES;
    _appIconImgView.layer.borderWidth=5.0f;
    _appIconImgView.layer.borderColor=[[UIColor clearColor] CGColor];
    [_versionNumberLbl setText: [NSString stringWithFormat:@"Version %@",[Global getInstance].appInfo.app.version]];
    [_updateDetailsTxtView setText:[Global getInstance].appInfo.app.msg];
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

- (IBAction)updateNowPressed:(id)sender {
    NSString *iTunesLink = [NSString stringWithFormat:@"itms-apps://%@", [Global getInstance].appInfo.app.storeUrl];;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}
@end
