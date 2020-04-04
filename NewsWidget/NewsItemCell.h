//
//  NewsItemCell.h
//  HybridDynamicProject
//
//  Created by Yomna Ahmed on 7/2/15.
//  Copyright (c) 2015 Mohamed Mansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "AsyncImageView.h"
@interface NewsItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *newsImg;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *numOfShare;
@property (weak, nonatomic) IBOutlet UILabel *Resources;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@end
