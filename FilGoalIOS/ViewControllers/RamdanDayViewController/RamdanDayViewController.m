//
//  RamdanDayViewController.m
//  Reyada
//
//  Created by Nada Gamal on 5/4/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "RamdanDayViewController.h"
#import "FeaturedCompontent.h"
#import "Component.h"
#import "RamdanVideoCustomCell.h"
#import "UIImageView+WebCache.h"
#import "WeatherCustomCell.h"
#import "FoodDescriptionDetailsViewController/FoodDescriptionDetailsViewController.h"
#import "TextTypeCutomCell.h"
#import "AzkarCustomCellCell.h"
#import "TodayFoodDescriptionCell.h"
#import "VideoDetailsModelViewController/VideoModelDetailsViewController.h"
#import "TextViewController/TextDetailsViewController.h"
#import "Condition.h"
#import "MWPhotoBrowser.h"
#import "Forecast.h"
@interface RamdanDayViewController ()
{
    Forecast * forecastObject;
    NSArray * forcasts;
    NSMutableArray *componentsArray;
    NSString * hightTemp;
    NSDictionary * weekDays;
    Condition * weatherCondition;
    NSMutableArray * forcastHighTempList;
    NSMutableArray * forcastLowTempList;
    bool isAmskyaaLoaded;


}

@end

@implementation RamdanDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //load weather status arabic keywords
      // [OS]-SpecialSection(section name)-[page title/before/after]
    isAmskyaaLoaded=NO;
    self.screenName=[NSString stringWithFormat:@"iOS-SpecialSection-%@",self.title];
   // NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"WeatherArabicConditions" ofType:@"plist"];
   // self.plistFile = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    self.navigationController.navigationItem.rightBarButtonItem=nil;
    // Do any additional setup after loading the view from its nib.
    forcastLowTempList=[[NSMutableArray alloc]init];
    forcastHighTempList=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor colorWithRed:0.902 green:0.912 blue:0.934 alpha:1];
    self.index = 0;
   // weekDays=[[NSDictionary alloc]initWithObjects:@[@"الجمعة",@"السبت",@"الاحد",@"الاثتين",@"الثلاثاء",@"الاربعاء",@"الخميس"] forKeys:@[@"Fri",@"Sat",@"Sun",@"Mon",@"Tue",@"Wed",@"Thu"]];
    

    [WServicesManager getFeaturedComponent:nil andJsonSrcUrl:[NSString stringWithFormat:@"%@%@%@",self.baseUrl,_source,@".json"] success:^(FeaturedCompontent *component) {
        
        self.component = component;
            componentsArray = [[NSMutableArray alloc]init];
            for(Component *component in self.component.component){
            
               if(component.type != 5 && component.type != 6){
                
                    [componentsArray addObject:component];
                    [self.tableView reloadData];
                
              }
                
            
            }
        if(_isFromPushNotification)
        {
            _isFromPushNotification=NO;
            [self handlePushNotificationActions];
        }
        
    } failure:^(NSError *error) {
        
    }];
   // self.tableView.tableFooterView = [UIView new];
    
}
-(void)handlePushNotificationActions
{
    //NSArray *components = componentsArray;
    Component *component = self.componentt;
        if(component.largeImageURL!=nil&&(component.fullDescription==nil||[component.fullDescription isEqualToString:@""])&&component.videoURL==nil)
        {
            // image only
            self.photos=[[NSMutableArray alloc]init];
            [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:component.largeImageURL]]];
            [self showImageController];
            
            
        }
        else if(component.largeImageURL!=nil&&component.fullDescription!=nil&&component.videoURL==nil)
        {
            // image and text
            FoodDescriptionDetailsViewController * viewController=[[FoodDescriptionDetailsViewController alloc]init];
            viewController.titleLblTxtStr=component.title;
            viewController.componetTitleStr=component.componentTitle;
            viewController.detailsTxtViewStr=component.fullDescription;
            viewController.topImagUrl=component.largeImageURL;
            viewController.compontentImgUrl=component.componentIconURL;
            viewController.title=self.title;
            [self.navigationController presentViewController:viewController animated:YES completion:nil];
            
        }
        else if((component.largeImageURL==nil||[component.largeImageURL isEqualToString:@""])&&component.fullDescription!=nil&&component.videoURL==nil)
        {
            //text
            TextDetailsViewController * viewController=[[TextDetailsViewController alloc]init];
            viewController.titleLblTxtStr=component.title;
            viewController.componetTitleStr=component.componentTitle;
            viewController.detailsTxtViewStr=component.fullDescription;
            viewController.compontentImgUrl=component.componentIconURL;
            viewController.title=self.title;
            [self.navigationController presentViewController:viewController animated:YES completion:nil];
            
        }
        
        
    
    else if (component.videoURL!=nil)
    {
        VideoModelDetailsViewController * viewController=[[VideoModelDetailsViewController alloc]init];
        viewController.videoEmbdedUrl=component.videoURL;
        viewController.titleLblTxtStr=component.title;
        viewController.componetTitleStr=component.componentTitle;
        viewController.detailsTxtViewStr=component.fullDescription;
        viewController.topImagUrl=component.largeImageURL;
        viewController.compontentImgUrl=component.componentIconURL;
        viewController.title=self.title;
        [self.navigationController presentViewController:viewController animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //[self.tableView reloadData];


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return componentsArray.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    Component *component = [componentsArray objectAtIndex:section];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    if(component.type == 4){
    [headerView setBackgroundColor:[UIColor clearColor]];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, headerView.frame.size.width - 10, headerView.frame.size.height - 10)];
    title.textAlignment = NSTextAlignmentRight;
   // title.text = component.componentTitle;
    title.font = [UIFont systemFontOfSize:21];
    //[headerView addSubview:title];
    }
    
    return headerView;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int offset;
    NSString * resoulution;
    if(IS_IPHONE_6)
    {
        offset=50;
        resoulution=@"@2x";
    }
    
    else if(IS_IPHONE_6_PLUS)
    {
          offset=90;
          resoulution=@"@3x";

    }
    else
    {
        resoulution=@"@2x";

        offset=0;
    }
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell ;
 
    NSArray *components = componentsArray;
    Component *component = [components objectAtIndex:indexPath.section];
//   if(component.type==6)
//    CellIdentifier=@"WeatherCustomCell";
      if (component.type == 3)
    {
        CellIdentifier=@"TextTypeCutomCell";
    }
    else    if (component.type == 1)
    {
        CellIdentifier=@"AzkarCustomCellCell";
    }
    else    if (component.type == 2)
    {
        CellIdentifier=@"RamdanVideoCustomCell";
    }
    else    if (component.type == 4)
    {
        CellIdentifier=@"TodayFoodDescriptionCell";
    }
//    else if(component.type==5)
//    {
//        CellIdentifier = @"Amskyaacell";
//        
//    }
    else
        CellIdentifier = @"Cell";
    
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.layer setCornerRadius:6.0f];
        [cell.layer setMasksToBounds:YES];
        [cell.layer setBorderWidth:0.0f];
    
    }
    else{
    UIView *subView = (UIView *)[cell.contentView viewWithTag:11];
        offset=20;
         isAmskyaaLoaded=YES;
    if ([subView superview]) {
        //[subView removeFromSuperview];
       
    }
    }
    
   // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    
   if (component.type == 2){
       cell=  [[[NSBundle mainBundle]loadNibNamed:@"RamdanVideoCustomCell" owner:self options:nil]objectAtIndex:0];
  
  
    if(component.smallImageURL !=nil)
    {
        [((RamdanVideoCustomCell *)cell).videoImage   sd_setImageWithURL:[NSURL URLWithString:component.smallImageURL]  placeholderImage:[UIImage imageNamed:@"place_holder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
  
        
        
    }
       
       if(component.componentIconURL !=nil)
       {
           [((RamdanVideoCustomCell *)cell).cellIconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",component.componentIconURL,resoulution]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
               
           }];
       }
       
      ((RamdanVideoCustomCell *)cell).videoTitle.text = component.title;
       ((RamdanVideoCustomCell *)cell).cellTopTitleLblTxt.text = component.componentTitle;

    
       
    }
   else    if (component.type == 3){
       //text only
       cell=  [[[NSBundle mainBundle]loadNibNamed:@"TextTypeCutomCell" owner:self options:nil]objectAtIndex:0];
       if(component.componentIconURL!=nil)
      [ ((TextTypeCutomCell*)cell).iconCellImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",component.componentIconURL,resoulution]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
           
                    }];
     [ ((TextTypeCutomCell*)cell).titleLblTxt setText:component.title];

       [ ((TextTypeCutomCell*)cell).componentTitleLbl setText:component.componentTitle];
       [ ((TextTypeCutomCell*)cell).detailsLblTxt setText:component.brief];
       if(component.componentIconURL!=nil)
       [((TextTypeCutomCell*)cell).iconCellImg  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",component.componentIconURL,resoulution]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
           
       }];

   }
    
   else    if (component.type == 1){
       //image Only
       cell=  [[[NSBundle mainBundle]loadNibNamed:@"AzkarCustomCellCell" owner:self options:nil]objectAtIndex:0];
       
       [((AzkarCustomCellCell*)cell).cellTopTitleLblTxt setText:component.componentTitle];
       if(component.smallImageURL !=nil)
       [((AzkarCustomCellCell*)cell).cellImgView sd_setImageWithURL:[NSURL URLWithString:component.smallImageURL]  placeholderImage:[UIImage imageNamed:@"place_holder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
          
                  }];
       

       
       
   }
   else    if (component.type == 4){
       //image+text
       cell=  [[[NSBundle mainBundle]loadNibNamed:@"TodayFoodDescriptionCell" owner:self options:nil]objectAtIndex:0];
        if(component.componentIconURL !=nil)
       [ ((TodayFoodDescriptionCell*)cell).cellIconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@.png",component.componentIconURL,resoulution]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
           
       }];
       
       if(component.smallImageURL !=nil)
           [ ((TodayFoodDescriptionCell*)cell).imgView  sd_setImageWithURL:[NSURL URLWithString:component.smallImageURL]  placeholderImage:[UIImage imageNamed:@"place_holder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
               
           }];
       
     
             
       
       [ ((TodayFoodDescriptionCell*)cell).cellTopTitleLblTxt setText:component.componentTitle];
       [ ((TodayFoodDescriptionCell*)cell).titleCellLblTxt setText:component.title];
       [ ((TodayFoodDescriptionCell*)cell).descriptionCellLblTxt setText:component.brief];
       
       
       
   }
    

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
   
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *today = [NSDate date];
    NSString *todaysString = [formatter stringFromDate:today];
    NSDate *todaysDate = [formatter dateFromString:todaysString];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSDate *componentDate = [formatter dateFromString:self.itemDate];
    Component *component = [componentsArray objectAtIndex:indexPath.section];
     if(component.type==5 && [todaysDate compare:componentDate] == NSOrderedSame)
       return 263;
     else  if(component.type==6 && [todaysDate compare:componentDate] == NSOrderedSame)
         return 220;
    else    if (component.type == 3){
            return 205; // text
    }
    else    if (component.type == 4){
        return 344; //food
    }
    else    if (component.type == 1){
           return 295; //azkar
    }
   else
    return 329;//video


}

#pragma - mark get Weather Data
-(void)updateWeatherDayswithData:(NSArray*)forecasts andSection :(NSInteger)section
{
    NSIndexPath * indexPath=[NSIndexPath indexPathForRow:0 inSection:section];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    for (int i=0; i<forecasts.count; i++) {
        Forecast * forecastObj=(Forecast*)[forecasts objectAtIndex:i];
        if([forecastObj.day isEqualToString: @"Sun"])
        {
            [( (WeatherCustomCell*)cell).sundayLowTempLbl setText:forecastObj.low];
            [( (WeatherCustomCell*)cell).sundayHighTempLbl setText:forecastObj.high];
            
        }
        else  if([forecastObj.day isEqualToString: @"Mon"])
        {
            [( (WeatherCustomCell*)cell).mondayLowTempLbl setText:forecastObj.low];
            [( (WeatherCustomCell*)cell).mondayHighTempLbl setText:forecastObj.high];
            
        }
        else  if([forecastObj.day isEqualToString: @"Tue"])
        {
            [( (WeatherCustomCell*)cell).tuesdayLowTempLbl setText:forecastObj.low];
            [( (WeatherCustomCell*)cell).tuesdayHighTempLbl setText:forecastObj.high];
            
        }
        else  if([forecastObj.day isEqualToString: @"Wed"])
        {
            [( (WeatherCustomCell*)cell).wednesdayLowTempLbl setText:forecastObj.low];
            [( (WeatherCustomCell*)cell).wedensdayHighTempLbl setText:forecastObj.high];
            
        }
        else  if([forecastObj.day isEqualToString: @"Thu"])
        {
            [( (WeatherCustomCell*)cell).thursdayLowTempLbl setText:forecastObj.low];
            [( (WeatherCustomCell*)cell).thursdayHighTempLbl setText:forecastObj.high];
            
        }
        
        
    }
}

//#pragma mark - Photo Gallery
-(void)showImageController
{
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO; // Auto-play first video
    
    // Customise selection images to change colours if required

    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:0];
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:[NSString stringWithFormat:@"iOS-SpecialSection-ImageOnlyComponent"]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    // Present
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
    
    // Manipulate
   // [browser showNextPhotoAnimated:YES];
  //  [browser showPreviousPhotoAnimated:YES];
}
#pragma mark - MWPhotoBrowser Delegates
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

#pragma mark - UITableView Delegates 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *components = componentsArray;
    Component *component = [components objectAtIndex:indexPath.section];
     if (component.type !=2&&component.type !=5&&component.type !=6){
         if(component.largeImageURL!=nil&&(component.fullDescription==nil||[component.fullDescription isEqualToString:@""]))
         {
             // image only
             self.photos=[[NSMutableArray alloc]init];
             [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:component.largeImageURL]]];
             [self showImageController];

             
         }
         else if(component.largeImageURL!=nil&&component.fullDescription!=nil)
         {
             // image and text
             FoodDescriptionDetailsViewController * viewController=[[FoodDescriptionDetailsViewController alloc]init];
             viewController.titleLblTxtStr=component.title;
             viewController.componetTitleStr=component.componentTitle;
             viewController.detailsTxtViewStr=component.fullDescription;
             viewController.topImagUrl=component.largeImageURL;
             viewController.compontentImgUrl=component.componentIconURL;
             viewController.title=self.title;
             [self.navigationController presentViewController:viewController animated:YES completion:nil];
             
         }
         else if((component.largeImageURL==nil||[component.largeImageURL isEqualToString:@""])&&component.fullDescription!=nil)
         {
             //text
             TextDetailsViewController * viewController=[[TextDetailsViewController alloc]init];
             viewController.titleLblTxtStr=component.title;
             viewController.componetTitleStr=component.componentTitle;
             viewController.detailsTxtViewStr=component.fullDescription;
             viewController.compontentImgUrl=component.componentIconURL;
             viewController.title=self.title;
             [self.navigationController presentViewController:viewController animated:YES completion:nil];
             
         }

         
     }
     else if (component.type == 2)
     {
         VideoModelDetailsViewController * viewController=[[VideoModelDetailsViewController alloc]init];
         viewController.videoEmbdedUrl=component.videoURL;
         viewController.titleLblTxtStr=component.title;
         viewController.componetTitleStr=component.componentTitle;
         viewController.detailsTxtViewStr=component.fullDescription;
         viewController.topImagUrl=component.largeImageURL;
         viewController.compontentImgUrl=component.componentIconURL;
         viewController.title=self.title;
         [self.navigationController presentViewController:viewController animated:YES completion:nil];
     }
}
#pragma - mark XLPagerTabStripChildItem
- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController

{
    return self.title;
}
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                    withVelocity:(CGPoint)velocity
             targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if(scrollView.contentOffset.y >0) {
        BOOL scroll= true;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"ScrollUpNotification"
         object:userInfo];
    }
    else
    {
        BOOL scroll= false;
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[ NSString stringWithFormat:@"%D",scroll] forKey:@"scroll"];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"ScrollDownNotification"
         object:userInfo];
    }
    


}


@end
