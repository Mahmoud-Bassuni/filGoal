//
//  AlbumCustomCellTableViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCustomCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *albumImg;
@property (strong, nonatomic) IBOutlet UILabel *albumTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *albumDateLbl;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
-(void) initWithAlbumItem:(Album*)item;
@end
