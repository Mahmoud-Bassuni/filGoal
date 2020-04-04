//
//  User.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/15/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "User.h"

@implementation User
NSString *const kUsername = @"username";
NSString *const kPassword = @"password";
NSString *const kUserId = @"userId";
NSString *const kGender = @"gender";
NSString *const kProfileImgUrl = @"profileImgUrl";
NSString *const kIsFromFacebook = @"isFromFacebook";
NSString *const kTeams = @"Teams";

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.username = [aDecoder decodeObjectForKey:kUsername];
    self.password = [aDecoder decodeObjectForKey:kPassword];
    self.userId = [aDecoder decodeObjectForKey:kUserId];
    self.gender = [aDecoder decodeBoolForKey:kGender];
    self.profileImgUrl= [aDecoder decodeObjectForKey:kProfileImgUrl];
    self.isFromFacebook= [aDecoder decodeBoolForKey:kIsFromFacebook];
    self.teamsDic = [aDecoder decodeObjectForKey:kTeams];

    return self;

}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.username forKey:kUsername];
    [aCoder encodeObject:self.password forKey:kPassword];
    [aCoder encodeObject:self.userId forKey:kUserId];
    [aCoder encodeBool:self.gender forKey:kGender];
    [aCoder encodeBool:self.isFromFacebook forKey:kIsFromFacebook];
    [aCoder encodeObject:self.profileImgUrl forKey:kProfileImgUrl];
    [aCoder encodeObject:self.teamsDic forKey:kTeams];

    
}
@end
