//
//  NewsDetails3DtouchViewViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/1/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetails3DtouchViewViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *newsSummaryTxtView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLbl;
@property (strong,nonatomic) NSString * newsTitle;
@property (assign,nonatomic) NSInteger newsID;
@property (assign,nonatomic) NSInteger newsIndex;
@property (strong,nonatomic) NewsItem * newsDetailsObject;
@property (strong,nonatomic) NSString * newsdescription;
@property (weak, nonatomic) IBOutlet UIWebView *newsDetailsWebView;
@property (weak, nonatomic) IBOutlet UIImageView *newsImgView;
@end
