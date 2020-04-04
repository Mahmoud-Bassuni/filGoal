
//
//  BrightCoveViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/25/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import "BrightCoveViewController.h"
#import <BrightcovePlayerSDK/BrightcovePlayerSDK.h>
#import <BrightcovePlayerUI/BrightcovePlayerUI.h>
@interface BrightCoveViewController ()

@end

@implementation BrightCoveViewController
static NSString * const kViewControllerCatalogToken = @"LOGql0XrGF47clyKy5gQtfij5CTGKNzHZLB8KGyCQJE8MmcvIyQsuA..";
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
     //   [self setup];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];

    [self addChildViewController:self.avpvc];
    self.avpvc.view.frame = self.videoContainer.bounds;
    self.avpvc.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.videoContainer addSubview:self.avpvc.view];
    [self.avpvc didMoveToParentViewController:self];
    
    [self requestContentFromCatalog];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setup
{
   /* BCOVPlayerSDKManager *manager = [BCOVPlayerSDKManager sharedManager];
    _playbackController = [manager createPlaybackControllerWithViewStrategy:[manager defaultControlsViewStrategy]];
  /// _playbackController = [manager createPlaybackController];
   // // _playbackController.analytics.account = kPublisherID;
   // _playbackController
    _playbackController.delegate = self;
    _playbackController.autoAdvance = YES;
    _playbackController.autoPlay = YES;
    
    _catalogService = [[BCOVCatalogService alloc] initWithToken:kViewControllerCatalogToken];
    */
    _avpvc = [[AVPlayerViewController alloc] init];
   // _avpvc.showsPlaybackControls = true;
    
    //_avpvc.videoGravity=@"AVLayerVideoGravityResizeAspectFill";
    BCOVPlayerSDKManager *manager = [BCOVPlayerSDKManager sharedManager];
    
    _playbackController = [manager createPlaybackControllerWithViewStrategy:[manager defaultControlsViewStrategy]];
    _playbackController.delegate = self;
    _playbackController.autoAdvance = YES;
    _playbackController.autoPlay = YES;
    
    _catalogService = [[BCOVCatalogService alloc] initWithToken:kViewControllerCatalogToken];
}

- (void)requestContentFromCatalog
{
//    BCOVPlaybackService *playbackService = [[BCOVPlaybackService alloc] initWithAccountId:@"4593825243001" policyKey:@"3ab0d722-328b-470c-b3ac-7187f45ae1b1"];
    
    [self.catalogService findVideoWithVideoID:self.videoID parameters:nil completion:^(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error) {
        if (video)
        {
            
            [self.playbackController setVideos:[[BCOVPlaylist alloc]initWithVideo:video].videos];
        }
        else
        {
        }
    }];

}
- (IBAction)dismissVideo:(id)sender {
    [ self.navigationController popViewControllerAnimated:NO];
}
#pragma mark BCOVPlaybackControllerDelegate Methods

- (void)playbackController:(id<BCOVPlaybackController>)controller didAdvanceToPlaybackSession:(id<BCOVPlaybackSession>)session
{
    self.avpvc.player = session.player;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:_avpvc.player.currentItem];


}


-(void)itemDidFinishPlaying:(NSNotification *) notification {
    // Will be called when AVPlayer finishes playing playerItem
    [ self.navigationController popViewControllerAnimated:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
