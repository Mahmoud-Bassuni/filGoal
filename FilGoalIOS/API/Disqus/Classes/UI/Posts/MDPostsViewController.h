//
//  MDPostsViewController.h
//  Disqus
//
//  Created by Andrew Kopanev on 1/16/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MDBaseViewController.h"
#import "HUMDisqusWebView.h"
#import "GAITrackedViewController.h"
@interface MDPostsViewController : ParentViewController
@property (nonatomic, strong) IBOutlet HUMDisqusWebView *disqusView;
- (id)initWithForumShortname:(NSString *)forumShortname  thread_ident:(NSString *)thread_ident;
//- (id)initWithThreadId:(NSString *)threadId title:(NSString *)title;
- (IBAction)backPressed:(id)sender;
- (IBAction)nextPressed:(id)sender;
- (IBAction)reloadWebView:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

@end
