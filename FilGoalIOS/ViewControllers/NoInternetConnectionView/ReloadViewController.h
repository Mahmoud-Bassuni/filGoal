//
//  ReloadViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 6/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReloadViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *retryBtn;
- (IBAction)retryBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
