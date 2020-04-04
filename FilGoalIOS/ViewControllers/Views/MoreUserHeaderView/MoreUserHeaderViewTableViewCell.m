//
//  MoreUserHeaderViewTableViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/15/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "MoreUserHeaderViewTableViewCell.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "ChangePasswordViewController.h"
@implementation MoreUserHeaderViewTableViewCell
{
    User * user;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userRoundedView.layer.cornerRadius = self.userRoundedView.frame.size.width/2;
    self.userRoundedView.clipsToBounds = YES;
    self.userRoundedView.layer.borderWidth = 1.0;
    self.userRoundedView.layer.borderColor = [[UIColor greyColor]CGColor];
    if ([UserMethods retrieveUserObject] != nil) {
           user = [UserMethods retrieveUserObject];
            if(user!= nil)
            {
                [self.loginBtn setTitle:@"تسجيل خروج" forState:UIControlStateNormal];
                [self.welcomeTitleLbl setText:user.username];
                if(user.profileImgUrl != nil)
                {
                    self.userImgView.layer.cornerRadius = self.userImgView.frame.size.width/2;
                    self.userImgView.clipsToBounds = YES;
                    [self.userImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=normal",user.userId]]];
                }
                self.registerBtn.hidden = YES;
                self.registerBtn.enabled = NO;
                if(user.isFromFacebook)
                {
                    self.editBtn.hidden = YES;
                    self.editBtn.enabled = NO;
                }
                else
                {
                self.editBtn.hidden = NO;
                self.editBtn.enabled = YES;
                }
            }
        }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)loginBtnPressed:(id)sender {
    if(user != nil)
    {
        [UserMethods logout];
        [self.loginBtn setTitle:@"تسجيل دخول       | " forState:UIControlStateNormal];
        [self.welcomeTitleLbl setText:@"مرحباً بك "];
        self.registerBtn.hidden = NO;
        self.registerBtn.enabled = YES;
        self.userImgView.image = [UIImage imageNamed:@"user"];
        self.editBtn.hidden = YES;
        self.editBtn.enabled = NO;
        user = nil;
    }
    else
    {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    LoginViewController * viewController = [[LoginViewController alloc]init];
    [navigationContoller pushViewController:viewController animated:YES];
    }
}

- (IBAction)registerBtnPressed:(id)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    RegisterViewController * viewController = [[RegisterViewController alloc]init];
    [navigationContoller pushViewController:viewController animated:YES];
}

- (IBAction)editBtnPressed:(id)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    ChangePasswordViewController * viewController = [[ChangePasswordViewController alloc]init];
    [navigationContoller pushViewController:viewController animated:YES];

}


@end
