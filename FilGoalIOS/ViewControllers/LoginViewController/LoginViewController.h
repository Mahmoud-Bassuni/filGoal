//
//  LoginViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "ForgotPasswordViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : ParentViewController<UITextFieldDelegate, UITextViewDelegate, BSKeyboardControlsDelegate,FBSDKLoginButtonDelegate>
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIView *loginView;
//@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
- (IBAction)loginBtnPressed:(id)sender;
- (IBAction)forgotPasswordBtnPressed:(id)sender;
- (IBAction)registerBtnPressed:(id)sender;
- (IBAction)facebookLoginPressed:(id)sender;

@end
