//
//	Token.m
//
//	Create by Nada Gamal on 10/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Token.h"

NSString *const kTokenAccessToken = @"access_token";
NSString *const kTokenExpiresIn = @"expires_in";
NSString *const kTokenRefreshToken = @"refresh_token";
NSString *const kTokenRights = @"rights";
NSString *const kTokenTokenType = @"token_type";
NSString *const kTokenUserName = @"userName";
NSString *const kTokenViews = @"views";

@interface Token ()
@end
@implementation Token




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTokenAccessToken] isKindOfClass:[NSNull class]]){
		self.accessToken = dictionary[kTokenAccessToken];
	}	
	if(![dictionary[kTokenExpiresIn] isKindOfClass:[NSNull class]]){
		self.expiresIn = [dictionary[kTokenExpiresIn] integerValue];
	}

	if(![dictionary[kTokenRefreshToken] isKindOfClass:[NSNull class]]){
		self.refreshToken = dictionary[kTokenRefreshToken];
	}	
	if(![dictionary[kTokenRights] isKindOfClass:[NSNull class]]){
		self.rights = dictionary[kTokenRights];
	}	
	if(![dictionary[kTokenTokenType] isKindOfClass:[NSNull class]]){
		self.tokenType = dictionary[kTokenTokenType];
	}	
	if(![dictionary[kTokenUserName] isKindOfClass:[NSNull class]]){
		self.userName = dictionary[kTokenUserName];
	}	
	if(![dictionary[kTokenViews] isKindOfClass:[NSNull class]]){
		self.views = dictionary[kTokenViews];
	}	
	return self;
}
@end