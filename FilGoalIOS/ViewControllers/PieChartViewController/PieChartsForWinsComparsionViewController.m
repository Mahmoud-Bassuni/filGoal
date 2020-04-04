//
//  PieChartsForWinsComparsionViewController.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/16/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import "PieChartsForWinsComparsionViewController.h"
#import "PNChart.h"

@interface PieChartsForWinsComparsionViewController ()

@end

@implementation PieChartsForWinsComparsionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self drawPieCharts];
    [self.homeTeamWinVsawayTeamLbl setText:[NSString stringWithFormat:@"فوز %@ علي %@ ",self.matchItem.homeTeamName,self.matchItem.awayTeamName]];
      [self.awayTeamWinVshomeTeamLbl setText:[NSString stringWithFormat:@"فوز %@ علي %@ ",self.matchItem.awayTeamName,self.matchItem.homeTeamName]];
    [self.nOfWiningMatchesLblForhomeTeam setText:[NSString stringWithFormat:@"فوز %ld مباريات ",(long)self.winComparsion.firstTeamWins]];
    [self.nOfWiningMatchesLblForawayTeam setText:[NSString stringWithFormat:@"فوز %ld مباريات",(long)self.winComparsion.secondTeamWins]];
    [self.nOfDrawMatchesLbl setText:[NSString stringWithFormat:@"تعادل %ld مباريات",(long)self.winComparsion.draws]];
    [self.homeTeamLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)self.matchItem.homeTeamId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios"]];
    [self.awayTeamLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%li.png",TEAM_IMAGES_BASE_URL,(long)self.matchItem.awayTeamId]] placeholderImage:[UIImage imageNamed:@"match_holder_ios"]];


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    
}
-(void) drawPieCharts
{
    CGFloat  firstTeamWinsValue=(int)round((self.winComparsion.firstTeamWins/(float)self.winComparsion.totalMatches)*100);
    CGFloat  secTeamWinsValue=(int)round((self.winComparsion.secondTeamWins/(float)self.winComparsion.totalMatches)*100);
    CGFloat  drawsValue=(int)round((self.winComparsion.draws/(float)self.winComparsion.totalMatches)*100);
    if(self.winComparsion.totalMatches==0)
    {
        firstTeamWinsValue=0;
        secTeamWinsValue=0;
        drawsValue=0;
    }
    PNCircleChart * firstTeamCircleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0,0.0,100.0, 100.0)
                                                                          total:@100
                                                                        current:@(firstTeamWinsValue)
                                                                      clockwise:YES];
    firstTeamCircleChart.backgroundColor = [UIColor clearColor];
    [firstTeamCircleChart setStrokeColor:PNGreen];
    [firstTeamCircleChart setLineWidth:[NSNumber numberWithFloat:6.0]];
    [firstTeamCircleChart strokeChart];
    [self.homeTeamWinView addSubview:firstTeamCircleChart];
    
    
    PNCircleChart * secTeamCircleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0,0.0, 100.0, 100.0)
                                                                        total:@100
                                                                      current:@(secTeamWinsValue)
                                                                    clockwise:YES];
    secTeamCircleChart.backgroundColor = [UIColor clearColor];
    [secTeamCircleChart setStrokeColor:[UIColor colorWithRed:255.0/255.0 green:199.0/255.0  blue:19.0/255.0  alpha:1.0]];
    [secTeamCircleChart setLineWidth:[NSNumber numberWithFloat:6.0]];
    [secTeamCircleChart strokeChart];
    [self.awayTeamWinView addSubview:secTeamCircleChart];
    
    PNCircleChart * drawCircleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0,0.0,100.0, 100.0)
                                                                     total:@100
                                                                   current:@(drawsValue)
                                                                 clockwise:YES];
    drawCircleChart.backgroundColor = [UIColor clearColor];
    [drawCircleChart setStrokeColor:[UIColor darkGrayColor]];
    [drawCircleChart setLineWidth:[NSNumber numberWithFloat:6.0]];
    [drawCircleChart strokeChart];
    [self.drawTeamsView addSubview:drawCircleChart];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
