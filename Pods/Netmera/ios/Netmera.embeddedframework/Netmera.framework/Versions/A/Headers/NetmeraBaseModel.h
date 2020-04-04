//
//  BaseModel.h
//  NMCommons
//
//  Created by Yavuz Nuzumlali on 05/06/14.
//  Copyright (c) 2014 Muhammed Yavuz Nuzumlali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetmeraSerializableModel.h"

extern NSString *const kNetmeraClassJSONKey;

@interface NetmeraBaseModel : NSObject <NetmeraSerializableModel>

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue NS_DESIGNATED_INITIALIZER;

+ (NSDictionary *)keyPathPropertySelectorMapping;
+ (NSDictionary *)keyPathClassMapping;
- (NSAttributedString *)attributedDebugDescription;

@end