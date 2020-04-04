// AFOAuth2Manager.m
//
// Copyright (c) 2012-2014 AFNetworking (http://afnetworking.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE

#import "AFOAuth2Manager.h"
#import "AFOAuthCredential.h"
#import "AFHTTPSessionManager.h"


NSString * const kAFOAuthClientCredentialsGrantType = @"client_credentials";
NSString * const kAFOAuthPasswordCredentialsGrantType = @"password";
NSString * const kAFOAuthCodeGrantType = @"authorization_code";
NSString * const kAFOAuthRefreshGrantType = @"refresh_token";

NSString * const AFOAuth2ErrorDomain = @"com.alamofire.networking.oauth2.error";

// See: http://tools.ietf.org/html/rfc6749#section-5.2
static NSError * AFErrorFromRFC6749Section5_2Error(id object) {
    if (![object valueForKey:@"error"] || [[object valueForKey:@"error"] isEqual:[NSNull null]]) {
        return nil;
    }
    
    NSMutableDictionary *mutableUserInfo = [NSMutableDictionary dictionary];
    
    NSString *description = nil;
    if ([object valueForKey:@"error_description"]) {
        description = [object valueForKey:@"error_description"];
    } else {
        if ([[object valueForKey:@"error"] isEqualToString:@"invalid_request"]) {
            description = NSLocalizedStringFromTable(@"The request is missing a required parameter, includes an unsupported parameter value (other than grant type), repeats a parameter, includes multiple credentials, utilizes more than one mechanism for authenticating the client, or is otherwise malformed.", @"AFOAuth2Manager", @"invalid_request");
        } else if ([[object valueForKey:@"error"] isEqualToString:@"invalid_client"]) {
            description = NSLocalizedStringFromTable(@"Client authentication failed (e.g., unknown client, no client authentication included, or unsupported authentication method).  The authorization server MAY return an HTTP 401 (Unauthorized) status code to indicate which HTTP authentication schemes are supported.  If the client attempted to authenticate via the \"Authorization\" request header field, the authorization server MUST respond with an HTTP 401 (Unauthorized) status code and include the \"WWW-Authenticate\" response header field matching the authentication scheme used by the client.", @"AFOAuth2Manager", @"invalid_request");
        } else if ([[object valueForKey:@"error"] isEqualToString:@"invalid_grant"]) {
            description = NSLocalizedStringFromTable(@"The provided authorization grant (e.g., authorization code, resource owner credentials) or refresh token is invalid, expired, revoked, does not match the redirection URI used in the authorization request, or was issued to another client.", @"AFOAuth2Manager", @"invalid_request");
        } else if ([[object valueForKey:@"error"] isEqualToString:@"unauthorized_client"]) {
            description = NSLocalizedStringFromTable(@"The authenticated client is not authorized to use this authorization grant type.", @"AFOAuth2Manager", @"invalid_request");
        } else if ([[object valueForKey:@"error"] isEqualToString:@"unsupported_grant_type"]) {
            description = NSLocalizedStringFromTable(@"The authorization grant type is not supported by the authorization server.", @"AFOAuth2Manager", @"invalid_request");
        }
    }
    
    if (description) {
        mutableUserInfo[NSLocalizedDescriptionKey] = description;
    }
    
    if ([object valueForKey:@"error_uri"]) {
        mutableUserInfo[NSLocalizedRecoverySuggestionErrorKey] = [object valueForKey:@"error_uri"];
    }
    
    return [NSError errorWithDomain:AFOAuth2ErrorDomain code:-1 userInfo:mutableUserInfo];
}

@interface AFOAuth2Manager()
@property (readwrite, nonatomic, copy) NSString *serviceProviderIdentifier;
@property (readwrite, nonatomic, copy) NSString *clientID;
@property (readwrite, nonatomic, copy) NSString *secret;

@end

@implementation AFOAuth2Manager

+ (instancetype) managerWithBaseURL:(NSURL *)url
                           clientID:(NSString *)clientID
                             secret:(NSString *)secret {
    return [self managerWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] clientID:clientID secret:secret];
}

+ (instancetype) managerWithBaseURL:(NSURL *)url
               sessionConfiguration:(NSURLSessionConfiguration *)configuration
                           clientID:(NSString *)clientID
                             secret:(NSString *)secret {
    return [[self alloc] initWithBaseURL:url sessionConfiguration:configuration clientID:clientID secret:secret];
}

- (id)initWithBaseURL:(NSURL *)url
             clientID:(NSString *)clientID
               secret:(NSString *)secret {
    return [self initWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] clientID:clientID secret:secret];
}

- (id)initWithBaseURL:(NSURL *)url
 sessionConfiguration:(NSURLSessionConfiguration *)configuration
             clientID:(NSString *)clientID
               secret:(NSString *)secret {
    NSParameterAssert(url);
    NSParameterAssert(clientID);
    NSParameterAssert(secret);
    
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    
    self.serviceProviderIdentifier = [self.baseURL host];
    self.clientID = clientID;
    self.secret = secret;
    self.useHTTPBasicAuthentication = YES;
    if([self.serviceProviderIdentifier isEqualToString:@"sso.sarmady.net"])
    {
        self.useHTTPBasicAuthentication = NO;

    }
    else
        self.useHTTPBasicAuthentication = YES;

    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    return self;
}

#pragma mark -

- (void)setUseHTTPBasicAuthentication:(BOOL)useHTTPBasicAuthentication {
    _useHTTPBasicAuthentication = useHTTPBasicAuthentication;
    
    if (self.useHTTPBasicAuthentication) {
        if ([self.baseURL.absoluteString containsString:@"predict"]){
            [self.requestSerializer setValue:@"A80AFFA3-F5D8-47E0-897D-24DE682D5C0C" forHTTPHeaderField:@"ClientId"];
        }
        else
        [self.requestSerializer setAuthorizationHeaderFieldWithUsername:self.clientID password:self.secret];
    } else {
        [self.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];

        if([self.serviceProviderIdentifier isEqualToString:@"sso.sarmady.net"])
        {
            [self.requestSerializer setValue:@"6b0ba53b-af83-439a-8941-b224a4b245e0" forHTTPHeaderField:@"ClientId"];
            
        }
    }
}

- (void)setSecret:(NSString *)secret {
    if (!secret) {
        secret = @"";
    }
    
    _secret = secret;
}

#pragma mark - 

- (NSURLSessionTask *)authenticateUsingOAuthWithURLString:(NSString *)URLString
                                                 username:(NSString *)username
                                                 password:(NSString *)password
                                                    scope:(NSString *)scope
                                                  success:(void (^)(AFOAuthCredential * _Nonnull))success
                                                  failure:(void (^)(NSError * _Nonnull))failure {
    NSParameterAssert(username);
    NSParameterAssert(password);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:kAFOAuthPasswordCredentialsGrantType forKey:@"grant_type"];
    [parameters setValue:username forKey:@"UserName"]; //SMGL was username
    [parameters setValue:password forKey:@"Password"]; //SMGL was password
    //NSLog(@"SMGL parameters : %@ \n",parameters);
    
    if (scope) {
         [parameters setValue:scope forKey:@"scope"];
         NSLog(@"SMGL scope : %@ \n",scope);
    }
    
    return [self authenticateUsingOAuthWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionTask *)authenticateUsingOAuthWithURLString:(NSString *)URLString
                                                    scope:(NSString *)scope
                                                  success:(void (^)(AFOAuthCredential * _Nonnull))success
                                                  failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:kAFOAuthClientCredentialsGrantType forKey:@"grant_type"];
    
    if (scope) {
        [parameters setValue:scope forKey:@"scope"];
    }
    
    return [self authenticateUsingOAuthWithURLString:URLString parameters:parameters success:success failure:failure];
}


- (NSURLSessionTask *)authenticateUsingOAuthWithURLString:(NSString *)URLString
                                             refreshToken:(NSString *)refreshToken
                                                  success:(void (^)(AFOAuthCredential *credential))success
                                                  failure:(void (^)(NSError *error))failure
{
    NSParameterAssert(refreshToken);
    
    NSDictionary *parameters = @{
                                 @"grant_type": kAFOAuthRefreshGrantType,
                                 @"refresh_token": refreshToken
                                 };
    
    return [self authenticateUsingOAuthWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionTask *)authenticateUsingOAuthWithURLString:(NSString *)URLString
                                                     code:(NSString *)code
                                              redirectURI:(NSString *)uri
                                                  success:(void (^)(AFOAuthCredential *credential))success
                                                  failure:(void (^)(NSError *error))failure
{
    NSParameterAssert(code);
    NSParameterAssert(uri);
    
    NSDictionary *parameters = @{
                                 @"grant_type": kAFOAuthCodeGrantType,
                                 @"code": code,
                                 @"redirect_uri": uri
                                 };
    
    return [self authenticateUsingOAuthWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionTask *)authenticateUsingOAuthWithURLString:(NSString *)URLString
                                               parameters:(NSDictionary *)parameters
                                                  success:(void (^)(AFOAuthCredential *credential))success
                                                  failure:(void (^)(NSError *error))failure
{
    //[self testOauthTokenFunction];
    //

    //NSString *newURL = [NSString stringWithFormat:@"ios-api.filgoal.com/oauth/token"];
    
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (!self.useHTTPBasicAuthentication) {
        mutableParameters[@"client_id"] = self.clientID;
        mutableParameters[@"client_secret"] = self.secret;
    }
    else{
    }
    parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
    
    NSLog(@"SMGL parameters : %@ \n",parameters);
    
    NSURLSessionTask *task;
    task = [self POST:URLString parameters:parameters  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!responseObject) {
            if (failure) {
                failure(nil);
            }
            return;
        }
        
        if ([responseObject valueForKey:@"error"]) {
            if (failure) {
                failure(AFErrorFromRFC6749Section5_2Error(responseObject));
            }
        }
        

        NSString *refreshToken = [responseObject valueForKey:@"refresh_token"];
        if (!refreshToken || [refreshToken isEqual:[NSNull null]]) {
            refreshToken = [parameters valueForKey:@"refresh_token"];
        }
        
        AFOAuthCredential *credential = [AFOAuthCredential credentialWithOAuthToken:[responseObject valueForKey:@"access_token"] tokenType:[responseObject valueForKey:@"token_type"]];
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
        
        // Expiration is optional, but recommended in the OAuth2 spec. It not provide, assume distantFuture === never expires
        NSDate *expireDate = [NSDate distantFuture];
        id expiresIn = [responseObject valueForKey:@"expires_in"];
        if (expiresIn && ![expiresIn isEqual:[NSNull null]]) {
            expireDate = [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
        }
        
        if (expireDate) {
            [credential setExpiration:expireDate];
        }
        
        if (success) {
            success(credential);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n\n SMGL task 1 : %@", task);
        NSLog(@"\n\n SMGL error 1 : %@", error);
        NSLog(@"\n\n SMGL error localized 1 : %@", [error localizedDescription]);
        NSLog(@"\n\n SMGL error debug 1 : %@", [error debugDescription]);
        NSLog(@"\n\n SMGL error description 1 : %@", [error description]);
        
        if (failure) {
            failure(error);
        }
    }];
    
    return task;
}

//SMGL TESTING NEW POST METHOD ===================== START
-(void)testOauthTokenFunction {
    
    NSDictionary *newParameters3 = @{ @"UserName" :@"FilGoalIOS",
                                      @"Password" :@"F!lgo@L@$poRtsEng!ne",
                                      @"grant_type" :@"password",
                                      @"client_id" :@"FG",
                                      @"client_secret" :@"F!LGo@L2016",
                                      @"scope" :@"password"};
    NSLog(@"SMGL parameters 3 : %@ \n",newParameters3);
    
    
    
    NSMutableDictionary *newParameters4 = [NSMutableDictionary dictionary];
    [newParameters4 setValue:@"FilGoalAndroid" forKey:@"UserName"];
    [newParameters4 setValue:@"F!lgo@L@$poRtsEng!ne" forKey:@"Password"];
    [newParameters4 setValue:@"password" forKey:@"grant_type"];
    [newParameters4 setValue:@"FG" forKey:@"client_id"]; //was client_id
    [newParameters4 setValue:@"F!LGo@L2016" forKey:@"client_secret"];
    [newParameters4 setValue:@"password" forKey:@"scope"];
    NSLog(@"SMGL parameters 4 : %@ \n",newParameters4);
    
    NSError *error;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://seapi.filgoal.com/oauth/token"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //[request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSLog(@"SMGL headers 1 : %@ \n", [request allHTTPHeaderFields]);

    
    [request setHTTPMethod:@"POST"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:newParameters3 options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //handle errors here
        if (data != nil) {
            NSError *err;   //error for parsing json
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            NSLog(@"SMGL postAComment Data: %@", json.debugDescription);
        }
        if (error != nil) {
            NSLog(@"SMGL postAComment error: %@", error.debugDescription);
        }
        
    }];
    [postDataTask resume];
    
}
//SMGL STOP TESTING THE NEW POST METHOD ===================== END


@end
