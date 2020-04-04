//
//  MatchCommentsWithWebViewCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/10/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "MatchCommentsWithWebViewCell.h"
#import "MatchComment.h"
#import "SVWebViewController.h"
@implementation MatchCommentsWithWebViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}
- (IBAction)shareBtnPressed:(id)sender {

}

+(UITableViewCell*)loadCommentContentWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath andCommentMinObj:(MatchComment*)matchCommentItem
{
    static NSString *CellIdentifier = @"MatchCommentWebViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"MatchCommentsWithWebViewCell";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    
   // UIButton * shareBtn=(UIButton*)[cell viewWithTag:10000];
   // [shareBtn setTag:indexPath.row];
    
    UIWebView<UIWebViewDelegate> * contentWebView=(UIWebView*)[cell viewWithTag:1000];
    
    [contentWebView setBackgroundColor:[UIColor clearColor]];
    contentWebView.delegate=self;
    contentWebView.scrollView.scrollEnabled=NO;
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
    if(matchCommentItem.order!=0)
    {
        [minuteLbl setText:[NSString stringWithFormat:@"مثبت"]];
    }
    NSString * commentDetails=[NSString stringWithFormat:
                               @"<html><head><script src=http://platform.twitter.com/widgets.js> </script><style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #172983; } img{width:100%%; height:auto} #content > iFrame { width : 100%%} <a class=twitter-tweet data-width=224 data-height=150> </style></head><body><div id='content' dir='rtl' name='content'>%@ \n %@</div></body></html>",14,[UIColor blackColor],@"DINNextLTW23Regular",[NSString stringWithFormat:@"%@",matchCommentItem.content],[NSString stringWithFormat:@"%@",matchCommentItem.contentUrl]];;
    
    [contentWebView loadHTMLString:commentDetails baseURL:nil];
    //  [contentWebView sizeToFit];
    
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark- UIWebviewDelegate ....

#pragma mark webView delegate
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //CGRect newBounds = webView.bounds;
    //newBounds.size.height = webView.scrollView.contentSize.height;
    //  webView.bounds = newBounds;
    // UIView * commentView=(UIView*)[self viewWithTag:700];
    // UIWebView<UIWebViewDelegate> * contentWebView=(UIWebView*)[self viewWithTag:1000];
    // [webView sizeToFit];
    // CGRect newBounds = webView.bounds;
    // newBounds.size.height = webView.scrollView.contentSize.height;
    //  webView.bounds = newBounds;
    // contentWebView.bounds =webView.bounds;
    // NSLog(@"%i", contentWebView.frame.size.height);
    // [commentView setFrame:CGRectMake(commentView.frame.origin.x, commentView.frame.origin.y, commentView.frame.size.width, webView.scrollView.contentSize.height)];
}

@end
