//
//  MoreViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//
//update by abdelrahman elabd Fixed Country issue

#import "MoreViewController.h"
#import "MenuItemCellLoader.h"
#import "SMSViewController.h"
#import "BookmarkPushNotificationsViewController.h"
#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "MoreUserHeaderViewTableViewCell.h"
#import "UserTeamsListViewController.h"
@import Firebase;
@interface MoreViewController ()
    {
        NSArray * cells;
        NSArray * cellImages;
        AppDelegate * appDelegate;
        CountryFooterViewCell * countryFooterCell;
        
    }
    @end

@implementation MoreViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [[SDImageCache sharedImageCache] clearMemory]; // clear memory
    
    [self setTableviewFooter];
    // decative championship
    if(![Global getInstance].appInfo.isChampActive){
        cells = @[@"الأقسام",@"الصور",@"خدمة الرسائل القصيرة",@"الإشعارات المحفوظة",@"الإعدادات",@"أراء حرة مباشرة",@"فرق مفضلة",@"المزيد من التطبيقات"];
        
        cellImages = @[@"section",@"album",@"sms",@"alert",@"setting",@"opinion",@"notification",@"grid"];
    }
    else{
        cells = @[@"البطولات"
                  ,@"الأقسام",@"الصور",@"خدمة الرسائل القصيرة",@"الإشعارات المحفوظة",@"الإعدادات",@"أراء حرة مباشرة",@"فرق مفضلة",@"المزيد من التطبيقات"];
        
        cellImages = @[@"champ",@"section",@"album",@"sms",@"alert",@"setting",@"opinion",@"notification",@"grid"];
        
    }
    
    if(self.isShowed)
    {
        self.isShowed = NO;
        [self showCountriesPopup];
    }
    // [self setScreenSponsor];
    self.screenName=[NSString stringWithFormat:@"iOS- More Screen"];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- More Screen"
                                     }];
    
    //Set TableView
    self.tableView.bounces = YES;
    
}
-(void)viewDidAppear:(BOOL)animated
    {
        //  [self.tableView reloadData];
        [super viewDidAppear:YES];
        MoreUserHeaderViewTableViewCell * headerView = [[[NSBundle mainBundle] loadNibNamed:@"MoreUserHeaderViewTableViewCell" owner:self options:nil]objectAtIndex:0];
        headerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 120);
        self.tableView.tableHeaderView = headerView;
        [self setBannerViewFooter];
        //[super setUpBannerUnderNav:self.view anotherTopView:nil];
        
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
-(void)setScreenSponsor
    {
        AppInfo *appInfo= [Global getInstance].appInfo;
        NSString * sponsorUrl;
        if (appInfo.sponsor.isActive==1) {
            sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
            if (IS_IPHONE_6_PLUS) {
                sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header6plus@3x.png",appInfo.sponsor.imgsBaseUrl];
            }
            else if (IS_IPHONE_6)
            {
                sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header6@2x.png",appInfo.sponsor.imgsBaseUrl];
            }
            else
            {
                sponsorUrl=[NSString stringWithFormat:@"%@/MainSponsor/header5@2x.png",appInfo.sponsor.imgsBaseUrl];
            }
            
            [self.sponsorImg sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.sponsorImgConstraintHeight.constant = 25;
                
            }];
        }
        else{
            self.sponsorImgConstraintHeight.constant = 0;
            
        }
        if([sponsorUrl isEqualToString:@""]||sponsorUrl==nil)
        {
            self.sponsorImgConstraintHeight.constant = 0;
        }
    }
    
-(void)setTableviewFooter
    {
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth-40, 100)];
        self.tableView.tableFooterView.userInteractionEnabled = YES;
        countryFooterCell = [[[NSBundle mainBundle] loadNibNamed:@"CountryFooterViewCell" owner:self options:nil] objectAtIndex:0];
        countryFooterCell.contentView.frame = CGRectMake(0, 0, Screenwidth-40, 100);
        countryFooterCell.frame = CGRectMake(0, 0, Screenwidth-40, 100);
        countryFooterCell.userInteractionEnabled = YES;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSData * checkSelectedOrnot = [prefs objectForKey:@"checkSelectedCountry"];
        
        if (!([checkSelectedOrnot  isEqual: @"true"])){
            NSData * countryData = [prefs objectForKey:COUNTRY];
            Country * countryItem = (Country *)[NSKeyedUnarchiver unarchiveObjectWithData: countryData];
            if(countryItem.flag != nil)
            [countryFooterCell.countryImgView sd_setImageWithURL:[NSURL URLWithString:countryItem.flag] placeholderImage:[UIImage new] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"error:%@",error);
            }];
            
            countryFooterCell.countryNameLbl.text  = [NSString stringWithFormat:@"الدولة : %@",countryItem.name];
        }
        else{
            NSData * countryData = [prefs objectForKey:@"selectedCountry"];
            Country * countryItem = (Country *)[NSKeyedUnarchiver unarchiveObjectWithData: countryData];
            if(countryItem.flag != nil)
            [countryFooterCell.countryImgView sd_setImageWithURL:[NSURL URLWithString:countryItem.flag] placeholderImage:[UIImage new] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"error:%@",error);
            }];
            
            countryFooterCell.countryNameLbl.text  = [NSString stringWithFormat:@"الدولة : %@",countryItem.name];
        }
        [self.tableView.tableFooterView addSubview: countryFooterCell];
        UITapGestureRecognizer * gestureTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(countryPressed:)];
        gestureTap.numberOfTapsRequired = 1;
        [self.tableView.tableFooterView addGestureRecognizer:gestureTap];
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
        [self getTimeOffest];
        countryFooterCell.countryNameLbl.text = [NSString stringWithFormat:@"الدولة : %@",[Global getInstance].country.name];
        
        // cell.countryNameLbl.text = [NSString stringWithFormat:@"الدولة : %@",selectedCountry.name];
    }
    
-(IBAction)countryPressed:(id)sender
    {
        [self showCountriesPopup];
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
        
        

//        NSData * countryData = [prefs objectForKey:COUNTRY];
//        Country * countryItem = (Country *)[NSKeyedUnarchiver unarchiveObjectWithData: countryData];
        
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return cells.count;
    }
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString * cellIdentifier = @"MenuListCustomCell";
        
        MenuItemCellLoader *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuListCustomCell" owner:self options:nil]objectAtIndex:0];
        cell.cellTitleLbl.textColor = [UIColor colorWithRed:0.52 green:0.51 blue:0.51 alpha:1.0];
        cell.selectedBarLbl.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgView.image = [UIImage imageNamed:[cellImages objectAtIndex:indexPath.row]];
        cell.cellTitleLbl.text = [cells objectAtIndex:indexPath.row];
        if(indexPath.row == 0 || indexPath.row == 1)
        {
            cell.arrowImg.hidden = NO;
        }
        else
        cell.arrowImg.hidden = YES;
        
        return cell;
    }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return 60;
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UINavigationController * navigationController = appDelegate.getSelectedNavigationController;
        if([Global getInstance].appInfo.isChampActive){
            if(indexPath.row == 0)
            {
                //Championships
                ChampionsViewController * viewController = [[ChampionsViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 1)
            {
                //Sections
                SectionsViewController * viewController = [[SectionsViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 2)
            {
                //Albums
                GalleriesViewController * viewController = [[GalleriesViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 3)
            {
                //SMS
                SMSViewController * viewController = [[SMSViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 4)
            {
                //Bookmark Notifications
                BookmarkPushNotificationsViewController * viewController = [[BookmarkPushNotificationsViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 5)
            {
                //Settings
                SettingsViewController * viewController = [[SettingsViewController alloc]init];
                [navigationController pushViewController:viewController animated:NO];
            }
            else if(indexPath.row == 6)
            {
                //Authors
                AuthorsViewController * viewController = [[AuthorsViewController alloc]init];
                [navigationController pushViewController:viewController animated:NO];
            }
            else if(indexPath.row == 7)
            {
                UserTeamsListViewController * viewController = [[UserTeamsListViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 8)
            {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/artist/sarmady-communications-company/id374210176?mt=8&ign-mpt=uo%3D2"]];
            }
        }
        else{
            if(indexPath.row == 0)
            {
                //Sections
                SectionsViewController * viewController = [[SectionsViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 1)
            {
                //Albums
                GalleriesViewController * viewController = [[GalleriesViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 2)
            {
                //SMS
                SMSViewController * viewController = [[SMSViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 3)
            {
                //Bookmark Notifications
                BookmarkPushNotificationsViewController * viewController = [[BookmarkPushNotificationsViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 4)
            {
                //Settings
                SettingsViewController * viewController = [[SettingsViewController alloc]init];
                [navigationController pushViewController:viewController animated:NO];
            }
            else if(indexPath.row == 5)
            {
                //Authors
                AuthorsViewController * viewController = [[AuthorsViewController alloc]init];
                [navigationController pushViewController:viewController animated:NO];
            }
            else if(indexPath.row == 6)
            {
                UserTeamsListViewController * viewController = [[UserTeamsListViewController alloc]init];
                [navigationController pushViewController:viewController animated:YES];
            }
            else if(indexPath.row == 7)
            {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/artist/sarmady-communications-company/id374210176?mt=8&ign-mpt=uo%3D2"]];
            }
        }
    }
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat maxOffset = (scrollView.contentSize.height - scrollView.frame.size.height);
    CGFloat originOffset = 0;
    
    // Don't scroll below the last cell. - Bottom
    if (scrollView.contentOffset.y >= maxOffset) {
        //scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, maxOffset);
        
        // Don't scroll above the first cell. - Top
    } else if (scrollView.contentOffset.y <= originOffset) {
        scrollView.contentOffset = CGPointZero;
    }
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
         } failure:^(NSError *error) {
             
             
         }];
        
    }
- (IBAction)loginBtnPressed:(id)sender {
    LoginViewController * viewController = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}
    
- (IBAction)registerBtnPressed:(id)sender {
    RegisterViewController * viewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}
    
-(void)setBannerViewFooter
    {
        
        self.bannerVieww=[[DFPBannerView alloc]initWithAdSize:kGADAdSizeBanner];;
        self.bannerVieww.adUnitID = MeduimRectangle_AD_UNIT_ID;
        self.bannerVieww.delegate = self;
        self.bannerVieww.rootViewController = self;
        DFPRequest *request = [DFPRequest request];
        //setTargeting('Keyword', ['Home', 'Inner']).setTargeting('Position', ['Pos1'])
        //  request.customTargeting = [[NSDictionary alloc]initWithObjects:@[keywords,postions] forKeys:@[@"Keyword",@"Position"]];
        // Initiate a generic request to load it with an ad.
        [self.bannerVieww loadRequest:request];
        [_footerView addSubview:_bannerVieww];
        
    }
-(void)adViewDidReceiveAd:(GADBannerView *)bannerView
    {
        NSLog(@"Banner adNetworkClassName %@",bannerView.adNetworkClassName);
        
    }
-(void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
    {
        IBGLog(@"Banner Error : %@",error.description);
        
    }
    
    @end
