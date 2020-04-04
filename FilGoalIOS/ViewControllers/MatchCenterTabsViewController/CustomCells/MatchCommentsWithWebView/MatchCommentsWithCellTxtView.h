//
//  MatchCommentsWithWebViewCell.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/10/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchCommentsWithCellTxtView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *minuteLbl;
@property (strong, nonatomic) IBOutlet UITextView *contentTxtView;
@property (nonatomic,assign) NSInteger matchID;
- (IBAction)shareBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
+(UITableViewCell*)loadCommentContentWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCommentMinObj:(MatchComment*)matchCommentItem;
@end
