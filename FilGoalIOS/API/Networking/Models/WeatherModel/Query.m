//
//	Query.m
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Query.h"

@interface Query ()
@end
@implementation Query




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"count"] isKindOfClass:[NSNull class]]){
		self.count = [dictionary[@"count"] integerValue];
	}

	if(![dictionary[@"created"] isKindOfClass:[NSNull class]]){
		self.created = dictionary[@"created"];
	}	
	if(![dictionary[@"lang"] isKindOfClass:[NSNull class]]){
		self.lang = dictionary[@"lang"];
	}	
	if(![dictionary[@"results"] isKindOfClass:[NSNull class]]){
		self.results = [[Result alloc] initWithDictionary:dictionary[@"results"]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[@"count"] = @(self.count);
	if(self.created != nil){
		dictionary[@"created"] = self.created;
	}
	if(self.lang != nil){
		dictionary[@"lang"] = self.lang;
	}
	if(self.results != nil){
		dictionary[@"results"] = [self.results toDictionary];
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
	[aCoder encodeObject:@(self.count) forKey:@"count"];	if(self.created != nil){
		[aCoder encodeObject:self.created forKey:@"created"];
	}
	if(self.lang != nil){
		[aCoder encodeObject:self.lang forKey:@"lang"];
	}
	if(self.results != nil){
		[aCoder encodeObject:self.results forKey:@"results"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.count = [[aDecoder decodeObjectForKey:@"count"] integerValue];
	self.created = [aDecoder decodeObjectForKey:@"created"];
	self.lang = [aDecoder decodeObjectForKey:@"lang"];
	self.results = [aDecoder decodeObjectForKey:@"results"];
	return self;

}
@end