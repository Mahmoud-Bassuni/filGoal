//
//  LandingScreenViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandingScreenViewController : GAITrackedViewController
- (IBAction)homeBtnPressed:(id)sender;
- (IBAction)sectionBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sectionBtn;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIButton *button;

@end
