//
//	TeamPreference.h
//
//	Create by Nada Gamal on 6/12/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface TeamPreference : NSObject

@property (nonatomic, strong) NSMutableSet * eventIds;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, assign) NSInteger teamId;
@property (nonatomic, assign) NSInteger userId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
