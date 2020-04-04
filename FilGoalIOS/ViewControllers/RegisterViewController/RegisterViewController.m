//
//  RegisterViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/14/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "RegisterViewController.h"
@import Firebase;
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *fields = @[self.emailTxt, self.passwordTxt,
                        self.confirmPasswordTxt, self.genderSegmentControl];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    self.screenName = @"iOS- Register Screen";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- Register Screen"
                                     }];
    [self hideSponsorBanner:self.view];
    self.scrollView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)genderSegmentValueChanged:(id)sender {
    [self.keyboardControls setActiveField:_genderSegmentControl];
}

- (IBAction)registerUserBtnPressed:(id)sender {
    if (self.emailTxt.text.length == 0 || self.passwordTxt.text.length == 0) {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"برجاء إدخال الايميل او كلمة السر.", nil) handler:nil];
    }
    else if(self.passwordTxt.text.length<6 ||self.passwordTxt.text.length>20||![self.passwordTxt.text isEqualToString:self.confirmPasswordTxt.text])
    {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"برجاء إدخال كلمة مرور صحيحة", nil) handler:nil];
    }
    else if (![self.emailTxt.text isValidEmail]) {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"رجاء إدخال بريد إلكتروني صحيح.", nil) handler:nil];
    }
    else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        User * user = [[User alloc]init];
        user.username = self.emailTxt.text;
        user.password = self.passwordTxt.text;
        user.gender = YES;
        user.isFromFacebook = NO;

        [SSOServiceManager registerUserWith:user success:^(id result) {
            user.userId =  [result objectForKey:@"id"];
            [UserMethods storeUserWithUser:user];
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
          [UIAlertView showAlertViewWithMessage:@"هذا الايميل موجود مسبقا" handler:nil];
            [MBProgressHUD hideHUDForView:self.view animated:YES];

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
