//
//	Message.m
//
//	Create by Nada Gamal on 19/2/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Message.h"

NSString *const kMessageIsActive = @"is_active";
NSString *const kMessageIsRepeated = @"is_repeated";
NSString *const kMessageMsg = @"msg";
NSString *const kMessageMsgId = @"msg_id";
NSString *const kMessageMsgUrl = @"msg_url";

@interface Message ()
@end
@implementation Message




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMessageIsActive] isKindOfClass:[NSNull class]]){
		self.isActive = [dictionary[kMessageIsActive] integerValue];
	}

	if(![dictionary[kMessageIsRepeated] isKindOfClass:[NSNull class]]){
		self.isRepeated = [dictionary[kMessageIsRepeated] integerValue];
	}

	if(![dictionary[kMessageMsg] isKindOfClass:[NSNull class]]){
		self.msg = dictionary[kMessageMsg];
	}	
	if(![dictionary[kMessageMsgId] isKindOfClass:[NSNull class]]){
		self.msgId = [dictionary[kMessageMsgId] integerValue];
	}

	if(![dictionary[kMessageMsgUrl] isKindOfClass:[NSNull class]]){
		self.msgUrl = dictionary[kMessageMsgUrl];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMessageIsActive] = @(self.isActive);
	dictionary[kMessageIsRepeated] = @(self.isRepeated);
	if(self.msg != nil){
		dictionary[kMessageMsg] = self.msg;
	}
	dictionary[kMessageMsgId] = @(self.msgId);
	if(self.msgUrl != nil){
		dictionary[kMessageMsgUrl] = self.msgUrl;
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
	[aCoder encodeObject:@(self.isActive) forKey:kMessageIsActive];	[aCoder encodeObject:@(self.isRepeated) forKey:kMessageIsRepeated];	if(self.msg != nil){
		[aCoder encodeObject:self.msg forKey:kMessageMsg];
	}
	[aCoder encodeObject:@(self.msgId) forKey:kMessageMsgId];	if(self.msgUrl != nil){
		[aCoder encodeObject:self.msgUrl forKey:kMessageMsgUrl];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.isActive = [[aDecoder decodeObjectForKey:kMessageIsActive] integerValue];
	self.isRepeated = [[aDecoder decodeObjectForKey:kMessageIsRepeated] integerValue];
	self.msg = [aDecoder decodeObjectForKey:kMessageMsg];
	self.msgId = [[aDecoder decodeObjectForKey:kMessageMsgId] integerValue];
	self.msgUrl = [aDecoder decodeObjectForKey:kMessageMsgUrl];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Message *copy = [Message new];

	copy.isActive = self.isActive;
	copy.isRepeated = self.isRepeated;
	copy.msg = [self.msg copy];
	copy.msgId = self.msgId;
	copy.msgUrl = [self.msgUrl copy];

	return copy;
}
@end