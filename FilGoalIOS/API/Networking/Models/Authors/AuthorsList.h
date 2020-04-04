//
//	AuthorsList.h
//
//	Create by Nada Gamal on 3/12/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Author.h"
#import "FilteredOpinion.h"
#import "FilteredOpinion.h"

@interface AuthorsList : NSObject

@property (nonatomic, strong) NSArray * featured;
@property (nonatomic, strong) NSArray * filteredOpinions;
@property (nonatomic, assign) BOOL isMoreItemsExists;
@property (nonatomic, strong) NSArray * mostViewedOpinions;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
