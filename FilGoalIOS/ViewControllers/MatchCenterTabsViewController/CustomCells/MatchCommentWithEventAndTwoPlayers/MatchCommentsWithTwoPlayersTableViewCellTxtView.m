//
//  MatchCommentsWithTwoPlayersTableViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCommentsWithTwoPlayersTableViewCellTxtView.h"
#import  "UIImageView+WebCache.h"

@implementation MatchCommentsWithTwoPlayersTableViewCellTxtView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:NO];//Need to clear background of UIWebView
    self.backgroundColor = [UIColor clearColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearMemory)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)shareBtnPressed:(id)sender {
    
}
+(UITableViewCell*)loadCommentContentWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCommentMinObj:(MatchComment*)matchCommentItem
{
    static NSString *CellIdentifier = @"MatchCommentsWithTwoPlayersTableViewCellTxtView";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    NSString *nibname=@"MatchCommentsWithTwoPlayersTableViewCellTxtView";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    
  //  UIButton * shareBtn=(UIButton*)[cell viewWithTag:10000];
   // [shareBtn setTag:indexPath.row];
    UIImageView * flagImgView =(UIImageView*)[cell viewWithTag:2];
    UIImageView * eventImgView =(UIImageView*)[cell viewWithTag:3];
    UIImageView * playerOutImgView =(UIImageView*)[cell viewWithTag:9];
    UIImageView * playerInImgView =(UIImageView*)[cell viewWithTag:90];
    UIImageView * eventView =(UIImageView*)[cell viewWithTag:20];
    UIImageView * playerAImgView =(UIImageView*)[cell viewWithTag:4];
    UIImageView * playerBImgView =(UIImageView*)[cell viewWithTag:40];
    __weak UITextView * contentTxtView=[cell viewWithTag:1000];
    UILabel * eventALbl=(UILabel*)[cell viewWithTag:5];
    UILabel * eventBLbl=(UILabel*)[cell viewWithTag:50];
    UILabel * playerANameLbl=(UILabel*)[cell viewWithTag:6];
    UILabel * playerBNameLbl=(UILabel*)[cell viewWithTag:60];
    UILabel * playerAPositionLbl=(UILabel*)[cell viewWithTag:7];
    UILabel * playerBPositionLbl=(UILabel*)[cell viewWithTag:70];
    UILabel * minuteLbl=(UILabel*)[cell viewWithTag:2000];
    minuteLbl.layer.cornerRadius = minuteLbl.frame.size.width/2;
    minuteLbl.clipsToBounds = YES;
    minuteLbl.layer.borderWidth = 1.0f;
    minuteLbl.layer.borderColor = [[UIColor orangeColor] CGColor];
    playerAImgView.layer.cornerRadius = playerAImgView.frame.size.width/2;
    playerAImgView.clipsToBounds = YES;
    playerBImgView.layer.cornerRadius = playerBImgView.frame.size.width/2;
    playerBImgView.clipsToBounds = YES;
    eventView.layer.cornerRadius = eventView.frame.size.width/2;
    eventView.clipsToBounds = YES;
    eventView.layer.borderWidth = 1.0f;
    eventView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
   // [contentWebView sizeToFit];
    [eventImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d.png",EVENTS_BASE_URL,(int)matchCommentItem.matchEvent.matchEventTypeId]]];
    [flagImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)matchCommentItem.matchEvent.teamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"] ];
    [playerOutImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-1.png",EVENTS_BASE_URL,(int)matchCommentItem.matchEvent.matchEventTypeId]]];
    [playerInImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-0.png",EVENTS_BASE_URL,(int)matchCommentItem.matchEvent.matchEventTypeId]]];
    
    [playerAImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)matchCommentItem.matchEvent.playerBId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    [playerANameLbl setText:matchCommentItem.matchEvent.playerBName];
    [playerAPositionLbl setText:matchCommentItem.matchEvent.playerBRoleName];
    
    [playerBImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)matchCommentItem.matchEvent.playerAId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    [playerBNameLbl setText:matchCommentItem.matchEvent.playerAName];
    [playerBPositionLbl setText:matchCommentItem.matchEvent.playerARoleName];
    
    
    [contentTxtView setBackgroundColor:[UIColor clearColor]];
    if(matchCommentItem.time>matchCommentItem.matchStatusestime)
    {
        // minuteLabel.text=[NSString stringWithFormat:@"%li",(long)item.time];
        [minuteLbl setText:[NSString stringWithFormat:@"%li+%li",(long)matchCommentItem.matchStatusestime,(matchCommentItem.time-matchCommentItem.matchStatusestime)]];
        
        
        
    }
    else
        [minuteLbl setText:[NSString stringWithFormat:@"%li", (long)matchCommentItem.time]];
    
    if(matchCommentItem.matchStatusMaxTime==0)
    {
        [minuteLbl setText:[NSString stringWithFormat:@"%@",matchCommentItem.matchStatusName]];
        
    }
    
    [eventALbl setText:@"خروج"];
    [eventBLbl setText:@"دخول"];
    
    if(matchCommentItem.contentUrl==nil)
    {
        matchCommentItem.contentUrl=@"";
    }

   
     // contentWebView=nil;
    [contentTxtView setText:matchCommentItem.content];
    
    return cell;
}
-(void)clearMemory
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
 //   self.contentWebView=nil;
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    CGRect newBounds = webView.bounds;
//    newBounds.size.height = webView.scrollView.contentSize.height;
//    webView.bounds = newBounds;
//    UIView * commentView=(UIView*)[self viewWithTag:500];
//    UIWebView<UIWebViewDelegate> * contentWebView=(UIWebView*)[self viewWithTag:1000];
//    contentWebView.bounds=newBounds;
    //[commentView setFrame:CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y, commentView.frame.size.width, contentWebView.scrollView.contentSize.height+20)];
    
    
}
@end
