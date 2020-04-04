//
//  Items.h
//
//  Created by MacBookPro  on 5/6/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HomeItems : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *partVideos;
//@property (nonatomic, retain) NSArray *partMatches;
@property (nonatomic, retain) NSArray *partNews;
@property (nonatomic, retain) NSArray *partAlbums;
@property (nonatomic, retain) NSArray *partPolls;


+ (HomeItems *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
