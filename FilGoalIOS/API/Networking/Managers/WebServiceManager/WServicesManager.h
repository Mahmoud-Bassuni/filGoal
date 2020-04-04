//
//  WServicesManager.h
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "HelperMethods.h"
#import "AFNetworking.h"
#import "HMACAuthentication.h"
#import "FeaturedCompontent.h"
#import "FeaturedSectionItems.h"
@interface WServicesManager : AFHTTPSessionManager
typedef  NS_ENUM(NSUInteger, AuthType)
{
    SportesEngineAPIs = 1,
    CMSAPIs = 2,
    SSOAPIs = 4,
    NoAuth =3,
    
    
};

+(NSString*)getSportsEngineApiBaseURL;
+(NSString*)getApiBaseURL;
+(NSString*)getSSOBaseUrl;
+ (void)getFeaturedComponent:(NSDictionary*)parameters andJsonSrcUrl:(NSString *)source success:(void (^)(FeaturedCompontent* component))success failure:(void (^)(NSError *error))failure;

+ (void)getsectionItems:(NSDictionary*)parameters success:(void (^)(FeaturedSectionItems* section))success failure:(void (^)(NSError *error))failure;

+(void)getDataWithURLString:(NSString *)urlString andParameters:(id)parameters WithObjectName:(NSString *)obj andAuthenticationType:(AuthType)type success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;

+(void)getToken;
-(void)loadAFNetwotkingSettings:(AuthType)type;
-(NSString*)getHMACHeaderStringWithUrl:(NSString*)urlString andParameters:(NSDictionary*)parameters;
-(NSString*)getHMACHeaderString:(NSString*)urlString andParameters:(NSDictionary*)parameters andTimestamp:(NSString*)timestamp;
//+(void)postDataWithURLString:(NSString *)urlString andParameters:(id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
//+(void)postDataWithURLString:(NSString *)urlString body:(NSString*)body andParameters:(id)parameters success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;
@end

