//
//  MDThreadsViewController.h
//  Disqus
//
//  Created by Andrew Kopanev on 1/16/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import "MDBaseViewController.h"

@interface MDThreadsViewController : MDBaseViewController

- (id)initWithForumShortname:(NSString *)forumShortname  thread_ident:(NSString *)thread_ident;

@end
