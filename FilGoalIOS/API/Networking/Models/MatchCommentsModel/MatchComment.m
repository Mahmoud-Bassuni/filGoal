//
//	MatchComment.m
//
//	Create by Mohamed Mansour on 11/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchComment.h"

NSString *const kMatchCommentContent = @"content";
NSString *const kMatchCommentContentUrl = @"contentUrl";
NSString *const kMatchCommentIdField = @"id";
NSString *const kMatchCommentLanguageId = @"languageId";
NSString *const kMatchCommentLanguageName = @"languageName";
NSString *const kMatchCommentMatchEventId = @"matchEventId";
NSString *const kMatchCommentMatchId = @"matchId";
NSString *const kMatchCommentMatchStatusId = @"matchStatusId";
NSString *const kMatchCommentMatchStatusMaxTime = @"matchStatusMaxTime";
NSString *const kMatchCommentMatchStatusName = @"matchStatusName";
NSString *const kMatchCommentTime = @"time";
NSString *const kMatchCommentOrder = @"order";

@interface MatchComment ()
@end
@implementation MatchComment




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMatchCommentContent] isKindOfClass:[NSNull class]]){
		self.content = dictionary[kMatchCommentContent];
	}	
	if(![dictionary[kMatchCommentContentUrl] isKindOfClass:[NSNull class]]){
		self.contentUrl = dictionary[kMatchCommentContentUrl];
	}	
	if(![dictionary[kMatchCommentIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchCommentIdField] integerValue];
	}

	if(![dictionary[kMatchCommentLanguageId] isKindOfClass:[NSNull class]]){
		self.languageId = [dictionary[kMatchCommentLanguageId] integerValue];
	}

	if(![dictionary[kMatchCommentLanguageName] isKindOfClass:[NSNull class]]){
		self.languageName = dictionary[kMatchCommentLanguageName];
	}	
	if(![dictionary[kMatchCommentMatchEventId] isKindOfClass:[NSNull class]]){
		self.matchEventId = [dictionary[kMatchCommentMatchEventId]integerValue];
	}	
	if(![dictionary[kMatchCommentMatchId] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kMatchCommentMatchId] integerValue];
	}

	if(![dictionary[kMatchCommentMatchStatusId] isKindOfClass:[NSNull class]]){
		self.matchStatusId = [dictionary[kMatchCommentMatchStatusId] integerValue];
	}

	if(![dictionary[kMatchCommentMatchStatusMaxTime] isKindOfClass:[NSNull class]]){
		self.matchStatusMaxTime = [dictionary[kMatchCommentMatchStatusMaxTime]integerValue];
	}
    if(![dictionary[kMatchCommentOrder] isKindOfClass:[NSNull class]]){
        self.order = [dictionary[kMatchCommentOrder]integerValue];
    }
	if(![dictionary[kMatchCommentMatchStatusName] isKindOfClass:[NSNull class]]){
		self.matchStatusName = dictionary[kMatchCommentMatchStatusName];
	}	
	if(![dictionary[kMatchCommentTime] isKindOfClass:[NSNull class]]){
		self.time = [dictionary[kMatchCommentTime] integerValue];
	}

	return self;
}
@end
