//
//  LoginViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@import Firebase;
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.loginBtn.layer.cornerRadius = 10.0;
    self.loginBtn.clipsToBounds = YES;
    NSArray *fields = @[self.emailTxt, self.passwordTxt];
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    self.screenName = @"iOS- Login Screen";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- Login Screen"
                                     }];
    [super hideSponsorBanner:self.view];
    self.scrollView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)loginBtnPressed:(id)sender {
    if (self.emailTxt.text.length == 0 || self.passwordTxt.text.length == 0) {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"برجاء إدخال الايميل او كلمة السر.", nil) handler:nil];
    }
    else if(self.passwordTxt.text.length<6 ||self.passwordTxt.text.length>20)
    {
        [UIAlertView showAlertViewWithMessage:NSLocalizedString(@"برجاء إدخال كلمة مرور صحيحة", nil) handler:nil];
    }
    else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        User * user = [[User alloc]init];
        user.username = self.emailTxt.text;
        user.password = self.passwordTxt.text;
        [SSOServiceManager LoginWithUser:user  success:^(AFOAuthCredential *credential) {
            User * user = [[User alloc]init];
            user.userId = credential.userId;
            user.username = credential.username;
            user.password = self.passwordTxt.text;
            user.isFromFacebook = NO;
           // [UserMethods storeUserWithUser:user];
            [UserMethods getUserPreferencesWithUser:user handler:^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if([GetAppDelegate().getSelectedNavigationController.topViewController isKindOfClass:[TeamProfileViewController class]])
                {
                TeamProfileViewController * viewController = (TeamProfileViewController*)GetAppDelegate().getSelectedNavigationController.topViewController;
                viewController.isEditMode = YES;
                }
                if([self presentingViewController])
                {
                    [self setTransparentUINavigationBar];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else
                    [self.navigationController popToRootViewControllerAnimated:YES];
                
                
            }];

            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [UIAlertView showAlertViewWithTitle:NSLocalizedString(@"خطأ", nil)
                                        message:NSLocalizedString(@"إسم المستخدم أو كلمة المرور غير صحيحة. رجاء المحاولة مرة أخرى.", nil)
                                        handler:nil];
        }];
    }
}

- (IBAction)forgotPasswordBtnPressed:(id)sender {
    ForgotPasswordViewController * viewController = [[ForgotPasswordViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:NO];
}

- (IBAction)registerBtnPressed:(id)sender {
    RegisterViewController * viewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:NO];
}

- (IBAction)facebookLoginPressed:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             [UIAlertView showAlertViewWithTitle:NSLocalizedString(@"خطأ", nil)
                                         message:NSLocalizedString(@"إسم المستخدم أو كلمة المرور غير صحيحة. رجاء المحاولة مرة أخرى.", nil)
                                         handler:nil];
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             [self getFBUserInfo];
         }
     }];
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
-(void)getFBUserInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([FBSDKAccessToken currentAccessToken]) {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,name,email,gender,picture" forKey:@"fields"];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 IBGLog(@"%@", [NSString stringWithFormat:@"Facebook User: %@", result]);
                 User * user = [self getSSOUserObjectUsingFbResultObject:result];
                // [UserMethods storeUserWithUser:user];
                 [SSOServiceManager fbLoginWithUser:user success:^(id obj) {
                     [UserMethods getUserPreferencesWithUser:user handler:^{
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                 if([GetAppDelegate().getSelectedNavigationController.topViewController isKindOfClass:[TeamProfileViewController class]])
                         {
                         TeamProfileViewController * viewController = (TeamProfileViewController*)GetAppDelegate().getSelectedNavigationController.topViewController;
                         viewController.isEditMode = YES;
                         }
                         if([self presentingViewController])
                         {
                             [self setTransparentUINavigationBar];
                           [self dismissViewControllerAnimated:YES completion:nil];
                         }
                         else
                         [self.navigationController popToRootViewControllerAnimated:YES];
                         
                     }];

                     
                 } failure:^(NSError *error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [UIAlertView showAlertViewWithTitle:NSLocalizedString(@"خطأ", nil)
                                                 message:NSLocalizedString(@"حدث خطأ", nil)
                                                 handler:nil];
                 }];
             }
         }];
    }
}
-(User*)getSSOUserObjectUsingFbResultObject:(NSDictionary*)result
{
    User * user = [[User alloc]init];
    user.isFromFacebook = YES;
    user.userId = [result objectForKey:@"id"];
    user.username = [result objectForKey:@"name"];
    FBSDKAccessToken * token = [FBSDKAccessToken currentAccessToken];
    user.password = token.tokenString;
    if([[result objectForKey:@"gender"]isEqualToString:@"female"])
    {
        user.gender = @"1";
    }
    else
    {
        user.gender = @"0";
    }
    if([result objectForKey:@"picture"]!= nil && [[result objectForKey:@"picture"]objectForKey:@"data"]!= nil &&[[[result objectForKey:@"picture"]objectForKey:@"data"] objectForKey:@"url"]!= nil)
    {
        user.profileImgUrl = [[[result objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"];
    }
    return user;
}
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
//    [self getFBUserInfo];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}
- (BOOL) loginButtonWillLogin:(FBSDKLoginButton *)loginButton
{
    return YES;
}


@end
