//
//  NSString+Validation.m
//  ContactCars
//
//  Created by Hesham Abd-Elmegid on 1/4/15.
//  Copyright (c) 2015 Sarmady. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isValidPhoneNumber {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(01)[012][0-9]{8}"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    
    NSRange textRange = NSMakeRange(0, self.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:self
                                                  options:0
                                                    range:textRange];
    
    if (self.length > 0 && NSEqualRanges(matchRange, textRange)) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

@end
