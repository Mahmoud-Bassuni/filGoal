//
//  AppColor.m
//  FilGoalIOS
//
//  Created by Nada Mohamed on 8/23/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor(AppColor)

+ (UIColor *) mainAppYellowColor {
    return [UIColor colorWithRed:0.94 green:0.64 blue:0.02 alpha:1.0];
}

+ (UIColor *) mainAppDarkGrayColor {
    return  [UIColor colorWithRed:0.09 green:0.09 blue:0.09 alpha:1.0];
}

+ (UIColor *) secondGrayColor {
    return [UIColor colorWithRed:0.18 green:0.18 blue:0.19 alpha:1.0];
}

+(UIColor *) navigationBarColor
{
    return  [UIColor colorWithRed:43.0/255.0 green:43.0/255.0 blue:43.0/255.0 alpha:1.0];
}
+ (UIColor *)lightGrayAppColor {
    return [UIColor colorWithWhite:240.0f / 255.0f alpha:1.0f];
}
+ (UIColor *)greyColor {
    return [UIColor colorWithWhite:88.0f / 255.0f alpha:1.0f];
}
+ (UIColor *)fa_brownishGreyColor {
    return [UIColor colorWithWhite:93.0f / 255.0f alpha:1.0f];
}
+ (UIColor *)fa_whiteFourColor {
    return [UIColor colorWithWhite:239.0f / 255.0f alpha:1.0f];
}
@end
