//
//  ImageCollectionViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 4/19/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *nOfImagesLbl;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *roundedView;

@end
