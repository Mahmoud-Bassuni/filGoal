//
//  WeekMatchesViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/26/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "WeekMatchesViewController.h"
#import "UIImageView+WebCache.h"
#import "MatchesByDateViewController.h"
#import "CalendarViewController.h"
#import "UINavigationBar+Awesome.h"
#import "FilGoalIOS-Swift.h"
#import <Masonry/Masonry.h>
#import "SpecialSponsorUrl.h"


@import Firebase;
@interface WeekMatchesViewController ()
{
    TabsViewController * tabsViewController;
    CustomIOSAlertView * alertView;
    CalendarViewController * calendarViewController;
    UIButton * filterMatches;
    ActionSheetDatePicker * picker;
}

@property (strong, nonatomic) UIView *testView;
@property (strong, nonatomic) UIImageView *testViewImageV;
@property (strong, nonatomic) UIImage *testViewImage;
@property BOOL hideSponsorBanner;
@end

@implementation WeekMatchesViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTabIndex:) name:@"SetTabIndex" object:nil];

    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"مباريات";
    self.screenName=[NSString stringWithFormat:@"iOS- Week Matches"];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- Week Matches"
                                     }];
    self.tabsView.hidden = NO;
    [self createNavigationFilterBtn];
    
}
-(void)setTabIndex:(NSNotification*)note{
    NSDictionary * userInfo = [note userInfo];
    self.isFromWidget = [[userInfo objectForKey:@"isFrom"]boolValue];
    self.selectedTabIndex = [[userInfo objectForKey:@"selectedIndex"]intValue];;
    [[NSNotificationCenter defaultCenter]removeObserver:@"SetTabIndex"];
    if(self.pageMenu.controllerArray.count>0 || self.pageMenu != nil){
        if(self.isFromWidget)
        {
            if(self.selectedTabIndex == 1)
                [self.pageMenu moveToPage:self.childViewControllers.count-3];
            if(self.selectedTabIndex == 0)
                [self.pageMenu moveToPage:self.childViewControllers.count-4];
            if(self.selectedTabIndex == 2)
                [self.pageMenu moveToPage:self.childViewControllers.count-2];
        }
        else
            [self.pageMenu moveToPage:self.childViewControllers.count-3];
    }

}
-(void)viewDidAppear:(BOOL)animated {
      if(self.pageMenu.controllerArray == 0 || self.pageMenu == nil)
    {
        [self createTabsView];
    }
    if(self.navigationController.viewControllers.count>1)
    {
        [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
       // self.title = @"مباريات";
    }
    else
        [self setMainSponsor];
    
    [self setUpBannerUnderNav:self.view anotherTopView:nil];
}

//This Is The Same As The Ones On ParentViewController
-(void)changeSponsorImage:(UIImage*)image   {
    if (self.testView != nil && self.testViewImageV != nil) {
        UIImage *newImage = [image resizeImageScaledToWidthWithWidth:self.view.frame.size.width];
        /*[self.testView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(newImage.size.height);
         make.width.mas_equalTo(newImage.size.width);
         }];*/
        
        MASViewAttribute *topAttri = self.testView.mas_top;
        MASViewAttribute *bottomAttri = self.testView.mas_bottom;
        
        [self.testView removeConstraints:self.testView.constraints];
        [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topAttri);
            make.bottom.equalTo(bottomAttri);
            make.width.mas_equalTo(newImage.size.width);
            make.height.mas_equalTo(newImage.size.height);
        }];
        
        self.testViewImageV.image = newImage;
        
        [self.view layoutIfNeeded];
    }
}

-(void)setUpBannerUnderNav:(UIView*)fullView anotherTopView:(nullable UIView*)anotherTopView {
    //[self.testViewImage resizeImageScaledToWidthWithWidth:100];
    if (self.testView == nil && self.testViewImageV == nil && self.hideSponsorBanner != YES) {
        
        //Constants
        int height = 0;//self.testViewImage.size.height; //60;
        int width = self.view.frame.size.width;
        
        
        //The View
        self.testView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
        self.testView.translatesAutoresizingMaskIntoConstraints = NO;
        self.testView.backgroundColor = [UIColor blackColor]; //[UIColor orangeColor];
        self.testView.layer.masksToBounds = NO;
        self.testView.layer.shadowOffset = CGSizeMake(.0f,3.0f); //2.5f
        self.testView.layer.shadowRadius = 1.5f; //1.5f;
        self.testView.layer.shadowOpacity = .9f; //.9f;
        self.testView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.testView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.testView.bounds].CGPath;
        self.testView.userInteractionEnabled = YES;

        
        //The ImageView
        self.testViewImageV = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
        self.testViewImageV.translatesAutoresizingMaskIntoConstraints = NO;
        self.testViewImageV.clipsToBounds = YES;
        self.testViewImageV.backgroundColor = [UIColor colorWithWhite:0.19 alpha:0.85]; //[UIColor colorWithWhite:0.15 alpha:0.85]; status bar color
        self.testViewImageV.userInteractionEnabled = YES;
        
        
        //The Tap Gesture
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sponsorButtonTapped:)];
        [self.testViewImageV addGestureRecognizer:tapGesture];
        
        
        //Functions
        [self setNavigationBarBackgroundImage]; //[self setSponsors];
        [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
        
        
        //Add
        [self.testView addSubview: self.testViewImageV];
        [fullView addSubview: self.testView];//[self.view addSubview: self.testView];
        
        
        //The ImageView Constraint
        [self.testViewImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.testView);
        }];
        [fullView layoutIfNeeded];
        
        
        if (anotherTopView == nil) { //1st case - WORKING
            //for (int i = 0; i < fullView.constraints.count; i++){ NSLayoutConstraint *constraint = [fullView.constraints objectAtIndex:i];
            for (NSLayoutConstraint *constraint in fullView.constraints) {
                //NSLog(@"---- constraint: %@ \n", constraint);
                if ([self isTopConstraint:constraint topView:fullView]) {
                    //NSLog(@"-------- Result Constraint: %@ \n", constraint);
                    
                    //NSLayoutConstraint *newConstraint;
                    if (constraint.firstItem == fullView) {
                        //newConstraint.firstItem = testView;
                        [fullView removeConstraint:constraint];
                        
                        [self.testView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo([(UIView*)constraint.firstItem mas_top]);//mas_bottom
                            make.bottom.equalTo([(UIView*)constraint.secondItem mas_top]);
                            make.height.mas_equalTo(self.testViewImage == nil ? height : self.testViewImage.size.height);
                            make.width.mas_equalTo(width);
                        }];
                        break;
                    } else if (constraint.secondItem == fullView) {
                        //newConstraint.secondItem = testView;
                        [fullView removeConstraint:constraint];
                        
                        
                        [self.testView mas_remakeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo([(UIView*)constraint.secondItem mas_top]);
                            make.bottom.equalTo([(UIView*)constraint.firstItem mas_top]);
                            make.height.mas_equalTo(self.testViewImage == nil ? height : self.testViewImage.size.height);
                            make.width.mas_equalTo(width);
                        }];
                        break;
                    }
                }
            }
            [fullView layoutIfNeeded];
            
        } else { //2nd case - NOT WORKING
            
            for (int i = 0; i < fullView.constraints.count; i++){
                NSLayoutConstraint *constraint = [fullView.constraints objectAtIndex:i];
                //NSLog(@"---- constraint: %@ \n", constraint);
                if ([self isTopConstraint:constraint topView:anotherTopView]) {
                    //NSLog(@"-------- Result Constraint: %@ \n", constraint);
                    
                    NSLayoutConstraint *newConstraint; //= constraint;
                    if (constraint.firstItem == anotherTopView) {
                        //newConstraint.firstItem = testView;
                        newConstraint = [NSLayoutConstraint constraintWithItem:constraint.firstItem attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.testView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
                        newConstraint.identifier = @"OurNewConstraint";
                        [fullView removeConstraint:constraint];
                        [fullView addConstraint:newConstraint];
                    } else if (constraint.secondItem == anotherTopView) {
                        //newConstraint.secondItem = testView;
                        newConstraint = [NSLayoutConstraint constraintWithItem:self.testView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:constraint.secondItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
                        newConstraint.identifier = @"OurNewConstraint";
                        [fullView removeConstraint:constraint];
                        [fullView addConstraint:newConstraint];
                    }
                }
            }
            [fullView layoutIfNeeded];
        }
        
    } else {
        [self setNavigationBarBackgroundImage];//[self setSponsors];
    }
}

- (BOOL)isTopConstraint:(NSLayoutConstraint *)constraint topView:(UIView*)topView
{
    //return  [self firstItemMatchesTopConstraint:constraint] ||
    //[self secondItemMatchesTopConstraint:constraint];
    return [self firstItemMatchesTopConstraint:constraint topView:topView] || [self secondItemMatchesTopConstraint:constraint topView:topView];
}

- (BOOL)firstItemMatchesTopConstraint:(NSLayoutConstraint *)constraint topView:(UIView*)topView
{
    return constraint.firstItem == topView && constraint.firstAttribute == NSLayoutAttributeTop;
}

- (BOOL)secondItemMatchesTopConstraint:(NSLayoutConstraint *)constraint topView:(UIView*)topView
{
    return constraint.secondItem == topView && constraint.secondAttribute == NSLayoutAttributeTop;
}

-(void)sponsorButtonTapped:(UITapGestureRecognizer*)sender {
    //Testing Purpose
    //self.champs_id = 815;
    //self.section_id = 44;
    //self.activeCategory = @"album";
    
    //Start
    NSString *urlWillOpen;     //Will set it inside that cases
    Sponsorship *sponsorShip = [Global getInstance].appInfo.sponsorship.firstObject;
    
    //Check special_sponsor - Check if the current championship has sponsor
    if (self.champs_id != nil) {
        NSArray *filteredArray = [sponsorShip.mainSponsor.specialSponsor.champsUrl filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            if ([(SpecialSponsorUrl*)evaluatedObject idField] == self.champs_id) {
                return YES; //Same Id, then this is the one
            }
            return NO;  //Not the same id, then ignore it
        }] ];
        
        if (filteredArray.firstObject != nil) {
            urlWillOpen = [(SpecialSponsorUrl*)filteredArray.firstObject url];
        }
    }
    //Check special_sponsor - Check if the current section has sponsor
    else if (self.section_id != nil) {
        NSArray *filteredArray = [sponsorShip.mainSponsor.specialSponsor.sectionUrl filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            if ([(SpecialSponsorUrl*)evaluatedObject idField] == self.section_id) {
                return YES; //Same Id, then this is the one
            }
            return NO;  //Not the same id, then ignore it
        }] ];
        
        if (filteredArray.firstObject != nil) {
            urlWillOpen = [(SpecialSponsorUrl*)filteredArray.firstObject url];
        }
    }
    //Check Category - Matches, Albums, News, Videos
    else if ( [[self.activeCategory lowercaseString] containsString: @"album"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.albumsUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"match"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.matchesUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"new"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.newsUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"video"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.videosUrl;
        
    } else if ( [[self.activeCategory lowercaseString] containsString: @"free"] ) {
        urlWillOpen = sponsorShip.mainSponsor.perContentTypeSponsor.freeOpinionsUrl;
        
    }
    //Check app_sponsor - The General Case and its the last
    if ( urlWillOpen == nil) {
        //Open App Global Sponsor
        urlWillOpen = sponsorShip.mainSponsor.appSponsor.appBarUrl;
        
    }
    
    
    //Open The URL
    if (urlWillOpen != nil) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlWillOpen]];
    }
}

//This Sets The New Sponsor Banner
-(void)setFilGoalNavigationBar
{
    [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    if (IS_IPHONE_4) {
        //self.testViewImageV.image = [UIImage imageNamed:@"Nav4"];
    } else if(IS_IPHONE_5) {
        //self.testViewImageV.image = [UIImage imageNamed:@"Nav5"];
    } else if (IS_IPHONE_6) {
        //self.testViewImageV.image = [UIImage imageNamed:@"Nav6"];
    } else {
        //self.testViewImageV.image = [UIImage imageNamed:@"Nav6+"] ;
    }
}
//This Sets The New Sponsor Banner
-(void)setNavigationBarBackgroundImage
{
    [self setFilGoalNavigationBar];
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //Using NavigationBar
                //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];.
                //Using New SponsorBanner
                //self.testViewImageV.image = image;
                self.testViewImage = image;
                [self changeSponsorImage: image];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (image && finished) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //Commented beacuse this line was somehow decreassing the image quality when it was getting retrived
                            //[[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                            
                            //Using NavigationBar
                            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                            //Using New SponsorBanner
                            //self.testViewImageV.image = image;
                            self.testViewImage = image;
                            [self changeSponsorImage: image];
                        });
                    }
                }];
            });
        }
    }
}
/// ===== ===== ===== ===== ===== End End End ===== ===== ===== ===== =====

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)createTabsView
{
    self.childViewControllers=[[NSMutableArray alloc]init];
    NSDictionary * dateDic = [self getWeekDates];
    NSArray * dates = [dateDic objectForKey:@"Dates"];
    NSArray * otherDates = [dateDic objectForKey:@"BeforeDates"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDateFormatter * outputFormat = [[NSDateFormatter alloc] init];
    outputFormat.dateFormat = @"EEEE dd MMMM";
    [outputFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ar"]];
    
    for(int i= (int) dates.count-1 ; i>=0 ; i--)
    {
        MatchesByDateViewController * viewController = [[MatchesByDateViewController alloc]init];
        viewController.selectedDateStr = [formatter stringFromDate:dates[i]];
        viewController.dayBeforeSelectedDateStr = [formatter stringFromDate:otherDates[i]];
        viewController.title =  [outputFormat stringFromDate:dates[i]];
        viewController.index = i;
        viewController.isFromMatchesView = YES;
        [self.childViewControllers addObject:viewController];
    }
    self.tabsView.hidden = YES;
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor:[UIColor mainAppYellowColor],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionMenuItemFont:[UIFont defaultMeduimFontOfSize:14.0],
                                 CAPSPageMenuOptionMenuHeight: @(50.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(90.0),
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor greyColor], CAPSPageMenuOptionMenuItemWidthBasedOnTitleTextWidth:@(YES),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES),
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor blackColor]
                                 };
    self.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:self.childViewControllers frame:CGRectMake(0.0, 0.0,Screenwidth, self.tabsView.frame.size.height) options:parameters];
    self.pageMenu.delegate=self;
    // self.pageMenu.currentPageIndex = self.childViewControllers.count-3;
    if(self.isFromWidget)
    {
        if(self.selectedTabIndex == 1)
            [self.pageMenu moveToPage:self.childViewControllers.count-3];
        if(self.selectedTabIndex == 0)
            [self.pageMenu moveToPage:self.childViewControllers.count-4];
        if(self.selectedTabIndex == 2)
            [self.pageMenu moveToPage:self.childViewControllers.count-2];
    }
    else
        [self.pageMenu moveToPage:self.childViewControllers.count-3];
    
    [self.tabsView addSubview:_pageMenu.view];
    self.tabsView.hidden = NO;
}
#pragma mark - PageMenu Delegate
- (void)willMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    
}

- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
-(void)createNavigationFilterBtn
{
    filterMatches = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterMatches setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    filterMatches.bounds = CGRectMake(40,-1,30,30);
    [filterMatches addTarget:self action:@selector(filterMatchesUsingDate:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:filterMatches];
    
    [filterMatches addTarget:self action:@selector(filterMatchesUsingDate:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)filterMatchesUsingDate:(id)sender
{
    picker = [[ActionSheetDatePicker alloc]initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] target:self action:@selector(getMatchesByDate:) origin:sender];
    picker.toolbarBackgroundColor = [UIColor darkGrayColor];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTintColor:[UIColor darkGrayColor]];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"إلغاء" forState:UIControlStateNormal];
    [cancelButton setFrame:CGRectMake(0, 0, 32, 32)];
    [picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:cancelButton]];
    UIButton * doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // [doneButton addTarget:self action:@selector(getMatchesByDate:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTintColor:[UIColor darkGrayColor]];
    [doneButton setTitle:@"تم" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setFrame:CGRectMake(0, 0, 32, 32)];
    [picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:doneButton]];
    [picker showActionSheetPicker];
    
}
-(void)getMatchesByDate:(NSDate *)selectedDate
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:selectedDate];
    [components setDay:[components day]-1];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSDate * afterDate = [gregorian dateFromComponents:components];
    MatchesByDateViewController * viewController = [[MatchesByDateViewController alloc]init];
    viewController.selectedDateStr = [outputFormatter stringFromDate:selectedDate];
    viewController.dayBeforeSelectedDateStr = [outputFormatter stringFromDate:afterDate];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(NSDictionary *) getWeekDates
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[NSDate date]];
    NSDateComponents * otherComponents = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[NSDate date]];
    
    [otherComponents setDay:[otherComponents day]-3];
    [otherComponents setMonth:[otherComponents month]];
    [otherComponents setYear:[otherComponents year]];
    NSDate * dayBeforeStartDate = [gregorian dateFromComponents:otherComponents];
    [components setDay:[components day]-2];
    [components setMonth:[components month]];
    [components setYear:[components year]];
    NSDate * startDate = [gregorian dateFromComponents:components];
    [components setDay:[components day]+6];
    NSDate * endDate = [gregorian dateFromComponents:components];
    components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:endDate];
    [components setDay:[components day]-1];
    NSDate * beforeEndDate = [gregorian dateFromComponents:components];
    
    NSMutableArray * dates = [@[startDate] mutableCopy];
    NSMutableArray * otherDates = [@[dayBeforeStartDate] mutableCopy];
    
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * weekComponents = [gregorianCalendar components:NSCalendarUnitDay
                                                             fromDate:startDate
                                                               toDate:endDate
                                                              options:0];
    
    for (int i = 1; i < weekComponents.day; ++i) {
        NSDateComponents *newComponents = [NSDateComponents new];
        newComponents.day = i;
        
        NSDate *date = [gregorianCalendar dateByAddingComponents:newComponents
                                                          toDate:startDate
                                                         options:0];
        newComponents.day -= 1;
        NSDate * dayBeforeDate = [gregorianCalendar dateByAddingComponents:newComponents
                                                                    toDate:startDate
                                                                   options:0];
        [dates addObject:date];
        [otherDates addObject:dayBeforeDate];
    }
    [dates addObject:endDate];
    [otherDates addObject:beforeEndDate];
    
    return [[NSDictionary alloc]initWithObjects:@[dates,otherDates] forKeys:@[@"Dates",@"BeforeDates"]];
    
}
#pragma mark - setNavigationBar Image
// Sponsors
-(void)setMainSponsor
{
    NSString * mainSponsorUrl=[[NSString alloc]init];
    if([AppSponsors isMatchSponsorContentActive])
    {
        mainSponsorUrl = [NSString stringWithFormat:@"%@",[AppSponsors getNavigationBarMainSponsorPerContentType: @"Matches"]];
        self.activeCategory = @"Matches";
    }
    else if([AppSponsors isAppNavigationbarSponsorActive])
    {
        mainSponsorUrl = [AppSponsors getAppNavigationbarSponsorImagePath];
    }
    [self setNavigationBarBackgroundImage: mainSponsorUrl];
}

-(void)setNavigationBarBackgroundImage:(NSString*)mainSponsorUrl
{
    [self setFilGoalNavigationBar];
    //Make it stop setting the NavBar 
    /*UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:mainSponsorUrl];
    if(image!=nil)
    {
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:mainSponsorUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[SDImageCache sharedImageCache] storeImage:image forKey:mainSponsorUrl toDisk:YES];
                    [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                });
            }
        }];
    }*/
}

/*
-(void)setFilGoalNavigationBar
{
    [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    if(IS_IPHONE_4)
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
    else if(IS_IPHONE_5)
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
    else if (IS_IPHONE_6)
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
    else
        [GetAppDelegate().getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
}
*/

@end
