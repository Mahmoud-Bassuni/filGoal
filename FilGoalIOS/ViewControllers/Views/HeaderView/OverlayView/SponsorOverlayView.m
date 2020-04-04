//
//  SponsorOverlayView.m
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 2/7/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import "SponsorOverlayView.h"
#import <SDWebImage/UIImage+GIF.h>
@implementation SponsorOverlayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"https://media.giphy.com/media/CSzX56UjMMYwKiWYl6U/giphy.gif"]];
    [self setBannerView];
}

-(void)setBannerView
{
    UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, Screenwidth, 300)];
    [footerView setBackgroundColor:[UIColor clearColor]];
    GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(300, 250));
    self.bannerView=[[DFPBannerView alloc]initWithAdSize:customAdSize origin:CGPointMake((Screenwidth-300)/2, 0)];
    self.bannerView.adUnitID = MeduimRectangle_AD_UNIT_ID;
    self.bannerView.delegate = self;
    self.bannerView.adSize=customAdSize;
    self.bannerView.rootViewController = self;
    DFPRequest *request = [DFPRequest request];
   // @[@"Inner",@"Section",[NSString stringWithFormat:@"قسم %@",_sectionName]]
    if(self.sectionName!=nil)
        request.customTargeting=[[NSDictionary alloc]initWithObjects:@[@[@"Inner",@"Section",[NSString stringWithFormat:@"قسم %@",_sectionName]],@[]] forKeys:@[@"Keyword",@"Position"]];
    else if(self.champName!=nil)
        request.customTargeting=[[NSDictionary alloc]initWithObjects:@[@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",_champName]],@[]] forKeys:@[@"Keyword",@"Position"]];
    [self.bannerView loadRequest:request];
    [footerView addSubview:self.bannerView];
    [self addSubview:footerView];
}
//-(void)adViewDidReceiveAd:(GADBannerView *)bannerView
//{
//    self.backgroundColor=[UIColor blackColor];
//}
//-(void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
//{
//    self.backgroundColor=[UIColor clearColor];
//    [self removeFromSuperview];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"enableStreching" object:nil];
//}
- (IBAction)closeBtnPressed:(id)sender {
    [self removeFromSuperview];

}

@end
