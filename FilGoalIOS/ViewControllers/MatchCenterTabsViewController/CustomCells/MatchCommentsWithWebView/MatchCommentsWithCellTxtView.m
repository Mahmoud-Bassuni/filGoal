//
//  MatchCommentsWithWebViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/10/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCommentsWithCellTxtView.h"
#import "MatchComment.h"
#import "SVWebViewController.h"
@implementation MatchCommentsWithCellTxtView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    
}
- (IBAction)shareBtnPressed:(id)sender {

}

+(UITableViewCell*)loadCommentContentWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCommentMinObj:(MatchComment*)matchCommentItem
{
    static NSString *CellIdentifier = @"MatchCommentsWithCellTxtView";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    
    NSString *nibname=@"MatchCommentsWithCellTxtView";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    
   // UIButton * shareBtn=(UIButton*)[cell viewWithTag:10000];
   // [shareBtn setTag:indexPath.row];
    
    __weak UITextView * contentTxtView=[cell viewWithTag:1000];
    
    UILabel * minuteLbl=(UILabel*)[cell viewWithTag:2000];
    minuteLbl.layer.cornerRadius = minuteLbl.frame.size.width/2;
    minuteLbl.clipsToBounds = YES;
    minuteLbl.layer.borderWidth = 1.0f;
    minuteLbl.layer.borderColor = [[UIColor orangeColor] CGColor];
    if(matchCommentItem.time>matchCommentItem.matchStatusestime)
    {
        // minuteLabel.text=[NSString stringWithFormat:@"%li",(long)item.time];
        [minuteLbl setText:[NSString stringWithFormat:@"%li+%li",(long)matchCommentItem.matchStatusestime,(matchCommentItem.time-matchCommentItem.matchStatusestime)]];
        
        
        
    }
    else
        [minuteLbl setText:[NSString stringWithFormat:@"%li", (long)matchCommentItem.time]];
    
    if(matchCommentItem.matchStatusMaxTime==0)
    {
        [minuteLbl setText:[NSString stringWithFormat:@"%@ ",matchCommentItem.matchStatusName]];

    }
    if(matchCommentItem.contentUrl==nil)
    {
        matchCommentItem.contentUrl=@"";
    }

    [contentTxtView setText:matchCommentItem.content];
    //  [contentWebView sizeToFit];
    
     // contentWebView=nil;
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)clearMemory
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
   // self.contentWebView=nil;

    
}


@end
