//
//  ScorersDetails.h
//
//  Created by MacBookPro  on 5/29/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ScorersDetails : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *scorers;
@property (nonatomic, assign) int totalcount;

+ (ScorersDetails *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
