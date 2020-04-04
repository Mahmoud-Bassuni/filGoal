//
//  SettingsViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 6/1/15.
//  Copyright (c) 2015 MohamedMansour . All rights reserved.
//

#import "SettingsViewController.h"
#import "NotificationCustomCell.h"
#import "WebViewViewController.h"
#import "Global.h"
#import "TutorialViewController.h"
#import "Constants.h"
#import "CountriesViewController.h"
#import "MZFormSheetController.h"
#import "MZFormSheetSegue.h"
#import "CountryTableViewCell.h"
@interface SettingsViewController ()<MZFormSheetBackgroundWindowDelegate,MZFormSheetControllerTransition>
    {
        NSMutableArray * cellTitles;
        NSInteger selectedIndex;
        NSArray * firstSectionCellTitles;
        BOOL isSelected;
        
    }
    @end

@implementation SettingsViewController
    
- (void)viewDidLoad {
    self.screenName=@"iOS-Settings";
    [super viewDidLoad];
    isSelected = NO;
    firstSectionCellTitles=@[@"اختر الدولة"];
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"IS_NOTIFICATION_ACTIVE"]==NO&&[[NSUserDefaults standardUserDefaults]objectForKey:@"IS_NOTIFICATION_ACTIVE"]!=nil)
    {
        [self.notificationSwitch setOn:NO];
    }
    //get Tags List for current device
    UILabel * versionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 60)];
    [versionLabel setTextColor:[UIColor darkGrayColor]];
    [versionLabel setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:11.0]];
    [versionLabel setTextAlignment:NSTextAlignmentCenter];
    [versionLabel setText:[NSString stringWithFormat:@"version %@",[self versionBuild]]];
    self.tableView.tableFooterView=versionLabel;
    
    if(self.isShowed)
    {
        self.isShowed = NO;
        [self showCountriesPopup];
    }
    [super setUpBannerUnderNav:self.view anotherTopView:nil];
    
}
-(void)viewDidAppear:(BOOL)animated
    {
        [super viewDidAppear:YES];
        //self.title = @"الإعدادات";
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *) build
    {
        return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    }
    
- (NSString *) versionBuild
    {
        NSString * version = [super appVersion];
        NSString * build = [self build];
        
        NSString * versionBuild = [NSString stringWithFormat: @"%@", version];
        
        if (![version isEqualToString: build]) {
            versionBuild = [NSString stringWithFormat: @"%@(%@)", versionBuild, build];
        }
        
        return versionBuild;
    }
#pragma mark - Switch Changed
-(void)switchChanged:(UISwitch*)sender
    {
        if(!sender.on)
        {
            [Netmera setEnabledReceivingPushNotifications:NO];
        }
        else
        [Netmera setEnabledReceivingPushNotifications:YES];
    }
#pragma - mark UItableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
    {
        return 20;
    }
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //set background View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    view.backgroundColor=[UIColor clearColor];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(-8, 0, tableView.frame.size.width, 18)];
    [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:13.0]];
    // [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:14]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentRight];
    [title setBackgroundColor:[UIColor clearColor]];
    
    if (section==0) {
        if(self.notificationSwitch.isOn)
        
        title.text=@"الاشعارات";
        else
        title.text=@"";
        
        [view addSubview:title];
    }
    
    else if (section==1){
        
        title.text=@"اخري";
        [view addSubview:title];
    }
    
    
    return view;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 3;
    }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 1 || section == 0)
    return 1;
    else
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if(indexPath.section==0)
        return 45.0;
        else
        return 44.0;
    }
    
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *simpleTableIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            
        }
        
        if(indexPath.section==0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NotificationCustomCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
            ((NotificationCustomCell*)cell).cellTitle.text=@"تفعيل الاشعارات";
            // ((NotificationCustomCell*)cell).notificationSwitch =[[UISwitch alloc]init];
            [((NotificationCustomCell*)cell).notificationSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventTouchUpInside];
            [((NotificationCustomCell*)cell).notificationSwitch setTag:indexPath.row];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section == 1)
        {
            if(indexPath.row==0&&[[NSUserDefaults standardUserDefaults]objectForKey:COUNTRY]!=nil)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"CountryTableViewCell"];
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CountryTableViewCell" owner:self options:nil];
                cell = [topLevelObjects objectAtIndex:0];
                //((CountryTableViewCell*)cell).countryNameLbl.text = [[NSUserDefaults standardUserDefaults]objectForKey:COUNTRY];
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                NSData * checkSelectedOrnot = [prefs objectForKey:@"checkSelectedCountry"];
                if (!([checkSelectedOrnot  isEqual: @"true"])){
                    NSData * countryData = [prefs objectForKey:COUNTRY];
                    Country * countryItem = (Country *)[NSKeyedUnarchiver unarchiveObjectWithData: countryData];
                    
                    if(countryItem.flag != nil)
                    [((CountryTableViewCell*)cell).flagImgView sd_setImageWithURL:[NSURL URLWithString:countryItem.flag]];
                    
                    ((CountryTableViewCell*)cell).countryNameLbl.text  = [NSString stringWithFormat:@"الدولة : %@",countryItem.name];
                }
                else{
                    NSData * countryData = [prefs objectForKey:@"selectedCountry"];
                    Country * countryItem = (Country *)[NSKeyedUnarchiver unarchiveObjectWithData: countryData];
                    if(countryItem.flag != nil)
                    [((CountryTableViewCell*)cell).flagImgView sd_setImageWithURL:[NSURL URLWithString:countryItem.flag] placeholderImage:[UIImage new] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        NSLog(@"error:%@",error);
                    }];
                    
                    ((CountryTableViewCell*)cell).countryNameLbl.text = [NSString stringWithFormat:@"الدولة : %@",countryItem.name];
                    
                }
            }
            else
            {
                cell.textLabel.text=[firstSectionCellTitles objectAtIndex:indexPath.row];
                
            }
        }
        else if (indexPath.section==2)
        {
            if(indexPath.row==0)
            cell.textLabel.text=@"شرح توضيحي";
            else
            cell.textLabel.text=@"عن الشركة";
        }
        
        
        cell.textLabel.font =   [UIFont fontWithName:@"DINNextLTW23Regular" size:14.0];
        cell.textLabel.textColor=[UIColor darkGrayColor];
        cell.textLabel.textAlignment=NSTextAlignmentRight;
        return cell;
    }
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if(indexPath.section==2&&indexPath.row==1)
        {
            [self.navigationController pushViewController:[[WebViewViewController alloc]init] animated:YES];
        }
        else  if(indexPath.section==2&&indexPath.row==0)
        {
            [self.navigationController pushViewController:[[TutorialViewController alloc]init] animated:YES];
            
        }
        else if(indexPath.section == 1)
        {
            if(indexPath.section==1&&indexPath.row==0)
            {
                
                [self showCountriesPopup];
                id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
                
                [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"iOS-Settings"     // Event category (required)
                                                                      action: @"Show-Countries-List" // Event action (required)
                                                                       label: @"SelectCountry" value:nil] build]];
                
            }
        }
        
    }
-(void)showCountriesPopup
    {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
               Country *countryItem = [[Country alloc]init];
               NSData * checkSelectedOrnot = [prefs objectForKey:@"checkSelectedCountry"];
               
               if (!([checkSelectedOrnot  isEqual: @"true"])){
                          NSData * countryData = [prefs objectForKey:COUNTRY];
                          countryItem = (Country *)[NSKeyedUnarchiver unarchiveObjectWithData: countryData];
                      }
                      else{
                          NSData * countryData = [prefs objectForKey:@"selectedCountry"];
                          countryItem = (Country *)[NSKeyedUnarchiver unarchiveObjectWithData: countryData];
                      }
               
        
        
        [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
        [[MZFormSheetBackgroundWindow appearance] setBlurRadius:9.0];
        [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
        CountriesViewController * countriesVC = [[CountriesViewController alloc]init];
        countriesVC.delegate = self;
        countriesVC.selectedCountryName = countryItem.name;
        countriesVC.view.frame = CGRectMake(10.0, 0.0, 100.0, 100.0);
        MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:countriesVC];
        
        formSheet.presentedFormSheetSize = CGSizeMake(Screenwidth-40, 300);
        //    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromTop;
        formSheet.shadowRadius = 2.0;
        formSheet.shadowOpacity = 0.3;
        formSheet.shouldDismissOnBackgroundViewTap = YES;
        formSheet.shouldCenterVertically = YES;
        formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
        formSheet.transitionStyle = MZFormSheetTransitionStyleCustom;
        
        [MZFormSheetController sharedBackgroundWindow].formSheetBackgroundWindowDelegate = self;
        
        [self mz_presentFormSheetController:formSheet animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
            
        }];
    }
    
    
#pragma mark - country picker
- (void) didSelectCountryObj:(Country*)country
    {
        
        NSData *selectedCountryObject = [NSKeyedArchiver archivedDataWithRootObject:country];
        NSString *valueToSave = @"true";
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"checkSelectedCountry"];
        [[NSUserDefaults standardUserDefaults] setObject:selectedCountryObject forKey:@"selectedCountry"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Global getInstance].country=country;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        //NSData *selectedCountryObject = [NSKeyedArchiver archivedDataWithRootObject:[Global getInstance].country];
        [prefs setObject:selectedCountryObject forKey:COUNTRY];
        //[[NSUserDefaults standardUserDefaults]synchronize];
        
        [self getTimeOffest];
        isSelected=YES;
        CountryTableViewCell * cell= [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.countryNameLbl.text = [NSString stringWithFormat:@"الدولة : %@",country.name];
    }
    
    
#pragma mark - Get time Offset API using IP
-(void)getTimeOffest
    {
        NSDictionary * parameters=[[NSDictionary alloc]initWithObjects:@[[Global getInstance].country.ip] forKeys:@[@"ip"]];
        [WServicesManager getDataWithURLString:kGetAreaDetails andParameters:parameters WithObjectName:@"AreaDetails" andAuthenticationType:NoAuth success:^(AreaDetails * areaDetails)
         {
             [Global getInstance].timeZone=areaDetails.timezone;
             [Global getInstance].timeOffset=[areaDetails.timezone floatValue];
             NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
             NSData *selectedCountryObject = [NSKeyedArchiver archivedDataWithRootObject:[Global getInstance].country];
             [prefs setObject:selectedCountryObject forKey:COUNTRY];
             [prefs setObject:[NSString stringWithFormat:@"%f",[Global getInstance].timeOffset]   forKey:TIME_OFFSET];
             [[NSUserDefaults standardUserDefaults]setFloat:[Global getInstance].timeOffset forKey:TIME_OFFSET];
             [[NSUserDefaults standardUserDefaults]setObject:[areaDetails.code uppercaseString] forKey:@"SponsorCountryCode"];
             [[NSUserDefaults standardUserDefaults]setBool:NO  forKey:@"IsMessageShowed"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
             [appDelegate setTabBarViewController];
             //  [appDelegate setRootViewController:[[HomeViewController alloc]initHomeViewWithSectionId:0 andChampions:@[]]];
         } failure:^(NSError *error) {
             
             
         }];
        
    }
    
    
    @end
