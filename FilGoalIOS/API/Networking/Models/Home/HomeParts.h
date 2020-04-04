//
//  HomeParts.h
//
//  Created by MacBookPro  on 5/6/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeItems;

@interface HomeParts : NSObject <NSCoding>

@property (nonatomic, retain) HomeItems *items;
@property (nonatomic, retain) NSString *partName;
@property (nonatomic, assign) int partType;

+ (HomeParts *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
