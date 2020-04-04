//
//	FilteredOpinion.m
//
//	Create by Nada Gamal on 3/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "FilteredOpinion.h"

NSString *const kFilteredOpinionCommentsNo = @"comments_no";
NSString *const kFilteredOpinionEditorId = @"editor_id";
NSString *const kFilteredOpinionEditorName = @"editor_name";
NSString *const kFilteredOpinionEditorPicture = @"editor_picture";
NSString *const kFilteredOpinionImages = @"images";
NSString *const kFilteredOpinionNewsDate = @"news_date";
NSString *const kFilteredOpinionNewsDescription = @"news_description";
NSString *const kFilteredOpinionNewsDislikes = @"news_dislikes";
NSString *const kFilteredOpinionNewsId = @"news_id";
NSString *const kFilteredOpinionNewsLikes = @"news_likes";
NSString *const kFilteredOpinionNewsSectionId = @"news_section_id";
NSString *const kFilteredOpinionNewsTitle = @"news_title";
NSString *const kFilteredOpinionNewsTypeId = @"news_type_id";
NSString *const kFilteredOpinionNewsWriter = @"news_writer";
NSString *const kFilteredOpinionQuotes = @"quotes";
NSString *const kFilteredOpinionSourceDate = @"source_date";
NSString *const kFilteredOpinionType = @"type";

@interface FilteredOpinion ()
@end
@implementation FilteredOpinion




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kFilteredOpinionCommentsNo] isKindOfClass:[NSNull class]]){
		self.commentsNo = [dictionary[kFilteredOpinionCommentsNo] integerValue];
	}

	if(![dictionary[kFilteredOpinionEditorId] isKindOfClass:[NSNull class]]){
		self.editorId = [dictionary[kFilteredOpinionEditorId] integerValue];
	}

	if(![dictionary[kFilteredOpinionEditorName] isKindOfClass:[NSNull class]]){
		self.editorName = dictionary[kFilteredOpinionEditorName];
	}	
	if(![dictionary[kFilteredOpinionEditorPicture] isKindOfClass:[NSNull class]]){
		self.editorPicture = dictionary[kFilteredOpinionEditorPicture];
	}	
	if(dictionary[kFilteredOpinionImages] != nil && [dictionary[kFilteredOpinionImages] isKindOfClass:[NSArray class]]){
		NSArray * imagesDictionaries = dictionary[kFilteredOpinionImages];
		NSMutableArray * imagesItems = [NSMutableArray array];
		for(NSDictionary * imagesDictionary in imagesDictionaries){
			Image * imagesItem = [[Image alloc] initWithDictionary:imagesDictionary];
			[imagesItems addObject:imagesItem];
		}
		self.images = imagesItems;
	}
	if(![dictionary[kFilteredOpinionNewsDate] isKindOfClass:[NSNull class]]){
		self.newsDate = dictionary[kFilteredOpinionNewsDate];
	}	
	if(![dictionary[kFilteredOpinionNewsDescription] isKindOfClass:[NSNull class]]){
		self.newsDescription = dictionary[kFilteredOpinionNewsDescription];
	}	
	if(![dictionary[kFilteredOpinionNewsDislikes] isKindOfClass:[NSNull class]]){
		self.newsDislikes = [dictionary[kFilteredOpinionNewsDislikes] integerValue];
	}

	if(![dictionary[kFilteredOpinionNewsId] isKindOfClass:[NSNull class]]){
		self.newsId = [dictionary[kFilteredOpinionNewsId] integerValue];
	}

	if(![dictionary[kFilteredOpinionNewsLikes] isKindOfClass:[NSNull class]]){
		self.newsLikes = [dictionary[kFilteredOpinionNewsLikes] integerValue];
	}

	if(dictionary[kFilteredOpinionNewsSectionId] != nil && [dictionary[kFilteredOpinionNewsSectionId] isKindOfClass:[NSArray class]]){
		NSArray * newsSectionIdDictionaries = dictionary[kFilteredOpinionNewsSectionId];
		NSMutableArray * newsSectionIdItems = [NSMutableArray array];
		for(NSDictionary * newsSectionIdDictionary in newsSectionIdDictionaries){
			NewsSectionId * newsSectionIdItem = [[NewsSectionId alloc] initWithDictionary:newsSectionIdDictionary];
			[newsSectionIdItems addObject:newsSectionIdItem];
		}
		self.newsSectionId = newsSectionIdItems;
	}
	if(![dictionary[kFilteredOpinionNewsTitle] isKindOfClass:[NSNull class]]){
		self.newsTitle = dictionary[kFilteredOpinionNewsTitle];
	}	
	if(![dictionary[kFilteredOpinionNewsTypeId] isKindOfClass:[NSNull class]]){
		self.newsTypeId = [dictionary[kFilteredOpinionNewsTypeId] integerValue];
	}

	if(![dictionary[kFilteredOpinionNewsWriter] isKindOfClass:[NSNull class]]){
		self.newsWriter = dictionary[kFilteredOpinionNewsWriter];
	}	
	if(![dictionary[kFilteredOpinionQuotes] isKindOfClass:[NSNull class]]){
		self.quotes = dictionary[kFilteredOpinionQuotes];
	}	
	if(![dictionary[kFilteredOpinionSourceDate] isKindOfClass:[NSNull class]]){
		self.sourceDate = dictionary[kFilteredOpinionSourceDate];
	}	
	if(![dictionary[kFilteredOpinionType] isKindOfClass:[NSNull class]]){
		self.type = dictionary[kFilteredOpinionType];
	}	
	return self;
}
@end