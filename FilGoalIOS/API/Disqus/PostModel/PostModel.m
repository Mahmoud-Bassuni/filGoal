//
//  WidgetMatchModel.m
//  FilGoalIOS
//
//  Created by Yomna Ahmed on 11/2/14.
//  Copyright (c) 2014 MohamedMansour . All rights reserved.
//

#import "PostModel.h"

@implementation PostModel

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    }

- (id)initWithJSONDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        id obj = [dictionary valueForKey:@"id"];
        if (obj && [obj isKindOfClass:[NSString class]]) {
            self.identifier = [NSNumber numberWithInt:[obj intValue]];
        }
        
        
        obj = [dictionary valueForKey:@"parent"];
        if (obj && [obj isKindOfClass:[NSNumber class]]) {
            self.parentIdenfier = obj;
            self.isChild=true;
        }
        else
        {
            self.isChild=false;
            self.isParent=true;
        }
        self.likes = [dictionary valueForKey:@"likes"];
         self.dislikes = [dictionary valueForKey:@"dislikes"];
        //self.likes = obj[@"likes"] ;
       // self.dislikes = obj[@"dislikes"];
        
        obj = [dictionary valueForKey:@"author"];
        if (obj && [obj isKindOfClass:[NSDictionary class]]) {
            
            id authorObj = [obj valueForKey:@"username"];
            if (authorObj && [authorObj isKindOfClass:[NSString class]]) {
                self.authorUsername = authorObj;
            }
            
            authorObj = [obj valueForKey:@"name"];
            if (authorObj && [authorObj isKindOfClass:[NSString class]]) {
                self.authorName = authorObj;
            }
            
            
           
            
            
            authorObj = [obj valueForKey:@"avatar"];
            if (authorObj && [authorObj isKindOfClass:[NSDictionary class]]) {
               
                NSDictionary *large = authorObj[@"large"];
                self.authorAvatarURL =[NSURL URLWithString: large[@"permalink"]];;
                //self.authorAvatarURL = [NSURL URLWithString:[authorObj valueForKey:@"permalink"]];
            }
        }
        
        obj = [dictionary valueForKey:@"raw_message"];
        if (obj && [obj isKindOfClass:[NSString class]]) {
            self.rawMessage = obj;
        }
        
        obj = [dictionary valueForKey:@"createdAt"];
        if (obj && [obj isKindOfClass:[NSString class]]) {
            
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
            self.creationDate = [dateFormat dateFromString:obj];
          //   = [self dateFromISO8601:obj];
        }
        
        obj = [dictionary valueForKey:@"thread"];
        if (obj && [obj isKindOfClass:[NSNumber class]]) {
            self.threadId = obj;
        }
        
        
        
    }
    return self;
}

@end
