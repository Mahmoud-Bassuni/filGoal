//
//  MatchActionCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "LineUpCellLoader.h"
#import  "Images.h"
#import  "UIImageView+WebCache.h"
#import "MatchTeamsSquad.h"

@implementation LineUpCellLoader

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withline1:(MatchTeamsSquad *)item1 withline2:(MatchTeamsSquad *)item2
{
    
    int x2=20;
    int x1=Screenwidth-30;
    
    
    UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *nibname=@"LineUpCellLoader";
    
    //if (cell == nil)
    cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    else{  cell.contentView.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
    }
    UILabel *player1Label = (UILabel *)[cell viewWithTag:1000];
    UILabel *player2Label = (UILabel *)[cell viewWithTag:1002];
    UILabel *playertype1Label = (UILabel *)[cell viewWithTag:1001];
    UILabel *playertype2Label = (UILabel *)[cell viewWithTag:1003];
    
    UILabel *playerNo1Label = (UILabel *)[cell viewWithTag:1004];
    UILabel *playerNo2Label = (UILabel *)[cell viewWithTag:1005];
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstPlayerBtnPressed:)];
    UITapGestureRecognizer * otherPlayerGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secPlayerBtnPressed:)];
    otherPlayerGesture.numberOfTapsRequired = 1;
    gesture.numberOfTapsRequired = 1;
    player1Label.userInteractionEnabled = YES;
    player2Label.userInteractionEnabled = YES;
    [player1Label setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:player1Label.font.pointSize]];
    [playertype1Label setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:playertype1Label.font.pointSize]];
    [player2Label setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:player2Label.font.pointSize]];
    [playertype2Label setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:playertype2Label.font.pointSize]];
    [playerNo1Label setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:player2Label.font.pointSize]];
    [playerNo2Label setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:playertype2Label.font.pointSize]];
    
    player1Label.text=[NSString stringWithFormat:@"%@",(item1.personName==nil)?@"":item1.personName];
    playertype1Label.text=[NSString stringWithFormat:@"%@",(item1.playerPositionName==nil)?@"":item1.playerPositionName];
    playerNo1Label.text=[NSString stringWithFormat:@"%li",(long)item1.shirtNumber];
    playerNo2Label.text=[NSString stringWithFormat:@"%li",(long)item2.shirtNumber];
    
    
    int y1=10;
    int y2=10;
    NSArray *p1actions= item1.playerMatchEvents;
    for(MatchEvent *action in p1actions){
        UIImageView *actionImage=[[UIImageView alloc]initWithFrame:CGRectMake(x1, y1, 15, 15) ];
        
        if(action.playerAId&&action.playerBId!=0 && item1.personId == action.playerBId)
        {
            [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-1.png",EVENTS_BASE_URL,(int)action.matchEventTypeId]]];
        }
        else if(action.playerAId&&action.playerBId!=0 && item1.personId == action.playerAId)
        {
            [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-0.png",EVENTS_BASE_URL,(int)action.matchEventTypeId]]];
            
        }
        
        else
        [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d.png",EVENTS_BASE_URL,(int)action.matchEventTypeId]]];
        
        [cell.contentView addSubview:actionImage];
        
        x1=x1-20;
        
    }
    player1Label.tag = item1.personId;

    if (item2!=nil) {
        
        player2Label.text=[NSString stringWithFormat:@"%@",(item2.personName==nil)?@"":item2.personName];
        playertype2Label.text=[NSString stringWithFormat:@"%@",(item2.playerPositionName==nil)?@"":item2.playerPositionName];
        NSArray *p2actions= item2.playerMatchEvents;
        for(MatchEvent *action in p2actions){
            UIImageView *actionImage=[[UIImageView alloc]initWithFrame:CGRectMake(x2, y2, 15, 15) ];
            if(action.playerAId&&action.playerBId!=0 && item2.personId == action.playerBId)
            {
                [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-1.png",EVENTS_BASE_URL,(int)action.matchEventTypeId]]];
            }
            else if(action.playerAId&&action.playerBId!=0 && item2.personId == action.playerAId)
            {
                [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-0.png",EVENTS_BASE_URL,(int)action.matchEventTypeId]]];

            }
            else
                [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d.png",EVENTS_BASE_URL,(int)action.matchEventTypeId]]];

            [cell.contentView addSubview:actionImage];
            x2=x2+20;


        }
        player2Label.tag = item2.personId;

    }
    
    [player1Label addGestureRecognizer:gesture];
    [player2Label addGestureRecognizer:otherPlayerGesture];
    
    return cell;
    
}
+ (void)secPlayerBtnPressed:(UITapGestureRecognizer*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.view.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

+ (void)firstPlayerBtnPressed:(UITapGestureRecognizer*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.view.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

@end
