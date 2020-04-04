//
//  CalendarViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 7/2/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>
@interface CalendarViewController : UIViewController<JTCalendarDelegate>
//@property (strong, nonatomic) IBOutlet UIView *calendarView;
//@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic)JTCalendarManager * calendarManager;
@property (weak, nonatomic) IBOutlet JTVerticalCalendarView *calendarContentView;
@property (strong, nonatomic) IBOutlet UILabel *selectedDateLbl;
- (IBAction)doneBtnPressed:(id)sender;
- (IBAction)cancelBtnPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *doneBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;


@end
