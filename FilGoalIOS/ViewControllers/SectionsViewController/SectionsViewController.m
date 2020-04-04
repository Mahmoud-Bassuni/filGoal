//
//  HomeViewController.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 4/6/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "SectionsViewController.h"

#import "Global.h"
#import "UIImageView+WebCache.h"
#import "Champion.h"
#import "SectionCellLoader.h"
#import  "AppInfo.h"
#import "Sponsor.h"
#import "Global.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "MainSectionViewController.h"
@import Firebase;
@interface SectionsViewController ()

@end

@implementation SectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   // self.title = @"الأقسام";
    //[super setUpBannerUnderNav:self.view anotherTopView:nil];
}

- (void)viewDidLoad
{
     self.screenName = [NSString stringWithFormat:@"iOS- Sections List" ];
    [FIRAnalytics logEventWithName:kFIREventViewItem
                        parameters:@{
                                     kFIRParameterItemName:@"iOS- Sections List"
                                     }];
    [super viewDidLoad];
    
    self.sections =[[NSMutableArray alloc]initWithArray:[Global getInstance].metaData.sections];

}
#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.sections count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    Section *item=[self.sections objectAtIndex:indexPath.row ];
    return      [SectionCellLoader loadCellWithtableView:tableView cellForRowAtIndexPath:indexPath withChamItem:item];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Section *item=[self.sections objectAtIndex:indexPath.row ];
    MainSectionViewController* mainSection=[[MainSectionViewController alloc]initWithSection:item];
    mainSection.section=item;
    [self.navigationController pushViewController:mainSection animated:YES];
//    if(item.champIds.count==1)
//    {
//        ChampId * champItem=item.champIds[0];
//        ChampionShipData * champion = [[ChampionShipData alloc]init];
//        champion.idField=champItem.champID;
//        champion.idField = item.champId;
//        champion.name = item.sectionName;
//        if(item.champId != 0)
//        {
//            ChampionDetailsTabsViewController * detailsScreen = [[ChampionDetailsTabsViewController alloc]init];
//            detailsScreen.champion = champion;
//            detailsScreen.sectionId=item.sectionId;
//            [self.navigationController pushViewController:detailsScreen animated:YES];
//        }
//    }
//    else
//    {
//        MainSectionViewController* mainSection=[[MainSectionViewController alloc]initWithSection:item];
//        mainSection.section=item;
//        [self.navigationController pushViewController:mainSection animated:YES];
//    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
