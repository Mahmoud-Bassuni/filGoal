//
//  Types.h
//
//  Created by MacBookPro  on 5/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Type : NSObject <NSCoding>

@property (nonatomic, assign) int typeId;
@property (nonatomic, retain) NSString *typeName;

+ (Type *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
