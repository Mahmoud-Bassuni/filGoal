//
//  StoryCell.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/10/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"
#import "VideoItem.h"
#import "Album.h"
@interface StoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImgHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UIView *shadwoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
-(void)initWithNewsItem:(NewsItem*) item;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintHeight;
-(void)initWithVideoItem:(VideoItem*)item;
-(void)initWithAlbumItem:(Album *)item;
@end
