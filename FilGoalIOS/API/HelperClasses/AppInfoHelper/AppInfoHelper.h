//
//  AppInfoHelper.h
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 5/10/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfoHelper : NSObject
+(void)saveAreaDetails:(AreaDetails*)areaDetails;
+(NSString*)getArabicCountryNameByCountryCode:(NSString*)countryCode;
+(Country*)getCountry;
@end
