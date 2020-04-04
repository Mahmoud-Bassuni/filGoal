//
//	AfterSection.m
//
//	Create by Mohamed Mansour on 16/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "AfterSection.h"

@interface AfterSection ()
@end
@implementation AfterSection




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"src"] isKindOfClass:[NSNull class]]){
		self.src = dictionary[@"src"];
	}	
	if(![dictionary[@"title"] isKindOfClass:[NSNull class]]){
		self.title = dictionary[@"title"];
	}	
	if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[@"type"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.src != nil){
		dictionary[@"src"] = self.src;
	}
	if(self.title != nil){
		dictionary[@"title"] = self.title;
	}
	dictionary[@"type"] = @(self.type);
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
	if(self.src != nil){
		[aCoder encodeObject:self.src forKey:@"src"];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:@"title"];
	}
	[aCoder encodeObject:@(self.type) forKey:@"type"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.src = [aDecoder decodeObjectForKey:@"src"];
	self.title = [aDecoder decodeObjectForKey:@"title"];
	self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];
	return self;

}
@end