

//
//  NewsWidgetModel.m
//  HybridDynamicProject
//
//  Created by Yomna Ahmed on 7/2/15.
//  Copyright (c) 2015 Mohamed Mansour. All rights reserved.
//

#import "NewsWidgetModel.h"

@implementation NewsWidgetModel
#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.article_id = [aDecoder decodeObjectForKey:@"news_id"];
    self.article_title = [aDecoder decodeObjectForKey:@"news_title"];
   // self.img_url = [aDecoder decodeObjectForKey:@"img_url"];
    //self.pubDate = [aDecoder decodeObjectForKey:@"pubDate"];
    self.thumbnail = [aDecoder decodeObjectForKey:@"large"];
   // self.resources= [aDecoder decodeObjectForKey:@"resources"];
   //self.Num_Of_Shares= [aDecoder decodeIntForKey:@"Num_Of_Shares"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.article_id forKey:@"news_id"];
    [aCoder encodeObject:self.article_title forKey:@"news_title"];
   // [aCoder encodeObject:self.img_url forKey:@"img_url"];
    //[aCoder encodeObject:self.pubDate forKey:@"pubDate"];
    [aCoder encodeObject:self.thumbnail forKey:@"large"];
   // [aCoder encodeObject:self.resources forKey:@"resources"];
   // [aCoder encodeInt:self.Num_Of_Shares forKey:@"Num_Of_Shares"];
}

@end
