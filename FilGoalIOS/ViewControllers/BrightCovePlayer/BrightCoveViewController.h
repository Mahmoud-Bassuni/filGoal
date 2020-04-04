//
//  BrightCoveViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/25/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BrightcovePlayerSDK/BrightcovePlayerSDK.h>
#import <AVKit/AVKit.h>

@interface BrightCoveViewController : UIViewController<BCOVPlaybackControllerDelegate>
@property (nonatomic, strong) BCOVCatalogService *catalogService;
@property (nonatomic, strong) id<BCOVPlaybackController> playbackController;
@property (nonatomic, weak) IBOutlet UIView *videoContainer;
@property (nonatomic,strong)NSString * videoID;
@property (nonatomic, strong) AVPlayerViewController *avpvc;
@end
