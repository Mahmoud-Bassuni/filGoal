//
//  ForgotPasswordViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/14/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ForgotPasswordViewController.h"
@import Firebase;
@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.screenName = @"iOS- Forgot Password Screen";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- Forgot Password Screen"
                                     }];

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

- (IBAction)submitBtnPressed:(id)sender {
    if (self.emailTxt.text.length == 0) {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"رجاء إدخال بريد إلكتروني صحيح.", nil) handler:nil];
    }
    else if (![self.emailTxt.text isValidEmail]) {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"رجاء إدخال بريد إلكتروني صحيح.", nil) handler:nil];
    }
    else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [SSOServiceManager forgotPassword:self.emailTxt.text success:^(id result)
        {
            [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"تم إرسال رسالة إسترجاع كلمة السر إلى بريدك الالكتروني.", nil)  handler:nil];
                [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
           // [UIAlertView showAlertViewWithMessage:error.localizedDescription handler:nil];
            [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"رجاء إدخال بريد إلكتروني صحيح.", nil) handler:nil];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return false;
}
@end
