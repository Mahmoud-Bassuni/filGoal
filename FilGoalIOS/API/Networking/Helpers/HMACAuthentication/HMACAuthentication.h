//
//  HMACAuthentication.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 8/21/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMACAuthentication : NSObject
-(NSString*)getHeaderStringUsingUrlString:(NSString*)urlString andParameters:(NSDictionary*)parameters andTimestamp:(NSString*)timestamp;
- (id)initWithAppId:(NSString*) appId andApiSecret:(NSString*) apiKey;
@end
