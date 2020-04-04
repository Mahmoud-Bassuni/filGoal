//
//  UserTeamsListViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/7/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "UserTeamsListViewController.h"
#import "TeamEditableCell.h"
#import "TeamProfileViewController.h"
//#import "UIImageView+PlayGIF.h"
#import <Masonry/Masonry.h>

@import Firebase;
@interface UserTeamsListViewController ()
{
    NSArray* teams;
}
@end

@implementation UserTeamsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title = @"متابعاتي";
    self.screenName = @"iOS- User Follows Team";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- User Follows Team"
                                     }];

    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //Don't need
    [super setUpBannerUnderNav:self.view anotherTopView:self.tableView];
    [super viewDidAppear:animated];
    User * user = [UserMethods retrieveUserObject];
    teams = user.teamsDic.allValues;
    [self.tableView reloadData];
    if(teams.count==0)
    {
        self.imgView.hidden=NO;
        self.tableView.hidden=YES;
        [self.view setBackgroundColor:[UIColor whiteColor]];

    }
    else
    {
        self.imgView.hidden=YES;
        self.tableView.hidden=NO;
        [self.view setBackgroundColor:[UIColor whiteColor]];

    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return teams.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamPreference * item = [teams objectAtIndex:indexPath.row];
    TeamEditableCell * cell=[tableView dequeueReusableCellWithIdentifier:@"TeamEditableCell"];
    if(cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TeamEditableCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.deleteBtn.tag = item.teamId;
    cell.editBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(removeTeamItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editBtn addTarget:self action:@selector(editTeamProfileAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.teamNameLbl.text = item.teamName;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.teamId]] placeholderImage:[UIImage imageNamed:@"Team-Image-Placeholder"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                       [cell.activityIndicator stopAnimating];
                                       
                                   }];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teamImgTaped:)];
    [cell.imgView setTag:indexPath.row];
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.view.userInteractionEnabled = YES;
    cell.imgView.userInteractionEnabled = YES;
    [cell.imgView addGestureRecognizer:tapGesture];
    
    return cell;
}
#pragma mark - Actions
-(void)removeTeamItemAction:(UIButton*)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    int teamId = (int)[sender tag];
    [UserMethods deleteTeam:teamId handler:^{
        User * user = [UserMethods retrieveUserObject];
        teams = user.teamsDic.allValues;
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
}
-(void)editTeamProfileAction:(UIButton*)sender
{
    int row = (int)[sender tag];
    TeamPreference * item = [teams objectAtIndex:row];
    TeamProfileViewController * viewController =[[TeamProfileViewController alloc]init];
    viewController.isEditMode = YES;
    viewController.teamId= (int)item.teamId;
    viewController.teamName= item.teamName;
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark - Handle Gesture
-(void)teamImgTaped:(UITapGestureRecognizer*)tap
{
    TeamPreference * item = [teams objectAtIndex:tap.view.tag];
    TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
    teamProfile.teamId = (int)item.teamId;
    teamProfile.teamName = item.teamName;
    [GetAppDelegate().getSelectedNavigationController pushViewController:teamProfile animated:YES];
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
