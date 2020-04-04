//
//  UsersStatisticsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 5/12/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import "UsersStatisticsViewController.h"
#import "PredictionStatistics.h"
#import "PredictionServiceManager.h"
@interface UsersStatisticsViewController ()

@end

@implementation UsersStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getStatisticsAPI];
    self.contentSizeInPopup = CGSizeMake(300, self.view.frame.size.height);
    // Navigationbar
    self.popupController.navigationBarHidden = YES;
    self.view.layer.cornerRadius=6.0;
    self.view.clipsToBounds=YES;
    self.popupController.containerView.layer.cornerRadius=6.0;
    self.popupController.containerView.clipsToBounds=YES;
    self.drawProgressView.layer.transform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    self.awayProgressView.layer.transform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    self.homeProgressView.layer.transform = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0);
    [self setScreenSponsor];

}
-(void)setScreenSponsor{
    if([AppSponsors isPredictionChampionActiveUsingId:self.matchItem.championshipId]){
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:[AppSponsors getPredictionMatchStatisticsSponsorImagePathUsingChampionId:self.matchItem.championshipId]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(image != nil){
            self.sponsorImgView.hidden = NO;
            }
        }];
        
    }
    else{
        self.sponsorImgView.hidden = YES;
    }
}
-(void)getStatisticsAPI{
    [PredictionServiceManager getUserStatisticsUsingMatchId:self.matchItem.idField succuss:^(PredictionStatistics * result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            float totalValue = (int)result.homeTeamWin + (int)result.awayTeamWin;
            self.homeTeamNameLbl.text = [NSString stringWithFormat:@"فوز  %@",self.matchItem.homeTeamName];
            self.awayTeamNameLbl.text = [NSString stringWithFormat:@"فوز  %@",self.matchItem.awayTeamName];
            self.drawTeamLbl.text=@"تعادل الفريقين";
            if(totalValue != 0){
            float homeTeamValue = result.homeTeamWin / totalValue;
            float awayTeamValue = result.awayTeamWin / totalValue;
            float drawTeamValue = result.matchDraw / totalValue;
            self.awayProgressView.progress = awayTeamValue;
            self.homeProgressView.progress = homeTeamValue;
            self.drawProgressView.progress = drawTeamValue;
            self.homeTeamPercentageLbl.text = [NSString stringWithFormat:@"%li %%",(long)result.homeTeamWinPercentage];
            self.awayTeamPercentageLbl.text = [NSString stringWithFormat:@"%li %%",(long)result.awayTeamWinPercentage];
            self.drawTeamPercentageLbl.text = [NSString stringWithFormat:@"%li %%",(long)result.matchDrawPercentage];

            }

        });
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
