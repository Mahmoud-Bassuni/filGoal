//
//  PlayersViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 7/30/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "PlayersViewController.h"
#import "PlayerHeaderViewCell.h"
#import "PlayerCellTableViewCell.h"
@import Firebase;
@interface PlayersViewController ()
{
    BOOL isSelected;
    NSInteger selectedPickerIndex;
}
@end

@implementation PlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isSelected = YES;
    self.screenName = @"iOS - Team Players";
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS - Team Players"
                                     }];
    self.tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PlayerHeaderViewCell" owner:self options:nil]objectAtIndex:0];
    self.selectChampionshipBtn.layer.cornerRadius = 20;
    self.selectChampionshipBtn.clipsToBounds = YES;
    
    if(self.championships.count>0)
    {
        ChampionShipData * item = [self.championships objectAtIndex:0];
        [self.selectChampionshipBtn setTitle:[NSString stringWithFormat:@"   %@",item.name] forState:UIControlStateNormal];
        [self getPlayersDataWithChampionId:item.idField];
        selectedPickerIndex = 0;
    }
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = [super setBannerViewFooter:@[@"Inner",@"Team",[NSString stringWithFormat:@"فريق %@",self.teamName]] andPosition:@[@"Pos1"]andScreenName:@"iOS - Team Players"];
    self.screenName=[NSString stringWithFormat:@"iOS- Team Players with ID %ld",(long)self.teamId];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"iOS- Team Players with ID %ld",(long)self.teamId]
                                     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Get Player Data
-(void) getPlayersDataWithChampionId:(NSInteger) champId
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[@"Id,Name,Slug,Teams",[NSString stringWithFormat:@"Teams($select=Id,TeamId,TeamName;$filter=TeamId eq %i;$expand=Players)",self.teamId]] forKeys:@[@"$select",@"$expand"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:ChampionshipDetailsAPI,[WServicesManager getSportsEngineApiBaseURL],champId] andParameters:paramDic WithObjectName:@"ChampionShipData" andAuthenticationType:SportesEngineAPIs success:^(ChampionShipData * success)
     {
         
         if(success.teams.count>0)
         {
             self.loadingLbl.hidden = YES;
             Team * team = success.teams[0];
             self.players = [[NSArray alloc]initWithArray: team.players];
             NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"playerPositionId"
                                                                         ascending: YES];
             self.players = [self.players sortedArrayUsingDescriptors:@[sortOrder]];
             if(self.players.count>0)
             {
                 [self.tableView reloadData];
                 self.tableView.hidden = NO;
                 
             }
             else{
                 self.loadingLbl.hidden = NO;
                 [self.loadingLbl setText:@"لم يتم العثور علي لاعبين"];
                 self.tableView.hidden = YES;
             }
             [self.activityIndicator stopAnimating];
             [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Players with Team ID = %li ",(long)self.teamId]  ApiError:@"Success"];

             
         }
     }failure:^(NSError *error) {
         self.loadingLbl.hidden = NO;
         [self.loadingLbl setText:@"لم يتم العثور علي لاعبين"];
         IBGLog(@"Player Profile API Error  : %@",error);
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Players with Team ID = %li ",(long)self.teamId] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getPlayersDataWithChampionId:champId];
                                          }];

         
     }];
}

-(NSArray*) getChampionshipTitles
{
    NSMutableArray * titles = [[NSMutableArray alloc]init];
    
    for(ChampionShipData * item in self.championships)
    {
        [titles addObject:item.name];
    }
    return [[NSArray alloc]initWithArray:titles];
}

#pragma - mark XLPagerTabStripChildItem
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}
#pragma mark Tag Collectionview delegate
//- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected
//{
//    [self.activityIndicator startAnimating];
//    [self.activityIndicator setHidden:NO];
//    ChampionShipData * item = [self.championships objectAtIndex:index];
//    [self getPlayersDataWithChampionId:item.idField];
//}
#pragma mark - UITableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.players.count>0)
        return 1;
    
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Player * item = self.players[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCellTableViewCell"];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"PlayerCellTableViewCell" owner:self options:nil]objectAtIndex:0];
    
    [((PlayerCellTableViewCell*)cell)initWithPlayer:item];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Player * item = self.players[indexPath.row];
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = item;
    [self.navigationController pushViewController:playerProfileVC animated:YES];
}

-(void)championshipsBtnPressed:(id)sender
{
    ActionSheetStringPicker * actionsheetPicker = [[ActionSheetStringPicker alloc]initWithTitle:@"اختر البطولة"
                                                                                           rows:[self getChampionshipTitles]
                                                                               initialSelection:selectedPickerIndex
                                                                                      doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                                                          [self.activityIndicator startAnimating];
                                                                                          [self.activityIndicator setHidden:NO];
                                                                                          ChampionShipData * item = [self.championships objectAtIndex:selectedIndex];
                                                                                          selectedPickerIndex = selectedIndex;
                                                                                          [self.selectChampionshipBtn setTitle:[NSString stringWithFormat:@"   %@",item.name] forState:UIControlStateNormal];
                                                                                          
                                                                                          [self getPlayersDataWithChampionId:item.idField];
                                                                                          
                                                                                      }
                                                                                    cancelBlock:^(ActionSheetStringPicker *picker) {
                                                                                        NSLog(@"Block Picker Canceled");
                                                                                    }
                                                                                         origin:sender];
    UIBarButtonItem * doneButton=[[UIBarButtonItem alloc]initWithTitle:@"تم" style:UIBarButtonItemStyleDone target:self action:nil];
    [doneButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    UIBarButtonItem * cancelButton=[[UIBarButtonItem alloc]initWithTitle:@"الغاء" style:UIBarButtonItemStyleDone target:self action:nil];
    [cancelButton setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [doneButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [actionsheetPicker setCancelButton:cancelButton];
    [actionsheetPicker setDoneButton:doneButton];
    [[UIToolbar appearance]setTintColor:[UIColor whiteColor]];
    actionsheetPicker.pickerBackgroundColor = [UIColor whiteColor];
    actionsheetPicker.toolbarBackgroundColor = [UIColor darkGrayColor];
    actionsheetPicker.toolbarButtonsColor = [UIColor whiteColor];
    [actionsheetPicker showActionSheetPicker];
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
     if(self.teamId !=0)
    {
        if (velocity.y > 0){
            //NSLog(@"up");
            BOOL scroll= true;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"TeamScrollUpNotification"
             object:userInfo];
            
        }
        if (velocity.y < 0){
            //NSLog(@"down");
            BOOL scroll= false;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
            if(scrollView.contentOffset.y<=0)
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"TeamScrollDownNotification"
                 object:userInfo];
            
        }
    }
}

//[UIColor colorWithRed:0.23 green:0.24 blue:0.24 alpha:1.0]
@end
