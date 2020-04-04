//
//  UIViewController+ErrorHandlers.m
//  ContactCars
//
//  Created by Hesham Abd-Elmegid on 25/12/14.
//  Copyright (c) 2014 Sarmady. All rights reserved.
//

#import "UIViewController+ErrorHandlers.h"
#import <BlocksKit/BlocksKit+UIKit.h>

@implementation UIViewController (ErrorHandlers)

- (void)showNetworkingErrorWithMessage:(NSString *)message {
    if ([self isViewLoaded] && self.view.window) {
        if (!message) {
            message = NSLocalizedString(@"لم نتمكن من الاتصال بالانترنت لتحميل البيانات. رجاء المحاولة مرة أخرى.", nil);
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] bk_initWithTitle:@"خطأ" message:message];
        [alertView bk_addButtonWithTitle:@"تم" handler:nil];
        [alertView show];
    }
}

- (void)showDefaultNetworkingErrorMessageForError:(NSError *)error
                                   refreshHandler:(void (^)(void))refreshHandler {
    if ([self isViewLoaded] && self.view.window) {
        NSString *message;

        if ((error.code == NSURLErrorUserCancelledAuthentication)  &&
            (error.code == NSURLErrorServerCertificateNotYetValid)) {
            message = NSLocalizedString(@"لم نتمكن من إنشاء إتصال آمن بالانترنت. رجاء قم بمراجعة إعدادات التاريخ و الوقت.\n\nهل تريد المحاولة مرة أخرى؟", nil);
        }else if (error.code == NSURLErrorCannotConnectToHost)
        {
            message = NSLocalizedString(@"عفوا حدث خطاء ؛ الرجاء المحاولة لاحقا", nil);

        }
        else {
            message = NSLocalizedString(@"لم نتمكن من الاتصال بالانترنت لتحميل البيانات. هل تريد المحاولة مرة أخرى؟", nil);
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] bk_initWithTitle:@"خطأ" message:message];
        [alertView bk_addButtonWithTitle:@"لا" handler:nil];
        [alertView bk_addButtonWithTitle:@"نعم" handler:refreshHandler];
        [alertView show];
    }
}

- (void)showDefaultNetworkingErrorMessageForError:(NSError *)error {
    NSString *message;
    if ((error.code == NSURLErrorUserCancelledAuthentication)  &&
        (error.code == NSURLErrorServerCertificateNotYetValid)) {
        message = NSLocalizedString(@"لم نتمكن من إنشاء إتصال آمن بالانترنت. رجاء قم بمراجعة إعدادات التاريخ و الوقت.", nil);;
    }
    
    [self showNetworkingErrorWithMessage:message];
}

@end
