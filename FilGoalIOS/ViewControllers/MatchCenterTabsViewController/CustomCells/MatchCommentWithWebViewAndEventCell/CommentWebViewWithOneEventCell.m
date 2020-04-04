//
//  CommentWebViewWithOneEventCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "CommentWebViewWithOneEventCell.h"
#import  "UIImageView+WebCache.h"

@implementation CommentWebViewWithOneEventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
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

- (IBAction)playerBtnPressed:(UIButton*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

+(UITableViewCell*)loadCommentContentWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCommentMinObj:(MatchComment*)matchCommentItem
{
    static NSString *CellIdentifier = @"CommentWebViewWithOneEventCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"CommentWebViewWithOneEventCell";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
  //  UIButton * shareBtn=(UIButton*)[cell viewWithTag:10000];
    //[shareBtn setTag:indexPath.row];
     UIButton * playerBtn =(UIButton*)[cell viewWithTag:9000];
    UIImageView * flagImgView =(UIImageView*)[cell viewWithTag:2];
    UIImageView * eventImgView =(UIImageView*)[cell viewWithTag:3];
    UIImageView * eventView =(UIImageView*)[cell viewWithTag:20];
    UIImageView * playerImgView =(UIImageView*)[cell viewWithTag:4];
    UIWebView<UIWebViewDelegate> * contentWebView=(UIWebView*)[cell viewWithTag:1000];
    UILabel * eventLbl=(UILabel*)[cell viewWithTag:5];
    UILabel * playerNameLbl=(UILabel*)[cell viewWithTag:6];
    UILabel * playerPositionLbl=(UILabel*)[cell viewWithTag:7];
    UILabel * minuteLbl=(UILabel*)[cell viewWithTag:2000];
    minuteLbl.layer.cornerRadius = minuteLbl.frame.size.width/2;
    minuteLbl.clipsToBounds = YES;
    minuteLbl.layer.borderWidth = 1.0f;
    minuteLbl.layer.borderColor = [[UIColor orangeColor] CGColor];
    contentWebView.scrollView.scrollEnabled=NO;
    playerImgView.layer.cornerRadius = playerImgView.frame.size.width/2;
    playerImgView.clipsToBounds = YES;
    eventView.layer.cornerRadius = eventView.frame.size.width/2;
    eventView.clipsToBounds = YES;
    eventView.layer.borderWidth = 1.0f;
    eventView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [eventImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d.png",EVENTS_BASE_URL,(int)matchCommentItem.matchEvent.matchEventTypeId]]];
    [flagImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)matchCommentItem.matchEvent.teamId]]  placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"] ];
    if(matchCommentItem.matchEvent.playerAId!=0)
    {
    [playerImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)matchCommentItem.matchEvent.playerAId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    [playerNameLbl setText:matchCommentItem.matchEvent.playerAName];
    [playerPositionLbl setText:matchCommentItem.matchEvent.playerARoleName];
    }
    else
    {
    [playerImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)matchCommentItem.matchEvent.playerBId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios.png"]];
    [playerNameLbl setText:matchCommentItem.matchEvent.playerBName];
    [playerPositionLbl setText:matchCommentItem.matchEvent.playerBRoleName];
    }
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
    
    [eventLbl setText:matchCommentItem.matchEvent.matchEventTypeName];
    if(matchCommentItem.contentUrl==nil)
    {
        matchCommentItem.contentUrl=@"";
    }
    if(matchCommentItem.order!=0)
    {
        [minuteLbl setText:[NSString stringWithFormat:@"مثبت"]];
        
    }
    
     //NSString* embedHTML = @"<iframe width=\"200\" height=\"150\" src=\"https://www.youtube.com/embed/ADefH7IDAZs\" frameborder=\"0\" allowfullscreen></iframe>";
    NSString * commentDetails=[NSString stringWithFormat:
                               @"<html><head><script src=http://platform.twitter.com/widgets.js> </script><style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #172983; } img{width:100%%; height:auto} #content > iframe { max-width: 100%%; width: 220; height: 150; } <a class=twitter-tweet data-width=224 data-height=150> </style></head><body><div id='content' dir='rtl' name='content'>%@</div></body></html>",14,[UIColor blackColor],@"DINNextLTW23Regular",[NSString stringWithFormat:@"%@ \n %@",matchCommentItem.content, matchCommentItem.contentUrl]];


    
   // NSString *embedHTML = @"<p>اكتفى منتخب الجزائر بالتعادل بهدف لكل منتخب أمام الكاميرون في بداية مشوار الخضر في تصفيات إفريقيا المؤهلة إلى كأس العالم روسيا 2018.</p><p>أصحاب الأرض تقدموا أولا عن طريق العربي هلال سوداني في الدقيقة السابعة من عمر الشوط الأول.</p><p>لكن عودة الأسود جاءت سريعة وقوية فنجح بنيامين موكاندجو في إدراك التعادل للكاميرون في الدقيقة 23.</p><p>تعثر الجزائر بالتعادل الأول جاء على ملعب مصطفى تشاكر في مدينة بليدة الجزائرية وسط حضور جماهيري مبهر.</p><p>حارس الكاميرون تألق في إبعاد خطورة الجزائر عن طريق إسلام سليماني وسفير تايدر ورياض بودبوز ورياض محرز.</p><p>بينما كاد المنتخب الكاميروني في أكثر من مناسبة أن يهز شباك الجزائر ولكن كل محاولات الأسود مرت بسلام على مرمى رايس موبلحي.</p><p>تعثر الجزائر زاد من صعوبة المجموعة الثانية النارية وخصوصا بعد فوز منتخب نيجيريا خارج الديار أمام زامبيا.</p><p>في الجولة الثانية، منتخب الجزائر سيرحل لمواجهة نيجيريا على ملعب الأخير بينما تستضيف الكاميرون منتخب زامبيا.</p><p><script type='text/javascript'src='http://player.vmp.mezzoz.com/DXS9MSY7.js'data-file='http://video.vmp.mezzoz.com/DXS9MSY7/3SYD5EQ3'></script></p>";
   // NSString* embedHTML = @"<iframe type=\"text/html\" width=\"200\" height=\"150\" src=\"http://www.youtube.com/embed/j8Bc7eRTdWY\" frameborder=\"0\"></iframe>";
    
    // Initialize the html data to webview
    //[contentWebView stringByEvaluatingJavaScriptFromString:embedHTML]
    if(matchCommentItem.matchEvent.playerAId!=0)
    {
    playerBtn.tag = matchCommentItem.matchEvent.playerAId;
    }
    else
        playerBtn.tag = matchCommentItem.matchEvent.playerBId;

    [contentWebView loadHTMLString:commentDetails baseURL:nil];
  //  [contentWebView loadHTMLString:commentDetails baseURL:nil];
    
    return cell;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if(webView.tag==123456)
        return;
//    [webView sizeToFit];
//    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, webView.frame.size.height+30)];
//    CGRect newBounds = webView.bounds;
//    newBounds.size.height = webView.scrollView.contentSize.height;
//    webView.bounds = newBounds;
  // UIView * commentView=(UIView*)[self viewWithTag:600];
//    UIWebView<UIWebViewDelegate> * contentWebView=(UIWebView*)[self viewWithTag:1000];
//    contentWebView.bounds=newBounds;
 //  [commentView setFrame:CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y, commentView.frame.size.width, webView.scrollView.contentSize.height+80)];
    
    
}

@end
