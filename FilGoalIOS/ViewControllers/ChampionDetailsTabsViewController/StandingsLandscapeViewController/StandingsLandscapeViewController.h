//
//  StandingsLandscapeViewController.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 10/18/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandingsLandscapeViewController : GAITrackedViewController
@property(nonatomic,strong) NSArray * standings;
@property(nonatomic,strong) Round * selectedRound;
@property (strong, nonatomic) ChampionShipData * championshipItem;

@end
