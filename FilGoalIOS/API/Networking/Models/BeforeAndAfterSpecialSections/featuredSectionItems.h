//
//  FeaturedSectionItems.h
//  Reyada
//
//  Created by Ahmed Kotb on 5/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AfterSection.h"

@interface FeaturedSectionItems : NSObject

@property (nonatomic, strong) NSArray * section;
@property (nonatomic, strong) AfterSection * afterSection;
@property (nonatomic, strong) NSString * baseUrl;
@property (nonatomic, strong) AfterSection * beforeSection;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
