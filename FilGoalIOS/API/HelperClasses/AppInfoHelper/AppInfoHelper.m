//
//  AppInfoHelper.m
//  FilGoalIOS
//
//  Created by Nada Gamal Mohamed on 5/10/18.
//  Copyright © 2018 Sarmady. All rights reserved.
//

#import "AppInfoHelper.h"

@implementation AppInfoHelper
+(NSString*)getArabicCountryNameByCountryCode:(NSString*)countryCode
{
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar_EG"];
    NSString *country = [usLocale displayNameForKey: NSLocaleCountryCode value: countryCode];
    return country;
}
+(void)saveAreaDetails:(AreaDetails*)areaDetails{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sarmady.FilgoalIOS"];
    Country * country=[[Country alloc]init];
    country.flag=[NSString stringWithFormat:kFlagImageUrl,@"64",areaDetails.code];
    country.name=[self getArabicCountryNameByCountryCode:areaDetails.code];
    [Global getInstance].timeZone=areaDetails.timezone;
    [Global getInstance].country=country;
    [Global getInstance].timeOffset=[areaDetails.timezone floatValue];
    NSData * countryItem = [NSKeyedArchiver archivedDataWithRootObject:[Global getInstance].country];
    [[NSUserDefaults standardUserDefaults]setObject:[areaDetails.code uppercaseString] forKey:@"SponsorCountryCode"];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:countryItem forKey:COUNTRY];
    [defaults setObject:[NSString stringWithFormat:@"%f",[Global getInstance].timeOffset]   forKey:TIME_OFFSET];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [defaults synchronize];
}
+(Country*)getCountry{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData * countryData = [prefs objectForKey:COUNTRY];
    Country * countryItem  = [[Country alloc]init];
    if([countryData isKindOfClass:[NSData class]])
    {
        countryItem = (Country *)[NSKeyedUnarchiver unarchiveObjectWithData: countryData];
        [Global getInstance].country=countryItem;
    }
    return  countryItem;
}
@end
