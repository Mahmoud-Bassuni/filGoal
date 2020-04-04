//
//  UIAlertView+DefaultAlerts.h
//  ContactCars
//
//  Created by Hesham Abd-Elmegid on 16/2/15.
//  Copyright (c) 2015 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (DefaultAlerts)

+ (UIAlertView *)alertViewWithMessage:(NSString *)message;
+ (void)showAlertViewWithMessage:(NSString *)message handler:(void (^)(void))handler;
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(void))handler;
+ (void)showAlertViewForDeletetWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(void))handler;

@end
