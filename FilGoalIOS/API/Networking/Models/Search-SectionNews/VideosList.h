//
//  SearchNews.h
//
//  Created by MacBookPro  on 2/23/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VideosList : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *videos;

+ (VideosList *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
-(instancetype)initWithArrayList:(NSArray*)responseObject;

@end
