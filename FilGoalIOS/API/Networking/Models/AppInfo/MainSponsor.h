//
//    MainSponsor.h
//
//    Create by Nada Gamal on 21/5/2018
//    Copyright © 2018. All rights reserved.
//

//    Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "AppSponsor.h"
#import "PerContentTypeSponsor.h"
#import "PredictSponsor.h"
#import "CoSponsor.h"

@interface MainSponsor : NSObject

@property (nonatomic, strong) AppSponsor * appSponsor;
@property (nonatomic, strong) PerContentTypeSponsor * perContentTypeSponsor;
@property (nonatomic, strong) PredictSponsor * predictSponsor;
@property (nonatomic, strong) CoSponsor * specialSponsor;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
