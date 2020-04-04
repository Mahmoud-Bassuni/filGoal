//
//	Condition.m
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Condition.h"

@interface Condition ()
@end
@implementation Condition




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"code"] isKindOfClass:[NSNull class]]){
		self.code = dictionary[@"code"];
	}	
	if(![dictionary[@"date"] isKindOfClass:[NSNull class]]){
		self.date = dictionary[@"date"];
	}	
	if(![dictionary[@"temp"] isKindOfClass:[NSNull class]]){
		self.temp = dictionary[@"temp"];
	}	
	if(![dictionary[@"text"] isKindOfClass:[NSNull class]]){
		self.text = dictionary[@"text"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.code != nil){
		dictionary[@"code"] = self.code;
	}
	if(self.date != nil){
		dictionary[@"date"] = self.date;
	}
	if(self.temp != nil){
		dictionary[@"temp"] = self.temp;
	}
	if(self.text != nil){
		dictionary[@"text"] = self.text;
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
	if(self.code != nil){
		[aCoder encodeObject:self.code forKey:@"code"];
	}
	if(self.date != nil){
		[aCoder encodeObject:self.date forKey:@"date"];
	}
	if(self.temp != nil){
		[aCoder encodeObject:self.temp forKey:@"temp"];
	}
	if(self.text != nil){
		[aCoder encodeObject:self.text forKey:@"text"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.code = [aDecoder decodeObjectForKey:@"code"];
	self.date = [aDecoder decodeObjectForKey:@"date"];
	self.temp = [aDecoder decodeObjectForKey:@"temp"];
	self.text = [aDecoder decodeObjectForKey:@"text"];
	return self;

}
@end