//
//	Item.m
//
//	Create by Nada Gamal on 3/5/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "ItemWeather.h"

@interface ItemWeather ()
@end
@implementation ItemWeather




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"condition"] isKindOfClass:[NSNull class]]){
		self.condition = [[Condition alloc] initWithDictionary:dictionary[@"condition"]];
	}

	if(![dictionary[@"description"] isKindOfClass:[NSNull class]]){
		self.descriptionField = dictionary[@"description"];
	}	
	if(dictionary[@"forecast"] != nil && [dictionary[@"forecast"] isKindOfClass:[NSArray class]]){
		NSArray * forecastDictionaries = dictionary[@"forecast"];
		NSMutableArray * forecastItems = [NSMutableArray array];
		for(NSDictionary * forecastDictionary in forecastDictionaries){
			Forecast * forecastItem = [[Forecast alloc] initWithDictionary:forecastDictionary];
			[forecastItems addObject:forecastItem];
		}
		self.forecast = forecastItems;
	}
	if(![dictionary[@"guid"] isKindOfClass:[NSNull class]]){
		self.guid = [[Guid alloc] initWithDictionary:dictionary[@"guid"]];
	}

	if(![dictionary[@"lat"] isKindOfClass:[NSNull class]]){
		self.lat = dictionary[@"lat"];
	}	
	if(![dictionary[@"link"] isKindOfClass:[NSNull class]]){
		self.link = dictionary[@"link"];
	}	
	if(![dictionary[@"long"] isKindOfClass:[NSNull class]]){
		self.longField = dictionary[@"long"];
	}	
	if(![dictionary[@"pubDate"] isKindOfClass:[NSNull class]]){
		self.pubDate = dictionary[@"pubDate"];
	}	
	if(![dictionary[@"title"] isKindOfClass:[NSNull class]]){
		self.title = dictionary[@"title"];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.condition != nil){
		dictionary[@"condition"] = [self.condition toDictionary];
	}
	if(self.descriptionField != nil){
		dictionary[@"description"] = self.descriptionField;
	}
	if(self.forecast != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Forecast * forecastElement in self.forecast){
			[dictionaryElements addObject:[forecastElement toDictionary]];
		}
		dictionary[@"forecast"] = dictionaryElements;
	}
	if(self.guid != nil){
		dictionary[@"guid"] = [self.guid toDictionary];
	}
	if(self.lat != nil){
		dictionary[@"lat"] = self.lat;
	}
	if(self.link != nil){
		dictionary[@"link"] = self.link;
	}
	if(self.longField != nil){
		dictionary[@"long"] = self.longField;
	}
	if(self.pubDate != nil){
		dictionary[@"pubDate"] = self.pubDate;
	}
	if(self.title != nil){
		dictionary[@"title"] = self.title;
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
	if(self.condition != nil){
		[aCoder encodeObject:self.condition forKey:@"condition"];
	}
	if(self.descriptionField != nil){
		[aCoder encodeObject:self.descriptionField forKey:@"description"];
	}
	if(self.forecast != nil){
		[aCoder encodeObject:self.forecast forKey:@"forecast"];
	}
	if(self.guid != nil){
		[aCoder encodeObject:self.guid forKey:@"guid"];
	}
	if(self.lat != nil){
		[aCoder encodeObject:self.lat forKey:@"lat"];
	}
	if(self.link != nil){
		[aCoder encodeObject:self.link forKey:@"link"];
	}
	if(self.longField != nil){
		[aCoder encodeObject:self.longField forKey:@"long"];
	}
	if(self.pubDate != nil){
		[aCoder encodeObject:self.pubDate forKey:@"pubDate"];
	}
	if(self.title != nil){
		[aCoder encodeObject:self.title forKey:@"title"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.condition = [aDecoder decodeObjectForKey:@"condition"];
	self.descriptionField = [aDecoder decodeObjectForKey:@"description"];
	self.forecast = [aDecoder decodeObjectForKey:@"forecast"];
	self.guid = [aDecoder decodeObjectForKey:@"guid"];
	self.lat = [aDecoder decodeObjectForKey:@"lat"];
	self.link = [aDecoder decodeObjectForKey:@"link"];
	self.longField = [aDecoder decodeObjectForKey:@"long"];
	self.pubDate = [aDecoder decodeObjectForKey:@"pubDate"];
	self.title = [aDecoder decodeObjectForKey:@"title"];
	return self;

}
@end