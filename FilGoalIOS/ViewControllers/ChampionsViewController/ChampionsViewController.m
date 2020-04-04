//
//  HomeViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "ChampionsViewController.h"
#import "Global.h"
#import "UIImageView+WebCache.h"
#import "Champion.h"
#import "ChampionCellLoader.h"
#import  "AppInfo.h"
#import "Sponsor.h"
#import "Global.h"
#import "AppDelegate.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "MainSectionViewController.h"
#import "MenuItemCellLoader.h"
@import Firebase;
@interface ChampionsViewController ()
{
    NSString * sponsorUrl;
}
@end

@implementation ChampionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
}
-(void)setScreenSponsor
{
    AppInfo *appInfo= [Global getInstance].appInfo;
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
        
        
        
        
        [self.sponser sd_setImageWithURL:[NSURL URLWithString:sponsorUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //[self.sponser setBackgroundColor:[UIColor colorWithRed:3/255.0 green:83/255.0 blue:138/255.0 alpha:1.0]];
            self.sponsorImgConstraintHeight.constant = 26;

            self.sponser.contentMode=UIViewContentModeScaleToFill;
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
- (void)viewDidLoad
{
     self.screenName = [NSString stringWithFormat:@"iOS-Champions List" ];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS-Champions List" 
                                     }];
    [super viewDidLoad];
    
    self.ChamList=[[NSMutableArray alloc]initWithArray:[Global getInstance].metaData.champions];
  
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
   [super viewDidAppear:YES];
    //self.title = @"البطولات";
    
    [super setNavigationBarBackgroundImage];
    //[super setUpBannerUnderNav:self.view anotherTopView:nil];
}

#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
return [self.ChamList count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Champion *item=[self.ChamList objectAtIndex:indexPath.row ];
    static NSString * cellIdentifier = @"MenuListCustomCell";
    
    MenuItemCellLoader *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuListCustomCell" owner:self options:nil]objectAtIndex:0];
    cell.cellTitleLbl.textColor = [UIColor colorWithRed:0.52 green:0.51 blue:0.51 alpha:1.0];
    cell.selectedBarLbl.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellTitleLbl.text = item.champName;
    
    UIActivityIndicatorView *ind = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(cell.imgView.center.x, cell.imgView.center.y, 15, 15)];
    ind.tintColor = [UIColor mainAppDarkGrayColor];
    [ind startAnimating];
    [ind setHidden:NO];
    [cell.imgView addSubview:ind];
    cell.arrowImg.hidden = YES;
    if(item.champLogo!=nil){
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:item.champLogo] placeholderImage:[UIImage imageNamed:@"Champion_list_holder.png"]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    [ind stopAnimating];
                                    [ind setHidden:YES];
                                }];
    }
    return cell;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Champion *item=[self.ChamList objectAtIndex:indexPath.row ];
    ChampionShipData * champion = [[ChampionShipData alloc]init];
    champion.idField = item.champId;
    champion.name = item.champName;
    if(item.champId != 0)
    {
        ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
        detailsScreen.champion = champion;
        [GetAppDelegate().getSelectedNavigationController pushViewController:detailsScreen animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
