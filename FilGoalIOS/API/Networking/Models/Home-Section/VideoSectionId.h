//
//  VideoSectionId.h
//
//  Created by MacBookPro  on 6/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VideoSectionId : NSObject <NSCoding>

@property (nonatomic, assign) double sectionId;

+ (VideoSectionId *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
