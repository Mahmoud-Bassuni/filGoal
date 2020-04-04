//
//  NewsCustomCell.h
//  Reyada
//
//  Created by Nada Gamal on 12/24/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwipeableCellDelegate <NSObject>
- (void)deleteAction:(UITableViewCell *)cell;
- (void)setAsReadAction:(UITableViewCell *)cell;
- (void)cellDidOpen:(UITableViewCell *)cell;
- (void)cellDidClose:(UITableViewCell *)cell;
@end

@interface NewsCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImg;
@property (weak, nonatomic) IBOutlet UIImageView *playImg;
@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *itemLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (assign,nonatomic) BOOL hideDeleteBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)openCell;
@end
