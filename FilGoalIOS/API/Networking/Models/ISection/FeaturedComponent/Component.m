//
//	Component.m
//
//	Create by Mohamed Mansour on 4/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Component.h"

@interface Component ()
@end
@implementation Component




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"brief"] isKindOfClass:[NSNull class]]){
		self.brief = dictionary[@"brief"];
	}	
	if(![dictionary[@"componentTitle"] isKindOfClass:[NSNull class]]){
		self.componentTitle = dictionary[@"componentTitle"];
	}	
	if(![dictionary[@"fullDescription"] isKindOfClass:[NSNull class]]){
		self.fullDescription = dictionary[@"fullDescription"];
	}	
	if(![dictionary[@"largeImageURL"] isKindOfClass:[NSNull class]]){
		self.largeImageURL = dictionary[@"largeImageURL"];
	}	
	if(![dictionary[@"smallImageURL"] isKindOfClass:[NSNull class]]){
		self.smallImageURL = dictionary[@"smallImageURL"];
	}	
	if(![dictionary[@"style"] isKindOfClass:[NSNull class]]){
		self.style = dictionary[@"style"];
	}	
	if(![dictionary[@"title"] isKindOfClass:[NSNull class]]){
		self.title = dictionary[@"title"];
	}	
	if(![dictionary[@"type"] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[@"type"] integerValue];
	}

	if(![dictionary[@"videoURL"] isKindOfClass:[NSNull class]]){
		self.videoURL = dictionary[@"videoURL"];
	}
    if(![dictionary[@"componentIconURL"] isKindOfClass:[NSNull class]]){
        self.componentIconURL = dictionary[@"componentIconURL"];
    }
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.brief != nil){
		dictionary[@"brief"] = self.brief;
	}
	if(self.componentTitle != nil){
		dictionary[@"componentTitle"] = self.componentTitle;
	}
	if(self.fullDescription != nil){
		dictionary[@"fullDescription"] = self.fullDescription;
	}
	if(self.largeImageURL != nil){
		dictionary[@"largeImageURL"] = self.largeImageURL;
	}
	if(self.smallImageURL != nil){
		dictionary[@"smallImageURL"] = self.smallImageURL;
	}
	if(self.style != nil){
		dictionary[@"style"] = self.style;
	}
	if(self.title != nil){
		dictionary[@"title"] = self.title;
	}
	dictionary[@"type"] = @(self.type);
	if(self.videoURL != nil){
		dictionary[@"videoURL"] = self.videoURL;
	}
    if(self.componentIconURL != nil){
        dictionary[@"componentIconURL"] = self.componentIconURL;
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
	if(self.brief != nil){
		[aCoder encodeObject:self.brief forKey:@"brief"];
	}
	if(self.componentTitle != nil){
		[aCoder encodeObject:self.componentTitle forKey:@"componentTitle"];
	}
	if(self.fullDescription != nil){
		[aCoder encodeObject:self.fullDescription forKey:@"fullDescription"];
	}
	if(self.largeImageURL != nil){
		[aCoder encodeObject:self.largeImageURL forKey:@"largeImageURL"];
	}
	if(self.smallImageURL != nil){
		[aCoder encodeObject:self.smallImageURL forKey:@"smallImageURL"];
	}
	if(self.style != nil){
		[aCoder encodeObject:self.style forKey:@"style"];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:@"title"];
	}
    if(self.componentIconURL != nil){
        [aCoder encodeObject:self.componentIconURL forKey:@"componentIconURL"];
    }
	[aCoder encodeObject:@(self.type) forKey:@"type"];	if(self.videoURL != nil){
		[aCoder encodeObject:self.videoURL forKey:@"videoURL"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.brief = [aDecoder decodeObjectForKey:@"brief"];
    self.componentIconURL = [aDecoder decodeObjectForKey:@"componentIconURL"];
	self.componentTitle = [aDecoder decodeObjectForKey:@"componentTitle"];
	self.fullDescription = [aDecoder decodeObjectForKey:@"fullDescription"];
	self.largeImageURL = [aDecoder decodeObjectForKey:@"largeImageURL"];
	self.smallImageURL = [aDecoder decodeObjectForKey:@"smallImageURL"];
	self.style = [aDecoder decodeObjectForKey:@"style"];
	self.title = [aDecoder decodeObjectForKey:@"title"];
	self.type = [[aDecoder decodeObjectForKey:@"type"] integerValue];
	self.videoURL = [aDecoder decodeObjectForKey:@"videoURL"];
	return self;

}
@end