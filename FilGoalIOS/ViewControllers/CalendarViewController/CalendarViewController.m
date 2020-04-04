//
//  CalendarViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/2/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()
{
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    
    NSDate *_dateSelected;
    NSString * firstDateStr;
    NSString * lastDateStr;
    NSMutableDictionary *_eventsByDate;

}
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EEEE dd MMMM"];
    self.dateFormatter.locale =  [NSLocale localeWithLocaleIdentifier:@"ar"];
    _todayDate = [NSDate date];
    [self.selectedDateLbl setText:[_dateFormatter stringFromDate:_todayDate]];
    [self setupFSCalendar];
    [self getMatchesByDate];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}
-(void)setupFSCalendar
{
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
   // [self createRandomEvents];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _calendarMenuView.scrollView.scrollEnabled = NO; // Scroll not supported with JTVerticalCalendarView
    _calendarManager.dateHelper.calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    _calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"ar"];
    
    //Rotate contentView(Scroll View) 180 degree
    
    _calendarManager.contentView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    //Rotate weekDayView label 180 degree
    for (UIView *contentViewSubview in _calendarManager.contentView.subviews) {
        if ([contentViewSubview class] == [JTCalendarPageView class]) {
            for (UIView *view in contentViewSubview.subviews) {
                if ([view class] == [JTCalendarWeekDayView class]) {
                    for (UIView *weekDayView in ((JTCalendarWeekDayView*)view).dayViews) {
                        weekDayView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
                    }
                }
            }
        }
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


#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.textLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);

    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
      //  dayView.dotView.image = [UIImage new];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
      //  dayView.dotView.image = [UIImage new];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
       // [self getMatchesByDate];
        dayView.circleView.hidden = YES;
       // dayView.dotView.backgroundColor =  [UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];;
      //  dayView.dotView.image = [UIImage imageNamed:@"ball-sm"];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
       // dayView.dotView.backgroundColor =  [UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
     //   dayView.dotView.image = [UIImage imageNamed:@"ball-sm"];

        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if(_eventsByDate.count>0)
    {
    if([self haveEventForDay:dayView.date]){
       //   dayView.textLabel.backgroundColor = [UIColor colorWithRed:0.90 green:0.65 blue:0.23 alpha:1.0];
      //  dayView.dotView.image = [UIImage imageNamed:@"ball-sm"];
        dayView.dotView.hidden = NO;
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor =[UIColor colorWithRed:0.99 green:0.86 blue:0.59 alpha:1.0];
    }
    else{
       // dayView.textLabel.backgroundColor = [UIColor clearColor];
        dayView.dotView.backgroundColor =  [UIColor clearColor];
       // dayView.dotView.image = [UIImage new];

        dayView.dotView.hidden = YES;
    }
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    [self.selectedDateLbl setText:[_dateFormatter stringFromDate:_dateSelected]];

    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:SELECTED_DATE object:_dateSelected];
}

- (IBAction)doneBtnPressed:(id)sender
{
    [self.view removeFromSuperview];
}
- (IBAction)cancelBtnPressed:(id)sender
{
    [self.view removeFromSuperview];

}

-(void) getMatchesByDate
{
    [self setDates:_calendarContentView.date];
    NSDictionary * paramDic=[[NSDictionary alloc]initWithObjects:@[[NSString stringWithFormat:@"Date lt %@ and Date ge %@",[NSString stringWithFormat:@"%@T22:00:00Z",lastDateStr],[NSString stringWithFormat:@"%@T22:00:00Z",firstDateStr]],@"Date"] forKeys:@[@"$filter",@"$select"]];
    [WServicesManager getDataWithURLString:[NSString stringWithFormat:MatchesListAPI_Url,[WServicesManager getSportsEngineApiBaseURL]] andParameters:paramDic WithObjectName:@"MatchesList" andAuthenticationType:SportesEngineAPIs success:^(id success)
     {
         MatchesList * matchesList = success;
         NSArray * dates = matchesList.dates;
         [self setDictionaryOfDates:dates];
         [self.calendarManager reload];
         
     }failure:^(NSError *error) {
         IBGLog(@"Match By Date Error  : %@",error);
         
         
     }];
}

-(void)setDictionaryOfDates: (NSArray*) dates
{
    _eventsByDate = [NSMutableDictionary new];

    for (int i=0;i<dates.count;i++)
    {
    NSString *key = [dates objectAtIndex:i];
    
    if(!_eventsByDate[key]){
        _eventsByDate[key] = [NSMutableArray new];
    }

        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"dd/MM/yyyy"];

    [_eventsByDate[key] addObject:[outputFormatter dateFromString:key]];
    }
}
-(void) setDates:(NSDate*)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:date];
    [components setMonth:[components month]];
    [components setDay:1];
    NSDate *firstDate = [gregorian dateFromComponents:components];
    [components setMonth:[components month]+1];
    [components setDay:0];
    NSDate * afterDate = [gregorian dateFromComponents:components];
   // currentDate = [outputFormatter stringFromDate:date];
    lastDateStr = [outputFormatter stringFromDate:afterDate];
    firstDateStr = [outputFormatter stringFromDate:firstDate];

}
- (BOOL)haveEventForDay:(NSDate *)date
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *key = [outputFormatter stringFromDate:date];
    
    if(_eventsByDate[key] && [(NSArray*)_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    [self getMatchesByDate];

}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    [self getMatchesByDate];

}

@end
