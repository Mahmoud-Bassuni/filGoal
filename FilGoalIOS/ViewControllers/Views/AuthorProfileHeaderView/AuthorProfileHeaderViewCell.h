//
//  AuthorProfileHeaderViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/5/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Author.h"

@interface AuthorProfileHeaderViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *authorName;
@property (strong, nonatomic) IBOutlet UILabel *nOfArticalsLbl;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *nOfReadsLbl;
-(void)initWithAuthorCell:(Author*)item;

@end
