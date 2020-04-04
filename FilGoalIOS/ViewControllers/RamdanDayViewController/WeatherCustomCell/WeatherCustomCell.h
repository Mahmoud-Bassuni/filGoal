//
//  WeatherCustomCell.h
//  Reyada
//
//  Created by Nada Gamal on 5/11/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *weatherStatusImg;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLblTxt;
@property (strong, nonatomic) IBOutlet UILabel *weatherStatusTxtLbl;
@property (strong, nonatomic) IBOutlet UILabel *lowTempLbl;
@property (weak, nonatomic) IBOutlet UIView *cellIconImg;
@property (strong, nonatomic) IBOutlet UILabel *highTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *sundayLowTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *mondayLowTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayLowTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayLowTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *thursdayLowTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *sundayHighTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *mondayHighTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayHighTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *wedensdayHighTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *thursdayHighTempLbl;
@property (strong, nonatomic) IBOutlet UILabel *sundayLbl;

@property (strong, nonatomic) IBOutlet UILabel *mondayLbl;

@property (strong, nonatomic) IBOutlet UILabel *tuesdayLbl;

@property (strong, nonatomic) IBOutlet UILabel *wednesdayLbl;

@property (strong, nonatomic) IBOutlet UILabel *thursdayLbl;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *celuisDegreeLbl;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *highTemperaturesLbls;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lowTemperaturesLbls;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *days;
@end
