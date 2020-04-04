//
//  VideoModelDetailsViewController.h
//  Reyada
//
//  Created by Nada Gamal on 5/11/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoModelDetailsViewController : ParentViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *topImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLblTxt;

- (IBAction)dismissView:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) NSString * videoEmbdedUrl;

@property (weak, nonatomic) IBOutlet UILabel *componetTitle;
@property (weak, nonatomic) IBOutlet UITextView *detailsTxtView;
@property (strong, nonatomic) NSString *titleLblTxtStr;
@property (strong, nonatomic) NSString *componetTitleStr;
@property (strong, nonatomic) NSString *detailsTxtViewStr;
@property (weak, nonatomic) IBOutlet UIImageView *compontIconImg;
@property(strong,nonatomic) NSString * compontentImgUrl;
@property(strong,nonatomic) NSString * topImagUrl;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
