//
//  StandingsLandscapeViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/18/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "StandingsLandscapeViewController.h"
#import "StandingsLandscapeCell.h"
#import "StandingsLandscapeHeaderCell.h"
@import Firebase;
@interface StandingsLandscapeViewController ()

@end
#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation StandingsLandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // [self transformView2ToLandscape]
    self.screenName=[NSString stringWithFormat:@"iOS- Champion Standings Landscape"];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- Champion Standings Landscape"
                                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    [self transformView2ToLandscape];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
}
-(void) transformView2ToLandscape {
    NSInteger rotationDirection;
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    
    if(currentOrientation == UIDeviceOrientationLandscapeRight){
        rotationDirection = 1;
    }else {
        rotationDirection = -1;
    }
    
   CGAffineTransform transform = [self.view transform];
    transform = CGAffineTransformRotate(transform, DEGREES_RADIANS(rotationDirection * 90));
    [self.view setTransform: transform];
    
}

#pragma mark - UITableView Datasource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary * dic;
    NSArray * list;
    if( [[self.standings objectAtIndex:section] isKindOfClass:[NSDictionary class]])
    {
        dic = [self.standings objectAtIndex:section];
        list = dic.allValues[0] ;
        if(list.count>1)
        {
            Standing * item = list[1];
            UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
            // UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
            ((MoreHeaderCell*)view).headerTitle.text = item.groupName;
            ((MoreHeaderCell*)view).backgroundColor = [UIColor whiteColor];
            ((MoreHeaderCell*)view).moreBtn.hidden = YES;
            return view;
        }
        else
            return [[UIView alloc]init];
    }
    
    return [[UIView alloc]init];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.selectedRound.roundTypeId == 10)
        return self.standings.count;
    else
        return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.selectedRound.roundTypeId == 10)
    {
        NSDictionary * dic;
        NSArray * list;
        if( [[self.standings objectAtIndex:section] isKindOfClass:[NSDictionary class]])
        {
            dic = [self.standings objectAtIndex:section];
            list = dic.allValues[0] ;
            if(list.count>0)
            {
                return list.count;
            }
            return 0;
            
        }
        else
            return 0;
    }
    else
        return self.standings.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier ;
    
    UITableViewCell *cell ;
    NSDictionary * dic;
    NSArray * list;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
    }
    cellIdentifier=@"StandingsLandscapeCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"StandingsLandscapeCell" owner:self options:nil]objectAtIndex:0];
    if(self.selectedRound.roundTypeId == 10)
    {
        if( [[self.standings objectAtIndex:indexPath.section] isKindOfClass:[NSDictionary class]])
        {
            dic = [self.standings objectAtIndex:indexPath.section];
            list = dic.allValues[0] ;
            if(list.count>0)
            {
                Standing * item = [list objectAtIndex:indexPath.row];
                if(indexPath.row==0)
                {
                    cellIdentifier=@"StandingsLandscapeHeader";
                    
                    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"StandingsLandscapeHeaderCell" owner:self options:nil]objectAtIndex:0];
                    
                }
                else
                {
                   // [((StandingsCell*)cell) initWithTeamStandingItem:item];
                    [((StandingsLandscapeCell*)cell) initWithStandingCell:item];

                }
            }
        }
    }
    else
    {
        if(indexPath.row==0)
        {
            cellIdentifier=@"StandingsLandscapeHeader";
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StandingsLandscapeHeaderCell" owner:self options:nil]objectAtIndex:0];
            
            
        }
        else
        {
            Standing * item = [self.standings objectAtIndex:indexPath.row];
            [((StandingsLandscapeCell*)cell) initWithStandingCell:item];

          //  [((StandingsLandscapeCell*)cell) initWithStandingCell:item];
        }
    }
    
    return cell;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return 44;
    else
        return 67;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.selectedRound.roundTypeId == 10)
        return 40;
    else
        return 0;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(self.selectedRound.roundTypeId == 10)
//    {
//        if( [[standings objectAtIndex:indexPath.section] isKindOfClass:[NSDictionary class]])
//        {
//            NSDictionary * dic;
//            NSArray * list;
//            dic = [standings objectAtIndex:indexPath.section];
//            list = dic.allValues[0] ;
//            if(list.count>0)
//            {
//                Standing * item = [list objectAtIndex:indexPath.row];
//                TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
//                teamProfile.teamId = (int)item.teamId;
//                teamProfile.teamName = item.teamName;
//                [self.navigationController pushViewController:teamProfile animated:YES];
//            }
//
//        }
//    }
//    else if(indexPath.row != 0)
//    {
//        Standing * item = standings[indexPath.row];
//        TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
//        teamProfile.teamId = (int)item.teamId;
//        teamProfile.teamName = item.teamName;
//        [self.navigationController pushViewController:teamProfile animated:YES];
//
//    }
//
//}
- (IBAction)dismissBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Orientation
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeRight;
//}

@end

