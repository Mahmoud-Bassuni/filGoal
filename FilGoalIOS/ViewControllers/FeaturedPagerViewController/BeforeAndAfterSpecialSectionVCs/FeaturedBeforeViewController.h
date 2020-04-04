//
//  FeaturedBeforeViewController.h
//  Reyada
//
//  Created by Ahmed Kotb on 5/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "ParentViewController.h"

@interface FeaturedBeforeViewController : ParentViewController
@property (nonatomic, strong) NSString *sponserUrl;
@property (weak, nonatomic) IBOutlet UIImageView * sponsorImg;
@property (strong, nonatomic) AfterSection * beforeSection;

@end
