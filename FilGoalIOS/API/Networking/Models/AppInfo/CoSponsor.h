//
//	CoSponsor.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface CoSponsor : NSObject

@property (nonatomic, strong) NSArray * champsIds;
@property (nonatomic, strong) NSArray * sectionIds;
//Contains NSDictionary
@property (nonatomic, strong) NSArray * champsUrl;
@property (nonatomic, strong) NSArray * sectionUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
