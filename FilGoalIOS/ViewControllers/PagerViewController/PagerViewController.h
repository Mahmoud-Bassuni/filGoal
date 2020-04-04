//
//  PagerViewController.h
//  AkhbarakMobileApp
//
//  Created by Nada Gamal on 2/13/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
#import "GalleryDetailsViewController.h"
#import "AdsViewController.h"
#import "Albums.h"
@interface PagerViewController : UIPageViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray * viewControllersList;
@property (nonatomic,strong) NSMutableArray * stories;
@property (nonatomic,strong) Album * selectedAlbum;
@property (nonatomic,strong) NewsItem * selectedNewsItem;
@property (nonatomic,strong) VideoItem * selectedVideoItem;
@property (nonatomic,strong) NSDictionary * paramDic;
@property (nonatomic,strong) NSMutableArray *storiesListWithAds;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) NSInteger pageNum;
@property (nonatomic,assign) NSInteger sectionID;


@end
