//
//  TeamsListViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 10/17/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "TeamsListViewController.h"
#import "TeamsList.h"
#import "MenuItemCellLoader.h"
#import "TeamCell.h"
@import Firebase;
@interface TeamsListViewController ()
{
    NSArray * teams;
}
@end

@implementation TeamsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    teams = [[NSArray alloc]init];
    [self getTeamListAPI];
    self.screenName=[NSString stringWithFormat:@"iOS- champion Teams List with ID %ld",(long)self.champId];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- champion Teams List with ID %ld",(long)self.champId]
                                     }];
    // Sponsor
    
    if(self.champId !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.champId])
    {
        NSString * sponsorUrl=[AppSponsors getListingSponsorImagePathUsingChampionId:self.champId andContentType:@"Matches"];
        self.sponsorImgView.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.champId category:@"Matches"];
        [self.sponsorImgView sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.sponsorImgHeight.constant = image.size.height;
        }];
    }
    else
    {
        self.sponsorImgView.hidden=YES;
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getTeamListAPI
{
    __weak __typeof(self) weakSelf = self;

    [WServicesManager getDataWithURLString:[NSString stringWithFormat:TeamsListAPI,[WServicesManager getSportsEngineApiBaseURL],_champId] andParameters:nil WithObjectName:@"TeamsList" andAuthenticationType:SportesEngineAPIs success:^(TeamsList * team)
     {
       if(team != nil && team.data.count>0)
       {
           teams = team.data;
           [self.tableView reloadData];
       }
         
     }failure:^(NSError *error) {
         IBGLog(@"AggregatedEvents API Error  : %@",error);
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [weakSelf getTeamListAPI];
                                          }];
     }];
}
#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return teams.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Team *item=[teams objectAtIndex:indexPath.row ];
    static NSString * cellIdentifier = @"MenuListCustomCell";
    
    TeamCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"TeamCell" owner:self options:nil]objectAtIndex:0];
    [cell initWithTeam:item];

    return cell;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Team *item=[teams objectAtIndex:indexPath.row ];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)item.teamId;
    teamProfile.teamName = item.teamName;
    UINavigationController * navigationController = delegate.getSelectedNavigationController;
    [navigationController pushViewController:teamProfile animated:NO];
    
    
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
