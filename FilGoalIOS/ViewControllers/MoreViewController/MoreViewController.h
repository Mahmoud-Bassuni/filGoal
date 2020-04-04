//
//  MoreViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChampionsViewController.h"
#import "SectionsViewController.h"
#import "CountryTableViewCell.h"
#import "CountryFooterViewCell.h"
#import "MZFormSheetController.h"
#import "MZFormSheetSegue.h"
#import "CountriesViewController.h"
#import "AuthorsViewController.h"
@interface MoreViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource,CountryPickerDelegate,MZFormSheetBackgroundWindowDelegate,GADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL  isShowed;
@property (strong, nonatomic) IBOutlet UIImageView *sponsorImg;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sponsorImgConstraintHeight;
@property (strong, nonatomic) DFPBannerView *bannerVieww;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@end
