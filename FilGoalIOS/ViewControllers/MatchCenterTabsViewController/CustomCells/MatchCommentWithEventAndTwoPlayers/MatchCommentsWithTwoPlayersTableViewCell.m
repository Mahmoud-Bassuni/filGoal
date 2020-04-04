//
//  MatchCommentsWithTwoPlayersTableViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/15/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCommentsWithTwoPlayersTableViewCell.h"
#import  "UIImageView+WebCache.h"

@implementation MatchCommentsWithTwoPlayersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self setOpaque:NO];//Need to clear background of UIWebView
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)shareBtnPressed:(id)sender {
    
}
+(UITableViewCell*)loadCommentContentWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCommentMinObj:(MatchComment*)matchCommentItem
{
    static NSString *CellIdentifier = @"MatchCommentsWithTwoPlayersTableViewCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"MatchCommentsWithTwoPlayersTableViewCell";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    
  //  UIButton * shareBtn=(UIButton*)[cell viewWithTag:10000];
   // [shareBtn setTag:indexPath.row];
     UIButton * firstPlayerBtn=(UIButton*)[cell viewWithTag:4000];
     UIButton * secPlayerBtn=(UIButton*)[cell viewWithTag:4001];
    UIImageView * flagImgView =(UIImageView*)[cell viewWithTag:2];
    UIImageView * eventImgView =(UIImageView*)[cell viewWithTag:3];
    UIImageView * playerOutImgView =(UIImageView*)[cell viewWithTag:9];
    UIImageView * playerInImgView =(UIImageView*)[cell viewWithTag:90];
    UIImageView * eventView =(UIImageView*)[cell viewWithTag:20];
    UIImageView * playerAImgView =(UIImageView*)[cell viewWithTag:4];
    UIImageView * playerBImgView =(UIImageView*)[cell viewWithTag:40];
    UIWebView<UIWebViewDelegate> * contentWebView=(UIWebView*)[cell viewWithTag:1000];
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
    contentWebView.scrollView.scrollEnabled=NO;
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
    
    firstPlayerBtn.tag = matchCommentItem.matchEvent.playerBId;
    secPlayerBtn.tag = matchCommentItem.matchEvent.playerAId;

    [contentWebView setBackgroundColor:[UIColor clearColor]];
    [contentWebView setAllowsInlineMediaPlayback:YES];
    contentWebView.mediaPlaybackRequiresUserAction = YES;
    contentWebView.delegate=self;
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
    if(matchCommentItem.order!=0)
    {
        [minuteLbl setText:[NSString stringWithFormat:@"مثبت"]];

    }
    
    [eventALbl setText:@"خروج"];
    [eventBLbl setText:@"دخول"];
    
    if(matchCommentItem.contentUrl==nil)
    {
        matchCommentItem.contentUrl=@"";
    }
    if(matchCommentItem.order!=0)
    {
        [minuteLbl setText:[NSString stringWithFormat:@"مثبت"]];
        
    }
    NSString * commentDetails=[NSString stringWithFormat:
                               @"<html><head><script src=http://platform.twitter.com/widgets.js> </script><style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #172983; } img{width:100%%; height:auto} #content > iFrame { width : 100%%} <a class=twitter-tweet data-width=224 data-height=150> </style></head><body><div id='content' dir='rtl' name='content'>%@</div></body></html>",14,[UIColor blackColor],@"DINNextLTW23Regular",[NSString stringWithFormat:@"%@ \n %@",matchCommentItem.content, matchCommentItem.contentUrl]];;
   
    [contentWebView loadHTMLString:commentDetails baseURL:nil];
    
    return cell;
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
- (IBAction)firstPlayerBtnPressed:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

- (IBAction)secPlayerBtnPressed:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

@end
