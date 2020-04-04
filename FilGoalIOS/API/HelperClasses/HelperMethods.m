//
//  HelperMethods.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "HelperMethods.h"

@implementation HelperMethods
//prama mark - Concatenate Url parameters
+(NSString*)addQueryStringToUrlString:(NSString *)urlString withDictionary:(NSDictionary *)dictionary
{
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:urlString];
    
    for (id key in dictionary) {
        NSString *keyString = [key description];
        NSString *valueString = [[dictionary objectForKey:key] description];
        
        if ([urlWithQuerystring rangeOfString:@"?"].location == NSNotFound) {
            [urlWithQuerystring appendFormat:@"?%@=%@", keyString, valueString];
        } else {
            [urlWithQuerystring appendFormat:@"&%@=%@", keyString, valueString];
        }
    }
    return urlWithQuerystring;
}
@end
