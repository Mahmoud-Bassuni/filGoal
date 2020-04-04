//
//  NewScorersViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/7/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "NewScorersViewController.h"
@import Firebase;
@interface NewScorersViewController ()
{
    NSInteger selectedPickerIndex;
}
@end

@implementation NewScorersViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"ScorerHeaderViewCell" owner:self options:nil]objectAtIndex:0];
    // corner raduis for select championship button
    self.selectChampionshipBtn.layer.cornerRadius = 20;
    self.selectChampionshipBtn.clipsToBounds = YES;
    
    if(self.championships.count>0)
    {
        ChampionShipData * item = [self.championships objectAtIndex:0];
        [self.selectChampionshipBtn setTitle:[NSString stringWithFormat:@"   %@",item.name] forState:UIControlStateNormal];
        [self getPlayersDataWithChampionId:item.idField];
        selectedPickerIndex = 0;
        self.screenName = @"iOS - Team Scorers";
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName:@"iOS - Team Scorers"
                                         }];
        self.selectChampionshipBtn.hidden = NO;
        self.dropdownBtn.hidden = NO;
        self.dropDownHeightConstraint.constant = 44;


    }
    else if(self.isFromChampionshipSection)
    {
        self.dropDownHeightConstraint.constant = 0;
        [self getPlayersDataWithChampionId:self.champId];
        self.screenName = @"iOS - Championship Scorers";
        [FIRAnalytics logEventWithName:kFIREventViewItem
                            parameters:@{
                                         kFIRParameterItemName:@"iOS - Championship Scorers"
                                         }];
        self.selectChampionshipBtn.hidden = YES;
        self.dropdownBtn.hidden = YES;
        if(self.champId !=0&&[AppSponsors isChampionCoSponsorActiveUsingId:self.champId])
        {
            NSString * sponsorUrl=[AppSponsors getListingSponsorImagePathUsingChampionId:self.champId andContentType:@"Matches"];

            [self.sponsorImgViewv sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.sponsorImgViewHeightConstraint.constant=image.size.height;

            }];
            
            
            @try {
                if (self.sponsorImgViewv != nil) {
                    self.sponsorImgViewv.tapURL = [AppSponsors activeChampionCoSponsorTapUrlUsingId:self.champId category:@"Matches"];
                }
            }
            @catch (NSException *exception) {
                NSLog(@"SMGL 1: %@", exception.description);
                NSLog(@"SMGL 2: %@", exception.reason);
            }
            @finally {
                NSLog(@"SMGL: Finally condition");
            }
        }
        else
        {
            self.sponsorImgViewv.hidden=YES;
            self.sponsorImgViewHeightConstraint.constant=0;
            self.topTableViewConstraint.constant=10.0;
        }
        self.tableView.tableFooterView = [super setBannerViewFooter:@[@"Inner",@"Championship",[NSString stringWithFormat:@"بطولة %@",_champName]] andPosition:@[@"Pos1"]andScreenName:@"iOS - Team Scorers"];

        
    }
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    NSDictionary * paramDic;
    if(!self.isFromChampionshipSection)
    {
        //team
   paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"TeamId eq %i and Goals gt 0",self.teamId],@"Goals desc, Played"] forKeys:@[@"$filter",@"$orderby"]];
    }
    else
    {
        paramDic=[[NSDictionary alloc]initWithObjects:@[@"Goals gt 0",@"Goals desc, Played"] forKeys:@[@"$filter",@"$orderby"]];
    }
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:ChampionshipScorersAPI,[WServicesManager getSportsEngineApiBaseURL],champId] andParameters:paramDic WithObjectName:@"ScorersList" andAuthenticationType:SportesEngineAPIs success:^(ScorersList * success)
     {
         if(success.data.count>0)
         {
             self.loadingLbl.hidden = YES;
             self.scorers = [[NSArray alloc]initWithArray: success.data];
             [self.tableView reloadData];
          //   [self.tableView layoutIfNeeded];
             self.tableView.hidden = NO;

         }
         else{
             self.loadingLbl.hidden = NO;
             [self.loadingLbl setText:@" لا يوجد هدافون"];
             self.tableView.hidden = YES;
         }
         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Scorers with champion ID = %li ",(long)champId]  ApiError:@"Success"];
         
     }failure:^(NSError *error) {
         self.loadingLbl.hidden = NO;
         [self.loadingLbl setText:@" لا يوجد هدافون"];
         IBGLog(@"Scorer Profile API Error  : %@",error);
         
         [self.activityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Team Scorers with champion ID = %li ",(long)champId] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getPlayersDataWithChampionId:champId];
                                          }];
         
     }];
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

#pragma mark - UITableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scorers.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Scorer * item = self.scorers[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ScorerCell"];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"ScorerCell" owner:self options:nil]objectAtIndex:0];
    
    [((ScorerCell*)cell)initWithCell:item];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    Scorer * item = self.scorers[indexPath.row];
    Player * player = [[Player alloc]init];
    player.playerId = (int)item.idField;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    [appDelegate.getSelectedNavigationController pushViewController:playerProfileVC animated:YES];
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
- (IBAction)championshipsBtnPressed:(id)sender {
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
    if( self.champId != 0)
    {
//        if (targetContentOffset->y > 0){
//            //NSLog(@"up");
//            self.tableView.scrollEnabled=YES;
//        }
//        else if (targetContentOffset->y == 0){
//            self.tableView.scrollEnabled=NO;
//        }
    }
    else     if(self.teamId !=0)
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


@end
