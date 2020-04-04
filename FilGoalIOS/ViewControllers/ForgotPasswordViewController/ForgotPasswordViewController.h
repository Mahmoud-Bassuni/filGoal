//
//  ForgotPasswordViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/14/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController :ParentViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;
- (IBAction)submitBtnPressed:(id)sender;

@end
