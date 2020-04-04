//
//  PlayerProfileViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/25/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "PlayerProfileViewController.h"
@import Firebase;
@interface PlayerProfileViewController ()
{
    NSMutableArray * playerStatics;
    NSArray * newsList;
    NSArray * videosList;
    NSArray * albumsList;
    NSMutableArray * sections;
}
@end

@implementation PlayerProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    sections = [[NSMutableArray alloc]init];
    self.playerId = self.player.playerId;
    playerStatics = [[NSMutableArray alloc]init];
    [self setScreenSponsor];
    [self setRoundCornersForImages];
    
    // Call APIs
    if(self.player.playerId != 0)
    {
        [self getPlayerData];
        [self getPlayerStatisticsData];
        [self getStoriesData];
    }
    self.screenName = [NSString stringWithFormat:@"Player Profile with ID %i",self.player.playerId];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:[NSString stringWithFormat:@"Player Profile with ID %i",self.player.playerId]
                                     }];
    self.tableView.scrollsToTop = YES;
    
    self.navigationController.navigationBar.translucent=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
-(void) fillUIWithPlayerObject
{
    
    UIColor *color = [UIColor whiteColor];
    UIFont * font = [UIFont fontWithName:@"DINNextLTW23Regular" size:14.0];
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : color, NSFontAttributeName:font };
    UIColor * grayColor = [UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.0];
    NSDictionary * grayAttrs = @{ NSForegroundColorAttributeName : grayColor , NSFontAttributeName:font };
    
    if(self.player != nil)
    {
        self.playerNameLbl.text = self.player.name;
        
        [self.playerImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",PERSON_IMAGES_BASE_URL,(long)self.player.idField]] placeholderImage:[UIImage imageNamed:@"champions_holder.png"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                         [self.activityIndicator stopAnimating];
                                         
                                     }];
        
        NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]init];
        
        //Social Media Links
        
        if(self.player.twitter == nil)
        {
            self.twitterBtn.hidden = YES;
            self.twitterBtn.enabled = NO;
        }
        if(self.player.facebook == nil)
        {
            self.facebookBtn.hidden = YES;
            self.facebookBtn.enabled = NO;
            
        }
        
        // Nationality
        
        attributeStr = [[NSMutableAttributedString alloc]init];
        NSAttributedString * playerNationalityStr = [[NSAttributedString alloc] initWithString:self.player.countryName attributes:attrs];
        NSAttributedString * nationalittyLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"الجنسية:" ] attributes:grayAttrs];
        [attributeStr appendAttributedString:nationalittyLbl];
        [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
        [attributeStr appendAttributedString:playerNationalityStr];
        self.playerNationalityLbl.attributedText = attributeStr;
        
        // DateOfBirth
        if(self.player.dateOfBirth != nil)
        {
        attributeStr = [[NSMutableAttributedString alloc]init];
        NSAttributedString * dateOfBirthStr = [[NSAttributedString alloc] initWithString:self.player.dateOfBirth attributes:attrs];
        NSAttributedString * dateOfBirthLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"تاريخ الميلاد:" ] attributes:grayAttrs];
        [attributeStr appendAttributedString:dateOfBirthLbl];
        [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
        [attributeStr appendAttributedString:dateOfBirthStr];
        self.playerBirthdateLbl.attributedText = attributeStr;
        }
        // Birth Place
        
        attributeStr = [[NSMutableAttributedString alloc]init];
        NSAttributedString * birthPlaceStr = [[NSAttributedString alloc] initWithString:self.player.countryName attributes:attrs];
        NSAttributedString * birthPlaceLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" مكان الميلاد:"  ] attributes:grayAttrs];
        [attributeStr appendAttributedString:birthPlaceLbl];
        [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
        [attributeStr appendAttributedString:birthPlaceStr];
        self.playerBirthPlace.attributedText = attributeStr;
        
        
        // Tshirt Number
        
        NSAttributedString * tShirtNumberStr;
        if(self.player.careerData.count>0)
        {
            CareerData * item = self.player.careerData[0];
            
            tShirtNumberStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li",(long)item.playerNumber] attributes:attrs];
            // Position
            
            self.playerTitleLbl.text =[NSString stringWithFormat:@"(%@)",item.playerPositionName];
            // Club Name
            
            attributeStr = [[NSMutableAttributedString alloc]init];
            NSAttributedString * teamNameStr = [[NSAttributedString alloc] initWithString:item.teamName attributes:attrs];
            NSAttributedString * teamLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"النادي:" ] attributes:grayAttrs];
            [attributeStr appendAttributedString:teamLbl];
            [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
            [attributeStr appendAttributedString:teamNameStr];
            self.teamNameLbl.attributedText = attributeStr;
            
            //Add gesture to team name
            UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teamNameLblPressed:)];
            gesture.numberOfTapsRequired = 1;
            self.teamNameLbl.userInteractionEnabled = YES;
            [self.teamNameLbl addGestureRecognizer:gesture];
            [self.teamLogoImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)item.teamId]]  placeholderImage:[UIImage imageNamed:@"champions_holder.png"]
                                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                                               
                                           }];
            
            attributeStr = [[NSMutableAttributedString alloc]init];
            
            NSAttributedString * tShirtNumberLbl = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"رقم القميص:" ] attributes:grayAttrs];
            [attributeStr appendAttributedString:tShirtNumberLbl];
            [attributeStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"  "]];
            [attributeStr appendAttributedString:tShirtNumberStr];
            self.tShirtNumberLbl.attributedText = attributeStr;
            
        }
        
        
    }
    else
    {
        
    }
}
-(void)setRoundCornersForImages
{
    self.playerImgView.layer.cornerRadius = self.playerImgView.frame.size.width/2;
    self.playerImgView.layer.borderWidth = 5.0;
    self.playerImgView.layer.borderColor = [[UIColor colorWithRed:0.27 green:0.27 blue:0.28 alpha:1.0]CGColor];
    self.playerImgView.clipsToBounds = YES;
    self.teamLogoView.clipsToBounds = YES;
    self.teamLogoView.layer.cornerRadius = self.teamLogoView.frame.size.width/2;
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teamNameLblPressed:)];
    gesture.numberOfTapsRequired = 1;
     self.teamLogoView.userInteractionEnabled = YES;
    [ self.teamLogoView addGestureRecognizer:gesture];
    
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
        }];
    }
    else{
        self.sponsorImgHeightConstraint.constant = 0;
        
    }
    if([sponsorUrl isEqualToString:@""]||sponsorUrl==nil)
    {
        self.sponsorImgHeightConstraint.constant = 0;
    }
    self.sponsorImgHeightConstraint.constant = 0;

}
#pragma mark - summation of Player statistics
-(void)setTotalNumberOfPlayerStatisticsAtAllChampions
{
    int nOfPlayedMatches = 0;
    int nOfGoals = 0;
    int nOfYellowCards = 0;
    int nOfRedCards = 0;
    for(PlayerProfileStatistic * item in playerStatics)
    {
        nOfRedCards += item.redCards;
        nOfGoals += item.goals;
        nOfYellowCards += item.yellowCards;
        nOfPlayedMatches += item.played;
    }
    
    self.nOfYellowCards.text = [NSString stringWithFormat:@"%i",nOfYellowCards];
    self.nOfRedCardsLbl.text = [NSString stringWithFormat:@"%i",nOfRedCards];
    self.nOfGoalsLbl.text = [NSString stringWithFormat:@"%i",nOfGoals];
    self.nOfGoalsLbl.text = [NSString stringWithFormat:@"%i",nOfGoals];
    self.nOfPlayedMatchesLbl.text = [NSString stringWithFormat:@"%i",nOfPlayedMatches];
    
}

#pragma mark - Get Stories Data
-(void)getStoriesData
{
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:PlayerDetailsAPI,[WServicesManager getApiBaseURL],self.player.playerId] andParameters:nil WithObjectName:@"PlayerProfile" andAuthenticationType:CMSAPIs success:^(PlayerProfile * success)
     {
         PlayerProfile * homeData = success;
         
         if(homeData.news.count>0)
         {
             newsList = homeData.news;
             NSDictionary * topNewsDic = [[NSDictionary alloc]initWithObjects:@[@[[[DFPBannerView alloc]init]]] forKeys:@[@"AdsView"]];
             if(sections.count>1)
                 [sections insertObject:topNewsDic atIndex:1];
             else
                 [sections addObject:topNewsDic];
             
             NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[newsList] forKeys:@[@"NewsList"]];
             if(sections.count>2)
                 [sections insertObject:dic atIndex:2];
             else
                 [sections addObject:dic];
             
         }
         if(homeData.videos.count>0)
         {
             videosList = homeData.videos;
             NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[videosList] forKeys:@[@"VideosList"]];
             if(sections.count>3)
                 [sections insertObject:dic atIndex:3];
             else
                 [sections addObject:dic];
             
         }
         if(homeData.albums.count>0)
         {
             NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[homeData.albums] forKeys:@[@"AlbumsList"]];
             if(sections.count>4)
                 [sections insertObject:dic atIndex:4];
             else
                 [sections addObject:dic];
         }
         
         [self reloadTableView];
         
     }failure:^(NSError *error) {
         IBGLog(@"Player Profile API Error  : %@",error);
         [self.largeActivityIndicator stopAnimating];
         
     }];
}
#pragma mark - Get Player Data API
-(void) getPlayerData
{
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[@"CareerData"] forKeys:@[@"$expand"]];
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:PlayerProfileAPI,[WServicesManager getSportsEngineApiBaseURL],self.player.playerId] andParameters:paramDic WithObjectName:@"Player" andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         self.player = success;
//         if(self.navigationController.viewControllers.count>1)
//         {
//             [self.navigationController.navigationBar setBackgroundColor:[UIColor mainAppDarkGrayColor]];
//             [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//             //self.title=self.player.name;
//         }
//         else
//             [self setNavigationBarBackgroundImage];
         
         [self fillUIWithPlayerObject];
         [self.largeActivityIndicator stopAnimating];
         
         
     }failure:^(NSError *error) {
         
         IBGLog(@"Player Profile API Error  : %@",error);
         [self showDefaultNetworkingErrorMessageForError:error
                                          refreshHandler:^{
                                              [self getPlayerData];
                                          }];
         [self.largeActivityIndicator stopAnimating];
         
         
     }];
}

#pragma mark - Get Statisics API
-(void) getPlayerStatisticsData
{
    
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:PlayerStatisticsAPI,[WServicesManager getSportsEngineApiBaseURL],self.player.playerId] andParameters:nil WithObjectName:nil andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         if([success isKindOfClass:[NSArray class]])
         {
             for(NSDictionary * item in success)
             {
                 PlayerProfileStatistic * statistics = [[PlayerProfileStatistic alloc]initWithDictionary:item];
                 [playerStatics addObject:statistics];
             }
             if(playerStatics.count>0)
             {
                 [self setTotalNumberOfPlayerStatisticsAtAllChampions];
                 // [sectionsDic setObject:playerStatics forKey:@"PlayerStatistics"];
                 NSDictionary * dic = [[NSDictionary alloc]initWithObjects:@[playerStatics] forKeys:@[@"PlayerStatistics"]];
                 if(sections.count>0)
                     [sections insertObject:dic atIndex:0];
                 else
                     [sections addObject:dic];
                 
                 [self reloadTableView];
             }
             //[self.view layoutIfNeeded];
             
         }
         
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Player Profile with player ID = %li ",(long)self.player.playerId]  ApiError:@"Success"];
         
     }failure:^(NSError *error) {
         
         IBGLog(@"Player Statistics API Error  : %@",error);
         [self.largeActivityIndicator stopAnimating];
         [self sendAppSpeedTimeIntervalWithTime:[self stopMeasuring] AndScreenName:[NSString stringWithFormat:@"Player Profile with player ID = %li ",(long)self.player.playerId] ApiError:[NSString stringWithFormat:@"Failure with Error : %@",error.description]];
         
     }];
}
#pragma mark - UITableView DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(sections.count>0)
    {
        NSDictionary * dic = [sections objectAtIndex:indexPath.section];
        NSArray * list = dic.allValues[0];
        if([list[indexPath.row] isKindOfClass:[PlayerProfileStatistic class]])
            return 52;
        else if([[list objectAtIndex:indexPath.row]isKindOfClass:[DFPBannerView class]])
        {
            return  270;
        }
        else
            return 112;;
    }
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary * dic = [sections objectAtIndex:section];
    NSArray * list = dic.allValues[0];
    if([list[0] isKindOfClass:[PlayerProfileStatistic class]])
        return 86;
    else
        return 50;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section<sections.count)
    {
        NSDictionary * dic = [sections objectAtIndex:section];
        NSArray * list = dic.allValues[0] ;
        return list.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = @"Cell";
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
    }
    if(sections.count>0)
    {
        NSDictionary * dic = [sections objectAtIndex:indexPath.section];
        NSArray * list = dic.allValues[0];
        
        if([[list objectAtIndex:indexPath.row] isKindOfClass:[PlayerProfileStatistic class]])
        {
            cellIdentifier = @"PlayerProfileStatisticsCell";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil]objectAtIndex:0];
            PlayerProfileStatistic * item = list[indexPath.row];
            [((PlayerProfileStatisticsCell*)cell) initWithPlayerStatistics:item];
        }
        else  if([[list objectAtIndex:indexPath.row] isKindOfClass:[NewsItem class]])
        {
            NewsCustomCell *cell;
            if (cell == nil)
            {
                cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
                cell.hideDeleteBtn = YES;
                cell.playImg.hidden= YES;
                
            }
            NewsItem * item = list[indexPath.row];
            Images *imageItem =[item.images objectAtIndex:0];
            
            [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:imageItem.large]placeholderImage:[UIImage imageNamed:@"place_holder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [((NewsCustomCell*)cell).activityIndicator stopAnimating];
            }];
            
            [((NewsCustomCell*)cell).itemLbl setText:item.newsTitle];
            ((NewsCustomCell*)cell).dateLabel.hidden = YES;
            
            return cell;
        }
        else if([[list objectAtIndex:indexPath.row] isKindOfClass:[VideoItem class]])
        {
            NewsCustomCell *cell;
            if (cell == nil)
            {
                cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
                cell.hideDeleteBtn = YES;
                cell.playImg.image = [UIImage imageNamed:@"play_button"];
                cell.playImg.hidden=NO;
                
            }
            VideoItem * item = [list objectAtIndex:indexPath.row];
            
            [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:item.videoPreviewImage]placeholderImage:[UIImage imageNamed:@"place_holder"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [((NewsCustomCell*)cell).activityIndicator stopAnimating];
            }];;
            
            [((NewsCustomCell*)cell).itemLbl setText:item.videoTitle];
            ((NewsCustomCell*)cell).dateLabel.hidden = YES;
            
            return cell;
            
        }
        else if([[list objectAtIndex:indexPath.row] isKindOfClass:[Album class]])
        {
            NewsCustomCell *cell;
            if (cell == nil)
            {
                cell=  [[[NSBundle mainBundle]loadNibNamed:@"NewsCustomCell" owner:self options:nil]objectAtIndex:0];
                cell.hideDeleteBtn = YES;
                cell.playImg.image = [UIImage imageNamed:@"ic_album"];
                cell.playImg.hidden=NO;
                
            }
            Album * item = [list objectAtIndex:indexPath.row];
            Picture * firstPictureItem;
            if(item.pictures.count>0)
                firstPictureItem=[item.pictures objectAtIndex:0];
            [((NewsCustomCell*)cell).itemLbl setText:item.albumTitle];
            ((NewsCustomCell*)cell).dateLabel.hidden = YES;
            
            [((NewsCustomCell*)cell).itemImg sd_setImageWithURL:[NSURL URLWithString:firstPictureItem.urls.large] placeholderImage:[UIImage imageNamed:@"place_holder.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [((NewsCustomCell*)cell).activityIndicator stopAnimating];
            }];
            
            return cell;
            
            
        }
        if([[list objectAtIndex:indexPath.row]isKindOfClass:[DFPBannerView class]])
        {
            cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 270)];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screenwidth-20, 250)];
            view.backgroundColor = [UIColor clearColor];
            UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, view.center.y,view.frame.size.width, 40)];
            [title setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:title.font.pointSize]];
            [title setTextColor:[UIColor blackColor]];
            [title setTextAlignment:NSTextAlignmentCenter];
            [title setBackgroundColor:[UIColor clearColor]];
            title.text=@"مساحة أعلانية";
            [view addSubview:title];
            [view addSubview:[super setBannerViewFooter:@[@"Person",@"Inner",[NSString stringWithFormat:@"لاعب %@",self.player.name]] andPosition:@[@"Pos1"]andScreenName:[NSString stringWithFormat:@"Player Profile with ID %i",self.player.playerId]]];
            [cell addSubview:view];
            return cell;
        }
        
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
    
    if(sections.count>0)
    {
        NSDictionary * dic = [sections objectAtIndex:section];
        NSArray * list = dic.allValues[0];
        if([[list objectAtIndex:0] isKindOfClass:[PlayerProfileStatistic class]])
        {
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 86)];
            UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"PlayerStatisticsTableViewHeader" owner:self options:nil] objectAtIndex:0];
            view.frame = headerView.frame;
            [headerView addSubview:view];
        }
        else if([[list objectAtIndex:0]isKindOfClass:[NewsItem class]])
        {
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
            UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
            ((MoreHeaderCell*)view).headerTitle.text = @"آخر أخبار اللاعب";
            ((MoreHeaderCell*)view).moreBtn.layer.cornerRadius = ((MoreHeaderCell*)view).moreBtn.frame.size.width/2;
            ((MoreHeaderCell*)view).moreBtn.clipsToBounds = YES;
            ((MoreHeaderCell*)view).moreBtn.tag = section;
            [((MoreHeaderCell*)view).moreBtn addTarget:self action:@selector(moreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            view.frame = headerView.frame;
            [headerView addSubview:view];
            
        }
        else if([[list objectAtIndex:0] isKindOfClass:[VideoItem class]])
        {
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
            UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
            ((MoreHeaderCell*)view).headerTitle.text = @"فيديوهات اللاعب";
            ((MoreHeaderCell*)view).moreBtn.layer.cornerRadius = ((MoreHeaderCell*)view).moreBtn.frame.size.width/2;
            ((MoreHeaderCell*)view).moreBtn.tag = section;
            ((MoreHeaderCell*)view).moreBtn.clipsToBounds = YES;
            [((MoreHeaderCell*)view).moreBtn addTarget:self action:@selector(moreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            view.frame = headerView.frame;
            [headerView addSubview:view];
            
            return view;
            
        }
        else if([[list objectAtIndex:0] isKindOfClass:[Album class]])
        {
            headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screenwidth, 50)];
            UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"MoreHeaderCell" owner:self options:nil] objectAtIndex:0];
            ((MoreHeaderCell*)view).headerTitle.text = @"صوراللاعب";
            ((MoreHeaderCell*)view).moreBtn.layer.cornerRadius = ((MoreHeaderCell*)view).moreBtn.frame.size.width/2;
            ((MoreHeaderCell*)view).moreBtn.tag = section;
            ((MoreHeaderCell*)view).moreBtn.clipsToBounds = YES;
            [((MoreHeaderCell*)view).moreBtn addTarget:self action:@selector(moreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            view.frame = headerView.frame;
            [headerView addSubview:view];
            
            return view;
            
        }
    }
    return headerView;
    
}

#pragma mark - UITableView Delegates
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [sections objectAtIndex:indexPath.section];
    NSArray * list = dic.allValues[0];
    
    if([[list objectAtIndex:indexPath.row] isKindOfClass:[NewsItem class]])
    {
        NewsItem * item = [list objectAtIndex:indexPath.row];
        
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
        {
            NewsDetailsViewControllerWithWKWebView * newsDetailsScreenWebView=[[NewsDetailsViewControllerWithWKWebView alloc] initWithNewsItem:item ];
            [self.navigationController pushViewController:newsDetailsScreenWebView animated:YES];
        }
        else
        {
            NewsDetailsViewController * newsDetailsScreen=[[NewsDetailsViewController alloc] initWithNewsItem:item];
            
            [self.navigationController pushViewController:newsDetailsScreen animated:YES];
        }
        
    }
    else if([[list objectAtIndex:indexPath.row]isKindOfClass:[VideoItem class]])
    {
        VideoItem * item = [list objectAtIndex:indexPath.row];
        VideoDetailsViewController * videoDetailsScreen=[[VideoDetailsViewController alloc] initWithVideo:item];
        [self.navigationController pushViewController:videoDetailsScreen animated:YES];
    }
    else if([[list objectAtIndex:indexPath.row] isKindOfClass:[Album class]])
    {
        Album * item = [list objectAtIndex:indexPath.row];
        GalleryDetailsViewController * detailsVC = [[GalleryDetailsViewController alloc]init];
        detailsVC.albumItem = item;
        [self.navigationController pushViewController:detailsVC animated:YES];
        
    }
}


#pragma mark - User Actions
- (IBAction)twitterBtnPressed:(id)sender {
    SVWebViewController * webController = [[SVWebViewController alloc]initWithAddress:self.player.twitter];
    [self.navigationController pushViewController:webController animated:YES];
    
}
- (IBAction)facebookBtnPressed:(id)sender {
    SVWebViewController * webController = [[SVWebViewController alloc]initWithAddress:self.player.facebook];
    [self.navigationController pushViewController:webController animated:YES];
}
- (IBAction)moreBtnPressed:(UIButton*)sender
{
    NSDictionary * dic = sections[sender.tag];
    NSArray * list = dic.allValues[0];
    
    if(list.count>0)
    {
        // More for News listing
        if([list[0] isKindOfClass:[NewsItem class]])
        {
            NewsHomeViewController * newsListVC = [[NewsHomeViewController alloc]initWithSectionId:0 TypeId:1];
            newsListVC.playerId = self.playerId;
            [self.navigationController pushViewController:newsListVC animated:YES];
            
        }
        // More for Videos listing
        
        else if([list[0] isKindOfClass:[VideoItem class]])
        {
            VideosViewController* videosViewController=[[VideosViewController alloc]initWithSectionId:0];
            videosViewController.playerId = self.playerId;
            
            [self.navigationController pushViewController:videosViewController animated:YES];
        }
        else if([list[0] isKindOfClass:[Album class]])
        {
            GalleriesViewController * galleriesViewController=[[GalleriesViewController alloc]init];
            galleriesViewController.playerId = self.playerId;
            
            [self.navigationController pushViewController:galleriesViewController animated:YES];
        }
    }
}
#pragma mark - reload TableView

-(void)reloadTableView
{
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
}
-(void)teamNameLblPressed:(UITapGestureRecognizer*)tap
{
    if(self.player.careerData.count>0)
    {
        CareerData * item = self.player.careerData[0];
        TeamProfileViewController * teamProfile = [[TeamProfileViewController alloc]init];
        teamProfile.teamId = (int)item.teamId;
        teamProfile.teamName = item.teamName;
        [self.navigationController pushViewController:teamProfile animated:YES];
    }
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
