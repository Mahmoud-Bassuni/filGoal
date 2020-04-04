//
//  AuthorListingCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/4/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorListingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *authorNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *authorArticalLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
