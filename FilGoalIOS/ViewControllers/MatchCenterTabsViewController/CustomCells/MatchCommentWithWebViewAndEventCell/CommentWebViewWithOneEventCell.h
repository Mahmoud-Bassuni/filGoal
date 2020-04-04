//
//  CommentWebViewWithOneEventCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentWebViewWithOneEventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *minuteLbl;
@property (strong, nonatomic) IBOutlet UIWebView <UIWebViewDelegate>*contentWebView;
@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *playerImg;
@property (weak, nonatomic) IBOutlet UILabel *playerPostitionLbl;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIView *eventView;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIImageView *eventImg;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
- (IBAction)shareBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *playerBtn;
- (IBAction)playerBtnPressed:(id)sender;
+(UITableViewCell*)loadCommentContentWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCommentMinObj:(MatchComment*)matchCommentItem;
@end
