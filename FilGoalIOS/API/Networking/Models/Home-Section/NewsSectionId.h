//
//  NewsSectionId.h
//
//  Created by MacBookPro  on 2/23/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NewsSectionId : NSObject <NSCoding>

@property (nonatomic, assign) int sectionId;

+ (NewsSectionId *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
