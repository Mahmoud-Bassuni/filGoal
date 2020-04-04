//
//  ChangePasswordViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/15/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "ChangePasswordViewController.h"
@import Firebase;
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *fields = @[self.passwordTxt,
                        self.passwordNewTxt];
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    self.screenName = @"iOS- Change Password Screen";
    //self.title = @"تغير كلمة المرور";
    self.changePasswordBtn.clipsToBounds = YES;
    self.changePasswordBtn.layer.cornerRadius= 12;
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- Change Password Screen"
                                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePasswordBtnPressed:(id)sender {
    if (self.passwordNewTxt.text.length == 0 || self.passwordTxt.text.length == 0) {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"برجاء أدخال البيانات", nil) handler:nil];
    }
    
    else if(self.passwordTxt.text.length<6 ||self.passwordTxt.text.length>20)
    {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"برجاء إدخال كلمة مرور صحيحة", nil) handler:nil];
    }
    else
    {
        [SSOServiceManager changePasswordWithOldPassword:self.passwordTxt.text andNewPassword:self.passwordNewTxt.text success:^(id result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"تم تغير كلمة المرور", nil) handler:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            });
        } failure:^(NSError *error) {
            //[UserMethods logout];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"برجاء إدخال كلمة مرور صحيحة", nil) handler:nil];

            });
         //   [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
    }
    
}
#pragma mark -
#pragma mark Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

#pragma mark -
#pragma mark Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.keyboardControls setActiveField:textView];
}

#pragma mark -
#pragma mark Keyboard Controls Delegate

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    UIView *view;
    view = field.superview.superview.superview;
    [self.scrollView scrollRectToVisible:view.frame animated:YES];
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return false;
}


@end
