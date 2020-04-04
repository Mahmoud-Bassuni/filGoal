//
//  MatchCommentsWithTwoPlayersTableViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchCommentsWithTwoPlayersTableViewCell : UITableViewCell<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *contentWebView;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UITextView *commentTxt;
@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImg;
@property (weak, nonatomic) IBOutlet UILabel * firstEventTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel * secEventTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel * firstPlayerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel * secPlayerNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView * firstPlayerImg;
@property (weak, nonatomic) IBOutlet UIImageView * secPlayerImg;
@property (weak, nonatomic) IBOutlet UILabel *minuteLbl;
@property (weak, nonatomic) IBOutlet UIImageView *eventImg;
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIView *eventView;
@property (weak, nonatomic) IBOutlet UILabel * firstPlayerPostitionLbl;
@property (weak, nonatomic) IBOutlet UILabel * secPlayerPostitionLbl;
@property (strong, nonatomic) IBOutlet UIImageView *playerOutEventImg;
@property (strong, nonatomic) IBOutlet UIImageView *playerInEventImg;
+(UITableViewCell*)loadCommentContentWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCommentMinObj:(MatchComment*)matchCommentItem;


@end
