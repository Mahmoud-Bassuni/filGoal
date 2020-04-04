//
//  FeaturedAfterViewController.h
//  Reyada
//
//  Created by Ahmed Kotb on 5/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "ParentViewController.h"
#import "XLPagerTabStripViewController.h"
#import "AfterSection.h"
@interface FeaturedAfterViewController : ParentViewController <XLPagerTabStripChildItem>
@property (nonatomic, strong) NSString *sponserUrl;
@property (weak, nonatomic) IBOutlet UIImageView *sponsorImg;
@property (strong, nonatomic) AfterSection * afterSection;


@end
