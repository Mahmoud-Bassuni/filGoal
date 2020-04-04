//
//  UIFont+DefaultFonts.m
//  FilGoal
//
//  Created by Nada Gamal on 12/11/17.
//  Copyright (c) 2017 Sarmady. All rights reserved.
//

#import "UIFont+DefaultFonts.h"

@implementation UIFont (DefaultFonts)

+ (UIFont *)defaultFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"DinnextRegular" size:size];
}

+ (UIFont *)defaultBoldFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"DinNextBold" size:size];
}

+ (UIFont *)defaultMeduimFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"DINNextLTArabic-Medium" size:size];
}

@end
