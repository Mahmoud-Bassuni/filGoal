//
//  RegisterViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/14/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : ParentViewController<UITextFieldDelegate, UITextViewDelegate, BSKeyboardControlsDelegate>
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UITextField * confirmPasswordTxt;
@property (strong, nonatomic) IBOutlet UISegmentedControl *genderSegmentControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

- (IBAction)genderSegmentValueChanged:(id)sender;
- (IBAction)registerUserBtnPressed:(id)sender;

@end
