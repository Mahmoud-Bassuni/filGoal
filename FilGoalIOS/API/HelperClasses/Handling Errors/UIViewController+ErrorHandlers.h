//
//  UIViewController+ErrorHandlers.h
//  ContactCars
//
//  Created by Hesham Abd-Elmegid on 25/12/14.
//  Copyright (c) 2014 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ErrorHandlers)

- (void)showNetworkingErrorWithMessage:(NSString *)message;

- (void)showDefaultNetworkingErrorMessageForError:(NSError *)error
                                   refreshHandler:(void (^)(void))refreshHandler;
- (void)showDefaultNetworkingErrorMessageForError:(NSError *)error;

@end
