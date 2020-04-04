//
//  CommentWebViewWithOneEventCell.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "CommentWebViewWithOneEventCellTxtView.h"
#import  "UIImageView+WebCache.h"

@implementation CommentWebViewWithOneEventCellTxtView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
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
    static NSString *CellIdentifier = @"CommentWebViewWithOneEventCellTxtView";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"CommentWebViewWithOneEventCellTxtView";
    
    if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];

       // cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
  //  UIButton * shareBtn=(UIButton*)[cell viewWithTag:10000];
    //[shareBtn setTag:indexPath.row];
    UIImageView * flagImgView =(UIImageView*)[cell viewWithTag:2];
    UIImageView * eventImgView =(UIImageView*)[cell viewWithTag:3];
    UIImageView * eventView =(UIImageView*)[cell viewWithTag:20];
    UIImageView * playerImgView =(UIImageView*)[cell viewWithTag:4];
    __weak UITextView * contentTxtView=[cell viewWithTag:1000];
    UILabel * eventLbl=(UILabel*)[cell viewWithTag:5];
    UILabel * playerNameLbl=(UILabel*)[cell viewWithTag:6];
    UILabel * playerPositionLbl=(UILabel*)[cell viewWithTag:7];
    UILabel * minuteLbl=(UILabel*)[cell viewWithTag:2000];
    minuteLbl.layer.cornerRadius = minuteLbl.frame.size.width/2;
    minuteLbl.clipsToBounds = YES;
    minuteLbl.layer.borderWidth = 1.0f;
    minuteLbl.layer.borderColor = [[UIColor orangeColor] CGColor];
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
     //NSString* embedHTML = @"<iframe width=\"200\" height=\"150\" src=\"https://www.youtube.com/embed/ADefH7IDAZs\" frameborder=\"0\" allowfullscreen></iframe>";
 


    
   // NSString *embedHTML = @"<p>اكتفى منتخب الجزائر بالتعادل بهدف لكل منتخب أمام الكاميرون في بداية مشوار الخضر في تصفيات إفريقيا المؤهلة إلى كأس العالم روسيا 2018.</p><p>أصحاب الأرض تقدموا أولا عن طريق العربي هلال سوداني في الدقيقة السابعة من عمر الشوط الأول.</p><p>لكن عودة الأسود جاءت سريعة وقوية فنجح بنيامين موكاندجو في إدراك التعادل للكاميرون في الدقيقة 23.</p><p>تعثر الجزائر بالتعادل الأول جاء على ملعب مصطفى تشاكر في مدينة بليدة الجزائرية وسط حضور جماهيري مبهر.</p><p>حارس الكاميرون تألق في إبعاد خطورة الجزائر عن طريق إسلام سليماني وسفير تايدر ورياض بودبوز ورياض محرز.</p><p>بينما كاد المنتخب الكاميروني في أكثر من مناسبة أن يهز شباك الجزائر ولكن كل محاولات الأسود مرت بسلام على مرمى رايس موبلحي.</p><p>تعثر الجزائر زاد من صعوبة المجموعة الثانية النارية وخصوصا بعد فوز منتخب نيجيريا خارج الديار أمام زامبيا.</p><p>في الجولة الثانية، منتخب الجزائر سيرحل لمواجهة نيجيريا على ملعب الأخير بينما تستضيف الكاميرون منتخب زامبيا.</p><p><script type='text/javascript'src='http://player.vmp.mezzoz.com/DXS9MSY7.js'data-file='http://video.vmp.mezzoz.com/DXS9MSY7/3SYD5EQ3'></script></p>";
   // NSString* embedHTML = @"<iframe type=\"text/html\" width=\"200\" height=\"150\" src=\"http://www.youtube.com/embed/j8Bc7eRTdWY\" frameborder=\"0\"></iframe>";
    
    // Initialize the html data to webview
    //[contentWebView stringByEvaluatingJavaScriptFromString:embedHTML]
  //  [contentWebView loadHTMLString:commentDetails baseURL:nil];
    [contentTxtView setText:matchCommentItem.content];
    
    return cell;
}

-(void)clearMemory
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
   // self.contentWebView=nil;
   
    
}
@end
