//
//  TutorialViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/13/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : ParentViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
