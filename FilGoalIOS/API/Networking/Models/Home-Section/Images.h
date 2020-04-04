//
//  Images.h
//
//  Created by MacBookPro  on 2/23/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Images : NSObject <NSCoding>

@property (nonatomic, retain) NSString *small;
@property (nonatomic, retain) NSString *large;
@property (nonatomic, retain) NSString *caption;

+ (Images *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
