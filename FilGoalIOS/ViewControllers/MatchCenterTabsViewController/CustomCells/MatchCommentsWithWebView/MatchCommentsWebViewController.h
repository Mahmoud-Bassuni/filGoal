//
//  MatchCommentsWebViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/9/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchCommentsWebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *minuteLbl;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextView *contentTxtView;
@property (nonatomic,assign) NSInteger matchID;
//- (IBAction)shareBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property(nonatomic,strong) MatchComment * matchComment;
@end
