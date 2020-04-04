//
//	Albums.h
//
//	Create by Nada Gamal on 20/9/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Album.h"

@interface Albums : NSObject

@property (nonatomic, strong) NSArray * albums;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) Album * info;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(instancetype)initWithArrayList:(NSArray*)responseObject;
@end
