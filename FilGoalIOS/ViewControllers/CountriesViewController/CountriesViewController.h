//
//  CountriesViewController.h
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/5/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CountryPickerDelegate <UIPickerViewDelegate>

- (void) didSelectCountryObj:(Country*)country;

@end
@interface CountriesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak_delegate) id<CountryPickerDelegate> delegate;
@property (nonatomic,strong)NSArray * countriesList;
@property (nonatomic, copy) NSString *selectedCountryName;
@property (nonatomic, copy) NSString *selectedCountryCode;
@property (nonatomic, copy) NSLocale *selectedLocale;


@end
