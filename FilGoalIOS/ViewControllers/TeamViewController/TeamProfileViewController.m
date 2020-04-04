//
//  TeamProfileViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 7/27/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//
#import "FilGoalIOS-Swift.h"

#import "TeamProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "PlayersViewController.h"
#import "NewScorersViewController.h"
#import "UINavigationBar+Awesome.h"
#import "UINavigationController+Transparency.h"
#import "LoginViewController.h"
#import "SVModalWebViewController.h"
#import <SafariServices/SafariServices.h>


#define NAVBAR_CHANGE_POINT 0

@interface TeamProfileViewController ()
{
    NSString * websiteUrl;
    AppDelegate * appDelegate;
    CGFloat tabsViewHeight;
    BOOL isViewLoaded;
    UIButton * favButton;
}
@end

@implementation TeamProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getChampionsData];
    [self getTeamData];
    [self setRoundCornersForImages];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.teamProfileTabs = [[TeamProfileTabsViewController alloc]init];
    [self setNavigationBtns];
    [self setBlackOverlay];
    tabsViewHeight = 600;
    isViewLoaded = YES;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(translateViewToTop:) name:@"TeamScrollUpNotification" object:nil];
    
    //self.topScrollViewConstraint.constant = -44;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.infoView.hidden=NO;
    
    //NavigationBar
    self.title = @"";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
    

    if(isViewLoaded)
    {
        isViewLoaded=NO;
    }
    else
    {
        
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if(_isEditMode)
    {
        _isEditMode = NO;
        [self addTeamToFavoritesBtnPressed:self];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setNavigationBarBackgroundImage];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y > 0){
        //self.title = self.teamName;
        //[self.navigationController.navigationBar lt_setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    }
    else
    {
        //NavigationBar
        self.title = @"";
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        self.navigationController.navigationBar.translucent = YES;
    }
}

#pragma mark - Right Navigation Buttons
-(void)setNavigationBtns
{
    // Add rightbar button to refresh match details view
    favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favButton.bounds = CGRectMake(Screenwidth-20, 0, 19, 16);
    if([[UserMethods getTeamEventsIdsUsingTeamId:self.teamId]count]>0)
        [favButton setBackgroundImage:[UIImage imageNamed:@"followH"] forState:UIControlStateNormal];
    else
        [favButton setBackgroundImage:[UIImage imageNamed:@"follow"] forState:UIControlStateNormal];
    
    [favButton addTarget:self action:@selector(addTeamToFavoritesBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    shareBtn.bounds = CGRectMake(Screenwidth-40, 0, 16, 18);
    [shareBtn addTarget:self action:@selector(shareBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems=@[ [[UIBarButtonItem alloc] initWithCustomView:favButton], [[UIBarButtonItem alloc] initWithCustomView:shareBtn]];
}



#pragma mark - Get Team Data API
-(void) getTeamData
{
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"Id eq %i",self.teamId],@"CareerData($filter=PersonTypeId eq 2)"] forKeys:@[@"$filter",@"$expand"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:TeamProfileAPI,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"TeamProfile" andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         self.teamProfile = success;
         self.teamProfileTabs.teamId = self.teamId;
         [self.largeActivityIndicator stopAnimating];
         [self initWithCell:self.teamProfile];
         
         // [self.tableView reloadData];
     }failure:^(NSError *error) {
         IBGLog(@"Player Profile API Error  : %@",error);
         [self.largeActivityIndicator stopAnimating];
     }];
}
-(void) getChampionsData
{
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"Teams/any(t: t/TeamId eq %li) and Active eq true",(long)self.teamId],@"Id,Name,Slug,ChampionshipTypeId,ChampionshipTypeName,SeasonId,SeasonName,Weeks",@"Id desc"] forKeys:@[@"$filter",@"$select",@"$orderby"]];
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:ChampionshipsAPI,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"Championship" andAuthenticationType:SportesEngineAPIs success:^(Championship * success)
     {
         self.championships = success.data;
         self.teamProfileTabs.teamId = self.teamId;
         self.teamProfileTabs.championships = self.championships;
        // [self createTabsView];
         self.teamProfileTabs.view.frame = CGRectMake(0,0, self.tabsView.frame.size.width, self.tabsView.frame.size.height);
         [self.tabsView addSubview:self.teamProfileTabs.view];
         [self.tabsView bringSubviewToFront:self.teamProfileTabs.view];
         [self.teamProfileTabs didMoveToParentViewController:self];
     }failure:^(NSError *error) {
         IBGLog(@"Player Profile API Error  : %@",error);
     }];
}
-(void)createTabsView
{
    self.childViewControllers = [[NSMutableArray alloc]init];
    TeamProfileDetailsViewController * teamProfileDetailsViewController = [[TeamProfileDetailsViewController alloc]init];
    teamProfileDetailsViewController.teamId = self.teamId;
    teamProfileDetailsViewController.title = @"نظرة عامة";
    teamProfileDetailsViewController.championships = self.championships;
    NewsHomeViewController* newsListScreen=[[NewsHomeViewController alloc]initWithSectionId:0 TypeId:1];
    newsListScreen.title=@"أخبار";
    newsListScreen.sectionId=0;
    newsListScreen.teamName=self.teamName;
    newsListScreen.teamId = self.teamId;
    VideosViewController* videosListScreen=[[VideosViewController alloc]init];
    //videosListScreen.sectionId = 1;
    videosListScreen.teamName=self.teamName;
    videosListScreen.title=@"فيديوهات";
    videosListScreen.teamId = self.teamId;
    TeamMatchesViewController * matchesVC = [[TeamMatchesViewController alloc]init];
    matchesVC.title=@"المباريات";
    matchesVC.teamName=self.teamName;
    matchesVC.teamId = self.teamId;
    GalleriesViewController * galleriesViewController = [[GalleriesViewController alloc]init];
    galleriesViewController.title = @"الصور";
    galleriesViewController.teamId = self.teamId;
    galleriesViewController.teamName=self.teamName;
    PlayersViewController * playersVC = [[PlayersViewController alloc]init];
    playersVC.title = @"اللاعبون";
    playersVC.championships = self.championships;
    playersVC.teamId = self.teamId;
    playersVC.teamName=self.teamName;
    NewScorersViewController * scorersVC = [[NewScorersViewController alloc]init];
    scorersVC.title = @"الهدافون";
    scorersVC.teamName=self.teamName;
    scorersVC.championships = self.championships;
    scorersVC.teamId = self.teamId;
    TeamStandingsViewController * standingsVC = [[TeamStandingsViewController alloc]init];
    standingsVC.title = @"ترتيب الفريق";
    standingsVC.teamName=self.teamName;
    standingsVC.championships = self.championships;
    standingsVC.teamId = self.teamId;
    
    self.childViewControllers = [NSMutableArray arrayWithObjects:standingsVC,scorersVC,playersVC,galleriesViewController,videosListScreen,newsListScreen,matchesVC,teamProfileDetailsViewController, nil];
    
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor:[UIColor mainAppYellowColor],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont defaultMeduimFontOfSize:14.0],
                                 CAPSPageMenuOptionMenuHeight: @(50.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(Screenwidth/self.childViewControllers.count),
                                 CAPSPageMenuOptionMenuItemWidthBasedOnTitleTextWidth:@(YES),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES),
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor blackColor]
                                 };
    self.pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:self.childViewControllers frame:CGRectMake(0.0, 0.0, self.tabsView.frame.size.width,self.tabsView.frame.size.height) options:parameters];
    self.pageMenu.delegate = self;
    [self.pageMenu moveToPage:self.childViewControllers.count-1];
    [self.tabsView addSubview:_pageMenu.view];
    self.tabsView.hidden = NO;
}


-(void)setRoundCornersForImages
{
    self.coachImgView.layer.cornerRadius = self.coachImgView.frame.size.width/2;
    self.coachImgView.clipsToBounds = YES;
    self.teamLogoView.layer.cornerRadius = self.teamLogoView.frame.size.width/2;
    self.teamLogoView.layer.borderWidth = 9.0;
    self.teamLogoView.clipsToBounds = YES;
    self.teamLogoView.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]CGColor];
    self.whiteView.layer.cornerRadius = self.whiteView.frame.size.width/2;
    self.whiteView.clipsToBounds = YES;
}

-(void)setTransparentUINavigationBar
{
    //NavigationBar
    self.title = @"";
    [appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [appDelegate.getSelectedNavigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [appDelegate.getSelectedNavigationController.navigationBar setShadowImage:[UIImage new]];
    appDelegate.getSelectedNavigationController.navigationBar.translucent = YES;
    [appDelegate.getSelectedNavigationController.navigationBar setBarTintColor:[UIColor clearColor]];

}

-(void)setNavigationBarBackgroundImage {
    //NavigationBar
    //[self.navigationController.navigationBar lt_reset];
    if(IS_IPHONE_4) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
    } else if(IS_IPHONE_5) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
    } else if (IS_IPHONE_6) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
    } else if (IS_IPHONE_6_PLUS) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
    } else {
         [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavX"] forBarMetrics:UIBarMetricsDefault];
        //UIImage *image = [[UIImage imageNamed:@"Nav6+"] resizeImageScaledToWidthWithWidth: [UIScreen mainScreen].bounds.size.width];
        CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                 ([UIApplication sharedApplication].statusBarFrame.size.height +(self.navigationController.navigationBar.frame.size.height ?: 0.0)));
        UIImage *image = [[UIImage imageNamed:@"NavX"] resizeImageWithTargetSize:size];  
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
}

-(void)initWithCell:(TeamProfile*)teamProfile
{
    UIColor *color = [UIColor whiteColor];
    UIFont * font = [UIFont fontWithName:@"DINNextLTW23Regular" size:14.0];
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : color, NSFontAttributeName:font };
    UIColor * grayColor = [UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0];
    NSDictionary * grayAttrs = @{ NSForegroundColorAttributeName : grayColor , NSFontAttributeName:font };
    if(teamProfile.data.count>0)
    {
        Data * item = teamProfile.data[0];
        // Website Url
        self.teamName=item.name;
        self.teamNameLbl.text = item.name;
        if(item.website !=nil)
            websiteUrl = [[NSString alloc]initWithString:item.website];
        // set Team Image
        [self.teamImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_BASE_URL,(long)item.idField]] placeholderImage:[UIImage imageNamed:@"Team-Image-Placeholder"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                       [self.teamImgActivityIndicator stopAnimating];
                                       
                                   }];
        
        [self.teamLogoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.idField]] placeholderImage:[UIImage imageNamed:@"Team-Image-Placeholder"]
                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                           [self.teamLogoActivityIndicator stopAnimating];
                                           
                                       }];
        NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]init];
        NSAttributedString * countryNameStr = [[NSAttributedString alloc] initWithString:item.countryName attributes:attrs];
        NSAttributedString * countryNameLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"الدولة:" ] attributes:grayAttrs];
        [attributeStr appendAttributedString:countryNameLbl];
        [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
        [attributeStr appendAttributedString:countryNameStr];
        //self.playgroundNameLbl.attributedText = attributeStr;
        self.playgroundNameLbl.text = item.countryName ;
        //foundation Label
        
        attributeStr = [[NSMutableAttributedString alloc]init];
        NSAttributedString * foundationStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li",(long)item.founded] attributes:attrs];
        NSAttributedString * foundationLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"سنة التأسيس:" ] attributes:grayAttrs];
        [attributeStr appendAttributedString:foundationLbl];
        [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
        [attributeStr appendAttributedString:foundationStr];
        //  self.foundationDateLbl.attributedText = attributeStr;
        self.foundationDateLbl.text = [NSString stringWithFormat:@"%li   ",(long)item.founded];
        
        
        // Coach Details
        
        NSArray * careerData = [[NSArray alloc]initWithArray: item.careerData];
        if(careerData.count>0)
        {
            CareerData * person = [careerData objectAtIndex:0];
            
            // Coach Image
            [self.coachImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)person.personId]] placeholderImage:[UIImage imageNamed:@"Coach-Image-Placeholder"]
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
//                                            [self.coachImgActivityIndicator stopAnimating];
                                            UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
                                            imageView.frame = self.coachImgView.frame;
                                            
                                        }];
            // Coach Name
            
            attributeStr = [[NSMutableAttributedString alloc]init];
            NSAttributedString * coachNameStr = [[NSAttributedString alloc] initWithString:person.personName attributes:attrs];
            NSAttributedString * coachNameLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"المدرب:" ] attributes:grayAttrs];
            [attributeStr appendAttributedString:coachNameLbl];
            [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
            [attributeStr appendAttributedString:coachNameStr];
            // self.coachNameLbl.attributedText = attributeStr;
            self.coachNameLbl.text = person.personName;
            
            
        }
        
    }
    
}
#pragma mark - Actions
- (IBAction)teamWebsitePressed:(id)sender {
    NSString *urlStr = [[NSString alloc] init];
    if ([websiteUrl containsString:@"https://"] == NO && [websiteUrl containsString:@"http://"] == NO) {
        urlStr = [NSString stringWithFormat:@"https://%@", websiteUrl];
    } else {
        urlStr = websiteUrl;
    }
    
    /*NSURL *url = [NSURL URLWithString:urlStr];
    if (url) {
        SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL: url];
        [self presentViewController:svc animated:YES completion:nil];
    }*/

    SVModalWebViewController * webController = [[SVModalWebViewController alloc]initWithAddress:urlStr];
    [self presentViewController:webController animated:YES completion:^{
    }];
    
    /*[GetAppDelegate().getSelectedNavigationController presentViewController:webController animated:YES completion:^{
    }];*/
    
}

- (IBAction)shareBtnPressed:(id)sender {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.filgoal.com/teams/%i",self.teamId]];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[self.teamName, url]
     applicationActivities:nil];
    
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    [self presentViewController:controller animated:YES completion:nil];
}
-(IBAction)addTeamToFavoritesBtnPressed:(id)sender
{
    if([UserMethods retrieveUserObject] !=nil)
    {
    MultiSelectionViewController * viewController = [[MultiSelectionViewController alloc]init];
    viewController.defaultSelections = [self getdefaultSelections];
    viewController.delegate = self;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:viewController];
    popupController.style = STPopupStyleBottomSheet;
    [popupController presentInViewController:self];
    }
    else
    {
        UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        closeBtn.bounds = CGRectMake(Screenwidth-20, 0, 16, 16);
        [closeBtn addTarget:self action:@selector(dismissLogin) forControlEvents:UIControlEventTouchUpInside];
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
        //NavigationBar
        [navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [navigationController.navigationBar setBarTintColor:[UIColor mainAppDarkGrayColor]];
        [navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
        navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:navigationController animated:YES completion:^{
            NSLog(@"%@",navigationController.topViewController);
            NSLog(@"%@",appDelegate.getSelectedNavigationController.topViewController);
            NSLog(@"%@",appDelegate.navigationController.viewControllers);
           navigationController.topViewController.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:closeBtn];

        }];

    }
}
-(void)dismissLogin
{
    [self dismissViewControllerAnimated:YES completion:^{
        if([UserMethods retrieveUserObject]!= nil)
        {
          //  [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self addTeamToFavoritesBtnPressed:self];
        }
    }];
}
#pragma mark - Handle Observer
-(void)translateViewToTop:(NSNotification*)notification
{
    BOOL scrollUp= [[notification.object objectForKey:@"scroll"] boolValue];
    if (scrollUp) { //WILL COLLAPSE
        //self.title = self.teamName;
        //[self setNavigationBarBackgroundImage];
        [UIView animateWithDuration:0.2
                         animations:^{
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  self.infoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                                                  [self setNavigationBarBackgroundImage];
                                              } completion:^(BOOL finished) {
                                              }];
                             
                             
                         }
                         completion:^(BOOL finished){
                             self.infoView.hidden = YES;
                             self.infoHeightConstraint.constant = 0.0;
                             self.topScrollViewConstraint.constant = 0.0;
                         }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(translateViewToTop:)
                                                     name:@"TeamScrollDownNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TeamScrollUpNotification" object:nil];
        
    } else {    //WILL EXPAND
        
        //[appDelegate.getSelectedNavigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
        //[self setTransparentUINavigationBar];
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.infoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  self.infoView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                                  [self setTransparentUINavigationBar];
                                              } completion:^(BOOL finished) {
                                                  
                                              }];
                             self.infoView.hidden=NO;
                             self.infoHeightConstraint.constant = 270.0;
                             self.topScrollViewConstraint.constant = -44;
                         }
                         completion:^(BOOL finished){
                             
                         }];
        
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TeamScrollDownNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(translateViewToTop:)
                                                     name:@"TeamScrollUpNotification"
                                                   object:nil];
    }
}
-(void)setBlackOverlay
{
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screenwidth, _teamImgView.frame.size.height)];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [self.teamImgView addSubview:overlay];
}

#pragma mark - Multi Selections View Delegate
-(void)multiSelectionViewController:(MultiSelectionViewController *)vc didFinishWithSelections:(NSArray *)selections
{
    if(selections.count>0)
    {
        [favButton setBackgroundImage:[UIImage imageNamed:@"followH"] forState:UIControlStateNormal];
        TeamPreference * teamPreference = [[TeamPreference alloc]init];
        teamPreference.teamId = self.teamId;
        teamPreference.teamName = self.teamName;
        teamPreference.eventIds = [[NSMutableSet alloc]initWithArray: [self getEventsIdsUsingSelections:selections]];
        [UserMethods updateUserTeamEvents:teamPreference];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [favButton setBackgroundImage:[UIImage imageNamed:@"follow"] forState:UIControlStateNormal];
        [UserMethods deleteTeam:self.teamId handler:^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
}
-(NSArray*)getEventsIdsUsingSelections:(NSArray*)selections
{
    NSMutableArray * events = [[NSMutableArray alloc]init];
    // Update Preferences
    for(NSString * title in selections)
    {
        if([title isEqualToString:kMatchSquadStr])
        {
            [events addObject:@4];
        }
        else if ([title isEqualToString:kMatchStatusStr])
        {
            [events addObject:@1];
        }
        else if ([title isEqualToString:kMatchEventsStr])
        {
            [events addObject:@2];
        }
        else if ([title isEqualToString:kMatchScoreStr])
        {
            [events addObject:@3];
        }
        
    }
    return events;
}
-(NSArray*)getdefaultSelections
{
    NSMutableArray * defaultSelections = [[NSMutableArray alloc]init];
    NSArray * list = [UserMethods getTeamEventsIdsUsingTeamId:self.teamId];
    if(list.count>0)
    {
        for(id eventId in list)
        {
            if([eventId integerValue] == ID_TEAM_PREFERENCE_MATCH_STATUS)
            {
                [defaultSelections addObject:kMatchStatusStr];
            }
            else if([eventId integerValue] == ID_TEAM_PREFERENCE_MATCH_SQUAD)
            {
                [defaultSelections addObject:kMatchSquadStr];
            }
            else if([eventId integerValue] == ID_TEAM_PREFERENCE_MATCH_FINAL_SCORE)
            {
                [defaultSelections addObject:kMatchScoreStr];
            }
            else if([eventId integerValue] == ID_TEAM_PREFERENCE_MATCH_EVENTS)
            {
                [defaultSelections addObject:kMatchEventsStr];
            }
            
        }
    }
    return [[NSArray alloc]initWithArray:defaultSelections];
}
/*
-(void)setNavigationBarBackgroundImage
{
//    [appDelegate.getSelectedNavigationController.navigationBar lt_setBackgroundColor:[UIColor mainAppDarkGrayColor]];
//    [self.navigationController.navigationBar setTranslucent:NO];
    if([AppSponsors isAppNavigationbarSponsorActive])
    {
        UIImage * image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:SponsorImagePathKey];
        if(image!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageWithCGImage:image.CGImage scale:[[UIScreen mainScreen] scale] orientation:image.imageOrientation] forBarMetrics:UIBarMetricsDefault];
                
            });
            
        }
        else
        {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:[AppSponsors getAppNavigationbarSponsorImagePath]] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    [[SDImageCache sharedImageCache] storeImage:image forKey:SponsorImagePathKey toDisk:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
                    });
                }
            }];
        }
    }
    else{
        if(IS_IPHONE_4) {
            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav4"] forBarMetrics:UIBarMetricsDefault];
        } else if(IS_IPHONE_5) {
            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav5"] forBarMetrics:UIBarMetricsDefault];
        } else if (IS_IPHONE_6) {
            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6"] forBarMetrics:UIBarMetricsDefault];
        } else {
            //[appDelegate.getSelectedNavigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Nav6+"] forBarMetrics:UIBarMetricsDefault];
        }
    }
    
}
*/

@end
