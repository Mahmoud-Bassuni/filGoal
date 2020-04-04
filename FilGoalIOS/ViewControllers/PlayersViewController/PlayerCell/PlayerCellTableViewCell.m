//
//  PlayerCellTableViewCell.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/6/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "PlayerCellTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation PlayerCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)playerProfileBtnPressed:(UIButton *)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];

    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

-(void) initWithPlayer:(Player*)item
{
    self.playerImgView.layer.cornerRadius = self.playerImgView.frame.size.width/2;
    self.playerImgView.clipsToBounds = YES;
    self.playerNameLbl.text = item.playerName;
    [self.playerImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)item.playerIdd]] placeholderImage:[UIImage imageNamed:@"Player-Image-Placeholder"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                     [self.activityIndicator stopAnimating];
                                     
                                 }];
    self.playerNumLbl.text = [NSString stringWithFormat:@"%li",(long)item.shirtNumber];
    self.playerPositionLbl.text = item.positionName;
    self.playerNationalityLbl.text = item.countryName;
    self.playerProfileBtn.tag = item.playerIdd;
}
@end
