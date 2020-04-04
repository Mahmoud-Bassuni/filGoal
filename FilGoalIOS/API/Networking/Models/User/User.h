//
//  User.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/15/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
@property(strong,nonatomic) NSString * username;
@property(strong,nonatomic) NSString * password;
@property(strong,nonatomic) NSString * userId;
@property(strong,nonatomic) NSString * profileImgUrl;
@property(strong,nonatomic) NSMutableDictionary * teamsDic;
@property(assign,nonatomic) bool gender;
@property(assign,nonatomic) BOOL isFromFacebook;



@end
