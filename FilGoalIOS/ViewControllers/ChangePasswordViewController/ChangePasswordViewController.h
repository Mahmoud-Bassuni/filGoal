//
//  ChangePasswordViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/15/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : ParentViewController<UITextFieldDelegate, UITextViewDelegate, BSKeyboardControlsDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordNewTxt;
@property (strong, nonatomic) IBOutlet UIButton *changePasswordBtn;
- (IBAction)changePasswordBtnPressed:(id)sender;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

@end
