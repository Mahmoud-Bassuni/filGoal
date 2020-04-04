//
//	Image.m
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Image.h"

@interface Image ()
@end
@implementation Image




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"height"] isKindOfClass:[NSNull class]]){
		self.height = dictionary[@"height"];
	}	
	if(![dictionary[@"link"] isKindOfClass:[NSNull class]]){
		self.link = dictionary[@"link"];
	}	
	if(![dictionary[@"title"] isKindOfClass:[NSNull class]]){
		self.title = dictionary[@"title"];
	}	
	if(![dictionary[@"url"] isKindOfClass:[NSNull class]]){
		self.url = dictionary[@"url"];
	}	
	if(![dictionary[@"width"] isKindOfClass:[NSNull class]]){
		self.width = dictionary[@"width"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.height != nil){
		dictionary[@"height"] = self.height;
	}
	if(self.link != nil){
		dictionary[@"link"] = self.link;
	}
	if(self.title != nil){
		dictionary[@"title"] = self.title;
	}
	if(self.url != nil){
		dictionary[@"url"] = self.url;
	}
	if(self.width != nil){
		dictionary[@"width"] = self.width;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.height != nil){
		[aCoder encodeObject:self.height forKey:@"height"];
	}
	if(self.link != nil){
		[aCoder encodeObject:self.link forKey:@"link"];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:@"title"];
	}
	if(self.url != nil){
		[aCoder encodeObject:self.url forKey:@"url"];
	}
	if(self.width != nil){
		[aCoder encodeObject:self.width forKey:@"width"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.height = [aDecoder decodeObjectForKey:@"height"];
	self.link = [aDecoder decodeObjectForKey:@"link"];
	self.title = [aDecoder decodeObjectForKey:@"title"];
	self.url = [aDecoder decodeObjectForKey:@"url"];
	self.width = [aDecoder decodeObjectForKey:@"width"];
	return self;

}
@end