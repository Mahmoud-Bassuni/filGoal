//
//	MatchComments.m
//
//	Create by Mohamed Mansour on 11/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MatchComments.h"

//NSString *const kMatchCommentsMatchComments = @"MatchComments";

@interface MatchComments ()
@end
@implementation MatchComments




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary != nil && [dictionary isKindOfClass:[NSArray class]]){
		NSMutableArray * matchCommentsDictionaries = dictionary;
		NSMutableArray * matchCommentsItems = [NSMutableArray array];
		for(NSDictionary * matchCommentsDictionary in matchCommentsDictionaries){
			MatchComment * matchCommentsItem = [[MatchComment alloc] initWithDictionary:matchCommentsDictionary];
			[matchCommentsItems addObject:matchCommentsItem];
		}
		self.matchComments = matchCommentsItems;
	}
	return self;
}
@end
