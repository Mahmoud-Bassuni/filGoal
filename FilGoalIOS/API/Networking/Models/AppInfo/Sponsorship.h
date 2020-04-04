//
//	Sponsorship.h
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "CoSponsor.h"
#import "MainSponsor.h"
#import "LandingScreenWithVerticalButton.h"
@interface Sponsorship : NSObject

@property (nonatomic, strong) CoSponsor * coSponsor;
@property (nonatomic, strong) MainSponsor * mainSponsor;
@property (nonatomic, strong) NSString * sponsorCountryCode;
@property (nonatomic, strong) NSString * sponsorPath;
@property (nonatomic, strong) LandingScreenWithVerticalButton * landingScreenWithVerticalButtons;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
