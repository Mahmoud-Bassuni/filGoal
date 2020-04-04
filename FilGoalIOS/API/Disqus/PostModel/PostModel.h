//
//  WidgetMatchModel.h
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/2/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostModel : NSObject

@property (nonatomic, assign) NSNumber  *dislikes;
@property (nonatomic, assign) NSNumber  *likes;
@property (nonatomic, assign) BOOL  isParent;
@property (nonatomic, assign) BOOL  isChild;
@property (retain, nonatomic) NSNumber *threadId;
@property (retain, nonatomic) NSNumber *identifier;
@property (retain, nonatomic) NSNumber *parentIdenfier;
@property (retain, nonatomic) NSString *authorUsername;
@property (retain, nonatomic) NSString *authorName;
@property (retain, nonatomic) NSURL *authorAvatarURL;
@property (retain, nonatomic) NSString *rawMessage;
@property (retain, nonatomic) NSDate *creationDate;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic)  NSMutableArray*childPosts;
- (id)initWithJSONDictionary:(NSDictionary *)dictionary;































@end
