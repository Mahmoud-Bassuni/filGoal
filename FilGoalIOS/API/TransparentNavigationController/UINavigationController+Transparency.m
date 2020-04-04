#import "UINavigationController+Transparency.h"

@implementation UINavigationController (Transparency)

- (void)gsk_setNavigationBarTransparent:(BOOL)transparent
                               animated:(BOOL)animated {
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [UIView animateWithDuration:animated ? 0.33 : 0 animations:^{
        if (transparent) {
            [appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage new]
                                     forBarMetrics:UIBarMetricsDefault];
            appDelegate.getSelectedNavigationController.navigationBar.shadowImage = [UIImage new];
            appDelegate.getSelectedNavigationController.navigationBar.translucent = YES;
            self.view.backgroundColor = [UIColor clearColor];
            appDelegate.getSelectedNavigationController.navigationBar.backgroundColor = [UIColor clearColor];
        } else {
            [appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:nil
                                     forBarMetrics:UIBarMetricsDefault];
        }
    }];
}

@end
