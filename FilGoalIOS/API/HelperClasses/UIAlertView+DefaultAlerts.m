//
//  UIAlertView+DefaultAlerts.m
//  ContactCars
//
//  Created by Hesham Abd-Elmegid on 16/2/15.
//  Copyright (c) 2015 Sarmady. All rights reserved.
//

#import "UIAlertView+DefaultAlerts.h"
#import <BlocksKit/BlocksKit+UIKit.h>

@implementation UIAlertView (DefaultAlerts)

+ (UIAlertView *)alertViewWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"تم", nil)
                                          otherButtonTitles:nil, nil];
    
    return alert;
}

+ (void)showAlertViewWithMessage:(NSString *)message handler:(void (^)(void))handler {
    [self showAlertViewWithTitle:@"" message:message handler:handler];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(void))handler {
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:title message:message];
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"تم", nil) handler:handler];
    [alertView show];
}

+ (void)showAlertViewForDeletetWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(void))handler {
    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:title message:message];
    [alertView bk_addButtonWithTitle:NSLocalizedString(@"نعم", nil) handler:handler];
    [alertView bk_setCancelButtonWithTitle:NSLocalizedString(@"إلغاء", nil)  handler:nil];
  
    [alertView show];
}
@end
