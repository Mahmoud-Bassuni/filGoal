//
//    Picture.m
//
//    Create by Nada Gamal on 19/2/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Picture.h"

NSString *const kPictureAddedDate = @"AddedDate";
NSString *const kPictureAlbumId = @"AlbumId";
NSString *const kPicturePicCaption = @"PicCaption";
NSString *const kPicturePicDesc = @"PicDesc";
NSString *const kPicturePicId = @"PicId";
NSString *const kPicturePicName = @"PicName";
NSString *const kPicturePicOrder = @"PicOrder";
NSString *const kPictureUrls = @"Urls";

@interface Picture ()
@end
@implementation Picture




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kPictureAddedDate] isKindOfClass:[NSNull class]]){
        self.addedDate = dictionary[kPictureAddedDate];
    }
    if(![dictionary[kPictureAlbumId] isKindOfClass:[NSNull class]]){
        self.albumId = [dictionary[kPictureAlbumId] integerValue];
    }
    
    if(![dictionary[kPicturePicCaption] isKindOfClass:[NSNull class]]){
        self.picCaption = dictionary[kPicturePicCaption];
    }
    if(![dictionary[kPicturePicDesc] isKindOfClass:[NSNull class]]){
        self.picDesc = dictionary[kPicturePicDesc];
    }
    if(![dictionary[kPicturePicId] isKindOfClass:[NSNull class]]){
        self.picId = [dictionary[kPicturePicId] integerValue];
    }
    
    if(![dictionary[kPicturePicName] isKindOfClass:[NSNull class]]){
        self.picName = dictionary[kPicturePicName];
    }
    if(![dictionary[kPicturePicOrder] isKindOfClass:[NSNull class]]){
        self.picOrder = [dictionary[kPicturePicOrder] integerValue];
    }
    
    if(![dictionary[kPictureUrls] isKindOfClass:[NSNull class]]){
        self.urls = [[Url alloc] initWithDictionary:dictionary[kPictureUrls]];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.addedDate != nil){
        dictionary[kPictureAddedDate] = self.addedDate;
    }
    dictionary[kPictureAlbumId] = @(self.albumId);
    if(self.picCaption != nil){
        dictionary[kPicturePicCaption] = self.picCaption;
    }
    if(self.picDesc != nil){
        dictionary[kPicturePicDesc] = self.picDesc;
    }
    dictionary[kPicturePicId] = @(self.picId);
    if(self.picName != nil){
        dictionary[kPicturePicName] = self.picName;
    }
    dictionary[kPicturePicOrder] = @(self.picOrder);
    if(self.urls != nil){
        dictionary[kPictureUrls] = [self.urls toDictionary];
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
    if(self.addedDate != nil){
        [aCoder encodeObject:self.addedDate forKey:kPictureAddedDate];
    }
    [aCoder encodeObject:@(self.albumId) forKey:kPictureAlbumId];    if(self.picCaption != nil){
        [aCoder encodeObject:self.picCaption forKey:kPicturePicCaption];
    }
    if(self.picDesc != nil){
        [aCoder encodeObject:self.picDesc forKey:kPicturePicDesc];
    }
    [aCoder encodeObject:@(self.picId) forKey:kPicturePicId];    if(self.picName != nil){
        [aCoder encodeObject:self.picName forKey:kPicturePicName];
    }
    [aCoder encodeObject:@(self.picOrder) forKey:kPicturePicOrder];    if(self.urls != nil){
        [aCoder encodeObject:self.urls forKey:kPictureUrls];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.addedDate = [aDecoder decodeObjectForKey:kPictureAddedDate];
    self.albumId = [[aDecoder decodeObjectForKey:kPictureAlbumId] integerValue];
    self.picCaption = [aDecoder decodeObjectForKey:kPicturePicCaption];
    self.picDesc = [aDecoder decodeObjectForKey:kPicturePicDesc];
    self.picId = [[aDecoder decodeObjectForKey:kPicturePicId] integerValue];
    self.picName = [aDecoder decodeObjectForKey:kPicturePicName];
    self.picOrder = [[aDecoder decodeObjectForKey:kPicturePicOrder] integerValue];
    self.urls = [aDecoder decodeObjectForKey:kPictureUrls];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    Picture *copy = [Picture new];
    
    copy.addedDate = [self.addedDate copy];
    copy.albumId = self.albumId;
    copy.picCaption = [self.picCaption copy];
    copy.picDesc = [self.picDesc copy];
    copy.picId = self.picId;
    copy.picName = [self.picName copy];
    copy.picOrder = self.picOrder;
    copy.urls = [self.urls copy];
    
    return copy;
}
@end
