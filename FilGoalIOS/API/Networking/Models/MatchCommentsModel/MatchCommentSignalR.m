//
//	MatchComment.m
//
//	Create by Mohamed Mansour on 11/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchCommentSignalR.h"

NSString *const kMatchCommentContentt = @"Content";
NSString *const kMatchCommentContentUrll = @"ContentUrl";
NSString *const kMatchCommentIdFieldd = @"Id";
NSString *const kMatchCommentLanguageIdd = @"LanguageId";
NSString *const kMatchCommentLanguageNamee = @"LanguageName";
NSString *const kMatchCommentMatchEventIdd = @"MatchEventId";
NSString *const kMatchCommentMatchIdd = @"MatchId";
NSString *const kMatchCommentMatchStatusIdd = @"MatchStatusId";
NSString *const kMatchCommentMatchStatusMaxTimee = @"MatchStatusMaxTime";
NSString *const kMatchCommentMatchStatusNamee = @"MatchStatusName";
NSString *const kMatchCommentTimee = @"Time";

@interface MatchCommentSignalR ()
@end
@implementation MatchCommentSignalR




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMatchCommentContentt] isKindOfClass:[NSNull class]]){
		self.content = dictionary[kMatchCommentContentt];
	}	
	if(![dictionary[kMatchCommentContentUrll] isKindOfClass:[NSNull class]]){
        self.contentUrl = dictionary[kMatchCommentContentUrll];
	}	
	if(![dictionary[kMatchCommentIdFieldd] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kMatchCommentIdFieldd] integerValue];
	}

	if(![dictionary[kMatchCommentLanguageIdd] isKindOfClass:[NSNull class]]){
		self.languageId = [dictionary[kMatchCommentLanguageIdd] integerValue];
	}

	if(![dictionary[kMatchCommentLanguageNamee] isKindOfClass:[NSNull class]]){
		self.languageName = dictionary[kMatchCommentLanguageNamee];
	}	
	if(![dictionary[kMatchCommentMatchEventIdd] isKindOfClass:[NSNull class]]){
		self.matchEventId = [dictionary[kMatchCommentMatchEventIdd]integerValue];
	}	
	if(![dictionary[kMatchCommentMatchIdd] isKindOfClass:[NSNull class]]){
		self.matchId = [dictionary[kMatchCommentMatchIdd] integerValue];
	}

	if(![dictionary[kMatchCommentMatchStatusIdd] isKindOfClass:[NSNull class]]){
		self.matchStatusId = [dictionary[kMatchCommentMatchStatusIdd] integerValue];
	}

	if(![dictionary[kMatchCommentMatchStatusMaxTimee] isKindOfClass:[NSNull class]]){
		self.matchStatusMaxTime = [dictionary[kMatchCommentMatchStatusMaxTimee]integerValue];
	}	
	if(![dictionary[kMatchCommentMatchStatusNamee] isKindOfClass:[NSNull class]]){
		self.matchStatusName = dictionary[kMatchCommentMatchStatusNamee];
	}	
	if(![dictionary[kMatchCommentTimee] isKindOfClass:[NSNull class]]){
		self.time = [dictionary[kMatchCommentTimee] integerValue];
	}

	return self;
}
@end
