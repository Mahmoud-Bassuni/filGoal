//
//  SSOServiceManager.m
//  
//
//  Created by Nada Gamal on 11/21/17.
//

#import "SSOServiceManager.h"
static NSString * const kGrantType=@"password";
static NSString * const kFBExternalLoginEndPoint = @"api/ExternalLogin";
static NSString * const kRegisterEndPoint = @"api/register";
static NSString * const kForgotPasswordEndPoint = @"api/forgotpassword";
static NSString * const kChangePasswordEndPoint = @"api/changepassword";
static NSString * const kEditProfileEndPoint = @"api/account";
static NSString * const kGetUserTeamsEndPoint = @"api/user/team";
static NSString * const kAddUserTeamsEndPoint = @"api/user/team/add";
static NSString * const kUpdateUserTeamEventsEndPoint = @"api/user/team/update";
static NSString * const kDeleteUserTeamEndPoint = @"api/user/team/delete";
static NSString * const kDeleteTeamEventEndPoint = @"api/user/team/deleteevent";
static NSString * const kSSOCrednitialIdentifier = @"SSOCrednitials";
static NSString * const kclientId = @"6b0ba53b-af83-439a-8941-b224a4b245e0";
static  AFHTTPSessionManager *manager;

@implementation SSOServiceManager

+(NSString*)getSSOBaseUrl{
    if([Global getInstance].appInfo.sSOBaseUrl!=nil)
    {
        return [Global getInstance].appInfo.sSOBaseUrl;
    }
    else
        return @"https://sso.sarmady.net/";
}
+(void)loadAFNetwotkingSettings{
    manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kSSOCrednitialIdentifier];
    [manager.requestSerializer setValue:kclientId forHTTPHeaderField:@"ClientId"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken] forHTTPHeaderField:@"Authorization"];
    
}
+(void)changePasswordWithOldPassword:(NSString*)oldPasswordTxt andNewPassword:(NSString*)newPasswordTxt success:(void (^)(id result))success failure:(void (^)(NSError *error))failure {
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kSSOCrednitialIdentifier];

    NSDictionary *parameters = @{
                                 @"OldPassword" : oldPasswordTxt,
                                 @"NewPassword" : newPasswordTxt,
                                 @"ConfirmPassword" : newPasswordTxt
                                 };
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString * body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kChangePasswordEndPoint];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:urlString]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    [req setHTTPMethod:@"POST"];
    [req setValue:kclientId forHTTPHeaderField:@"ClientId"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken] forHTTPHeaderField:@"Authorization"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    User * user = [UserMethods retrieveUserObject];
    if([credential isExpired]&&!user.isFromFacebook)
    {
        [self LoginWithUser:user success:^(id obj) {
            [AFOAuthCredential storeCredential:credential
                                withIdentifier:kSSOCrednitialIdentifier];

            [self changePasswordWithOldPassword:oldPasswordTxt andNewPassword:newPasswordTxt success:^(id result) {
                
                
                
            } failure:^(NSError *error) {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }];
        } failure:^(NSError *error) {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }];
    }
    else
    {
    NSURLSession * session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode == 200)
        {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            success(json);
        }
        else
        {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }
    }] resume];
    }
    
}


+(void)forgotPassword:(NSString*)emailTxt success:(void (^)(id result))success failure:(void (^)(NSError *error))failure {
    NSString * body = [NSString stringWithFormat:@"\"%@\"",emailTxt];;
    
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kForgotPasswordEndPoint];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:urlString]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:kclientId forHTTPHeaderField:@"ClientId"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode == 200)
        {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            success(json);
        }
        else
        {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }
    }] resume];
    
}

+(void)registerUserWith:(User*)user success:(void (^)(id result))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = @{
                                 @"Email" : user.username,
                                 @"Password" : user.password,
                                 @"ConfirmPassword" : user.password,
                                 @"Gender": @(user.gender)
                                 };
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString * body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kRegisterEndPoint];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:urlString]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:kclientId forHTTPHeaderField:@"ClientId"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode == 200)
        {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            success(json);
        }
        else
        {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }
    }] resume];
    
}

//#pragma mark - Get SSO Token which will be login API
+(void)LoginWithUser:(User*)user success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure
{
    AFOAuth2Manager *OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:[NSURL URLWithString:[self getSSOBaseUrl]]
                                    clientID:@""
                                      secret:@""];

    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/token"
                                              username:user.username
                                              password:user.password
                                                 scope:kGrantType
                                               success:^(AFOAuthCredential *credential) {
                                                   [AFOAuthCredential storeCredential:credential
                                                           withIdentifier:kSSOCrednitialIdentifier];
                                                   success(credential);
                                               }
                                               failure:^(NSError *error) {
                                                   NSLog(@"Update %@",error.description);
                                                   IBGLog(@"%@",error.description);
                                                   failure(error);
                                                   
                                               }];
}

//#pragma mark - Facebook Login
+(void)fbLoginWithUser:(User*)user success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure
{
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kFBExternalLoginEndPoint];
    NSDictionary *parameters = @{
                                 @"LoginProvider" : @"Facebook",
                                 @"UserName" : user.username,
                                 @"ExternalAccessToken" : user.password,
                                 @"gender": @(user.gender),
                                 @"UserId":user.userId
                                 };

    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString * body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:urlString]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:kclientId forHTTPHeaderField:@"ClientId"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if(httpResponse.statusCode == 200)
        {
            NSDictionary* responseObject = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            if (!responseObject) {
                if (failure) {
                    failure(nil);
                }
                return;
            }
            AFOAuthCredential *credential = [AFOAuthCredential credentialWithOAuthToken:[responseObject valueForKey:@"access_token"] tokenType:[responseObject valueForKey:@"token_type"]];
            NSString *refreshToken = [responseObject valueForKey:@"refresh_token"];
            if (!refreshToken || [refreshToken isEqual:[NSNull null]]) {
                refreshToken = [parameters valueForKey:@"refresh_token"];
            }
            if([responseObject valueForKey:@"id"] != nil)
            {
                [credential setUserId:[responseObject valueForKey:@"id"]];
            }
            if([responseObject valueForKey:@"username"]!= nil)
            {
                [credential setUsername:[responseObject valueForKey:@"username"]];
            }
            
            if (refreshToken) { // refreshToken is optional in the OAuth2 spec
                [credential setRefreshToken:refreshToken];
            }
            
            NSDate *expireDate = [NSDate distantFuture];
            id expiresIn = [responseObject valueForKey:@"expires_in"];
            if (expiresIn && ![expiresIn isEqual:[NSNull null]]) {
                expireDate = [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
            }
            
            if (expireDate) {
                [credential setExpiration:expireDate];
            }
            
            [AFOAuthCredential storeCredential:credential
                                withIdentifier:kSSOCrednitialIdentifier];
            success(credential);
        }
        else
        {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }
    }] resume];
}

+(void)getUserPreferences:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kGetUserTeamsEndPoint];
    [self loadAFNetwotkingSettings];
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kSSOCrednitialIdentifier];
    User * user = [UserMethods retrieveUserObject];

    if([credential isExpired]&& user != nil)
    {
        [self LoginWithUser:user success:^(id obj) {
            [AFOAuthCredential storeCredential:credential
                                withIdentifier:kSSOCrednitialIdentifier];
            
            [self getUserPreferences:^(id result) {
                
            } failure:^(NSError *error) {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }];
        } failure:^(NSError *error) {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }];
    }
    else
    {
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Update %@",error.description);
        IBGLog(@"%@",error.description);
        failure(error);
    }];
    }
    
}

+(void)addEventsWithEventsIds:(NSArray*)events andTeamId:(NSInteger)teamId andTeamName:(NSString*)teamName success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kAddUserTeamsEndPoint];
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kSSOCrednitialIdentifier];
    
    NSDictionary *parameters = @{
                                 @"EventIds" : events,
                                 @"TeamName" : teamName,
                                 @"TeamId" : [NSString stringWithFormat:@"%li",(long)teamId]
                                 };
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString * body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:urlString]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken] forHTTPHeaderField:@"Authorization"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [req setValue:kclientId forHTTPHeaderField:@"ClientId"];

    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    User * user = [UserMethods retrieveUserObject];
    if([credential isExpired]&& user != nil)
    {
        [self LoginWithUser:user success:^(id obj) {
            [AFOAuthCredential storeCredential:credential
                                withIdentifier:kSSOCrednitialIdentifier];
            
            [self addEventsWithEventsIds:events andTeamId:teamId  andTeamName:teamName success:^(id result) {

            } failure:^(NSError *error) {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }];
        } failure:^(NSError *error) {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }];
    }
    else
    {
        NSURLSession * session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if(httpResponse.statusCode == 200)
            {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                success(json);
            }
            else
            {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }
        }] resume];
    }
    
}
+(void)updateTeamsEventsWithIds:(NSArray*)events andTeamId:(NSInteger)teamId andTeamName:(NSString*)teamName success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kUpdateUserTeamEventsEndPoint];
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kSSOCrednitialIdentifier];
    
    NSDictionary *parameters = @{
                                 @"EventIds" : events,
                                 @"TeamName" : teamName,
                                 @"TeamId" : [NSString stringWithFormat:@"%li",(long)teamId]
                                 };
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString * body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:urlString]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    [req setHTTPMethod:@"PUT"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken] forHTTPHeaderField:@"Authorization"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [req setValue:kclientId forHTTPHeaderField:@"ClientId"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    User * user = [UserMethods retrieveUserObject];
    if([credential isExpired]&& user != nil)
    {
        [self LoginWithUser:user success:^(id obj) {
            [AFOAuthCredential storeCredential:credential
                                withIdentifier:kSSOCrednitialIdentifier];
            
            [self updateTeamsEventsWithIds:events andTeamId:teamId  andTeamName:teamName success:^(id result) {
                
            } failure:^(NSError *error) {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }];
        } failure:^(NSError *error) {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }];
    }
    else
    {
        NSURLSession * session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if(httpResponse.statusCode == 200)
            {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                success(json);
            }
            else
            {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }
        }] resume];
    }
    
}
+(void)deleteEventWithEventId:(NSInteger)eventId andTeamId:(NSInteger)teamId success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kDeleteTeamEventEndPoint];
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kSSOCrednitialIdentifier];
    
    NSDictionary *parameters = @{
                                 @"EventId" : @(eventId),
                                 @"TeamId" : @(teamId)
                                 };
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString * body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:urlString]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken] forHTTPHeaderField:@"Authorization"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [req setValue:kclientId forHTTPHeaderField:@"ClientId"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    User * user = [UserMethods retrieveUserObject];
    if([credential isExpired]&& user != nil)
    {
        [self LoginWithUser:user success:^(id obj) {
            [AFOAuthCredential storeCredential:credential
                                withIdentifier:kSSOCrednitialIdentifier];
            
            [self deleteEventWithEventId:eventId andTeamId:teamId success:^(id result) {
                
            } failure:^(NSError *error) {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }];
        } failure:^(NSError *error) {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }];
    }
    else
    {
        NSURLSession * session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if(httpResponse.statusCode == 200)
            {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                success(json);
            }
            else
            {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }
        }] resume];
    }
}
+(void)deleteTeamEventsWithTeamId:(NSInteger)teamId success:(void (^)(id result))success failure:(void (^)(NSError *error))failure
{
    NSString * urlString= [NSString stringWithFormat:@"%@%@",[self getSSOBaseUrl],kDeleteUserTeamEndPoint];
    AFOAuthCredential *credential =[AFOAuthCredential retrieveCredentialWithIdentifier:kSSOCrednitialIdentifier];
    
    NSDictionary *parameters = @{
                                 @"TeamId" : @(teamId)
                                 };
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString * body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:urlString]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[body length]];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:[NSString stringWithFormat:@"Bearer %@", credential.accessToken] forHTTPHeaderField:@"Authorization"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [req setValue:kclientId forHTTPHeaderField:@"ClientId"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    User * user = [UserMethods retrieveUserObject];
    if([credential isExpired]&& user != nil)
    {
        [self LoginWithUser:user success:^(id obj) {
            [AFOAuthCredential storeCredential:credential
                                withIdentifier:kSSOCrednitialIdentifier];
            
            [self deleteTeamEventsWithTeamId:teamId success:^(id result) {
                
            } failure:^(NSError *error) {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }];
        } failure:^(NSError *error) {
            NSLog(@"Update %@",error.description);
            IBGLog(@"%@",error.description);
            failure(error);
        }];
    }
    else
    {
        NSURLSession * session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
        [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            if(httpResponse.statusCode == 200)
            {
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&error];
                success(json);
            }
            else
            {
                NSLog(@"Update %@",error.description);
                IBGLog(@"%@",error.description);
                failure(error);
            }
        }] resume];
    }
}
@end
