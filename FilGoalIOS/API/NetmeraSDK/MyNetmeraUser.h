//
//  MyNetmeraUser.h
//  Akhbarak
//
//  Created by Nada Gamal on 10/23/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "User.h"
#import "TeamPreference.h"
#import <Netmera/Netmera.h>
@interface MyNetmeraUser : NetmeraUser
@property(nonatomic, strong) NSArray *matchStatus;

@property(nonatomic, strong) NSArray *matchEvent;

@property(nonatomic, strong) NSArray *matchFinalScore;

@property(nonatomic, strong) NSArray *matchTeamSquads;
-(void)updateUser:(User*)user;
-(void)updateUserWithTeam:(TeamPreference*)team;
@end
