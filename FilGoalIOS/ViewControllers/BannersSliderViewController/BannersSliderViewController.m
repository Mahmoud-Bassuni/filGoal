//
//  BannersSliderViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 12/14/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "BannersSliderViewController.h"
#import "SVWebViewController.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "MainSectionViewController.h"
#import "UIImageView+WebCache.h"
#import "GlobalViewController.h"
@interface BannersSliderViewController ()
{
    NSArray * banners;
    NSMutableArray * bannersImgsUrls;
    AppDelegate * appDelegate;
}
@end

@implementation BannersSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    banners = [[NSArray alloc]initWithArray:[Global getInstance].appInfo.specialSection.banners];
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    bannersImgsUrls=[[NSMutableArray alloc]init];
    for (int i=0; i<banners.count; i++) {
        if(_isFromHome)
            [bannersImgsUrls addObject:[NSURL URLWithString:[(Banner*)[banners objectAtIndex:i]imgUrl]]];
        else if([((Banner*)[banners objectAtIndex:i]).pageUrl rangeOfString:@"http://"].location!=NSNotFound)
            [bannersImgsUrls addObject:[NSURL URLWithString:[(Banner*)[banners objectAtIndex:i]imgUrl]]];
        
    }
    [self.carousel reloadData];
    _carousel.type = iCarouselTypeLinear;
    _carousel.autoscroll=NO;
    [self.carousel scrollToItemAtIndex:bannersImgsUrls.count-1 animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.scrollTimer=[NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(scrollCarousel) userInfo:nil repeats:YES];
    
}
-(void) scrollCarousel {
    NSInteger newIndex=self.carousel.currentItemIndex-1;
    if (newIndex <0) {
        newIndex=bannersImgsUrls.count-1;
    }
    [self.carousel scrollToItemAtIndex:newIndex duration:2.0];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return bannersImgsUrls.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width-35, self.carousel.frame.size.height)];
    [((UIImageView *)view) sd_setImageWithURL:[bannersImgsUrls objectAtIndex:index]];
    view.contentMode = UIViewContentModeScaleToFill;
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.01;
    }
    return value;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    Banner * item =[banners objectAtIndex:index];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:[NSString stringWithFormat:@"iOS - %@",item.title ]
                                                          action: [NSString stringWithFormat:@"iOS - %@",item.title ]
                                                           label: [NSString stringWithFormat:@"iOS - %@",item.title ]
                                                           value:nil] build]];
    if(([item.pageUrl rangeOfString:@"http://"].location!=NSNotFound) || ([item.pageUrl rangeOfString:@"https://"].location!=NSNotFound))
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:item.pageUrl]];
//        GlobalViewController * webView=[[GlobalViewController alloc]init];
//        appDelegate.isFullScreen=YES;
//        webView.url=[NSURL URLWithString:item.pageUrl];
//        [appDelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:appDelegate.window];
//        UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
//
//        [navigationContoller pushViewController:webView animated:YES];
        
    }
    else
    {
        Section * section=[[Global getInstance] getSectionItemWithSectionID:[item.pageUrl intValue] ];
        MainSectionViewController* mainSection=[[MainSectionViewController alloc]initWithSection:section];
        mainSection.section=section;
        UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
        [navigationContoller pushViewController:mainSection animated:YES];
    }
}




@end
