//
//  UniversalLinks.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/12/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UniversalLinks : NSObject
+(void)handleUniversalLinksWithUrlString:(NSString*)url andIsRedirectedUrl:(BOOL)isRedirect;
@end
