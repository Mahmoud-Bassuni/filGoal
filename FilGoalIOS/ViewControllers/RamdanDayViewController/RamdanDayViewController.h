//
//  RamdanDayViewController.h
//  Reyada
//
//  Created by Nada Gamal on 5/4/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeaturedCompontent.h"
#import "Global.h"
#import "XLPagerTabStripViewController.h"
#import "MWPhotoBrowser.h"
#import "ParentViewController.h"

@interface RamdanDayViewController : ParentViewController <XLPagerTabStripChildItem,UITableViewDelegate, UITableViewDataSource,MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *sponsorImg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FeaturedCompontent *component;
@property (strong, nonatomic) NSString *itemDate;
@property (strong, nonatomic) NSString *source;
@property (nonatomic, assign) NSInteger index;
@property (strong, nonatomic) NSString * pageTitle;
@property (assign,nonatomic) BOOL isFromPushNotification;
@property (nonatomic, strong) NSString *sponserUrl;
@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSMutableArray * photos;
@property (nonatomic, strong) NSDictionary * plistFile ;
@property (strong, nonatomic) Component *componentt;

@property (nonatomic,assign) NSInteger type;

@end
