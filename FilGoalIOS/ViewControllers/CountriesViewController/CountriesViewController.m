//
//  CountriesViewController.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 9/5/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "CountriesViewController.h"
#import "CountryTableViewCell.h"
#import "MZFormSheetController.h"
@interface CountriesViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation CountriesViewController
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}
-(void)viewDidAppear:(BOOL)animated
{
    self.countriesList = [[NSMutableArray alloc]init];
    [self getCountriesList];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryTableViewCell"];
    Country * item = [[Country alloc]initWithDictionary:[self.countriesList objectAtIndex:indexPath.row]];
    if (cell == nil) {
        cell = [[CountryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CountryTableViewCell"];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CountryTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    if([item.name isEqualToString:self.selectedCountryName])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setSelected:YES];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell setSelected:NO];
    }
    cell.countryNameLbl.text = item.name;
    if(item.flag != nil)
    [cell.flagImgView sd_setImageWithURL:[NSURL URLWithString:item.flag]];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countriesList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma mark - Get Countries List
-(void)getCountriesList
{
    NSDictionary* dictionary=[[NSDictionary alloc]initWithObjects:@[@"64",@"ar-eg"] forKeys:@[@"FlagSize",@"accept-language"]];
    [WServicesManager getDataWithURLString:kGetCountriesList andParameters:dictionary WithObjectName:nil andAuthenticationType:NoAuth success:^(NSArray * countries)
     {
         [self.activityIndicator stopAnimating];
         self.countriesList=countries;
         if(self.countriesList.count>0)
         {
             [self.tableView reloadData];
         }
         
     }
    failure:^(NSError *error) {
        [self showDefaultNetworkingErrorMessageForError:error
                                         refreshHandler:^{
                                             [self getCountriesList];
                                         }];
                                       
                                   }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Country * country=[[Country alloc]initWithDictionary:(NSDictionary*)[self.countriesList objectAtIndex:indexPath.row]];
    
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        [delegate didSelectCountryObj:country];
    }];
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
