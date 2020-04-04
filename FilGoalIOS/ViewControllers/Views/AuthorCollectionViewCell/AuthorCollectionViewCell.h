//
//  AuthorCollectionViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/3/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *authorNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *articleTitleLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
