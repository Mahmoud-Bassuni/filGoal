//
//	Team.h
//
//	Create by Nada Gamal on 6/8/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Player.h"

@interface Team : NSObject

@property (nonatomic, assign) NSInteger championshipId;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSArray * players;
@property (nonatomic, assign) NSInteger teamId;
@property (nonatomic, strong) NSString * teamName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end