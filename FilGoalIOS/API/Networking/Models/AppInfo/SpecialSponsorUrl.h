//
//  SpecialSponsorUrl.h
//  FilGoalIOS
//
//  Created by Sarmady on 4/1/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SpecialSponsorUrl : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * category;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
