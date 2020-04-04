//
//  MetaData.h
//
//  Created by MacBookPro  on 5/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MetaData : NSObject <NSCoding>

@property (nonatomic, retain) NSArray *sections;
@property (nonatomic, retain) NSArray *types;
@property (nonatomic, retain) NSArray *champions;

+ (MetaData *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
