//
//  WServicesManager.m
//  FilGoalIOS
//
//  Created by Nada Gamal on 11/22/17.
//  Copyright © 2017 Sarmady. All rights reserved.
//

#import "WServicesManager.h"
@implementation WServicesManager
{
    
}
static  AFHTTPSessionManager *manager;
static NSString * const kClientID=@"FG";
static NSString * const kUserName=@"FilGoalIOS";
static NSString * const kPassword=@"F!lgo@L@$poRtsEng!ne";
static NSString * const kGrantType=@"password";
static NSString * const kClientSecret=@"F!LGo@L2016";
static NSString * timestamp = @"";
+(NSString*)getApiBaseURL{
    
    [[[WServicesManager alloc]init] loadAFNetwotkingSettings:CMSAPIs];
    if([Global getInstance].appInfo==nil)
    {
        return @"https://api.filgoal.com";
    }
    else
        // return @"https://api.filgoal.com";
        return [Global getInstance].appInfo.oldAPIsBaseUrl;
    
}

+(NSString*)getSportsEngineApiBaseURL{
    [[[WServicesManager alloc]init] loadAFNetwotkingSettings:SportesEngineAPIs];
    // return @"http://sg.seapi.sarmady.net/";
    
    //SMGL
    if([Global getInstance].appInfo==nil) {
        return @"https://seapi.filgoal.com/";
    } else {
        NSLog(@"SMGL BASE URL Global: %@", [Global getInstance].appInfo.sportesEngineBaseUrl);
        return [Global getInstance].appInfo.sportesEngineBaseUrl;
    }
    
    //return @"https://seapi.filgoal.com/";
    //return @"https://ios-api.filgoal.com/";
}
-(void)loadAFNetwotkingSettings:(AuthType)type{
    manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //[Instabug enableLoggingForURLSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kCrednitialIdentifier];
    if(type == SportesEngineAPIs)
    {
        [manager.requestSerializer setValue:@"ar-EG" forHTTPHeaderField:@"Accept-Language"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken] forHTTPHeaderField:@"Authorization"];
        
    }
    else if (type == CMSAPIs)
    {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%i",2] forHTTPHeaderField:@"api-version"];
    }
    
}


-(NSString*)getHMACHeaderStringWithUrl:(NSString*)urlString andParameters:(NSDictionary*)parameters andTimestamp:(NSString*)timestamp{
    
    HMACAuthentication * hmac;
    if([Global getInstance].appInfo.hMacAppKey== nil && [Global getInstance].appInfo.hMacAppId == nil)
    {
        hmac = [[HMACAuthentication alloc]initWithAppId:HMAC_APP_ID andApiSecret:HMAC_API_KEY];
        
    }
    else
    {
        hmac = [[HMACAuthentication alloc]initWithAppId:[Global getInstance].appInfo.hMacAppId andApiSecret:[Global getInstance].appInfo.hMacAppKey];
        
    }
    return [hmac getHeaderStringUsingUrlString:urlString andParameters:parameters andTimestamp:timestamp];
}


-(NSString*)getHMACHeaderString:(NSString*)urlString andParameters:(NSDictionary*)parameters andTimestamp:(NSString*)timestamp{
    
    HMACAuthentication * hmac;
    if([Global getInstance].appInfo.hMacAppKey== nil && [Global getInstance].appInfo.hMacAppId == nil)
    {
        hmac = [[HMACAuthentication alloc]initWithAppId:HMAC_APP_ID andApiSecret:HMAC_API_KEY];
        
    }
    else
    {
        hmac = [[HMACAuthentication alloc]initWithAppId:[Global getInstance].appInfo.hMacAppId andApiSecret:[Global getInstance].appInfo.hMacAppKey];
        
    }
    return [hmac getHeaderStringUsingUrlString:urlString andParameters:parameters andTimestamp:timestamp];
}

+ (void)getFeaturedComponent:(NSDictionary*)parameters andJsonSrcUrl:(NSString *)source success:(void (^)(FeaturedCompontent* component))success failure:(void (^)(NSError *error))failure{
    
    [manager GET:source parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        FeaturedCompontent *component=[[FeaturedCompontent alloc]init];
        component = [component initWithDictionary:responseObject];
        if (component==nil) {
        }
        else{
            success(component);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}


+ (void)getsectionItems:(NSDictionary*)parameters success:(void (^)(FeaturedSectionItems* section))success failure:(void (^)(NSError *error))failure{
    
    [manager GET:[parameters objectForKey:@"JsonUrl"] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        FeaturedSectionItems *section=[[FeaturedSectionItems alloc]init];
        section = [section initWithDictionary:responseObject];
        if (section==nil) {
            //failure();
        }
        else{
            success(section);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];
    
    
    
    
    
}
+(void)addCMSHeadersWithUrlString:(NSString*)urlString andParameters:(NSMutableDictionary*)parameters
{
    urlString = [[HelperMethods addQueryStringToUrlString:urlString  withDictionary:parameters]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    parameters = nil;
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [[[WServicesManager alloc]init] getHMACHeaderStringWithUrl:urlString andParameters:parameters andTimestamp:timestamp]]forHTTPHeaderField:@"Authorization"];
    if([urlString rangeOfString:NewsDetailsAPI].location != NSNotFound)
    {
        if([[parameters objectForKey:@"ISREFRESH"] isEqual:@1])
        {
            [manager.requestSerializer setValue:[NSString stringWithFormat:@"%i",true]forHTTPHeaderField:@"RefreshCache"];
        }
        else
        {
            [manager.requestSerializer setValue:[NSString stringWithFormat:@"%i",false]forHTTPHeaderField:@"RefreshCache"];
            
        }
        [parameters removeObjectForKey:@"ISREFRESH"];
    }
    // timestamp = @"";
}
+(void)getDataWithURLString:(NSString *)urlString andParameters:(id)parameters WithObjectName:(NSString *)obj andAuthenticationType:(AuthType)type success:(void (^)(id result))success failure:(void (^)(NSError *error))failure {
    
    if(manager == nil)
    {
        [[[WServicesManager alloc]init] loadAFNetwotkingSettings:NoAuth];
    }
    if([urlString.lowercaseString containsString:@"appinfo"]) {
        [[[WServicesManager alloc]init] loadAFNetwotkingSettings:NoAuth];
    }
    if(type == CMSAPIs)
    {
        //[self addCMSHeadersWithUrlString:urlString andParameters:parameters];

                                if([urlString rangeOfString:@"news/details"].location != NSNotFound)
        {
            if([[parameters objectForKey:@"ISREFRESH"] isEqual:@1])
            {
                [manager.requestSerializer setValue:[NSString stringWithFormat:@"%i",true]forHTTPHeaderField:@"RefreshCache"];
            }
            else
            {
                [manager.requestSerializer setValue:[NSString stringWithFormat:@"%i",false]forHTTPHeaderField:@"RefreshCache"];
                
            }
            [parameters removeObjectForKey:@"ISREFRESH"];
        }
        urlString = [[HelperMethods addQueryStringToUrlString:urlString  withDictionary:parameters]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        parameters = nil;
        NSLog(@"header: %@", [NSString stringWithFormat:@"%@", [[[WServicesManager alloc]init] getHMACHeaderStringWithUrl:urlString andParameters:parameters andTimestamp:timestamp]]);
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [[[WServicesManager alloc]init] getHMACHeaderStringWithUrl:urlString andParameters:parameters andTimestamp:timestamp]]forHTTPHeaderField:@"Authorization"];
    }
    
    IBGLog(@"service UrlString: %@ ,\nparameters : %@ , \nmanager: %@",urlString,parameters, manager.description);
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        id object = NSClassFromString(obj);
        if (object == nil) {
            success(responseObject);
        }
        else{
            
            if([responseObject isKindOfClass:[NSArray class]]&&([obj isEqualToString:@"Albums"]||[obj isEqualToString:@"NewsList"] ||[obj isEqualToString:@"VideosList"]))
            {
                object = [[object alloc]initWithArrayList:(NSArray*)responseObject];
                success(object);
            }
            else
            {
                object=[[object alloc] initWithDictionary:(NSDictionary*)responseObject];
                success(object);
            }
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        IBGLog(@"Error: %@, \noperation: %@, \n%@, \n%@, \n%@, \n%@", error, operation.taskDescription, operation.description, operation.originalRequest, operation.originalRequest.HTTPBody, operation.originalRequest.HTTPBodyStream);
        //failure(error);
        NSInteger statusCode = 0;
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
        statusCode = httpResponse.statusCode;
        if (statusCode == 401) {
            manager.responseSerializer = [AFJSONResponseSerializer
                                          serializerWithReadingOptions:NSJSONReadingAllowFragments];
            if(type == CMSAPIs)
            {
                [manager GET:ServerTimeAPI parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
                    
                    //double time = [responseObject doubleValue] - 6;
                    timestamp = [NSString stringWithFormat:@"%@",responseObject];
                    [self getDataWithURLString:urlString andParameters:parameters WithObjectName:obj andAuthenticationType:type success:^(id result) {
                        id object = NSClassFromString(obj);
                        if (object == nil) {
                            success(result);
                        }
                        else{
                            if([result isKindOfClass:NSClassFromString(obj)])
                            {
                                success(result);
                                
                            }
                            else
                            {
                                object=[[object alloc] initWithDictionary:(NSDictionary*)result];
                                success(object);
                            }
                        }
                    }
                                       failure:^(NSError *error) {
                                           failure(error);
                                           
                                       }];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failure(error);
                }];
            }
            else
            {
                //sportesEngine
                [self getToken];
                [[[WServicesManager alloc]init] loadAFNetwotkingSettings:SportesEngineAPIs];
                [self getDataWithURLString:urlString andParameters:parameters WithObjectName:obj andAuthenticationType:type success:^(id result) {
                    id object = NSClassFromString(obj);
                    if (object == nil) {
                        success(result);
                    }
                    else{
                        if([result isKindOfClass:NSClassFromString(obj)])
                        {
                            success(result);
                            
                        }
                        else
                        {
                            object=[[object alloc] initWithDictionary:(NSDictionary*)result];
                            success(object);
                        }
                        
                    }
                }
                                   failure:^(NSError *error) {
                                       failure(error);
                                       
                                   }];
                
                
            }
            
        }
        else
        {
            failure(error);
        }
        
    }];
    
    
    
    
}

+(void)getToken
{
    IBGLog(@"\n\n SMGL getToken 1");
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:[NSURL URLWithString:[self getSportsEngineApiBaseURL]]
                                    clientID:kClientID
                                      secret:kClientSecret];
    
    IBGLog(@"SMGL clientID : %@",kClientID);
    IBGLog(@"SMGL secret : %@",kClientSecret);

    
    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/oauth/token"
                                              username:kUserName
                                              password:kPassword
                                                 scope:kGrantType
                                               success:^(AFOAuthCredential *credential) {
                                                   [AFOAuthCredential storeCredential:credential
                                                                       withIdentifier:kCrednitialIdentifier];
                                               }
                                               failure:^(NSError *error) {
                                                   IBGLog(@"\n\ngetToken Token  Error  : %@ \n",error);
                                                   IBGLog(@"\n\nlocalized description Error : %@ \n",error.localizedDescription);
                                               }];
}



@end

