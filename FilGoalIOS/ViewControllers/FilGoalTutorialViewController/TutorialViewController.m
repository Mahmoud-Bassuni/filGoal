//
//  TutorialViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 9/13/15.
//  Copyright © 2015 Sarmady. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()
{
    NSMutableArray * tutorialImgs;
}
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
   if( IS_IPHONE_4)
       tutorialImgs=[[NSMutableArray alloc]initWithArray:@[@"1_4s.jpg",@"2_4s.jpg",@"3_4s.jpg",@"4_4s.jpg",@"5_4s.jpg"]];
    else if (IS_IPHONE_5)
        tutorialImgs=[[NSMutableArray alloc]initWithArray:@[@"1_5.jpg",@"2_5.jpg",@"3_5.jpg",@"4_5.jpg",@"5_5.jpg"]];
    else if (IS_IPHONE_6)
        tutorialImgs=[[NSMutableArray alloc]initWithArray:@[@"1_6.jpg",@"2_6.jpg",@"3_6.jpg",@"4_6.jpg",@"5_6.jpg"]];
    else
        tutorialImgs=[[NSMutableArray alloc]initWithArray:@[@"1_6p.jpg",@"2_6p.jpg",@"3_6p.jpg",@"4_6p.jpg",@"5_6p.jpg"]];


   self.pageControl.currentPage = 0;
    CGFloat frameX =[[UIScreen mainScreen]bounds].size.width;
    CGFloat frameY = Screenheight-self.pageControl.frame.size.height; //padding for UIpageControl

       self.pageControl.numberOfPages = 5;
    
    for(int i = 0; i < 5; i++)
    {
        UIImageView*imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[tutorialImgs objectAtIndex:i]]];
           // imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        //imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
            imageView.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width * i, 0.0,[[UIScreen mainScreen]bounds].size.width,  [[UIScreen mainScreen]bounds].size.height -120);
            //imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.scrollView addSubview:imageView];
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.window.frame.size.height>500) {
        self. scrollView.contentSize = CGSizeMake(frameX*5, frameY-50);

    }
    else{
        self. scrollView.contentSize = CGSizeMake(frameX*5, frameY-100);
        
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page=1;
    if(self.scrollView.contentOffset.x<0){
        page=3;
        CGPoint point=self.scrollView.contentOffset;
        point.x=(3*Screenwidth);
        
        [self.scrollView setContentOffset:point animated:YES];
    }
    else if(self.scrollView.contentOffset.x==0)
        page=0;
    else
        page =  self.scrollView.contentOffset.x  / pageWidth;
    
    self.pageControl.currentPage = page;
    
}
- (IBAction)changePage:(id)sender {
    int page = (int) self.pageControl.currentPage;
    CGRect frame =  self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [ self.scrollView scrollRectToVisible:frame animated:YES];
    
   // self.pageControlUsed = YES;
}
-(void)pageTurn:(UIPageControl *) page
{
    
}
-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
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
