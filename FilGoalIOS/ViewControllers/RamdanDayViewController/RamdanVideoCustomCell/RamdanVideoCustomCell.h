//
//  RamdanVideoCustomCell.h
//  Reyada
//
//  Created by Nada Gamal on 5/4/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RamdanVideoCustomCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *numberOfViews;
@property (weak, nonatomic) IBOutlet UILabel *cellTopTitleLblTxt;
@property (weak, nonatomic) IBOutlet UIImageView *cellIconImg;

@end
