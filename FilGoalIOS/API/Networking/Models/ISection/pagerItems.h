//
//  pagerItems.h
//  Reyada
//
//  Created by Ahmed Kotb on 5/12/16.
//  Copyright © 2016 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pagerItems : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * source;
@property (nonatomic, strong) NSString * date;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
