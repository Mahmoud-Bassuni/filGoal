//
//  MatchActionCellLoader.m
//  FilGoalIOS
//
//  Created by MohamedMansour on 5/8/14.
//  Copyright (c) 2014 MohamedMansour. All rights reserved.
//

#import "MatchActionCellLoader.h"
#import  "UIImageView+WebCache.h"
#import "MatchEvent.h"
#import "Constants.h"
@implementation MatchActionCellLoader

+(UITableViewCell*)loadCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withMatchAction:(MatchEvent *)item clubone:(int) clubone clubtwo:(int)clubtwo {
    
    NSLog(@"debugDescription: %@", [item debugDescription]);
    NSLog(@"description: %@", [item description]);
    NSLog(@"bId: %ld", (long)[item playerBId]);
    NSLog(@"aId: %ld", (long)[item playerAId]);
    
    int x1=Screenwidth-130;
    int x2=0;
    
    UITableViewCell *cell =nil;
    
    NSString *nibname=@"MatchActionCellLoader";
    
    //if (cell == nil)
        cell =  [[[NSBundle mainBundle]loadNibNamed:nibname owner:self options:nil]lastObject];
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    else{  cell.contentView.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
    }
     UILabel *minuteLabel = (UILabel *)[cell viewWithTag:1000];
   // MatchEvent * action=[item objectAtIndex:0];
    int y1=minuteLabel.frame.origin.y+3;
    int y2=minuteLabel.frame.origin.y+3;

    if(item.time>item.matchStatusestime)
    {
       // minuteLabel.text=[NSString stringWithFormat:@"%li",(long)item.time];
        minuteLabel.text=[NSString stringWithFormat:@"%li+%li",(long)item.matchStatusestime,(item.time-item.matchStatusestime)];

  
    }
   else
       minuteLabel.text=[NSString stringWithFormat:@"%li",(long)item.time];

    //NSArray *sctions= item.actions;
   // for(MatchEvent *action in item){
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstPlayerBtnPressed:)];
    UITapGestureRecognizer * otherPlayerGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(secPlayerBtnPressed:)];
    otherPlayerGesture.numberOfTapsRequired = 1;
    gesture.numberOfTapsRequired = 1;
    UILabel *player;
    UILabel * otherPlayer;
        if (item.teamId==clubone) {
            
            UIImageView *actionImage=[[UIImageView alloc]initWithFrame:CGRectMake(x1, y1+3, 20, 20) ];
            //[actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d",EVENTS_BASE_URL,(int)action.matchEventTypeId]]];
            [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d.png",EVENTS_BASE_URL,(int)item.matchEventTypeId]]];
            player=[[UILabel alloc] initWithFrame:CGRectMake(x1 +30, y1, 100, 20)];
            [player setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:11]];
            [player setTextAlignment:NSTextAlignmentLeft];
            player.userInteractionEnabled = YES;

           otherPlayer=[[UILabel alloc] initWithFrame:CGRectMake(x1 +30,y1+30, 100, 20)];
            UIImageView * otherActionImage=[[UIImageView alloc]initWithFrame:CGRectMake(x1, y1+33, 20, 20) ];
            otherPlayer.userInteractionEnabled = YES;

            [otherPlayer setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:11]];
            [otherPlayer setTextAlignment:NSTextAlignmentLeft];

            if(item.playerAId&&item.playerBId!=0)
            {
                player.text=item.playerBName;
                otherPlayer.text=item.playerAName;
                [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-1.png",EVENTS_BASE_URL,(int)item.matchEventTypeId]]];
                [otherActionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-0.png",EVENTS_BASE_URL,(int)item.matchEventTypeId]]];
                [player setTag: item.playerBId];
                [otherPlayer setTag: item.playerAId];


            }
            else if(item.playerAName!=nil)
            {
                //V1 Was
               //player.text=item.playerAName;
               //[otherPlayer setTag: item.playerAId];
                
                //V2 New testing
                player.text=item.playerAName;
                [player setTag: item.playerAId];
            }
            else
            {
            player.text=item.playerBName;
                [player setTag: item.playerBId];

            }
            [cell.contentView addSubview:actionImage];
            [cell.contentView addSubview:otherActionImage];
            [cell.contentView addSubview:player];
            [cell.contentView addSubview:otherPlayer];
            
            y1=y1+30;
            player.userInteractionEnabled = YES;
            otherPlayer.userInteractionEnabled = YES;
           // [player addGestureRecognizer:gesture];
            //[otherPlayer addGestureRecognizer:otherPlayerGesture];
            [player addGestureRecognizer:gesture];
            [otherPlayer addGestureRecognizer:otherPlayerGesture];

        }
        else if (item.teamId==clubtwo) {
           
            UIImageView *actionImage=[[UIImageView alloc]initWithFrame:CGRectMake(x2+110, y2+3, 20, 20) ];
            [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d.png",EVENTS_BASE_URL,(int)item.matchEventTypeId]]];
            player=[[UILabel alloc] initWithFrame:CGRectMake(x2, y2, 100, 20)];
             [player setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:11]];
            [player setTextAlignment:NSTextAlignmentRight];
            otherPlayer=[[UILabel alloc] initWithFrame:CGRectMake(x2,y2+30, 100, 20)];
            [otherPlayer setFont:[UIFont fontWithName:@"DINNextLTW23Regular" size:11]];
            [otherPlayer setTextAlignment:NSTextAlignmentRight];
            UIImageView * otherActionImage=[[UIImageView alloc]initWithFrame:CGRectMake(x2+110, y2+33, 20, 20) ];

            if(item.playerAId&&item.playerBId!=0)
            {
                player.text=item.playerBName;
                otherPlayer.text=item.playerAName;
                [otherPlayer setTag: item.playerAId];
                [player setTag: item.playerBId];

                [actionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-1.png",EVENTS_BASE_URL,(int)item.matchEventTypeId]]];
                [otherActionImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d-0.png",EVENTS_BASE_URL,(int)item.matchEventTypeId]]];
                
            }
            else if(item.playerBName!=nil)
            {
            player.text=item.playerBName;
                [player setTag: item.playerBId];

            }
            else
            {
                //V1 Was
            //player.text=item.playerAName;
            //[otherPlayer setTag: item.playerAId];
                
                //V2 New testing
                player.text=item.playerAName;
                [player setTag: item.playerAId];
                
            }
            [cell.contentView addSubview:actionImage];
            [cell.contentView addSubview:otherActionImage];

            [cell.contentView addSubview:player];
            [cell.contentView addSubview:otherPlayer];

             y2=y2+30;
            player.userInteractionEnabled = YES;
            otherPlayer.userInteractionEnabled = YES;
            [player addGestureRecognizer:gesture];
            [otherPlayer addGestureRecognizer:otherPlayerGesture];

        }
  // }
   
 
 


    return cell;

}


+ (void)secPlayerBtnPressed:(UITapGestureRecognizer*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.view.tag;
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    NSLog(@"%d", (int)sender.view.tag);
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:playerProfileVC animated:YES];
}

+ (void)firstPlayerBtnPressed:(UITapGestureRecognizer*)sender {
    AppDelegate * appDelegate = (AppDelegate*) [[UIApplication sharedApplication]delegate];
    Player * player = [[Player alloc]init];
    player.playerId = (int)sender.view.tag;
    NSLog(@"%d", (int)sender.view.tag);
    PlayerProfileViewController * playerProfileVC = [[PlayerProfileViewController alloc]init];
    playerProfileVC.player = player;
    UINavigationController * navigationContoller = [appDelegate getSelectedNavigationController];
    [navigationContoller pushViewController:playerProfileVC animated:YES];
}
@end
