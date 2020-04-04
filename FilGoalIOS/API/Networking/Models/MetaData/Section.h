//
//  Sections.h
//
//  Created by MacBookPro  on 5/11/14
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>




#import <UIKit/UIKit.h>
#import "ChampId.h"

@interface Section : NSObject

@property (nonatomic, assign) NSInteger champId;
@property (nonatomic, strong) NSArray * champIds;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, assign) NSInteger sectionId;
@property (nonatomic, strong) NSString * sectionName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
