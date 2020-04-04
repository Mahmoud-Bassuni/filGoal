//
//	MatchComments.h
//
//	Create by Mohamed Mansour on 11/8/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "MatchComment.h"

@interface MatchComments : NSObject

@property (nonatomic, strong) NSMutableArray * matchComments;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
