//
//  MatchInfoViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 5/13/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import "MatchInfoViewController.h"
#import "MatchInfoHeaderViewCellTableViewCell.h"
@interface MatchInfoViewController ()

@end

@implementation MatchInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Navigationbar
    self.contentSizeInPopup = CGSizeMake(300, 300);
    self.popupController.navigationBarHidden = YES;
    self.view.layer.cornerRadius=6.0;
    self.view.clipsToBounds=YES;
    self.popupController.containerView.layer.cornerRadius=6.0;
    self.popupController.containerView.clipsToBounds=YES;
}
-(void)viewDidAppear:(BOOL)animated{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = [self.items objectAtIndex:indexPath.section];
    NSArray * list = dic.allValues[0] ;
    MatchInfoHeaderViewCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MatchInfoHeaderViewCellTableViewCell"];
    if(cell == nil){
    cell = [[[NSBundle mainBundle] loadNibNamed:@"MatchInfoHeaderViewCellTableViewCell" owner:self options:nil]objectAtIndex:0];
    }
    cell.iconImgView.hidden = YES;
    cell.cellTitleLbl.font = [UIFont fontWithName:@"DINNextLTW23Regular" size:13];
    cell.cellTitleLbl.text = list[indexPath.row];
    cell.cellTitleLbl.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary * dic = [self.items objectAtIndex:section];
    NSArray * list = dic.allValues[0] ;
    return list.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MatchInfoHeaderViewCellTableViewCell * headerCell = [[[NSBundle mainBundle] loadNibNamed:@"MatchInfoHeaderViewCellTableViewCell" owner:self options:nil]objectAtIndex:0];
    headerCell.iconImgView.hidden = NO;
    UIView * subView = [[UIView alloc]initWithFrame: CGRectMake(10, 0, Screenwidth-20, 40)];
    headerCell.frame = CGRectMake(0, 0,subView.frame.size.width , 40);
    subView.backgroundColor = [UIColor colorWithRed:0.23 green:0.24 blue:0.24 alpha:1.0];
    NSDictionary * dic = [self.items objectAtIndex:section];
    [headerCell.cellTitleLbl setText:[dic.allKeys objectAtIndex:0]];
    [headerCell.iconImgView setImage:[UIImage imageNamed:self.itemsIcons[section]]];
    return headerCell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
