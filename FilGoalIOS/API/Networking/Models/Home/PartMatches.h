//
//  PartMatches.h
//
//  Created by MacBookPro  on 5/6/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PartMatches : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *today;
@property (nonatomic, retain) NSArray *yesterday;
@property (nonatomic, retain) NSArray *tommorrow;
@property (nonatomic, retain) NSArray *live;

+ (PartMatches *)modelObjectWithDictionary:(NSDictionary *)dict;
//- (id)initWithDictionary:(NSDictionary *)dict;
//- (NSDictionary *)dictionaryRepresentation;

@end
