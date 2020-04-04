//
//  SponsorOverlayView.h
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 2/7/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SponsorOverlayView : UIView<GADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)closeBtnPressed:(id)sender;
@property(nonatomic,strong) DFPBannerView  *bannerView;
@property (strong, nonatomic) NSString *sectionName;
@property (assign, nonatomic) NSInteger sectionId;
@property (strong, nonatomic) NSString *champName;

@end
