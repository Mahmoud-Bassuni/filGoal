//
//  MDPostCellContentView.h
//  Disqus
//
//  Created by Andrew Kopanev on 1/17/14.
//  Copyright (c) 2014 Moqod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostModel.h"
@interface MDPostCellContentView : UITableViewCell



@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomBarView;

@property (strong, nonatomic) IBOutlet UILabel *likeNum;
@property (strong, nonatomic) IBOutlet UILabel *disLikeNum;

@property (strong, nonatomic) IBOutlet UIButton *expandColapseBtn;
@property (strong, nonatomic) IBOutlet UIImageView *userAvatar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ind;
+ (CGFloat)heightForPost:(PostModel *)post width:(CGFloat)width;

- (void)setPost:(PostModel *)post;

@end
