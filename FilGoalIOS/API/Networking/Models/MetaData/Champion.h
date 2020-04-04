//
//  Champion.h
//
//  Created by MacBookPro  on 6/4/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Champion : NSObject <NSCoding>

@property (nonatomic, assign) int displayorder;
@property (nonatomic, assign) int champId;
@property (nonatomic, assign) int numRounds;
@property (nonatomic, retain) NSString *champLogo;
@property (nonatomic, retain) NSString *champName;
@property (nonatomic, assign) int champType;
@property (nonatomic, assign) BOOL hasGroups;
@property (nonatomic, assign) int sectionid;

+ (Champion *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
