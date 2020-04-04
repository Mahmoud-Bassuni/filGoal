//
//  NewUpdateViewController.h
//  Reyada
//
//  Created by Nada Gamal on 6/22/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUpdateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *updateNowBtn;
- (IBAction)updateNowPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *updateDetailsTxtView;
@property (weak, nonatomic) IBOutlet UILabel *versionNumberLbl;
@property (weak, nonatomic) IBOutlet UIImageView *appIconImgView;

@end
